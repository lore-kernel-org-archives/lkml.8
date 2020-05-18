Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FB8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC1820674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgxJGJdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgERQRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgERQRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:17:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B382CC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:17:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i15so12523446wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QAAIvBIiSG9JwsQR1qXtydb4jm3fJbRMHalVBRP+3Hc=;
        b=lgxJGJdChC5tOGSzX2qNb/KbILwR9GRrHPhVWImxjZ+G/u81jZVLO6aZ/yKFVtBPoB
         GYEbRqYYCQi87hHebNPA2nGoBopM/tUrNq5ca4lzLPnkJoHeL95psGPo4jJUxKpRNjFA
         H1ji0/HEN/qgIKnYdDWMDxwWZs6vjIoeUGIFmmDk/m3EP9/EtVUOXQgDOuuy2+mWVmq/
         8VfOreTT8CVgscHj18A4Hm1CcCrook0dDQseZfMvlaSXdqvZvfO0QG5lmfkwtt36OdFT
         sDnUgBBQA2yn8kC7fusnm344XgLkiG1wDYHATSrMBQOS76XfTpy3tdgezl964+h2Oj3K
         gtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QAAIvBIiSG9JwsQR1qXtydb4jm3fJbRMHalVBRP+3Hc=;
        b=BWcFKXILT8gLaxnVK/pP37x8n6owfSwvI7bf3UjOvVLC0beMsbiY9IdcDN+0fkFcrZ
         ORf8ZbGqzZEoS+6WQmQlBwAzAAjLSVfj1Ce1vjfgswTDGfBwJilXX7R3TmP1PP4lDBcA
         9dM5zHg8rEqVeCfVhm9jz6SoXlATA+e4l1ZreCxAARUwgmsnAYxPpNMei5ypZE9Sz/Vl
         HXVXcwBH3ZjO2PYYP2jjgHc0Be1dDd4NuiNicM9S1u7PPqT/6b2rL5FqtytXfIM9L+Zk
         pr4DlPXnKo3E+rGK8aOPcZWXTy6UL/ZGyn88N+c1/ejH4IVgyX0uB/od9W85GVwaLey5
         s77Q==
X-Gm-Message-State: AOAM533AtS8+AURXe2xeVMEyJ0k4LtLTaqIQ3D7Rk6CynQx13tYR3jey
        y0OUb4/qb6F6OljWGFYEx6vBGWrxTs4=
X-Google-Smtp-Source: ABdhPJxHlBlD0ly153DN77AqTxt5AJ2rvLAP9ArOWvmtQQHeXmlkOmDPlOHFPyq1L7MhD3h4TLuenw==
X-Received: by 2002:a05:6000:1106:: with SMTP id z6mr20586205wrw.336.1589818654235;
        Mon, 18 May 2020 09:17:34 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id w9sm18851632wrc.27.2020.05.18.09.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 09:17:33 -0700 (PDT)
Subject: Re: [PATCH 1/2] UPSTREAM: usb: roles: Switch on role-switch uevent
 reporting
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, square@linaro.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        chenqiwu <chenqiwu@xiaomi.com>, linux-kernel@vger.kernel.org
References: <20200518161442.1232821-1-bryan.odonoghue@linaro.org>
 <20200518161442.1232821-2-bryan.odonoghue@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <219c4c0d-9aee-5541-b19a-1f79845b3e3e@linaro.org>
Date:   Mon, 18 May 2020 17:18:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518161442.1232821-2-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2020 17:14, Bryan O'Donoghue wrote:
> Right now we don't report to user-space a role switch when doing a
> usb_role_switch_set_role() despite having registered the uevent callbacks.
> 
> This patch switches on the notifications allowing user-space to see
> role-switch change notifications and subsequently determine the current
> controller data-role.
> 
> example:
> PFX=/devices/platform/soc/78d9000.usb/ci_hdrc.0
> 
> root@somebox# udevadm monitor -p
> 
> KERNEL[49.894994] change $PFX/usb_role/ci_hdrc.0-role-switch (usb_role)
> ACTION=change
> DEVPATH=$PFX/usb_role/ci_hdrc.0-role-switch
> SUBSYSTEM=usb_role
> DEVTYPE=usb_role_switch
> USB_ROLE_SWITCH=ci_hdrc.0-role-switch
> SEQNUM=2432
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Wen Yang <wenyang@linux.alibaba.com>
> Cc: chenqiwu <chenqiwu@xiaomi.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Link: https://lore.kernel.org/r/20200508162937.2566818-1-bryan.odonoghue@linaro.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [cherry-pick commit 3e63cff384e625f09758ce8f4d01ae3033402b63 upstream]
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

oops, applying this to a local tree.

Please ignore
