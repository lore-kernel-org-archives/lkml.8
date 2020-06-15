Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391BFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120F3207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+oomg0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbgFOQ1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbgFOQ1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:27:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C13C061A0E;
        Mon, 15 Jun 2020 09:27:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d66so8035873pfd.6;
        Mon, 15 Jun 2020 09:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KyRgF1yBt4bbtu88WX9Q1TUGj531P0GCr24KaJ/ap+I=;
        b=u+oomg0rkrQpvEyjS5sFvCk+IEbilWXXSUwTDnzmLdBHi3E9BL7DUSeHPm2NkYkoNJ
         u7O/U0vWJkpJUslYRj2hM89NqoZI3odpen/ldcyR0Io3dh720nOx3Q7k38x6DW9ncRme
         vAPW5My2JUCRJlKhwmQwguvmA65i3/FzV0eFNmwG+9A8kT0GADviHA42HxNseDTHfJgD
         L6xa7yV7kCxqf3/8GM62QNl7Ssq/MZJ2j/99TV8s4S8Bhmr8NrYTqP9FUsiSKvcIAAO0
         fF2W8aAsR5x2gVUK5P+E8hXB6UdzKzZEZUcN8ToWmM/zkNMvy4HZQg5iY1xN3ULabmJs
         +QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KyRgF1yBt4bbtu88WX9Q1TUGj531P0GCr24KaJ/ap+I=;
        b=BKtBC/MecF3JsP8j7P5KQYJFIs7gNoVMSmIk9Mv2oBJ6iSns0+5izEkAM0rOvXHu3Z
         xs75UzesxB8mYuwCjwFuEgsvUYwlYR65CdPNfg/08pcTVYrkEp9Nuv6oL8GZlRRp616h
         O9yG0H07QuvZ+oedI12NhxgZ/9cQLPbyZ1lFiadFjZ/ijPPCH9d99XPf2ZeQ1+ERaScT
         GaGh6Rf0y2rBSEaFqCZXzGf4s/eMQ6LV+19eLMOHwsxnzwwEENHeVXqsj+I8g0HEAvFh
         Mrmc9CX+z/weap8zhl5MxHE84FtiGl9IWivsYONJPqmaFiNtLd4HqJCbhq6wwW2sXzbh
         HtfA==
X-Gm-Message-State: AOAM532pGsF1bbT5bRBAtydbX6LTpjKhliypvrXPSGU9KP8XSX/ILWT7
        HSsiufLOtsyAU9lABYP55TQ=
X-Google-Smtp-Source: ABdhPJyFq0YnrE4QPmTYUMyvFcv3ek0syqeXJevNbjcfljZTC9PiuaAlkiEUXAEyCTPNd+8zhwZw7A==
X-Received: by 2002:a63:4e62:: with SMTP id o34mr22350239pgl.208.1592238472298;
        Mon, 15 Jun 2020 09:27:52 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d23sm29000pjv.45.2020.06.15.09.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:27:51 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] spi: bcm63xx: add BMIPS support
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200615080309.2897694-1-noltari@gmail.com>
 <20200615090943.2936839-1-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9f55d5a6-f936-cb73-6128-31a196dc5e47@gmail.com>
Date:   Mon, 15 Jun 2020 09:27:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615090943.2936839-1-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alvaro,

On 6/15/2020 2:09 AM, Álvaro Fernández Rojas wrote:
> BCM63xx SPI and HSSPI controller are present on several BMIPS SoCs (BCM6318,
> BCM6328, BCM6358, BCM6362, BCM6368 and BCM63268).
> 
> v2: use devm_reset_control_get_exclusive

We would also need to write a binding document for these two
controllers, as they appear to be missing, and this would document the
reset property.

I also believe that you should be making this property optional since
not all SoCs do have a dedicated reset controller line for SPI/HSSPI (if
at all).

Thank you!
-- 
Florian
