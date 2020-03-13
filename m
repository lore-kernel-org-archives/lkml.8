Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9575EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7802073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lS83ri4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgCMOQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:16:22 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4654 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgCMOQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:16:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e6b95570000>; Fri, 13 Mar 2020 07:14:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 13 Mar 2020 07:16:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 13 Mar 2020 07:16:20 -0700
Received: from [10.26.11.156] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Mar
 2020 14:16:18 +0000
Subject: Re: [PATCH] backlight: lp855x: Ensure regulators are disabled on
 probe failure
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
CC:     Milo Kim <milo.kim@ti.com>, Jingoo Han <jingoohan1@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <20200224140748.2182-1-jonathanh@nvidia.com>
 <20200224143732.rreev3ypou26hvx3@holly.lan>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <6ec74817-968b-ab5e-6566-56bbb9b67599@nvidia.com>
Date:   Fri, 13 Mar 2020 14:16:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224143732.rreev3ypou26hvx3@holly.lan>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584108887; bh=EKNVkhNRFooWTuQAuVXUIF52AnlF8L6H6GznFVFM9h4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lS83ri4NbaFqPyhoKbLqmkCEe3AgsW3k/m5m62gN9bq7V314Au+APvqTQNgPlqlsB
         pDPu/VR9NZfdx1/3MN+eaSHjMdXQnoBtT77/kW3yrvG01srNHhmFnbLazEQyI0QWlX
         ccsAna1axRLfJIiXKOVn7aGwyjoYvmli3KdF4KqhSjv8ZsNULtgrTZ9zfxrnvRZGS4
         Xzj331mbOmXuukiIGnRI1Y/kqFJz+X0Aj4qieHxseYx3348O1L0LlcnpPcXaoOc+yC
         JHdUEzsiWpdJwpxvP3yGufQLBBG3uxBiq7usviHsstbQ42aFMn8VozH2tPArI4cyc/
         b9zCDGar1+SPg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee, Daniel,

On 24/02/2020 14:37, Daniel Thompson wrote:
> On Mon, Feb 24, 2020 at 02:07:48PM +0000, Jon Hunter wrote:
>> If probing the LP885x backlight fails after the regulators have been
>> enabled, then the following warning is seen when releasing the
>> regulators ...
>>
>>  WARNING: CPU: 1 PID: 289 at drivers/regulator/core.c:2051 _regulator_put.part.28+0x158/0x160
>>  Modules linked in: tegra_xudc lp855x_bl(+) host1x pwm_tegra ip_tables x_tables ipv6 nf_defrag_ipv6
>>  CPU: 1 PID: 289 Comm: systemd-udevd Not tainted 5.6.0-rc2-next-20200224 #1
>>  Hardware name: NVIDIA Jetson TX1 Developer Kit (DT)
>>
>>  ...
>>
>>  Call trace:
>>   _regulator_put.part.28+0x158/0x160
>>   regulator_put+0x34/0x50
>>   devm_regulator_release+0x10/0x18
>>   release_nodes+0x12c/0x230
>>   devres_release_all+0x34/0x50
>>   really_probe+0x1c0/0x370
>>   driver_probe_device+0x58/0x100
>>   device_driver_attach+0x6c/0x78
>>   __driver_attach+0xb0/0xf0
>>   bus_for_each_dev+0x68/0xc8
>>   driver_attach+0x20/0x28
>>   bus_add_driver+0x160/0x1f0
>>   driver_register+0x60/0x110
>>   i2c_register_driver+0x40/0x80
>>   lp855x_driver_init+0x20/0x1000 [lp855x_bl]
>>   do_one_initcall+0x58/0x1a0
>>   do_init_module+0x54/0x1d0
>>   load_module+0x1d80/0x21c8
>>   __do_sys_finit_module+0xe8/0x100
>>   __arm64_sys_finit_module+0x18/0x20
>>   el0_svc_common.constprop.3+0xb0/0x168
>>   do_el0_svc+0x20/0x98
>>   el0_sync_handler+0xf4/0x1b0
>>   el0_sync+0x140/0x180
>>
>> Fix this by ensuring that the regulators are disabled, if enabled, on
>> probe failure.
>>
>> Finally, ensure that the vddio regulator is disabled in the driver
>> remove handler.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
I received a bounce from Milo's email and so I am not sure that his
email address is still valid.

Can either of you pick this up?

Not sure if we should update the MAINTAINERS as well?

Jon

-- 
nvpublic
