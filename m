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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB22C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD6721883
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMDCgbzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgFQV3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQV3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:29:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA1DC06174E;
        Wed, 17 Jun 2020 14:29:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b16so1744611pfi.13;
        Wed, 17 Jun 2020 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zv1INp4X/nxFJAvPT53tnYt0FwQawRZpMAzUGoSP1NI=;
        b=BMDCgbzQYArV+44ej/j29mTlKDViF0acMLXp4NcBjjN7T7whOMUpk3Q8OTMPKvlO87
         qfqnGIydMsBHtnsznOqjXk28Y010G9ZzC0w6yUfXAUyb38bySvpUzPmSDfE12HBo4QgB
         2NhqCguOyCxLT5mCcZktAqSlnej6TPpZleRX5WvbyKkZSed/GI/zXyrjkhEQr84CcsG3
         vDd8Vbo4/KvMRzI7oKY8cT+ewqfkBVUrH0kskbDEZ4qtl849JKzLyy/q6roCNkmMmo0d
         lEysXeDvxkDXswcE3ajOLx1zOich96vPU3igibDmf+dEVwrM6iIxxFVcjRluA/oNO0BF
         ym6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zv1INp4X/nxFJAvPT53tnYt0FwQawRZpMAzUGoSP1NI=;
        b=gx7rWRrWtDSBhjKwG3OmTCUtfc4p1bg0ucGQDyV59+WetfwrpvCsQjVjQmzl/A0ZTy
         uOMuWKAwChHqrh2phL5kzbzCBGE2qyOlBra91iAPMDR1XchftVHuOfpwCb5YiUSEnbgL
         goc8e8CCH+mlWuSYMossugHiKV9kbKeEcXG0OAlKjWjreq6a0hgqhpR1lPdURi0i2ZWX
         ZW1syBUrypDE0m8Ij0kYmJLINlpDTacFBUtfjCScc/pNmiryk/6GGFA7hrEIvUkQXG8i
         llJkCyhrIS8gO9bG8lEXQdO7G6YxyE/yR63kh7wnoYZccw06BUzuCFH+Rx/Fej21nAz+
         tTfA==
X-Gm-Message-State: AOAM5336LtwYDegCoi+CDMUZWNQrgjq3ZVEnjBuQkBwTj6oAUVyj5X5M
        gA2JgccUx12zuoixfjjrgzE=
X-Google-Smtp-Source: ABdhPJywKZd86vCKkZ9ihsL3xoKPhBz8XZ3r87sZB8iFEQjuRVnd1JSIUSMgFVRP+At+cRlQhqxuMg==
X-Received: by 2002:a63:f711:: with SMTP id x17mr675727pgh.79.1592429360392;
        Wed, 17 Jun 2020 14:29:20 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e143sm741832pfh.42.2020.06.17.14.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 14:29:19 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        simon@fire.lp0.eu, jonas.gorski@gmail.com, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200616184542.3504965-1-noltari@gmail.com>
 <20200616184542.3504965-2-noltari@gmail.com>
 <7b82a18b-2939-9516-d68d-ddac41014da1@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e37785fc-8d3e-bc7f-bd03-bb6ec0a6843f@gmail.com>
Date:   Wed, 17 Jun 2020 14:29:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <7b82a18b-2939-9516-d68d-ddac41014da1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/2020 2:20 PM, Florian Fainelli wrote:
> 
> 
> On 6/16/2020 11:45 AM, Álvaro Fernández Rojas wrote:
>> Document BCM63xx USBH PHY bindings.
>>
>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> 
> 
> 
> Since the USB PHY supports both roles (host and device) on a large
> number of SoCs, I would just remove "H" from the subject/binding/name
> accordingly. With that:

Well, the register is indeed named USBH, so the name can stay as-is,
this is fine, thanks!
-- 
Florian
