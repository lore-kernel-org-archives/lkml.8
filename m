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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B300CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 849DD2166E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B45A1JqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgFQVUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgFQVUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:20:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FFDC06174E;
        Wed, 17 Jun 2020 14:20:42 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e9so1887217pgo.9;
        Wed, 17 Jun 2020 14:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NohMyegEt9RgGZs2UzoxJxqN0gmHTgaywhB0Xzu/WmU=;
        b=B45A1JqMbdGfNkFOLEr80Gd4T4cJHGZpD46j+2UPvaUhAxUwCPVP6oDMxAHHZdG0PP
         NBSaOy58ayTiZ4z2IKWdPtBY/cMv1hW47Zb/k1+EDN//5NXSVRkRaz2k07Js4raYp3R7
         qJXH4XaCod9zMWVAX4yu8DTNZvZIk8PFGvsKulS5pwpjkMcaXtBweTxC0gHUQS0QGwQb
         9sGYmn2QrwjjB7oUm6hw7CYH4f5Ib1tZpcTeDldhHnuHlZIX0c4MxOx6jBmNp9uvr5BS
         TwB3vBHW2H6ANhuqu0dPKqDfwcqLb56iaMALoRy8H1jb/N103Vxx6BG4lgQ7yzL1ZGM9
         GzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NohMyegEt9RgGZs2UzoxJxqN0gmHTgaywhB0Xzu/WmU=;
        b=rkxXikHLH6amxloveGcI1WNujaF/EGfgAMMcmh5ZbRzadsyYFAVdc/T+YWfHYAkVhn
         8YIG0qYIhZ8IIxuW7yw/5AkbI75NmE/r3+YXcs0YD/IY51JLQuKm6csvtWRNQKKwX/TV
         KG6CVhuj+Bl0EDlKOvriLBzHMwz2Vlt7HxfETbaRyncm70Ut01N0Kj3seg/5Flk9oH//
         5pBR9nSOF9fJ/l0gBHWXvs1ca7lcapfg9IXGpcsAvp/nUuRDMbrDoD7OAmb3pQjcIW0v
         gOZ/j+jamo4BA67sn/aQLFin75D2eoYRDDtyIZ3LOzPjAzbqBg17W6JsWo2m5Lnvho3j
         s2tA==
X-Gm-Message-State: AOAM530q1eJbFmJXfDCC44FX0T49LnKdfTiRDCoxrEIzlfneTlHnCbg4
        geyzbUekpmndPCTOA+qDs2s=
X-Google-Smtp-Source: ABdhPJxQCCLyJYuEEt75M86xwUznb39t3XLVtOTwq0j0vZiNuzlxohhOfMK2hQu9uIG/YI5GnyoJzg==
X-Received: by 2002:a62:1654:: with SMTP id 81mr628850pfw.137.1592428841583;
        Wed, 17 Jun 2020 14:20:41 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f191sm702000pfa.82.2020.06.17.14.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 14:20:40 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        simon@fire.lp0.eu, jonas.gorski@gmail.com, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200616184542.3504965-1-noltari@gmail.com>
 <20200616184542.3504965-2-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7b82a18b-2939-9516-d68d-ddac41014da1@gmail.com>
Date:   Wed, 17 Jun 2020 14:20:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616184542.3504965-2-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/2020 11:45 AM, Álvaro Fernández Rojas wrote:
> Document BCM63xx USBH PHY bindings.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>



Since the USB PHY supports both roles (host and device) on a large
number of SoCs, I would just remove "H" from the subject/binding/name
accordingly. With that:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
