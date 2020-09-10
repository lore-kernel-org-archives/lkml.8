Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B575C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1780B208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdSWAub8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgIJSkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgIJSUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:20:53 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2120EC061573;
        Thu, 10 Sep 2020 11:20:29 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d6so5104430pfn.9;
        Thu, 10 Sep 2020 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IDfRgfK8TFyYuUETMljQaPyOXA2OueRzHmA1mszfwtI=;
        b=RdSWAub8vz/gpQDMeuxuhvWDCn62ByDKr45xznljh0Z/CCZnGkLphxDLcs9/hbdc27
         hZHt7XckzTSXBzBlSUzSVt3rrU+zy99BoQ/OlnegrZAWZgXgtTB3hH9og5qi4yYmG8nS
         Rf0lgwPXbH+u5C5m/hpcL/GnBHZ/VSz7R5/4jdnk2LnVt9FOLxh0JaXYeS8HgXduhBvP
         /wl1Hq48otKS05pSJ4qnEths+E2LgcrT3hd3gpy6y5BKlN0irHtnmPiAJl8UhQXnUObJ
         qEs2uhYPEzR7dx3t0cfQtiRIJweCnpFfgOoEZrrgS+Dmjn/zzHvCYINQbjvDqp3s1Xrd
         Luiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IDfRgfK8TFyYuUETMljQaPyOXA2OueRzHmA1mszfwtI=;
        b=fPgz/9Q4coV9FlIkenz2F62y+JBr5WRzRyGyu7HwHSl+KmMH1274yvv8BLEJyXi4rD
         bqJcu4Bo5R784YrJXtgc7Q9b3lZjNZoCSk2Z6c/nAcTdlfBADldgqtOoynL4YgIPPGfR
         2gtgJ0BTexnPcDgdcmCuk9lWNUSUP5R/DuXW4lXAdWDxMNk7TtMTJ8DxeMCjKsvSJGn4
         oTOklE0QrRO5jtn5EiMaInbovJIXvqqdQ6zs/1pHcOkOIKJLublwlz3K4PzBJlrl5w1Q
         +gxJ4bohEfBMGpP+YF198L9++JhBT/F2c6N33gc3aKivYOnWgfzvZnKS7uAcgFBkLlTr
         L0kg==
X-Gm-Message-State: AOAM531865EaVIZp9jMRIxPGnttIEw9v5kzYtY8ykqrmx1wUyZRu9vi4
        8XLuKWiycP8MoevV5UdxhJM=
X-Google-Smtp-Source: ABdhPJwoiHva8YyGewp1ys6dfrdwkMOcN/j9EGWmVZR4s6qWt3lcrSiO2jEJKCj9GDGFfe3iUEwdIg==
X-Received: by 2002:a63:4d5:: with SMTP id 204mr5741770pge.0.1599762028692;
        Thu, 10 Sep 2020 11:20:28 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w206sm6795964pfc.1.2020.09.10.11.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 11:20:28 -0700 (PDT)
Subject: Re: [PATCH 3/4] spi: bcm-qspi: Fix probe regression on iProc
 platforms
To:     Ray Jui <ray.jui@broadcom.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20200910152539.45584-1-ray.jui@broadcom.com>
 <20200910152539.45584-3-ray.jui@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <82258d80-f273-7aac-787f-68140e2d8cf6@gmail.com>
Date:   Thu, 10 Sep 2020 11:20:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200910152539.45584-3-ray.jui@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/2020 8:25 AM, Ray Jui wrote:
> iProc chips have QSPI controller that does not have the MSPI_REV
> offset. Reading from that offset will cause a bus error. Fix it by
> having MSPI_REV query disabled in the generic compatible string.
> 
> Fixes: 3a01f04d74ef ("spi: bcm-qspi: Handle lack of MSPI_REV offset")
> Link: https://lore.kernel.org/linux-arm-kernel/20200909211857.4144718-1-f.fainelli@gmail.com/T/#u
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
