Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70FDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9783B2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSDyLpd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgGOWOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOWN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:13:59 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33567C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:13:59 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d1so2974852plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hPolnAcEPImDBRIWPgPqyudTNM+MItweaMqp0DHw7xw=;
        b=aSDyLpd+/7Fj/Rro38XcMmgi78rLjpTg3gTtbdxqENEd0tChDb9/xROEvtUUdgTAJQ
         SBKfz6qpXTlFJcQ3EuvndpziICIAzIb7kISnZE5pDa3M4S4EoSBwdYDGjxJ3zewGKBXK
         qJnE2wZ1+Yr6yUCzoJGXWn30VsUluIwxPVuIE5RW9boznXh2yINhkzVih+uh6t1KuENR
         b0w8LgMzAs2tJP4Ca/S/Ue+FZYkka5poRu/ftx0rKldGCxvijAYKsunfJw3Y21Kwtt1V
         xHJHjtt9a+NC2JblV/+H8A2g79GjsuV7QI9lguw1CAQg9aUGhoWJdgs/EtARF8w3yryd
         58tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hPolnAcEPImDBRIWPgPqyudTNM+MItweaMqp0DHw7xw=;
        b=iMLo+avNax+55tmMsHTnWcZZ8GspsEM05/KbXViKT2WWV/akznGyr17VZrM7seoZWi
         sXqwDou4lekgKBcUTbmoW6UBGHrGCXqZnsebzEsne5/8cqqaqwkcMdQeb2gMYMWAAlCB
         TDm80ixhBAEOylxff2r00+x/19uvb6SlI4paM3IgiRmodLNZ+M8HREZqpAwiG1abYv4N
         DUgOQJx5siMMX/AF63pod3hL/px3Iwbjb00wQSsclTQnOjE/YAmIWdimqx99c0QZYhFv
         DjzmQL2pfno1It6ABAPrzXTWVwrDu5M70c8GzVk6QQKaqOubAPw67NfKQ+VLvXgtdmaD
         nWVg==
X-Gm-Message-State: AOAM53113TckVtTULygULbSDtF3OgVYLa96XHwkgZaVYnaMNpAeynBRa
        t/ze0PDgpGJnIccqy3RNlRU=
X-Google-Smtp-Source: ABdhPJw6YZj0QTHARxlKSg1VMOoFOt6Ol1eer2pQpU+Mds5lKEOzv8HrjSfC2OiMQuPEFK3USBVXwA==
X-Received: by 2002:a17:90b:46cb:: with SMTP id jx11mr1685603pjb.79.1594851238683;
        Wed, 15 Jul 2020 15:13:58 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m3sm3045304pfk.171.2020.07.15.15.13.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 15:13:57 -0700 (PDT)
Date:   Wed, 15 Jul 2020 15:13:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 1/3] driver core: Expose device link details in sysfs
Message-ID: <20200715221356.GA219557@roeck-us.net>
References: <20200521191800.136035-1-saravanak@google.com>
 <20200521191800.136035-2-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521191800.136035-2-saravanak@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 21, 2020 at 12:17:58PM -0700, Saravana Kannan wrote:
> It's helpful to be able to look at device link details from sysfs. So,
> expose it in sysfs.
> 
> Say device-A is supplier of device-B. These are the additional files
> this patch would create:
> 
> /sys/class/devlink/device-A:device-B/
> 	auto_remove_on
> 	consumer/ -> .../device-B/
> 	runtime_pm
> 	status
> 	supplier/ -> .../device-A/
> 	sync_state_only
> 
> /sys/devices/.../device-A/
> 	consumer:device-B/ -> /sys/class/devlink/device-A:device-B/
> 
> /sys/devices/.../device-B/
> 	supplier:device-A/ -> /sys/class/devlink/device-A:device-B/
> 
> That way:
> To get a list of all the device link in the system:
> ls /sys/class/devlink/
> 
> To get the consumer names and links of a device:
> ls -d /sys/devices/.../device-X/consumer:*
> 
> To get the supplier names and links of a device:
> ls -d /sys/devices/.../device-X/supplier:*
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>

