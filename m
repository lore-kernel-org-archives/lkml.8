Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB19FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 04:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3C9233CF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 04:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpTrv6FS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgFTEB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 00:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFTEB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 00:01:28 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69179C06174E;
        Fri, 19 Jun 2020 21:01:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dr13so12412354ejc.3;
        Fri, 19 Jun 2020 21:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JCYHOTJ0HAS5x0UPsw2q9jK1wV+WcKeUblO0ISjlJgU=;
        b=BpTrv6FS1BtxTu/7reJBA3v3AN2iHL8PqOPuMbDISbkfo1Y9F0QDR+xfvUAUYnXk7L
         HGd0iPvNVB2ne44BuzwbEF/UV9TZZXBI+kummTWlnH5N6IT7G+uAVt+s/aIdA4ENPEa4
         6OnXvslHMUMra91nAYKQzM9N7LxDQSRuSa6fZ13W5OcKc+hpSI49Z8iiC4MYecUPk6Q+
         ysaVxPr3LZiyllP93dDWnxf/mbn9jyPFsFFxNqEOEkeKBzgjiAyEutTwN3wGyEED6IXa
         v4J9hF0lm0oLvNCzCbNYeOAnN3efqV79/gMrK2+vW99kyP5XYZVlXv6bCU5Qi4+1r0Ry
         +JrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JCYHOTJ0HAS5x0UPsw2q9jK1wV+WcKeUblO0ISjlJgU=;
        b=JVP48zjWdWew6u/H6YvYvwgxAorjRJEYu4mG4fMzpWybLXC/OrtQKQFwnN4wX5lZMC
         cuV1/IUfm6aeEUInJ7JBsOtGAD77AP0vN3+oVZQp8ckBxY6DBsYQfd1xtAk4svyAXulq
         vzxvZmtlmneTX/fibfNOK4nZ0a8tMHSnTXlg3UQ/R0HspFK0H3RfztqoY+FhzhqO6BPx
         IBxHlIcZN+IaXTyCMtpI3I2z2CLbge0fWAEV3hv5IpLOzuym5F2cacLbHm87K0qC0nWk
         n0iTKDKFBgPZXHkMRm2xQtEr3EvmcIPp+AyNoW4XgUa1rU5IOkP227kQnpLVSlHBhcAC
         fpwg==
X-Gm-Message-State: AOAM5334FKEJturS0YBOpAfZrdQyjpxjgfs6Ify776CWAawwf1lFgD12
        Keiur/kTN8ththTfMEZghe4=
X-Google-Smtp-Source: ABdhPJw8B1IDFKZl+3uJjpFdOAUNzM5C+vslwfi8RWTQWvnrVzqSBDRH9VsMG7hJ3K+t/v5fDAV0ew==
X-Received: by 2002:a17:906:6410:: with SMTP id d16mr6860682ejm.376.1592625684787;
        Fri, 19 Jun 2020 21:01:24 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id lw11sm6000247ejb.58.2020.06.19.21.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 21:01:24 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        jonas.gorski@gmail.com, kishon@ti.com, vkoul@kernel.org,
        robh+dt@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        p.zabel@pengutronix.de, krzk@kernel.org,
        gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200619100035.4032596-1-noltari@gmail.com>
 <20200619100035.4032596-3-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b5c1993b-dce9-f963-54f0-c92def0c7582@gmail.com>
Date:   Fri, 19 Jun 2020 21:01:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619100035.4032596-3-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/2020 3:00 AM, Álvaro Fernández Rojas wrote:
> Add BCM63xx USBH PHY driver for BMIPS.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

This looks great, thanks Alvaro!
-- 
Florian
