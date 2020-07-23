Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A43C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44C6207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgGWN6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:58:07 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:39757 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728982AbgGWN6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:58:07 -0400
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 09BDA2002EE2B;
        Thu, 23 Jul 2020 15:58:05 +0200 (CEST)
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: `psi_avgs_work` shows up in PowerTOP
Message-ID: <054ebec6-ac67-2623-3aff-335c8919467c@molgen.mpg.de>
Date:   Thu, 23 Jul 2020 15:58:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Johannes,


On the Dell Latitude E7250 with Debian Sid/unstable and Linux 5.6.7, 
running `powertop`, `psi_avgs_work` shows up there with 40 mW to 60 mW.

> The battery reports a discharge rate of 7.16 W
> The power consumed was 147 J
> The estimated remaining time is 1 hours, 31 minutes
> 
> Summary: 795.2 wakeups/second,  0.0 GPU ops/seconds, 0.0 VFS ops/sec and 16.8% CPU use
> 
> Power est.              Usage       Events/s    Category       Description
>   2.62 W      5.5 ms/s     328.9        Timer          tick_sched_timer
>   817 mW     21.9 ms/s      99.9        Process        [PID 519673] firefox
>   521 mW      3.2 ms/s      65.1        Process        [PID 519710] firefox
>   270 mW      1.9 ms/s      33.8        Timer          hrtimer_wakeup
>   261 mW      0.4 pkts/s                Device         Network interface: eno1 (e1000e)
>   162 mW      4.7 ms/s      19.8        Process        [PID 520008] /usr/lib/firefox/firefox -contentproc
>   156 mW      4.0 ms/s      19.1        Process        [PID 519728] firefox
>   146 mW     16.0 ms/s      16.4        Process        [PID 72917] /usr/bin/gnome-shell
>   125 mW      5.8 ms/s      15.0        Process        [PID 518973] /usr/lib/thunderbird/thunderbird
>   121 mW    160.7 us/s      15.2        Process        [PID 11] [rcu_sched]
>   117 mW      5.2 ms/s      14.1        Process        [PID 520003] /usr/lib/firefox/firefox -contentproc
>   100 mW    100.0%                      Device         USB device: Fujitsu Keyboard (Fujitsu)
>   100 mW    100.0%                      Device         USB device: Jolla (Jolla)
>   100 mW      0.0%                      Device         Display backlight
>   100 mW    100.0%                      Device         USB device: USB Optical Mouse (Logitech)
>  95.4 mW    605.7 us/s      11.9        Process        [PID 519018] /usr/lib/thunderbird/thunderbird
>  91.3 mW      4.0 ms/s      11.0        Process        [PID 519906] /usr/lib/firefox/firefox -contentproc
>  84.9 mW     45.2 ms/s       5.0        kWork          intel_atomic_commit_work
>  80.1 mW      1.1 ms/s       9.9        Interrupt      [0] HI_SOFTIRQ
>  76.6 mW     30.1 us/s       9.6        kWork          kfree_rcu_monitor
>  75.8 mW     58.0 us/s       9.5        kWork          kfree_rcu_work
>  74.5 mW    269.4 us/s       9.3        kWork          engine_retire
>  62.5 mW      1.7 ms/s       7.6        Process        [PID 73223] ibus-daemon --panel disable -r --xim
>  59.6 mW     73.5 us/s       7.5        kWork          psi_avgs_work
>  56.9 mW      8.1 ms/s       6.1        Process        [PID 72956] /usr/bin/Xwayland :0 -rootless -norese
>  54.7 mW      4.7 ms/s       6.3        Interrupt      [7] sched(softirq)
>  54.0 mW     32.1 us/s       6.8        Timer          intel_uncore_fw_release_timer
> […]

Is that expected to show? I guess due to the granularity it is?


Kind regards,

Paul
