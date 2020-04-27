Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB28C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A532075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lex2acym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgD0Gs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 02:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgD0Gs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:48:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B34C061A10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 23:48:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x25so18246650wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 23:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tqZm99Zf/6X7vs6ItPkmz9XTCnn/Rh1fuG6t165ThuY=;
        b=Lex2acymH/EL8KL9oG1O//wvg0tIUjVIPs97boTnZEOAZhb9g2WRUYu7I/iTouDEdb
         2jV3D1jXa/XNfU92ytQwxWY64lg7wAnKDwkLcGIzP57XeUZEsDeNC5fBKdKhbQHUnUls
         A08OlWqYbxKuyy9DO6GvZVmwQXrpbd8RzhsUMYTQXnBxFeMkA1Tp60udYm6Htikd1zcr
         dMWXEQhxyL0rgQe2gmfi5gvy72Fe24HAgt2FPrjLSuKftOGnpR5DIJq+rJD5+ZR/hMGF
         lMafGfXO4lBn9XnDah8AtLjAHoEqkOVLuoa4fNCoEQ5xG20BwJwwhSTIq8eOlPS1k3ed
         69Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tqZm99Zf/6X7vs6ItPkmz9XTCnn/Rh1fuG6t165ThuY=;
        b=ENd7xWrSeCTYy7U2zh+VOEmREeksnaTHxV+uSBr5A/RtaEEZBubR7bOKtmfxziV3qV
         h8jZj13BezQ8ATuSJICCYadAhSgJrnXWyeCiYB3vaittxijQAY+AESIyd/HmnCUn4q1P
         urVcwUis3PaCQIYwd01cuJYzpLcscmI4ivxmZFN1IWEJnjueBmnLyF4M5GIzbHKqZ24E
         4EdoRzX0UBj4W+DA7Rj7YxBvOljymMTh78fY2LSNuIxegi1pphbQwIdMTpdQh7sioXjm
         hiKrLQecT1vk37aWxOSO3qSZfFEuRhy6M3qtgW7pGU1i+zouZqGYaBXCIOqAnU4plLYq
         LHNA==
X-Gm-Message-State: AGi0PuaiP3EcmreRsbQY+R8DvWtFfMITiIcbCXb2nWEuQ/yFLLgIOMHZ
        5X+p2Sz2V0MRcXM5WP+BC1ZBdw==
X-Google-Smtp-Source: APiQypLuZFXTKen+2fFsBnlGHaQuyH4+Eqpjh1HuxmoMEQ78eRCcmoD17SokVOfN4lYtcOz68V5J5g==
X-Received: by 2002:a1c:9c15:: with SMTP id f21mr24885638wme.139.1587970106742;
        Sun, 26 Apr 2020 23:48:26 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id k3sm22060397wru.90.2020.04.26.23.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 23:48:26 -0700 (PDT)
Date:   Mon, 27 Apr 2020 07:48:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] mfd: Add ENE KB3930 Embedded Controller driver
Message-ID: <20200427064824.GB3559@dell>
References: <20200424221123.106527-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200424221123.106527-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020, Lubomir Rintel wrote:

> Hi,
> 
> please take a look at the following patch set and consider applying it
> to the MFD tree. It a new driver with DT binding documentation changes,
> utilized by the LED driver submitted here:
> 
> https://lore.kernel.org/lkml/20200424220240.106055-1-lkundrak@v3.sk/

What is this?  The subject suggests this is a cover-letter for a
patch-set, but the patches are not attached to it.  If this is the
case, please ensure that you send it --threaded using

 `git send-email`

If it's just a random plea to go look at some set posted onto a
mailing list without me on Cc, then no.  Please send the set again,
properly, with me listed as a recipient.

> Compared to v1 the dt-bindings validation failure has been fixed.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
