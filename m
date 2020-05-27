Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5AAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8696B20C56
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcA20loL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391048AbgE0QYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391022AbgE0QX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:23:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496FAC05BD1E;
        Wed, 27 May 2020 09:23:58 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x13so11998650pfn.11;
        Wed, 27 May 2020 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lGeZptoOyZ1BVvw78efPExfusFYWZHjrOWKDS1Izp14=;
        b=AcA20loL8+f8VexMdWcFig193D4t/uEwNWDKgGgR3XzlgzdWmA0VU69HuMI5UtnlN/
         3G2dYcF8UzG4EKYuap9xrWzUkJHQIxIRcRiCyWWJeOncWUMgCVuaam+lHV4m4jgjBXHx
         dsAtqMSQHxzlO4bFE7GVE7tdHTAzXTopUpNxEw54kgeiNR64g4nQbH7fQ/Fb3u0WmO+7
         F7KeSVVmfufJaWhX0ZDf8/7dDc3nwRViXoJtSX5EoC4Ilk47qg9rZF0eZgqOAiTVKXcr
         HBODw3x14nD7KWnLzC8nlK+50oQWJx5ZmGQzr1k924n48nIhpXdlZGIczt1tz3F9p7ZI
         BPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lGeZptoOyZ1BVvw78efPExfusFYWZHjrOWKDS1Izp14=;
        b=Y39ugdmsTBmF3SY/Hpnx1L/JaQ5cHoccljjznzctDBL5u+7liW/RYSYQfJisSZQP9c
         oQohS1pNyL6T2KOOlZS/g/Q+kkgLZ4TuAwIpDo8dCPNzTNm3QzbcKsnwB+cxDapMdb9d
         ReQi4eKjXmHL8nIj2HMDv+58FM1IxDB+ghXcswQ4vCwozS1ewPp/6vcOVH365CnvEg9W
         urji0xG5+3axs7w/dzcU4fJtjU+fBt4N/vu03EcqS1jTDJPo51QVaX/jk125i0qgm7lE
         CCvV9WecSKw0MRj0UZNfWa8r9n6I6kCDyPfMbDdzjY/4VYhMhUnYBANhN3FQXgFXLA8E
         38sw==
X-Gm-Message-State: AOAM531VxlNa2gNXN5zDcaxB6T/eRCGFif5oNb5SvDLrtDumoBuTn/8U
        UAhG6T2RfuF5rJtvePDelwV7yg9E
X-Google-Smtp-Source: ABdhPJwNYpNkh17Ia9L8pg2plotC80BrMRP/7oTRdfw0slOZDK99ylchaXT+aGhkxvFznhrwCdILyg==
X-Received: by 2002:aa7:9464:: with SMTP id t4mr4563111pfq.52.1590596637360;
        Wed, 27 May 2020 09:23:57 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j10sm2727584pjf.9.2020.05.27.09.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 09:23:55 -0700 (PDT)
Subject: Re: [PATCH] net: dsa: b53: remove redundant premature assignment to
 new_pvid
To:     Colin King <colin.king@canonical.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200527120129.172676-1-colin.king@canonical.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <53bdf3f4-1a72-956c-8c32-424ad42c02b5@gmail.com>
Date:   Wed, 27 May 2020 09:23:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527120129.172676-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/2020 5:01 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable new_pvid is being assigned with a value that is never read,
> the following if statement updates new_pvid with a new value in both
> of the if paths. The assignment is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
