Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59539C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A212088E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gArX9VJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgFZSNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:13:52 -0400
Received: from mail.efficios.com ([167.114.26.124]:53942 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgFZSNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:13:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9113D2D5694;
        Fri, 26 Jun 2020 14:13:50 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gxkVJe4uPr3p; Fri, 26 Jun 2020 14:13:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3527C2D5784;
        Fri, 26 Jun 2020 14:13:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3527C2D5784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1593195230;
        bh=rgfmzezlHQeSavW8v52bXi4Rbl6TKxnTNKh4BFHPNto=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=gArX9VJJ022LDc57LKnaPQmJcjpzWEc6t2Jsu+V3hki16L8ucIEmvWA4/UG/fPVQT
         IGg00zIFG59B/96dlYc6X1wROwc4K9vp78jvbSbwrTnFVJnHFUNQYoZILGouonv4au
         lDkOyYQoAeO30Lf5ApPXux+pjO98cKVw0DcGSGf5Usph9eXIET/SvhKoiBYFWbMP3I
         DKvaIU6f+eZt14R/UBVUq/blJvtQIeAVZM2ZaNcSlewHKdSlYmp+oX8IoeMFwaUKkO
         jcjJhaEuoCKuc3KD/mooOh+HTn5kbUp9GMHP+Xpgu7dtPvNtrmC7otzkyhrPtcRpIS
         RuVKb2HnMRNVg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2-55afNXm-uG; Fri, 26 Jun 2020 14:13:50 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1F75F2D5783;
        Fri, 26 Jun 2020 14:13:50 -0400 (EDT)
Date:   Fri, 26 Jun 2020 14:13:50 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
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
Message-ID: <304619857.14491.1593195230002.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200626095801.14cfa8a3@oasis.local.home>
References: <20200625094454.732790f7@oasis.local.home> <1548518134.13177.1593107707149.JavaMail.zimbra@efficios.com> <20200625143525.2f3a2902@oasis.local.home> <79426976.13417.1593113702719.JavaMail.zimbra@efficios.com> <20200625223611.1dbb3b35@oasis.local.home> <20200625233552.2c8a0d1e@oasis.local.home> <20200626095801.14cfa8a3@oasis.local.home>
Subject: Re: [RFC][PATCH] ring-buffer: Have nested events still record
 running time stamp
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: ring-buffer: Have nested events still record running time stamp
Thread-Index: rFPgR5ao+c3L9lmc87zzrz2jETjodg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 26, 2020, at 9:58 AM, rostedt rostedt@goodmis.org wrote:

> On Thu, 25 Jun 2020 23:35:52 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> I have to think about this more, as I think there's a flaw in this
>> cmpxchg algorithm.
> 
> Bah, that was all wrong. I need to incorporate the seq counter into the
> time stamp. Luckily I only use 59 bits for a full time stamp (gives me
> 18 years of nanoseconds), which gives me 5 bits to pay with, and all I
> need is 4 (2 for top and 2 for bottom). Now I can make the timestamp 60
> bits with 30 bits from the top and 30 from the bottom, and using two
> bits in each of those as a sequence counter.
> 
> If after reading top and bottom, if the seq bits match, then the two
> match and can be put together as a valid number. Now I have this:

[...]
> 
> static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
> {
>	unsigned long top, bottom;
> 
>	top = local_read(&t->top);
>	bottom = local_read(&t->bottom);
> 
>	*cnt = rb_time_cnt(top);
> 
>	if (*cnt != rb_time_cnt(bottom))
>		return false;
> 
>	*ret = rb_time_val(top, bottom);
>	return true;
> }

If __rb_time_read or rb_time_cmpxchg are used in an interrupt over
rb_time_set (between setting top and bottom), those will never succeed.

How is this case handled ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
