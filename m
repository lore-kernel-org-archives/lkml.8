Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05715C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA84521744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BD+8OaHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbgBYO7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:59:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33099 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730754AbgBYO7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:59:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id u6so15136391wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VAjOwG3wByBMn+LNEOxqdTA7mvnfEFLl2FcpxcCoSHY=;
        b=BD+8OaHiDfSbH7mVkARg8BcbO6G1kpEnyE0SAe8AOMg0N1S4RUYy7IXx4Qd2yfoLvP
         P6mxlyK3EkbxhO2pn1wEc9tlQR3cORggeQs+dWlJ9XcG35sX61+FZpkvqQbu+YZbcsMc
         VZ5qDRe+dzkSOfRm6PTWaGhF1lh3/Tz0tVr8znpFmII4uoh4iaBl/aCSP/r3sbPo7TcT
         7NMCc0qOSKz8WzRtRbnwD2dQ1935AdUB1JOzDpibqbtFq8BaekxDmJi93R59b4u8CP0/
         eT3XRv7fM85vO1Zg59FyAmGLGPNJ0U0dIPFjn6PdOhjaJmEiCD1yj6DPR7M+3q8/+CaG
         ocyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VAjOwG3wByBMn+LNEOxqdTA7mvnfEFLl2FcpxcCoSHY=;
        b=V87Kn7uHe7xxTQr9+D+KHQEWtyt2199R1LAipd/TCp77/6E4N6rSIT+HPwhkN7lSRl
         SnF8c//ZrWTPhtfCGoZCTV9+fAl77XDpwMvT7p3yy7Vx5PlVBrzLrKvWq3oVN0Bmnknn
         lC7SlklvWWvra3LGpOq0HpcSEiGdQxj+tzieWoDDkrbVWAUmGb4rrpsPom7RrA/wVCmb
         WPBKuV5i6YFvOp8eKMahvE44zpSuRM445EAO5GCkMA8Kqm9cQ41Uzk7ZmHzufBirPV+e
         4Vcr7HlNrzwLl1pegIXg+77TGenNS5AVdB3sNW/2wouRpO8cKAFyt46n3tHS0lOiECDl
         GW6A==
X-Gm-Message-State: APjAAAXZ8EBElfqJf0YEZomwnsWw7wFtcWAmLqB5k4MPMHEUQweN83JC
        VRtY90DvmX7cYU38AVtjm2Fs+VxRfG0=
X-Google-Smtp-Source: APXvYqw9an6YxPnDrgXVKv0CbD1q2jHIoY1bGakjZHnAcqiimhqxTF4jdZIxXob6UuVvTeA2gWTbLQ==
X-Received: by 2002:a05:6000:188:: with SMTP id p8mr72417075wrx.336.1582642787608;
        Tue, 25 Feb 2020 06:59:47 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id b7sm16062991wrs.97.2020.02.25.06.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 06:59:46 -0800 (PST)
Subject: Re: [PATCH v1 0/3] nvmem: Add support for write-only instances, and
 clean-up
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>
References: <PSXP216MB043899D4B8F693E1E5C3ECCE80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <abdbeaf4-487d-8921-facc-b979421e97e7@linaro.org>
Date:   Tue, 25 Feb 2020 14:59:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <PSXP216MB043899D4B8F693E1E5C3ECCE80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/02/2020 17:41, Nicholas Johnson wrote:
> [Based on Linux v5.6-rc3, does not apply successfully to Linux v5.6-rc2]
> 
> Hello all,
> 
> I offer the first patch in this series to support write-only instances
> of nvmem. The use-case is the Thunderbolt driver, for which Mika
> Westerberg needs write-only nvmem. Refer to 03cd45d2e219 ("thunderbolt:
> Prevent crash if non-active NVMem file is read").
> 

Had a look at the crash trace from the mentioned patch.

Why can not we add a check for reg_read in bin_attr_nvmem_read() before 
dereferencing it?

The reason I ask this is because removing read_only is not that simple 
as you think.
Firstly because a there is no way to derive this flag by just looking at 
read/write callbacks.
Providers are much more generic drivers ex: at24 which can have 
read/write interfaces implemented, however read only flag is enforced at 
board/platform level config either via device tree property bindings or 
a write protection gpio.
Removing this is also going to break the device tree bindings.

only alternative I can see ATM is the mentioned check.

--srini



> The second patch in this series reverts the workaround 03cd45d2e219
> ("thunderbolt: Prevent crash if non-active NVMem file is read") which
> Mika applied in the mean time to prevent a kernel-mode NULL dereference.
> If Mika wants to do this himself or there is some reason not to apply
> this, that is fine, but in my mind, it is a logical progression to apply
> one after the other in the same series.
> 
> The third patch in this series removes the .read_only field, because we
> do not have a .write_only field. It only makes sense to have both or
> neither. Having either of them makes it hard to be consistent - what
> happens if a driver were to set both .read_only and .write_only? And
> there is the question of deciding if the nvmem is read-only because of
> the .read_only, or based on if the .reg_read is not NULL. What if they
> disagree? This patch does touch a lot of files, and I will understand if
> you do not wish to apply it. It is optional and does not need to be
> applied with the first two.
> 
> Thank you in advance for reviewing these.
> 
> Kind regards,
> 
> Nicholas Johnson (3):
>    nvmem: Add support for write-only instances
>    Revert "thunderbolt: Prevent crash if non-active NVMem file is read"
>    nvmem: Remove .read_only field from nvmem_config
> 
>   drivers/misc/eeprom/at24.c          |  4 +-
>   drivers/misc/eeprom/at25.c          |  4 +-
>   drivers/misc/eeprom/eeprom_93xx46.c |  4 +-
>   drivers/mtd/mtdcore.c               |  1 -
>   drivers/nvmem/bcm-ocotp.c           |  1 -
>   drivers/nvmem/core.c                |  5 +-
>   drivers/nvmem/imx-iim.c             |  1 -
>   drivers/nvmem/imx-ocotp-scu.c       |  1 -
>   drivers/nvmem/imx-ocotp.c           |  1 -
>   drivers/nvmem/lpc18xx_otp.c         |  1 -
>   drivers/nvmem/meson-mx-efuse.c      |  1 -
>   drivers/nvmem/nvmem-sysfs.c         | 77 ++++++++++++++++++++++++++---
>   drivers/nvmem/nvmem.h               |  1 -
>   drivers/nvmem/rockchip-efuse.c      |  1 -
>   drivers/nvmem/rockchip-otp.c        |  1 -
>   drivers/nvmem/sc27xx-efuse.c        |  1 -
>   drivers/nvmem/sprd-efuse.c          |  1 -
>   drivers/nvmem/stm32-romem.c         |  1 -
>   drivers/nvmem/sunxi_sid.c           |  1 -
>   drivers/nvmem/uniphier-efuse.c      |  1 -
>   drivers/nvmem/zynqmp_nvmem.c        |  1 -
>   drivers/soc/tegra/fuse/fuse-tegra.c |  1 -
>   drivers/thunderbolt/switch.c        |  8 ---
>   drivers/w1/slaves/w1_ds250x.c       |  1 -
>   include/linux/nvmem-provider.h      |  2 -
>   25 files changed, 77 insertions(+), 45 deletions(-)
> 
