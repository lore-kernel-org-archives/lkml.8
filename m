Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EBBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047C12088E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVUQiX4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgFQVjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgFQVjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:39:02 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF85C06174E;
        Wed, 17 Jun 2020 14:39:01 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b7so2681052pju.0;
        Wed, 17 Jun 2020 14:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Z1L8zEnT0ez27hMPJfvySv6oSz2yh1sjZDdhcO8RfP0=;
        b=WVUQiX4n9B4WfCJBET0HMR26vU5YifBBC/wyJt0FXFo1xS/PEUt4P9j1Yjm2b/b5jb
         8zpmP4ZHRZNWEpI0mY/XCZ5N2kd2e0f/b0f6vqT93FbsNIQtb9ctyblIiWSX2c81oH3g
         UQ9u/NivMKKM11OP7PxOWnqi271OlQTDB0idgVqXrgtxJkAJNYOZ7n8mQCDCfFz9jE7X
         f8jTsMp06G6yb546m3ZsPNfPvOcWgkAYbDaxiwa8XgBxrkSU46kWFeRBKyrl0cUw8e3D
         vI8nCAfl2ECyZVAuS8wlcSTkeEVKDuDRohwZxbRdneC5Be4FjTOwLNEzffi8AcWPV8D3
         agIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z1L8zEnT0ez27hMPJfvySv6oSz2yh1sjZDdhcO8RfP0=;
        b=tGlB91kNnDixHqvgNdkPLKmNOjEMizcaDMeHmSPJMKgC3zZ9xrX6L3gTxbQE5mLfLh
         6HS8hSBX/CXTAG5T3cwZYr5Ou1IsDEmLHgkEWkzN+3tatZgdWG5kWMUIrYw5Ol2BrvW0
         nwZWMBy1O6XexKplgrdMYiH8F9zxUDpXkpm5oAbQTPwXX7fE+vKNYI6b8UX21KH/BkAZ
         v0dadacDIGqwNDLY7t6cR/qGyjrvHID3Ig/7jiO8EwYlz5ZGKjKx+diIyVLVMGjkN/PO
         Lmv3XYClvA4WmgJceofiRwPmMGpdizyfl6hNn6UiKurTcc4hyf8PXfcDDI86BB1/Vd0h
         7pRQ==
X-Gm-Message-State: AOAM533TmN6lFZugA76XSJR5+46R6X4kXlibJLychtpqhensV9OmgwNV
        1LylJ2dxgsAGH8ug2uY1Gs8MkuHD
X-Google-Smtp-Source: ABdhPJz97eFcIZRAPlw+wrdz7tC9hhXVeN978btuN1qnKO9axu1PeT/YdSe8nJFrZiqd3ydWZR5BOw==
X-Received: by 2002:a17:902:a410:: with SMTP id p16mr897252plq.283.1592429940900;
        Wed, 17 Jun 2020 14:39:00 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r4sm668701pgp.60.2020.06.17.14.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 14:39:00 -0700 (PDT)
Subject: Re: [PATCH 1/8] mips: bmips: add BCM3368 clock definitions
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20200615090231.2932696-1-noltari@gmail.com>
 <20200615090231.2932696-2-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <699e92c7-d84a-5625-be90-8c97914d56bb@gmail.com>
Date:   Wed, 17 Jun 2020 14:38:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615090231.2932696-2-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2020 2:02 AM, Álvaro Fernández Rojas wrote:
> Add header with BCM3368 definitions in order to be able to include it from
> device tree files.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
