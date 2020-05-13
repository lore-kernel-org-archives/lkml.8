Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947B9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F09207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktSXpuEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbgEMPXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731638AbgEMPXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:23:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F4BC061A0C;
        Wed, 13 May 2020 08:23:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d207so9188839wmd.0;
        Wed, 13 May 2020 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aP5RqJaHjw0SSvS8jFa4SufpVRHV3wMOfmjoi5Yc1f4=;
        b=ktSXpuEIWmOyZetJtmtSOLnT96UirVaLdRpcXWTE/gYQC1WX1lHtfWkkUtx3Kfvp0S
         RL0FBNdf5vCW2FR41NIuumOgKvTuRUjtFFS/fA2Yphvfhpc4c6vHIuyy054G1B67Clz/
         Zqf0aNveo38QkOin7+9hk1I9AxhhNxfybUbb8CtvSQSXOxu/0KmHavMD3kiZlx04xwB8
         F3DhQX60hJ4YWPRdI5cmLK+U/WrFzCsOPHO1z4jKgROLch25aU4EiGazMvSmRKXEcrff
         TSWqovL29eEUyHBp8T5smBLlqePqhRdgFfW/1yoXCgvZI5PAkLcK6wQRY6EqqsLt7LOe
         3MPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aP5RqJaHjw0SSvS8jFa4SufpVRHV3wMOfmjoi5Yc1f4=;
        b=WDif4wpAROpbSq77A1ZLhqUhT3xtOjOn09zmqcCjwHih8x9KuHaq/UcteyYDzBGdXA
         30lIjjsFHkLuiDghK//IUC2G5daMstFwLiMwz2BBsvjEXyheuHOkG9D+0P6Ryriwg28/
         67KtAC918es6ppqA6Q+wZPBCqBYL09AZzT0r0hsXU1Mj+1iNDEWv8EeLjavI9aHuSBcp
         2dXu/371LkdFnskzzTFlDTlQDLPpPpVhYkR1MyK4a45SwtxgVfVOOV0Y2Ul6qJu6g4cW
         ja1usf8DxVsAFTrjCQtKYGfhoDZjVsLRs3J6EO08jYS97A31o7UoOD9NoDW8VB+mtTad
         Vb5Q==
X-Gm-Message-State: AGi0PubjhkEl1AOJ2yPMc4oYcPGdR02lxHmzLd5MyHbCgwBR6v7hqIfN
        GQuc+ad94muwzq7oNu2Ezq4=
X-Google-Smtp-Source: APiQypIa+86lv9x3CvtVmHtTwH5kxANcv58nv4VNDEBhX9EOGhGzbMBwX6Z3SwoBXqiXgPA8mEKURA==
X-Received: by 2002:a7b:c5d4:: with SMTP id n20mr45268150wmk.92.1589383426466;
        Wed, 13 May 2020 08:23:46 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b2sm25421028wrm.30.2020.05.13.08.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 08:23:45 -0700 (PDT)
Subject: Re: [PATCH v1] net: phy: at803x: add cable test support
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Michael Walle <michael@walle.cc>
Cc:     "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
References: <20200513120648.14415-1-o.rempel@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0c80397b-58b8-0807-0b98-695db8068e25@gmail.com>
Date:   Wed, 13 May 2020 08:23:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513120648.14415-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/2020 5:06 AM, Oleksij Rempel wrote:
> The cable test seems to be support by all of currently support Atherso
> PHYs, so add support for all of them. This patch was tested only on
> AR9331 PHY with following results:
> - No cable is detected as short
> - A 15m long cable connected only on one side is detected as 9m open.
> - A cable test with active link partner will provide no usable results.

How does this relate to Michael's recent work here:

https://www.spinics.net/lists/kernel/msg3509304.html
-- 
Florian
