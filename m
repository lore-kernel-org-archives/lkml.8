Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19AFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24C820B80
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgFPMSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:18:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52324 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgFPMSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:18:16 -0400
Received: from mail-ej1-f69.google.com ([209.85.218.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1jlAVr-0001WZ-My
        for linux-kernel@vger.kernel.org; Tue, 16 Jun 2020 12:16:23 +0000
Received: by mail-ej1-f69.google.com with SMTP id s4so9334509eju.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uSiEfAqqR7fvXOn2pGb0zZk/ANl8osJ8htzBpR8+Og0=;
        b=o/DJCj2OP6K1wnKdmD00HRl4BShp9hbJTlo9kZCK0dCamwFa/3KtckypGpHkbIp5L+
         kHsJrPCNB/8u+HZyPTK49siJmpsfamPJGFkXkATwMt9MFjNs6LG23Y2LCwt+SzBGXhSX
         biKn3JLSis7Kce38EZx+hrnieh3g4fCZaxdnsIb5mVMWS5Xs54/8QmXnhV5sAYfYh4Se
         PwLboQUT/RxtLynsuWl5vviK/S8zvZAI66PZ8Aw/FX6K11sVeQTlo2isn3xppCvMFKcr
         +ZnvzSfSznBHBZn5dQ+3n3XRFvpTwIzCN0rdwAPmB32+l1rpuNjreg0P1t4HyEdGsrJ4
         gC9g==
X-Gm-Message-State: AOAM530YnS3MkSMb63l+vRfuO8yAatxDT23Re+7wyX1EKAORxlvtl6Jp
        HMsYyGVlUqaH5hw7drngGJlGNvnTZ7KlFfeHj5CU9HsMK0omGkvKn6Bw8IqQtJhYZIpS5LQ0HsV
        7nmnY56FSjIJ19g6FPHc2aG3tMY2Rfgm10eI8SPYYV5TEDmVuUL9wzl3zzw==
X-Received: by 2002:a17:906:7f84:: with SMTP id f4mr2421576ejr.482.1592309783315;
        Tue, 16 Jun 2020 05:16:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRf01weiozezGWpOuTw/Ljoemb8IOy896dOLcGjhU0I1Y8MkoUPVNeqcN5Mb++pNPXU6iqhZuUbsK0OPh4CYY=
X-Received: by 2002:a17:906:7f84:: with SMTP id f4mr2421546ejr.482.1592309782997;
 Tue, 16 Jun 2020 05:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200616073833.GF5653@shao2-debian> <55e7a318-9021-f350-c80f-bc95070568fb@suse.cz>
In-Reply-To: <55e7a318-9021-f350-c80f-bc95070568fb@suse.cz>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Tue, 16 Jun 2020 09:15:47 -0300
Message-ID: <CAHD1Q_yxYB9UX4he8CeZMzdr8MhQAzrZtgc5+TsnWRv_dgMSfA@mail.gmail.com>
Subject: Re: [kernel/watchdog.c] f117955a22: kmsg.Failed_to_set_sysctl_parameter'kernel.softlockup_panic=#':parameter_not_found
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vlastimil! I agree with you..it's a good new behavior to report
that case, I guess.
Cheers,


Guilherme

On Tue, Jun 16, 2020 at 5:02 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 6/16/20 9:38 AM, kernel test robot wrote:
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: f117955a2255721a6a0e9cecf6cad3a6eb43cbc3 ("kernel/watchdog.c: convert {soft/hard}lockup boot parameters to sysctl aliases")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > in testcase: boot
> >
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> >
> >
> >
> > [    5.306502] netconsole: network logging started
> > [    5.793973] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
> > [    5.804702] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
> > [    5.828198] Sending DHCP requests ., OK
> > [    5.829815] IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0.2.15
> > [    5.831412] IP-Config: Complete:
> > [    5.832501]      device=eth0, hwaddr=52:54:00:12:34:56, ipaddr=10.0.2.15, mask=255.255.255.0, gw=10.0.2.2
> > [    5.835246]      host=vm-snb-ssd-19, domain=, nis-domain=(none)
> > [    5.836806]      bootserver=10.0.2.2, rootserver=10.0.2.2, rootpath=
> > [    5.836808]      nameserver0=10.0.2.3
> > [    5.839613] ALSA device list:
> > [    5.857103]   No soundcards found.
> > [    5.860706] Freeing unused kernel image (initmem) memory: 1540K
> > [    5.868210] Write protecting the kernel read-only data: 20480k
> > [    5.870913] Freeing unused kernel image (text/rodata gap) memory: 2044K
> > [    5.872636] Freeing unused kernel image (rodata/data gap) memory: 68K
> > [    5.874149] rodata_test: all tests were successful
> > [    5.875553] Failed to set sysctl parameter 'kernel.softlockup_panic=1': parameter not found
>
> In case the line above is the reason for this report, then it's because .config has:
>
> # CONFIG_SOFTLOCKUP_DETECTOR is not set
>
> While previously the softlockup_panic=1 parameter would be just silently ignored
> in that case. I don't think it's wrong to report it, though.
>
> > [    5.896259] Run /init as init process
> > [    5.897454]   with arguments:
> > [    5.898493]     /init
> > [    5.899418]   with environment:
> > [    5.900468]     HOME=/
> > [    5.901346]     TERM=linux
> > [    5.902311]     user=lkp
> > [    5.903266]     job=/lkp/jobs/scheduled/vm-snb-ssd-19/boot-1-debian-i386-20191205.cgz-f117955a2255721a6a0e9cecf6cad3a6eb43cbc3-20200615-43661-1fqppwn-3.yaml
> > [    5.906363]     ARCH=x86_64
> > [    5.907358]     kconfig=x86_64-kexec
> > [    5.908495]     branch=linus/master
> > [    5.909564]     commit=f117955a2255721a6a0e9cecf6cad3a6eb43cbc3
> > [    5.910982]     BOOT_IMAGE=/pkg/linux/x86_64-kexec/gcc-9/f117955a2255721a6a0e9cecf6cad3a6eb43cbc3/vmlinuz-5.7.0-12506-gf117955a22557
> > [    5.913735]     max_uptime=600
> > [    5.914651]     RESULT_ROOT=/result/boot/1/vm-snb-ssd/debian-i386-20191205.cgz/x86_64-kexec/gcc-9/f117955a2255721a6a0e9cecf6cad3a6eb43cbc3/3
> > [    5.917437]     LKP_SERVER=inn
> > [    5.918425]     selinux=0
> > [    5.919398]     softlockup_panic=1
> > [    5.920495]     nmi_watchdog=panic
> > [    5.925722]     prompt_ramdisk=0
> > [    5.926843]     vga=normal
> > [    5.927739]     watchdog_thresh=60
> > [    5.934222] systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
> > [    5.937449] systemd[1]: Failed to insert module 'autofs4': No such file or directory
> > [    5.941850] random: systemd: uninitialized urandom read (16 bytes read)
> > [    5.947176] random: systemd: uninitialized urandom read (16 bytes read)
> >
> >
> > To reproduce:
> >
> >         # build kernel
> >       cd linux
> >       cp config-5.7.0-12506-gf117955a22557 .config
> >       make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> >
> >
> >
> > Thanks,
> > Rong Chen
> >
>
