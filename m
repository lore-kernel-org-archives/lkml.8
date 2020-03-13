Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9B2C5ACC0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6974B206E9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgCMRaE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgCMRaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:30:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA224206BE;
        Fri, 13 Mar 2020 17:30:00 +0000 (UTC)
Date:   Fri, 13 Mar 2020 13:29:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     Konstantin Kharlamov <hi-angel@yandex.ru>,
        linux-modules <linux-modules@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFE] Who's using a module?
Message-ID: <20200313132958.29029440@gandalf.local.home>
In-Reply-To: <CAKi4VAK6_vNdh3JYV11TwCDAFCBozaHhUQ-vVWj-hr63B=80HQ@mail.gmail.com>
References: <b623f4a2-8b9b-edd9-3546-281155d90d4a@yandex.ru>
        <CAKi4VAK6_vNdh3JYV11TwCDAFCBozaHhUQ-vVWj-hr63B=80HQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Mar 2020 09:22:33 -0700
Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:

> +Jessica +Steve +lkml
> 
> On Wed, Mar 11, 2020 at 6:33 AM Konstantin Kharlamov <hi-angel@yandex.ru> wrote:
> >
> > Once in a while there's a need to remove a module (for example because you rebuilt it, or to reload it with different parameters, or whatever…). And then doing `rmmod modulename` and `modprobe -r modulename` gives:
> >
> >         rmmod: ERROR: Module modulename is in use
> >
> > If you're lucky, firing up `lsmod | grep modulename` will get you offenders inside "used by" column. But often there's nothing except the count above zero. It is very easy to reproduce if you check `lsmod` output for your graphics driver. I checked it on `i915` and `amdgpu`: when graphics session is opened you can't remove it and `lsmod` doesn't show who's using it.
> >
> > There's very popular and old question on SO¹ that at the moment has over 55k views, and the only answer that seem to work for people is insanely big and convoluted; it is using a custom kernel driver and kernel tracing capabilities. I guess this amount of research means: no, currently there's no easy way to get who's using a module.
> >
> > It would be amazing if kernel has capability to figure out who's using a module.  
> 
> Yeah, right now this would need some work on the kernel side to record
> the callers of try_module_get()/__module_get()... usually done e.g on
> fops-like structs in a owner field.
> The only thing we have there right now is the trace. The trace is not
> so bad since it can be added in the kernel command line, but would
> usually only be enabled while debugging.
> 
> For implementing such a feature I think we would need to add/remove
> module owner into the mod struct whenever we have a _get()/_put().
> Maybe it's worth it, but it doesn't
> come without overhead. I'd like to hear what other people think.

I believe that the issue is a task did a get on the module and hasn't
released it. As it is using that module. If anything, you can trace all the
function of the module if it isn't loaded yet. Simply do the following:

 # trace-cmd start -p function -l :mod:modname -e module_get -f 'name == "modname"' -R stacktrace
 # modprobe modname
 # trace-cmd show

For example I did the following:

 # trace-cmd start -p function -l :mod:ebtables -e module_get -f 'name == "ebtables"' -R stacktrace
  plugin 'function'
 # modprobe ebtable_filter
 # trace-cmd show
# tracer: function
#
# entries-in-buffer/entries-written: 7/7   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
        modprobe-1720  [001] ....   823.724284: ebtables_init <-do_one_initcall
        modprobe-1720  [001] ...1   823.724989: module_get: ebtables call_site=ref_module refcnt=2
        modprobe-1720  [001] ...2   823.724995: <stack trace>
 => trace_event_raw_event_module_refcnt
 => try_module_get.part.50
 => ref_module
 => resolve_symbol
 => load_module
 => __do_sys_finit_module
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
 => 0xc032e68fffffffff
 => 0x2946ffffffff
 => 0x68600000001
 => hp_wmi_perform_query
 => ebtables_init
 => 0x1020e9006
 => 0xc08e900000000686
 => 0xc032e6baffffffff
        modprobe-1720  [001] ....   823.725147: ebt_register_table <-ops_init
        modprobe-1720  [001] ....   823.725153: translate_table <-ebt_register_table
        modprobe-1720  [001] ....   823.725296: ebt_register_table <-ops_init
        modprobe-1720  [001] ....   823.725301: translate_table <-ebt_register_table

Not sure if this is something you are looking for.

-- Steve


> 
> 
> >
> > 1: https://stackoverflow.com/questions/448999/is-there-a-way-to-figure-out-what-is-using-a-linux-kernel-module
> >
> > P.S.: please, add me to CC when replying, I'm not subscribed to the list.  
> 
> 
> 
> --
> Lucas De Marchi

