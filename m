Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61817C2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FD220714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5ybvRGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgCZB4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:56:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46280 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgCZB4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 21:56:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id g7so4026243qtj.13;
        Wed, 25 Mar 2020 18:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9TtuwSbtWVDzWmu+qJ6L3Zgl2URii1uHTysKcz28f9s=;
        b=E5ybvRGlq50L3PdUjuWmg949g7ymbfpdogEjFzBWNRyFd1+sIib0thgSleAnrEouu2
         lWqX52wicKRD0Agnq6tDbkieC/EpoWTyL9j7UWjkCjp39XfQDwL9EiXn3p0yLvaNoiJC
         5keCAGaIBRSTTfqyVCHuHwR3lUHbrJHuQk8g66mDmSxuuOlDm0V46hgBhaMUVdiJXsVJ
         HXZROKrf5fhlFDdHDPTlKEqgacWRTsdr0G/qWrgq45Kz4YQWDjLzVsG8Rw1Sih/Bqzca
         mGmxu8zOwW56VjuQUDaPuQvwwhu8aQRiNz2fCzCnV9hWRBJqfRnBA+J+ZSlVBh/hxa5z
         rLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9TtuwSbtWVDzWmu+qJ6L3Zgl2URii1uHTysKcz28f9s=;
        b=cYBqPXJqZo06YBdTeuzTG5KqfSbugrRjmPw1xm3Mmo7D8EeGpaOzkbZEbVOwv4god3
         0J+hEuOD1GlgAif3I2qUKCGKUjUSeXBIF8LUSlCIc6foDGsK52hEqZq+EBlmdLGvaBV8
         /vNpzI/4rBwaPb/hfH5ONY3XKwH6LaHnlXPH+We3DsSXppgUeii2NN2z2zUIvQxk+wYP
         m8qe6WzZeSmvzo7HovsjMn5WpDQ366Fjuqw3no4ZJFvPug+BFK1jzAcfkRHkxWrHVPJn
         tYFrzKDB8SC2MvmlavyJiiPI3Yq5E9lMLqgxdbxWFOMlEmDR2vB7FMgmudAhxUohOrZI
         Y9cQ==
X-Gm-Message-State: ANhLgQ23VLIYVxyCyLI3DQ7ygNuhzVdlUWljyXWmgGeueAR4Zf0Zs7rc
        m204axWkNBVNVrPZ9+Qa6cE=
X-Google-Smtp-Source: ADFU+vs31z94RaOoesievI8Ge+X2oEz1wFYopBcHwWyZ/5R0Qvxb4moO0NG/B1FHTPlqYPJ5b9RCcg==
X-Received: by 2002:ac8:16b8:: with SMTP id r53mr6099076qtj.7.1585187781622;
        Wed, 25 Mar 2020 18:56:21 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id u51sm596798qth.46.2020.03.25.18.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 18:56:20 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] of: unittest: add overlay gpio test to catch gpio
 hog problem
From:   Frank Rowand <frowand.list@gmail.com>
To:     Anders Roxell <anders.roxell@linaro.org>, robh@kernel.org
Cc:     atull@kernel.org, devicetree@vger.kernel.org,
        geert+renesas@glider.be, linux-kernel@vger.kernel.org,
        pantelis.antoniou@konsulko.com
References: <1582224021-12827-1-git-send-email-frowand.list@gmail.com>
 <1582224021-12827-2-git-send-email-frowand.list@gmail.com>
 <20200226164206.GA10128@bogus>
 <60024e70-0abc-4a06-cd14-42c61a2d2597@gmail.com>
Message-ID: <b620ddd2-34a5-df5d-310f-4aa2f3e93a4a@gmail.com>
Date:   Wed, 25 Mar 2020 20:56:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <60024e70-0abc-4a06-cd14-42c61a2d2597@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/20 11:40 AM, Frank Rowand wrote:
> Hi Anders,
> 
> On 3/13/20 4:51 AM, Anders Roxell wrote:
>> From: Rob Herring <robh@kernel.org>
>>
>>> On Thu, 20 Feb 2020 12:40:20 -0600, frowand.list@gmail.com wrote:
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> Geert reports that gpio hog nodes are not properly processed when
>>>> the gpio hog node is added via an overlay reply and provides an
>>>> RFC patch to fix the problem [1].
>>>>
>>>> Add a unittest that shows the problem.  Unittest will report "1 failed"
>>>> test before applying Geert's RFC patch and "0 failed" after applying
>>>> Geert's RFC patch.
>>>>
>>>> [1] https://lore.kernel.org/linux-devicetree/20191230133852.5890-1-geert+renesas@glider.be/
>>>>
>>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>
>> I'm building arm64 on tag next-20200312, and booting in qemu, and I see
>> this "Kernel panic":
> 
> Thank you for the panic report.
> 
> There has also been an x86_64 failure (with a very different stack trace).
> I am going to investigate the x86_64 failure first.

