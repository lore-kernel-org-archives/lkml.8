Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E484C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8C920658
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLFpCGM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCRQI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:08:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38267 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgCRQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:08:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id l20so86916wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TLgXmNozvDp9BcNHyqTO6GFcWWQD94IGFBX9Q7VenQE=;
        b=bLFpCGM+/IwvHNaiAYAKTJ9y34pV6nWf2+rHEQSvy03mgzPEO4Eu2TClVo3U1ojGo+
         MW2vMGAJ91RENQgmwvOOduFqC618kHgdsyCOl+mRbmpUE5s9R7O6jYJjlhDxSGveezrh
         tDWD7PhBoKOyFK4YOJ9xCfHH8mOxbszaAOCnzvWfA6gjEw7EeD+F1vPbQ28qBxFlt0/G
         zUMhM0AUHeD1bh29CBy3NgN9vMqxg7I2QtnzNw3LCgukbTeifMPqb1YktEryS5HVYhKq
         rT9vp0Ern543LnaI71qAkkJ+va1joW7gaRYjSsKkXfaTRkS+PwGG51CV0MBTwJlsCr/W
         60mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TLgXmNozvDp9BcNHyqTO6GFcWWQD94IGFBX9Q7VenQE=;
        b=UyDfX/BeWFtJLcThKlXOJteM56ARFwfbK+I7BOthFqaAPvrTLN0Wv/GrZPSWKIS0Gk
         tzT1NapL6UP0/nXCqH9de1Wp7S5oSp9TKnVSmrZsC54pAaM6FXqblvoNFw5VJ6qVfdyO
         GcA0M4xi1wz8bisRCs23hLhukZpOjP5RL+yeF194aMJUsIUxBWrrXY7/PxWvNNZ8y6Nm
         xlzdT3OqoBMwwzcNtxMULeF9i6EBC6/dXnK55zmzKZzZJo4ZzEJUaoQ9jntvkTEWjfA+
         xwPt35t8yNmjOjnrpocIMrcxAdK26O9ylwj6Hy4Tx4hRZqALx8mW/I1vgQ6/Qz8A7bDO
         F7nQ==
X-Gm-Message-State: ANhLgQ1JdnO21VKzVJAVWlUaHFSYudbiNIwEUZIIElEDH80m3RTaouXP
        8VfYYgLALF2NG2u1H2Zo6sofXw==
X-Google-Smtp-Source: ADFU+vvOdrwm8NfsU9nb+Of9vMTUcgCmMgH1jK1yv5xSj4hnbY+LMIdHBHrDjM0VqevCarsbfAiXEA==
X-Received: by 2002:a1c:b154:: with SMTP id a81mr5935380wmf.175.1584547703944;
        Wed, 18 Mar 2020 09:08:23 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h16sm9957414wrr.48.2020.03.18.09.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 09:08:21 -0700 (PDT)
Subject: Re: [PATCH v5 1/1] nvmem: Add support for write-only instances
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>
References: <PSXP216MB0438D2F2D9B648BAF9A007A580F70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1057389f-2bd0-909c-93c9-21a12af90660@linaro.org>
Date:   Wed, 18 Mar 2020 16:08:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <PSXP216MB0438D2F2D9B648BAF9A007A580F70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/03/2020 15:20, Nicholas Johnson wrote:
> There is at least one real-world use-case for write-only nvmem
> instances. Refer to 03cd45d2e219 ("thunderbolt: Prevent crash if
> non-active NVMem file is read").
> 
> Add support for write-only nvmem instances by adding attrs for 0200.
> 
> Change nvmem_register() to abort if NULL group is returned from
> nvmem_sysfs_get_groups().
> 
> Return NULL from nvmem_sysfs_get_groups() in invalid cases.
> 
> Signed-off-by: Nicholas Johnson<nicholas.johnson-opensource@outlook.com.au>
> ---
>   drivers/nvmem/core.c        | 10 +++++--
>   drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
>   2 files changed, 56 insertions(+), 10 deletions(-)

Applied thanks,

--srini
