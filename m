Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA39C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 03:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BC720775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 03:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgFZDf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 23:35:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgFZDf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 23:35:56 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05A3E20709;
        Fri, 26 Jun 2020 03:35:53 +0000 (UTC)
Date:   Thu, 25 Jun 2020 23:35:52 -0400
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
Message-ID: <20200625233552.2c8a0d1e@oasis.local.home>
In-Reply-To: <20200625223611.1dbb3b35@oasis.local.home>
References: <20200625094454.732790f7@oasis.local.home>
        <1548518134.13177.1593107707149.JavaMail.zimbra@efficios.com>
        <20200625143525.2f3a2902@oasis.local.home>
        <79426976.13417.1593113702719.JavaMail.zimbra@efficios.com>
        <20200625223611.1dbb3b35@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 22:36:11 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> +static void rb_time_set(rb_time_t *t, u64 val)
> +{
> +	struct rb_time_read r;
> +
> +	rb_time_read_set(&r, val);
> +
> +	do {
> +		r.start_cnt = local_inc_return(&t->start_cnt);
> +		local_set(&t->top, r.top);
> +		local_set(&t->bottom, r.bottom);
> +		local_set(&t->end_cnt, r.start_cnt);
> +	} while (r.start_cnt != local_read(&t->start_cnt));
> +}
> +
> +static bool rb_time_read_cmpxchg(local_t *l, unsigned long expect, unsigned long set)
> +{
> +	unsigned long ret;
> +
> +	ret = local_cmpxchg(l, expect, set);
> +	return ret == expect;
> +}
> +
> +static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
> +{
> +	struct rb_time_read e, s;
> +
> +	rb_time_read_set(&e, expect);
> +	rb_time_read_set(&s, set);
> +
> +	e.start_cnt = local_read(&t->start_cnt);
> +	e.end_cnt = local_read(&t->end_cnt);
> +
> +	s.start_cnt = e.start_cnt + 1;
> +	s.end_cnt = e.start_cnt;
> +
> +	if (!rb_time_read_cmpxchg(&t->start_cnt, e.start_cnt, s.start_cnt))
> +		return false;
> +	if (!rb_time_read_cmpxchg(&t->top, e.top, s.top))
> +		return false;
> +	if (!rb_time_read_cmpxchg(&t->bottom, e.bottom, s.bottom))
> +		return false;
> +	return rb_time_read_cmpxchg(&t->end_cnt, e.end_cnt, s.end_cnt);
> +}
> +

I have to think about this more, as I think there's a flaw in this
cmpxchg algorithm.

-- Steve

