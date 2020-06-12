Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CC1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3AC2206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r65b29Wm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgFLWh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLWh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 18:37:56 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A45C03E96F;
        Fri, 12 Jun 2020 15:37:55 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h10so1046367pgq.10;
        Fri, 12 Jun 2020 15:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JwfU3Ak+LMYhX+D/DJ3cHip+/Jva9vIJhsQ0OPfwhqg=;
        b=r65b29WmFEMz4xy4WPMsirQEq75ojHp4m8iYFhOqVHJeReich3JcTaxwUFazCpRvB7
         Un1TkXGJj5MYakNqXHStcntbcKWiupNGLgq6oHxetBoIydHrpn1reWtWkXIZjDAlntDC
         Nrs7RGBbMwqnhgx8yEj2s4xMpxf2vwvT5/aJmWVkB/7rQJFVovI3R+gYB2K0eout2plm
         8LreVbbfdrBxUGIDbu46R6ApvfpaulGW0GbsQRrGNPE6pfLqGYduGVp4lZWW/6nGrcKM
         C0jIDmnPp0XzOcGsGagXe+UBEj2AjVkbp4HaRj4mQMkQTPVoYN9BVnCM77b1drQQI532
         eaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JwfU3Ak+LMYhX+D/DJ3cHip+/Jva9vIJhsQ0OPfwhqg=;
        b=mej0CNFhQEULTAbIqanVCyZc3A0/QT7tNLCE/4FhZNvVcpfmQAUtVcIk0BGhTRtXzB
         1PfYfP10WEQZvjlaniYHLD2fDlrpHBhkm8gxKWWMa17esB79Iaidg2aqLFO19xolHIJy
         wHT0+nOB5BCn2tIqYvIWA76eBO5kyUqqdTa2EinT+kIQy8ozaGeO/uubPCnOYw0ZoqIj
         aS1IR/f8tfiTsnPnlmD1rIVKTmLogxyJLj9wMnAxPdkVUuOAwWIkLk89AND+EFlOzv6k
         sxhKiBE3/wk3blHO/Z1lFRBTT2yKaCMLTpvGHuIM6F6uakKY8uHLk43y6m/EGCK02XMx
         C5dQ==
X-Gm-Message-State: AOAM532HE7qtkPnyz8EGgcAvcR3cvKP5ew1q5ZhLSHCKcO9BP5ZXp4aH
        3w9F8t1qSHrI9J3pBF8QbhI=
X-Google-Smtp-Source: ABdhPJzuqYss2XQHHTEEL4G4ZnVbNSLNJgPld3AOF3f/9w702uxIRSW0jghU9Nn/sCQgdj53nnqUEw==
X-Received: by 2002:a63:8dc4:: with SMTP id z187mr8101219pgd.199.1592001474836;
        Fri, 12 Jun 2020 15:37:54 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g9sm6539698pfm.151.2020.06.12.15.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 15:37:53 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] dt-bindings: reset: add BCM6345 reset controller
 bindings
To:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Roja?= =?UTF-8?Q?s?= 
        <noltari@gmail.com>
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        jonas.gorski@gmail.com, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, robh+dt@kernel.org,
        tsbogend@alpha.franken.de
References: <20200609160244.4139366-1-noltari@gmail.com>
 <20200610172859.466334-1-noltari@gmail.com>
 <20200610172859.466334-3-noltari@gmail.com> <20200612215756.GA3884504@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <81072f55-b2ea-4ccc-36c3-fccaf9306fce@gmail.com>
Date:   Fri, 12 Jun 2020 15:37:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612215756.GA3884504@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/2020 2:57 PM, Rob Herring wrote:
> On Wed, 10 Jun 2020 19:28:52 +0200, Álvaro Fernández Rojas wrote:
>> Add device tree binding documentation for BCM6345 reset controller.
>>
>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
>> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  .../bindings/reset/brcm,bcm6345-reset.yaml    | 37 +++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml
>>
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.example.dt.yaml: reset-controller@10000010: reg: [[268435472, 4]] is too short

maxItems for the reg property should be 1 here.
-- 
Florian
