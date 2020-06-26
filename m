Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E40CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B32120836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgFZN6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgFZN6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:58:08 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FB31207E8;
        Fri, 26 Jun 2020 13:58:03 +0000 (UTC)
Date:   Fri, 26 Jun 2020 09:58:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Jason Behmer <jbehmer@google.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Clark Williams <williams@redhat.com>,
        bristot <bristot@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Darren Hart <dvhart@vmware.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH] ring-buffer: Have nested events still record
 running time stamp
Message-ID: <20200626095801.14cfa8a3@oasis.local.home>
In-Reply-To: <20200625233552.2c8a0d1e@oasis.local.home>
References: <20200625094454.732790f7@oasis.local.home>
        <1548518134.13177.1593107707149.JavaMail.zimbra@efficios.com>
        <20200625143525.2f3a2902@oasis.local.home>
        <79426976.13417.1593113702719.JavaMail.zimbra@efficios.com>
        <20200625223611.1dbb3b35@oasis.local.home>
        <20200625233552.2c8a0d1e@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 23:35:52 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I have to think about this more, as I think there's a flaw in this
> cmpxchg algorithm.

Bah, that was all wrong. I need to incorporate the seq counter into the
time stamp. Luckily I only use 59 bits for a full time stamp (gives me
18 years of nanoseconds), which gives me 5 bits to pay with, and all I
need is 4 (2 for top and 2 for bottom). Now I can make the timestamp 60
bits with 30 bits from the top and 30 from the bottom, and using two
bits in each of those as a sequence counter.

If after reading top and bottom, if the seq bits match, then the two
match and can be put together as a valid number. Now I have this:


struct rb_time_struct {
	local_t		cnt;
	local_t		top;
	local_t		bottom;
};

typedef struct rb_time_struct rb_time_t;
	
#define RB_TIME_SHIFT	30
#define RB_TIME_VAL_MASK ((1 << RB_TIME_SHIFT) - 1)

static int rb_time_cnt(unsigned long val)
{
	return (val >> RB_TIME_SHIFT) & 3;
}

static u64 rb_time_val(unsigned long top, unsigned long bottom)
{
	u64 val;

	val = top & RB_TIME_VAL_MASK;
	val <<= RB_TIME_SHIFT;
	val |= bottom & RB_TIME_VAL_MASK;

	return val;
}

static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
{
	unsigned long top, bottom;

	top = local_read(&t->top);
	bottom = local_read(&t->bottom);

	*cnt = rb_time_cnt(top);

	if (*cnt != rb_time_cnt(bottom))
		return false;

	*ret = rb_time_val(top, bottom);
	return true;
}

static bool rb_time_read(rb_time_t *t, u64 *ret)
{
	unsigned long cnt;

	return __rb_time_read(t, ret, &cnt);
}

static inline unsigned long rb_time_val_cnt(unsigned long val, unsigned long cnt)
{
	return (val & RB_TIME_VAL_MASK) | ((cnt & 3) << RB_TIME_SHIFT);
}

static inline void rb_time_split(u64 val, unsigned long *top, unsigned long *bottom)
{
	*top = (unsigned long)((val >> RB_TIME_SHIFT) & RB_TIME_VAL_MASK);
	*bottom = (unsigned long)(val & RB_TIME_VAL_MASK);
}

static void rb_time_val_set(local_t *t, unsigned long val, unsigned long cnt)
{
	val = rb_time_val_cnt(val, cnt);
	local_set(t, val);
}

static void rb_time_set(rb_time_t *t, u64 val)
{
	unsigned long cnt, top, bottom;

	rb_time_split(val, &top, &bottom);
	do {
		cnt = local_inc_return(&t->cnt);
		rb_time_val_set(&t->top, top, cnt);
		rb_time_val_set(&t->bottom, bottom, cnt);
	} while (cnt != local_read(&t->cnt));
}

static bool rb_time_read_cmpxchg(local_t *l, unsigned long expect, unsigned long set)
{
	unsigned long ret;

	ret = local_cmpxchg(l, expect, set);
	return ret == expect;
}

static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
{
	unsigned long cnt, top, bottom;
	unsigned long cnt2, top2, bottom2;
	u64 val;

	 if (!__rb_time_read(t, &val, &cnt))
		 return false;

	 if (val != expect)
		 return false;

	 cnt2 = local_read(&t->cnt);
	 if (cnt2 != cnt)
		 return false;
	 cnt2++;

	 rb_time_split(val, &top, &bottom);
	 top = rb_time_val_cnt(top, cnt);
	 bottom = rb_time_val_cnt(bottom, cnt);

	 rb_time_split(set, &top2, &bottom2);
	 top = rb_time_val_cnt(top2, cnt2);
	 bottom = rb_time_val_cnt(bottom2, cnt2);
	 
	if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
		return false;
	if (!rb_time_read_cmpxchg(&t->top, top, top2))
		return false;
	if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
		return false;
	return true;
}

Maybe I might implement this for BITS_FOR_LONG == 32.

-- Steve
