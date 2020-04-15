Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DE8C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F8720737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xBGqeqRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896720AbgDOLE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408843AbgDOLDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:03:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2376C061A41
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 04:03:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d77so16889292wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 04:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0+mvRsViHtX7K9QeV8vxa3vsUkNlZfKOjncMUliYwFY=;
        b=xBGqeqRbPXVWiiUbxgEhXzqhm8+4utoknFiMQ2GeDoSoaq957UF0r5Ozhe/ePFxylV
         grOY7YQfUk2VucGAYiFwQCYWegigxHFgD+PUetMbxEgta+wz4wP0G35R0++BYc1bbvsn
         hG7GWkJn884XbfqytX4RFrFw5VSp/Ekt1aYTGKOzPqkeMR7Km73j1Gpb1gvcYG0QnqX1
         mhlUBbYGEwQGSs4bRkTeacdvsq1UBtgangAcQSnvQdJNbdyUkA4RsHnYBhyrr+6VMCqq
         4MoCPuQZclf/dkJJDRe9T3K3KS5EEjo7EbqK1YwZEEGkbnhaN344JYz9yKgl7BhKnGTW
         rrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0+mvRsViHtX7K9QeV8vxa3vsUkNlZfKOjncMUliYwFY=;
        b=e6v2mLT4xbN480uQuclmKHfn038I3gDHvTVBd+xOzS0w3MLTXF5h3IIUJfHRd44+HT
         CkF6x5NW++bVLdop031gNIzqM+GagBriCs+8FC2I8s/zfv8iSevrAF9+//ZQ/SMXwJ9K
         3meH+ECEnEErpfpkGN45Q90z2Ia5Zif+WvhqGSqgpPOhIpCHYv5r4TMyawnOdk9yj92i
         gSZPn8ov9Gp2mfTOSWPV95vHoMs6hnh4qmH5ejCCoAoS+sLJbwQ0666qMp0ZO2NubgjQ
         eJqvny8cU1xnqh2vCbMnA9PzeuGSaAEaqhR5eseQ9tIVbsu8Ox4XAT+kV0utEV+UZJht
         vVWg==
X-Gm-Message-State: AGi0PuYjBSf1TkATjcddlH1Kvvk/dK6u7x+0MukJYNl7i0xY5DdtDjDN
        fG1r6di7XBnPSUcye5RCnNyYnA==
X-Google-Smtp-Source: APiQypKYzMGWG+zMXscvJ4uCuaA8QuvLPgqp0ZkOm8oeOQzmEuU0a08KKg1p2ijuDQzlljeF//y0+A==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr4716740wmf.77.1586948621597;
        Wed, 15 Apr 2020 04:03:41 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id u30sm2531311wru.13.2020.04.15.04.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 04:03:41 -0700 (PDT)
Date:   Wed, 15 Apr 2020 12:04:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mfd: htc-i2cpld: convert to use
 i2c_new_client_device()
Message-ID: <20200415110442.GK2167633@dell>
References: <20200326211009.13411-1-wsa+renesas@sang-engineering.com>
 <20200326211009.13411-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200326211009.13411-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020, Wolfram Sang wrote:

> Move away from the deprecated API and return the shiny new ERRPTR where
> useful.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mfd/htc-i2cpld.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
