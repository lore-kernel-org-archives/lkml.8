Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC270C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8041620789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EVsPRgGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407075AbgFYUDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:03:34 -0400
Received: from mail.efficios.com ([167.114.26.124]:55990 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406569AbgFYUDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:03:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 42FAC2CD658;
        Thu, 25 Jun 2020 16:03:31 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id a5j9EpxsXUmd; Thu, 25 Jun 2020 16:03:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EF3152CD657;
        Thu, 25 Jun 2020 16:03:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EF3152CD657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1593115411;
        bh=9qvWCyGskE3rDO/cGQ6PqB+tK53PgbIkItbp+K8bsLw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=EVsPRgGHs5lDGx8sSCo+Tef2tg/j4GjgnFoJGaG1wk4m7MjY+gcFND5gx1eWb6JEY
         8v4iQ3Huyp0ZfSUfI8sf/OrswTqtBTZw9/s/gZwXI9ynl+rHJceWOBTnIoP8chpYOl
         PdrjOD0RvrskpiocDcUeIxU8wdVFF4hgmGTdXO3Qk0itwcVLAagF8uIxXf3zLohGEM
         9frDRN3ohytmmrtUVIoCvBMLREpeidPKyteNsomCcgViQn+9XGLul/nCYcDgXxukSW
         KXjDGhj7m+t1T4Q+4u400aDR+nj4Qjin1LywkQS+k4+jYjW/5HRxfOSRNItQdjrKX9
         5jFhYOhLlSRWg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cM7iAJ366Eq8; Thu, 25 Jun 2020 16:03:30 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D87662CD6E4;
        Thu, 25 Jun 2020 16:03:30 -0400 (EDT)
Date:   Thu, 25 Jun 2020 16:03:30 -0400 (EDT)
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
Message-ID: <581134894.13457.1593115410860.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200625150922.08abe7e6@oasis.local.home>
References: <20200625094454.732790f7@oasis.local.home> <1548518134.13177.1593107707149.JavaMail.zimbra@efficios.com> <20200625150922.08abe7e6@oasis.local.home>
Subject: Re: [RFC][PATCH] ring-buffer: Have nested events still record
 running time stamp
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: ring-buffer: Have nested events still record running time stamp
Thread-Index: +7sgo34aw0ps44PfSv+1wlFGe49CgQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 25, 2020, at 3:09 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 25 Jun 2020 13:55:07 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> What are the types used for before_stamp and write_stamp ? If those
>> are 64-bit integers, how does sharing them between nested contexts
>> work on 32-bit architectures ?
> 
> BTW, I forgot to state in either of my two emails, THANK YOU!
> 
> I really appreciate the thorough review of this patch, and I welcome
> the challenges you give me to make sure I can verify all that I claim
> can happen.

You're welcome! I believe these discussions we've been having for the past
10+ years on ring buffer design have helped improve our respective projects.

I'm glad to be of service!

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