This patch creates a lot of noise in linux-next when booting various
qemu images. Example log output as well as bisect results below.
Reverting the patch fixes the problem.

Guenter

---
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 13, name: kworker/0:1
2 locks held by kworker/0:1/13:
 #0: c78048a4 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x1a0/0x728
 #1: c78ebf18 ((work_completion)(&sdp->work)){+.+.}-{0:0}, at: process_one_work+0x1a0/0x728
Preemption disabled at:
[<c0085bb4>] srcu_invoke_callbacks+0xc0/0x158
CPU: 0 PID: 13 Comm: kworker/0:1 Not tainted 5.8.0-rc5-next-20200715 #1
Hardware name: Freescale i.MX25 (Device Tree Support)
Workqueue: rcu_gp srcu_invoke_callbacks
[<c0010fe4>] (unwind_backtrace) from [<c000e740>] (show_stack+0x10/0x18)
[<c000e740>] (show_stack) from [<c050985c>] (dump_stack+0x20/0x2c)
[<c050985c>] (dump_stack) from [<c00496e4>] (___might_sleep+0x1d0/0x2cc)
[<c00496e4>] (___might_sleep) from [<c09105e8>] (__mutex_lock+0x38/0x654)
[<c09105e8>] (__mutex_lock) from [<c0910c20>] (mutex_lock_nested+0x1c/0x28)
[<c0910c20>] (mutex_lock_nested) from [<c05b25dc>] (device_del+0x2c/0x3f0)
[<c05b25dc>] (device_del) from [<c05b2a10>] (__device_link_free_srcu+0x50/0x64)
[<c05b2a10>] (__device_link_free_srcu) from [<c0085bc4>] (srcu_invoke_callbacks+0xd0/0x158)
[<c0085bc4>] (srcu_invoke_callbacks) from [<c003ad2c>] (process_one_work+0x284/0x728)
[<c003ad2c>] (process_one_work) from [<c003b1fc>] (worker_thread+0x2c/0x52c)
[<c003b1fc>] (worker_thread) from [<c0042df8>] (kthread+0x154/0x180)
[<c0042df8>] (kthread) from [<c0008530>] (ret_from_fork+0x14/0x24)
Exception stack(0xc78ebfb0 to 0xc78ebff8)
bfa0:                                     00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
BUG: scheduling while atomic: kworker/0:1/13/0x00000201
3 locks held by kworker/0:1/13:
 #0: c78048a4 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x1a0/0x728
 #1: c78ebf18 ((work_completion)(&sdp->work)){+.+.}-{0:0}, at: process_one_work+0x1a0/0x728
 #2: c0cf5710 (gdp_mutex){+.+.}-{3:3}, at: cleanup_glue_dir.part.14+0x14/0xa0
Modules linked in:
Preemption disabled at:
[<c0085bb4>] srcu_invoke_callbacks+0xc0/0x158
CPU: 0 PID: 13 Comm: kworker/0:1 Tainted: G        W         5.8.0-rc5-next-20200715 #1
Hardware name: Freescale i.MX25 (Device Tree Support)
Workqueue: rcu_gp srcu_invoke_callbacks
[<c0010fe4>] (unwind_backtrace) from [<c000e740>] (show_stack+0x10/0x18)
[<c000e740>] (show_stack) from [<c050985c>] (dump_stack+0x20/0x2c)
[<c050985c>] (dump_stack) from [<c0049910>] (__schedule_bug+0x88/0xf0)
[<c0049910>] (__schedule_bug) from [<c090e148>] (__schedule+0x5f0/0x824)
[<c090e148>] (__schedule) from [<c090e3d0>] (schedule+0x54/0x128)
[<c090e3d0>] (schedule) from [<c090e838>] (schedule_preempt_disabled+0x14/0x28)
[<c090e838>] (schedule_preempt_disabled) from [<c0910744>] (__mutex_lock+0x194/0x654)
[<c0910744>] (__mutex_lock) from [<c0910c20>] (mutex_lock_nested+0x1c/0x28)
[<c0910c20>] (mutex_lock_nested) from [<c05b1d5c>] (cleanup_glue_dir.part.14+0x14/0xa0)
[<c05b1d5c>] (cleanup_glue_dir.part.14) from [<c05b296c>] (device_del+0x3bc/0x3f0)
[<c05b296c>] (device_del) from [<c05b2a10>] (__device_link_free_srcu+0x50/0x64)
[<c05b2a10>] (__device_link_free_srcu) from [<c0085bc4>] (srcu_invoke_callbacks+0xd0/0x158)
[<c0085bc4>] (srcu_invoke_callbacks) from [<c003ad2c>] (process_one_work+0x284/0x728)
[<c003ad2c>] (process_one_work) from [<c003b1fc>] (worker_thread+0x2c/0x52c)
[<c003b1fc>] (worker_thread) from [<c0042df8>] (kthread+0x154/0x180)
[<c0042df8>] (kthread) from [<c0008530>] (ret_from_fork+0x14/0x24)
Exception stack(0xc78ebfb0 to 0xc78ebff8)
bfa0:                                     00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
------------[ cut here ]------------

