Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FFBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3771206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UIQ7MwSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgGFQsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbgGFQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:48:24 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D2CC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 09:48:24 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id h18so17500471qvl.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2JeP+ifXxK0uosoL0t3ljC8p7SwsLP3wIIhTZzlV8qA=;
        b=UIQ7MwSsHnew0rf3x2kYsf185a4CnXXLIzbGGEkIBIJLsIGkSaCxq0wgwcvZgfDoPC
         GdfKnajsjzpi58T46CiEZJFlcZyXOsLW2KDeK1OEpSIRo+xc/lhBZdwX4jofnh/e2bcl
         7b7Ggl9dwW1WGQoQinPG70YCIB2Py0+Xj6ydRKSz5AxYZvOa60hLvpgJilS20aXu+M8i
         OPAIAno7NjKP1z0oJ14HHuKv9wLLrCiJ8T/L5C3CUN6OsSL/4UFiICGb8g1i4Al/cmda
         c71xomgv3vK/OnxxOPY+ljqKj02oxpAXuJO6IrEPVmoFlkB+I/45NGkPaA/uJ4AZWLQU
         iTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2JeP+ifXxK0uosoL0t3ljC8p7SwsLP3wIIhTZzlV8qA=;
        b=mek1MZGgp2uiq2o0mygkAWUdYEIHmEv7+Ux0Z7tQ42sIydfiIgnYOto/Ci+G4412L9
         GKZIw2azeIBWMkT8wfQOgJUckgtFR9yielTgM8qVDKuMy+mxteMcFPh2f4Ihw/oVaP2Q
         A2pamj6FxCFehyjIVB8eZA6RvZMIyp6Jisd/ksOiH2clEXZ8SIZmQL2Kx67lwNWBw1Gy
         aT8APKu44PpcSedkVCJiFt3AuyjxCF/KhHYZnLL2vaVXuHjxJHxXWKfq8bNM1u28hfpM
         Wp7e2m+nrwVquSjKNuT+HxTYQWHmvwIy2Rpq/UnRseuUwrWJFR+w4WfCt2sgfyEX7c0w
         onNg==
X-Gm-Message-State: AOAM531Zt5W3RJeFUUISbOj4TCLL1a6aGQwtbiVGr1mHdiO8S9KISkH4
        xk48B3vTtnHSOvdTDhZK7k6Seg==
X-Google-Smtp-Source: ABdhPJzAUyC3KmVI5dUsMpVXDC7KjcBlVki2JUxLLotxbYe6lInEGwUWM3CF8YkAEIdOaDn62P7GDg==
X-Received: by 2002:a05:6214:72c:: with SMTP id c12mr45236733qvz.76.1594054103236;
        Mon, 06 Jul 2020 09:48:23 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 188sm19346978qkf.50.2020.07.06.09.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 09:48:22 -0700 (PDT)
Date:   Mon, 6 Jul 2020 12:48:16 -0400
From:   Qian Cai <cai@lca.pw>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH tick-sched] Clarify "NOHZ: local_softirq_pending" warning
Message-ID: <20200706164816.GA1299@lca.pw>
References: <20200626210506.GA27189@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626210506.GA27189@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:05:06PM -0700, Paul E. McKenney wrote:
> Currently, can_stop_idle_tick() prints "NOHZ: local_softirq_pending HH"
> (where "HH" is the hexadecimal softirq vector number) when one or more
> non-RCU softirq handlers are still enablded when checking to stop the
> scheduler-tick interrupt.  This message is not as enlightening as one
> might hope, so this commit changes it to "NOHZ tick-stop error: Non-RCU
> local softirq work is pending, handler #HH.
> 
> Reported-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

CPU hotplug will sometimes trigger this warning on linux-next from NUMA
bare-metal which the commit makes it feel more like errors.

[  267.734981] smpboot: CPU 42 is now offline
[  267.991940] smpboot: Booting Node 2 Processor 42 APIC 0x29
[  267.998370] numa_add_cpu cpu 42 node 2: mask now 8-11,40-43
[  268.092380] ACPI: \_SB_.SCK0.C015: Found 2 idle states
[  268.181917] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #282
[  268.190585] numa_remove_cpu cpu 1 node 0: mask now 0,2-3,32-35
[  268.194075] smpboot: CPU 1 is now offline
[  268.415320] x86: Booting SMP configuration:
[  268.420245] smpboot: Booting Node 0 Processor 1 APIC 0x2

# git clone https://github.com/cailca/linux-mm
# cd linux-mm; make
# ./random 4 (it just soft offline and online each CPU)

The x86.config is also included there. This is only reproducible on x86
so far.

> 
> ---
> 
>  tick-sched.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index f0199a4..349a25a 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -927,7 +927,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
>  
>  		if (ratelimit < 10 &&
>  		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
> -			pr_warn("NOHZ: local_softirq_pending %02x\n",
> +			pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x\n",
>  				(unsigned int) local_softirq_pending());
>  			ratelimit++;
>  		}
