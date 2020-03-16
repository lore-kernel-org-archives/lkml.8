Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0D6C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827B420679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584380055;
	bh=d0dyqr+WPlsBEneLL+p3TFD21XBLfy5yd1BTLM2pOqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dt7aEKyYDWReRJ1Qu13jhKFwwUiDHA08rB5T7y7f1QqWSiPtCtCZyq38rzYkJRHx5
	 PLzudVD8ZWCpP3qbfbjPKTmLDY4PDTAFrdhZ+CtA1PUq0/Xl6dYwPQEMSS0JGAcbna
	 B9u0pJvR75+mIeS+BvmWzVRX37mcYlFwHkW7bVo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbgCPReO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730437AbgCPReO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:34:14 -0400
Received: from linux-8ccs (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74552205ED;
        Mon, 16 Mar 2020 17:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584380053;
        bh=d0dyqr+WPlsBEneLL+p3TFD21XBLfy5yd1BTLM2pOqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhADrUyBNJ9VsmcG8CWy4JLDr8n4UU6MCERPUNwVIncQoHdMNwcglKAgMWdvaCMt5
         51YYhzTYTmkKIhf4BF/9eDxVEfAcFs2HAFiR7R7ehrlIb0ktINZr7sl6Gl6BEiU3uP
         xjvbPlFjW1gKsb42WQ8zwZTUASeasyUesRfzel3M=
Date:   Mon, 16 Mar 2020 18:34:09 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     Konstantin Kharlamov <hi-angel@yandex.ru>,
        linux-modules <linux-modules@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFE] Who's using a module?
Message-ID: <20200316173408.GA6841@linux-8ccs>
References: <b623f4a2-8b9b-edd9-3546-281155d90d4a@yandex.ru>
 <CAKi4VAK6_vNdh3JYV11TwCDAFCBozaHhUQ-vVWj-hr63B=80HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKi4VAK6_vNdh3JYV11TwCDAFCBozaHhUQ-vVWj-hr63B=80HQ@mail.gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Lucas De Marchi [13/03/20 09:22 -0700]:
>+Jessica +Steve +lkml
>
>On Wed, Mar 11, 2020 at 6:33 AM Konstantin Kharlamov <hi-angel@yandex.ru> wrote:
>>
>> Once in a while there's a need to remove a module (for example because you rebuilt it, or to reload it with different parameters, or whatever…). And then doing `rmmod modulename` and `modprobe -r modulename` gives:
>>
>>         rmmod: ERROR: Module modulename is in use
>>
>> If you're lucky, firing up `lsmod | grep modulename` will get you offenders inside "used by" column. But often there's nothing except the count above zero. It is very easy to reproduce if you check `lsmod` output for your graphics driver. I checked it on `i915` and `amdgpu`: when graphics session is opened you can't remove it and `lsmod` doesn't show who's using it.
>>
>> There's very popular and old question on SO¹ that at the moment has over 55k views, and the only answer that seem to work for people is insanely big and convoluted; it is using a custom kernel driver and kernel tracing capabilities. I guess this amount of research means: no, currently there's no easy way to get who's using a module.
>>
>> It would be amazing if kernel has capability to figure out who's using a module.
>
>Yeah, right now this would need some work on the kernel side to record
>the callers of try_module_get()/__module_get()... usually done e.g on
>fops-like structs in a owner field.
>The only thing we have there right now is the trace. The trace is not
>so bad since it can be added in the kernel command line, but would
>usually only be enabled while debugging.
>
>For implementing such a feature I think we would need to add/remove
>module owner into the mod struct whenever we have a _get()/_put().
>Maybe it's worth it, but it doesn't
>come without overhead. I'd like to hear what other people think.

Hmm, we technically have mod->source_list and mod->target_list
already, which keeps track of modules that depend on THIS_MODULE and
modules that THIS_MODULE depends on, respectively. However, this is
limited to symbol dependencies only, which is what is shown in lsmod
in the Used By field. In other words, we currently only keep track of
module dependencies when a module uses a symbol from another module.

Indeed, it could be nice to keep track of try_module_get() callers,
but I'm afraid this is not as trivial as simply adding owner to
mod->source_list when try_module_get() is called. try_module_get() and
module_put() are designed to be quick and callable from interrupt and
process context, and mod->{source,target}_list are protected by the
module_mutex. Even if we could use module_mutex, it may increase lock
contention considerably. So the locking scheme would have to be
reworked to make this happen. I suppose this could be introduced as a
DEBUG option, and I'd welcome a patch if there's someone out there
interested in picking up the legwork. But I don't get the feeling
that the demand for this is that high (perhaps I'm totally wrong?),
especially for something that ftrace could report on much better. I
could for example trace all module_get's and put's from boot and see
which processes and even the call sites where these calls stem from.
E.g., if I enable tracing in /sys/kernel/debug/tracing/events/module/module_{get,put}
(and filter name == "i915"), you'd see output like:

               X-2404  [000] ....  2334.643888: module_put: i915 call_site=dma_buf_release refcnt=33
               X-2404  [000] ....  2334.643990: module_put: i915 call_site=dma_buf_release refcnt=32
        kwin_x11-2877  [007] ....  2334.645605: module_get: i915 call_site=dma_buf_export refcnt=33
        kwin_x11-2877  [007] ....  2334.650827: module_get: i915 call_site=dma_buf_export refcnt=34

Of course, you'd have to know to enable tracing before the problem
occurs..

Hope that helps clarify things a bit,

Jessica