---
# bad: [ca0e494af5edb59002665bf12871e94b4163a257] Add linux-next specific files for 20200715
# good: [11ba468877bb23f28956a35e896356252d63c983] Linux 5.8-rc5
git bisect start 'HEAD' 'v5.8-rc5'
# good: [8a21074e4724ce86b4e1a8fdc271081a86303014] Merge remote-tracking branch 'crypto/master'
git bisect good 8a21074e4724ce86b4e1a8fdc271081a86303014
# good: [71f459b5cd96681f615e5c920b3a38ab89e8b5f1] Merge remote-tracking branch 'audit/next'
git bisect good 71f459b5cd96681f615e5c920b3a38ab89e8b5f1
# bad: [5a310f73f874211ee7aa570b308d50def85aff1c] Merge remote-tracking branch 'thunderbolt/next'
git bisect bad 5a310f73f874211ee7aa570b308d50def85aff1c
# good: [db01f1b1e840f46bdd64c6c846e7b3246bdff55a] Merge remote-tracking branch 'kvm/linux-next'
git bisect good db01f1b1e840f46bdd64c6c846e7b3246bdff55a
# bad: [89947fbc4b34bfdef7ade2b26274e78b32d4e39f] Merge remote-tracking branch 'usb/usb-next'
git bisect bad 89947fbc4b34bfdef7ade2b26274e78b32d4e39f
# bad: [c845fc08689b52c05c0201614ac89f7978caa169] Merge remote-tracking branch 'driver-core/driver-core-next'
git bisect bad c845fc08689b52c05c0201614ac89f7978caa169
# good: [4621ddca720ceb9b45725acd428e0389e3c0b59b] Merge remote-tracking branch 'drivers-x86/for-next'
git bisect good 4621ddca720ceb9b45725acd428e0389e3c0b59b
# good: [fac3dee864e971dff81dd4969c361b2b373109c0] Merge remote-tracking branch 'leds/for-next'
git bisect good fac3dee864e971dff81dd4969c361b2b373109c0
# good: [55c7549819e438f40a3ef1d8ac5c38b73390bcb7] scripts: add dummy report mode to add_namespace.cocci
git bisect good 55c7549819e438f40a3ef1d8ac5c38b73390bcb7
# good: [fe940d7362e6d7a5e5086581d0462e00ba766992] driver core: Drop mention of obsolete bus rwsem from kernel-doc
git bisect good fe940d7362e6d7a5e5086581d0462e00ba766992
# bad: [da6d647598a6d182eb6a0344a7b14ae005244399] driver core: Add waiting_for_supplier sysfs file for devices
git bisect bad da6d647598a6d182eb6a0344a7b14ae005244399
# bad: [8fd456ec0cf03875908d6b67c1cd20cf0a7b4474] driver core: Add state_synced sysfs file for devices that support it
git bisect bad 8fd456ec0cf03875908d6b67c1cd20cf0a7b4474
# bad: [287905e68dd29873bcb7986a8290cd1e4cfde600] driver core: Expose device link details in sysfs
git bisect bad 287905e68dd29873bcb7986a8290cd1e4cfde600
# first bad commit: [287905e68dd29873bcb7986a8290cd1e4cfde600] driver core: Expose device link details in sysfs
