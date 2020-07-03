Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6B9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84152088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgGCOt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:49:59 -0400
Received: from foss.arm.com ([217.140.110.172]:40990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgGCOt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:49:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09ED831B;
        Fri,  3 Jul 2020 07:49:58 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 09A363F73C;
        Fri,  3 Jul 2020 07:49:56 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        lukasz.luba@arm.com
Subject: Re: [PATCH] firmware: arm_scmi: Fix SCMI Generic Power Domain probing
Date:   Fri,  3 Jul 2020 15:49:46 +0100
Message-Id: <159378759580.7741.1360234334350850998.b4-ty@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619220330.12217-1-cristian.marussi@arm.com>
References: <20200619220330.12217-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 23:03:30 +0100, Cristian Marussi wrote:
> When, at probe time, an SCMI communication failure inhibits the capacity to
> query power domains states, such domains should be skipped.
> 
> Registering partially initialized SCMI Power Domains with GenPD causes a
> Kernel panic.
> 
> [  292.593774] arm-scmi firmware:scmi: timed out in resp(caller: scmi_power_state_get+0xa4/0xd0)
> [  292.602369] scmi-power-domain scmi_dev.2: failed to get state for domain 9
> [  292.609366] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [  292.618190] Mem abort info:
> [  292.620982]   ESR = 0x96000006
> [  292.624065]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  292.629403]   SET = 0, FnV = 0
> [  292.632474]   EA = 0, S1PTW = 0
> [  292.635641] Data abort info:
> [  292.638542]   ISV = 0, ISS = 0x00000006
> [  292.642396]   CM = 0, WnR = 0
> [  292.645364] user pgtable: 4k pages, 48-bit VAs, pgdp=00000009f3691000
> [  292.651838] [0000000000000000] pgd=00000009f1ca0003, p4d=00000009f1ca0003, pud=00000009f35ea003, pmd=0000000000000000
> [  292.662504] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> [  292.672272] CPU: 2 PID: 381 Comm: bash Not tainted 5.8.0-rc1-00011-gebd118c2cca8 #2
> [  292.679938] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jan  3 2020
>    292.662504] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> [  292.702221] pstate: 80000005 (Nzcv daif -PAN -UAO BTYPE=--)
> [  292.707803] pc : of_genpd_add_provider_onecell+0x98/0x1f8
> [  292.713207] lr : of_genpd_add_provider_onecell+0x48/0x1f8
> [  292.718609] sp : ffff80001325bb50
> [  292.721922] x29: ffff80001325bb50 x28: ffff000974b28ec0
> [  292.727240] x27: ffff000971c11380 x26: ffff80001235b200
> [  292.732558] x25: ffff00097eff82c0 x24: 0000000000000001
> [  292.737874] x23: 00000000ffffffea x22: ffff00097eff82a8
> [  292.743191] x21: ffff80001235b1e0 x20: 0000000000000000
> [  292.748507] x19: ffff000974b2c080 x18: 0000000000000010
> [  292.753823] x17: 0000000000000000 x16: 0000000000000000
> [  292.759140] x15: ffffffffffffffff x14: ffff800012139948
> [  292.764456] x13: ffff80009325b817 x12: ffff80001325b81f
> [  292.769772] x11: ffff80001215a000 x10: 0000000000000a10
> [  292.775089] x9 : ffff800010970e08 x8 : ffff000974e84370
> [  292.780405] x7 : 00000000ffffffff x6 : ffff00097ef5c1f0
> [  292.785721] x5 : ffff00097ef5c1f0 x4 : 0000000000000000
> [  292.791038] x3 : ffff80001235b1e0 x2 : fffffffffffffc28
> [  292.796354] x1 : 000000000000000a x0 : ffff000971c11680
> [  292.801671] Call trace:
> [  292.804117]  of_genpd_add_provider_onecell+0x98/0x1f8
> [  292.809173]  scmi_pm_domain_probe+0x174/0x1e8
> [  292.813533]  scmi_dev_probe+0x90/0xe0
> [  292.817198]  really_probe+0xe4/0x448
> [  292.820774]  driver_probe_device+0xfc/0x168
> [  292.824961]  device_driver_attach+0x7c/0x88
> [  292.829146]  bind_store+0xe8/0x128
> [  292.832548]  drv_attr_store+0x2c/0x40
> [  292.836214]  sysfs_kf_write+0x4c/0x60
> [  292.839876]  kernfs_fop_write+0x114/0x230
> [  292.843889]  __vfs_write+0x24/0x50
> [  292.847291]  vfs_write+0xbc/0x1e0
> [  292.850605]  ksys_write+0x70/0xf8
> [  292.853919]  __arm64_sys_write+0x24/0x30
> [  292.857844]  el0_svc_common.constprop.3+0x94/0x160
> [  292.862638]  do_el0_svc+0x2c/0x98
> [  292.865954]  el0_sync_handler+0x148/0x1a8
> [  292.869964]  el0_sync+0x158/0x180
> [  292.873281] Code: eb1a005f d10f6042 540000c1 1400004e (f941ec42)
> [  292.879388] ---[ end trace 0077e182f3135393 ]---
> [  292.884007] Kernel panic - not syncing: Fatal exception
> [  292.889239] SMP: stopping secondary CPUs
> [  292.893347] Kernel Offset: 0x140000 from 0xffff800010000000
> [  292.898923] PHYS_OFFSET: 0x80000000
> [  292.902411] CPU features: 0x240022,25806087
> [  292.906594] Memory Limit: none
> [  292.909655] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> [...]


Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Fix SCMI genpd domain probing
      https://git.kernel.org/sudeep.holla/c/e0f1a30cf1

--
Regards,
Sudeep