I have fixed the x86_64 failure:

   https://lore.kernel.org/linux-devicetree/1585187131-21642-1-git-send-email-frowand.list@gmail.com/

Can you check if the two patches in that series fixes the problem that you
are seeing?

Thanks,

Frank


> 
> Can you please send the kernel .config?
> 
> Thanks,
> 
> Frank
> 
> 
>>
>> [...]
>> [  172.779435][    T1] systemd[1]: Mounted POSIX Message Queue File System.
>> [[0;32m  OK  [0m] Mounted POSIX Message Queue File System.
>> [  172.844551][    T1] systemd[1]: Mounted Huge Pages File System.
>> [[0;32m  OK  [0m] Mounted Huge Pages File System.
>> [  172.917332][    T1] systemd[1]: Mounted Debug File System.
>> [[0;32m  OK  [0m] Mounted Debug File System.
>> [  173.465694][  T251] _warn_unseeded_randomness: 6 callbacks suppressed
>> [  173.465803][  T251] random: get_random_u64 called from arch_mmap_rnd+0x94/0xb0 with crng_init=1
>> [  173.466000][  T251] random: get_random_u64 called from randomize_stack_top+0x4c/0xb0 with crng_init=1
>> [  173.466163][  T251] random: get_random_u32 called from arch_align_stack+0x6c/0x88 with crng_init=1
>> [  173.544157][    T1] systemd[1]: Started Create Static Device Nodes in /dev.
>> [[0;32m  OK  [0m] Started Create Static Device Nodes in /dev.
>> [  174.283422][  T240] Unable to handle kernel paging request at virtual address 978061b552800000
>> [  174.286169][  T240] Mem abort info:
>> [  174.303268][  T240]   ESR = 0x96000004
>> [  174.304652][  T240]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [  174.323298][  T240]   SET = 0, FnV = 0
>> [  174.324677][  T240]   EA = 0, S1PTW = 0
>> [  174.325937][  T240] Data abort info:
>> [  174.345383][  T240]   ISV = 0, ISS = 0x00000004
>> [  174.359310][  T240]   CM = 0, WnR = 0
>> [  174.360641][  T240] [978061b552800000] address between user and kernel address ranges
>> [  174.378712][  T240] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> [  174.381030][  T240] Modules linked in:
>> [  174.382362][  T240] CPU: 0 PID: 240 Comm: systemd-journal Tainted: G    B   W         5.6.0-rc5-next-20200312-00018-g5c00c2e7cf27 #6
>> [  174.386251][  T240] Hardware name: linux,dummy-virt (DT)
>> [  174.388056][  T240] pstate: 40400005 (nZcv daif +PAN -UAO)
>> [  174.389892][  T240] pc : sysfs_kf_seq_show+0x114/0x250
>> [  174.391638][  T240] lr : sysfs_kf_seq_show+0x114/0x250
>> [  174.393325][  T240] sp : ffff00006374faa0
>> [  174.394697][  T240] x29: ffff00006374faa0 x28: ffff000062620040 
>> [  174.396751][  T240] x27: ffff000062b0a010 x26: 978061b552800000 
>> [  174.398779][  T240] x25: ffff000068aae020 x24: ffff000068aae010 
>> [  174.400798][  T240] x23: ffff00006311c000 x22: ffff000064f4f800 
>> [  174.402794][  T240] x21: 0000000000001000 x20: ffff000068aae008 
>> [  174.404820][  T240] x19: 0000000000001000 x18: 0000000000000000 
>> [  174.406792][  T240] x17: 0000000000000000 x16: 0000000000000000 
>> [  174.408814][  T240] x15: 0000000000000000 x14: 0000000000000000 
>> [  174.410805][  T240] x13: ffff80000c623a00 x12: 1fffe0000c623800 
>> [  174.412829][  T240] x11: 1fffe0000c6239ff x10: ffff80000c6239ff 
>> [  174.414821][  T240] x9 : 0000000000000000 x8 : ffff00006311d000 
>> [  174.416865][  T240] x7 : 0000000000000000 x6 : 000000000000003f 
>> [  174.418907][  T240] x5 : 0000000000000040 x4 : 000000000000002d 
>> [  174.420932][  T240] x3 : ffffa000109a1274 x2 : 0000000000000001 
>> [  174.422924][  T240] x1 : ffffa00016010000 x0 : 0000000000000000 
>> [  174.424954][  T240] Call trace:
>> [  174.426097][  T240]  sysfs_kf_seq_show+0x114/0x250
>> [  174.427769][  T240]  kernfs_seq_show+0xa4/0xb8
>> [  174.429306][  T240]  seq_read+0x3a4/0x8e8
>> [  174.430678][  T240]  kernfs_fop_read+0x8c/0x6e0
>> [  174.432244][  T240]  __vfs_read+0x64/0xc0
>> [  174.433622][  T240]  vfs_read+0x158/0x2b0
>> [  174.435014][  T240]  ksys_read+0xfc/0x1e0
>> [  174.436427][  T240]  __arm64_sys_read+0x50/0x60
>> [  174.437944][  T240]  el0_svc_common.constprop.1+0x294/0x330
>> [  174.439795][  T240]  do_el0_svc+0xe4/0x100
>> [  174.441218][  T240]  el0_svc+0x70/0x80
>> [  174.442550][  T240]  el0_sync_handler+0xd0/0x7b4
>> [  174.444143][  T240]  el0_sync+0x164/0x180
>> [  174.445578][  T240] Code: aa1703e0 97f6e03a aa1a03e0 97f6e880 (f9400355) 
>> [  174.447885][  T240] ---[ end trace 5bcb796ff4270d74 ]---
>> [  174.449629][  T240] Kernel panic - not syncing: Fatal exception
>> [  174.451590][  T240] Kernel Offset: disabled
>> [  174.453005][  T240] CPU features: 0x80002,20002004
>> [  174.454597][  T240] Memory Limit: none
>> [  174.455955][  T240] ---[ end Kernel panic - not syncing: Fatal exception ]---
>>
>> When I say CONFIG_OF_UNITTEST=n it works.
>> If I revert there it starts to work when I revert the last one,
>> f4056e705b2e, from the list below:
>>
>> 485bb19d0b3e of: unittest: make gpio overlay test dependent on CONFIG_OF_GPIO
>> 0ac174397940 of: unittest: annotate warnings triggered by unittest
>> f4056e705b2e of: unittest: add overlay gpio test to catch gpio hog problem
>>
>> Cheers,
>> Anders
>>
>>>> ---
>>>>
>>>> changes since v1:
>>>>   - base on 5.6-rc1
>>>>   - fixed node names in overlays
>>>>   - removed unused fields from struct unittest_gpio_dev
>>>>   - of_unittest_overlay_gpio() cleaned up comments
>>>>   - of_unittest_overlay_gpio() moved saving global values into
>>>>     probe_pass_count and chip_request_count more tightly around
>>>>     test code expected to trigger changes in the global values
>>>>
>>>> v1 of this patch incorrectly reported that it had made changes
>>>> since the RFC version, but it was mistakenly created from the
>>>> wrong branch.
>>>>
>>>> There are checkpatch warnings.
>>>>   - New files are in a directory already covered by MAINTAINERS
>>>>   - The undocumented compatibles are restricted to use by unittest
>>>>     and should not be documented under Documentation
>>>>   - The printk() KERN_<LEVEL> warnings are false positives.  The level
>>>>     is supplied by a define parameter instead of a hard coded constant
>>>>   - The lines over 80 characters are consistent with unittest.c style
>>>>
>>>> This unittest was also valuable in that it allowed me to explore
>>>> possible issues related to the proposed solution to the gpio hog
>>>> problem.
>>>>
>>>>
>>>>  drivers/of/unittest-data/Makefile             |   8 +-
>>>>  drivers/of/unittest-data/overlay_gpio_01.dts  |  23 +++
>>>>  drivers/of/unittest-data/overlay_gpio_02a.dts |  16 ++
>>>>  drivers/of/unittest-data/overlay_gpio_02b.dts |  16 ++
>>>>  drivers/of/unittest-data/overlay_gpio_03.dts  |  23 +++
>>>>  drivers/of/unittest-data/overlay_gpio_04a.dts |  16 ++
>>>>  drivers/of/unittest-data/overlay_gpio_04b.dts |  16 ++
>>>>  drivers/of/unittest.c                         | 253 ++++++++++++++++++++++++++
>>>>  8 files changed, 370 insertions(+), 1 deletion(-)
>>>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_01.dts
>>>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_02a.dts
>>>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_02b.dts
>>>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_03.dts
>>>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_04a.dts
>>>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_04b.dts
>>>>
>>>
>>> Applied, thanks.
>>>
>>> Rob
>>
>>
> 
> 

