Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58BCC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9900B20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NscaW7BQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgGQQ4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgGQQ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:56:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3FBC0619D2;
        Fri, 17 Jul 2020 09:56:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z3so5683371pfn.12;
        Fri, 17 Jul 2020 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=okTIjusbtU6d1ty8+Q1jI6Vvd0+KoomCNv2GIe8K3wg=;
        b=NscaW7BQQOr7BMOCAnLQLSNwLqkF8B2HNrvWmpZE/ITy3n4EfawUr4WI0fLpFEE1RS
         oYe3xSxyr+eLKt7Rq9Psi03Y2CEvAbH0HR18GNjee0ZXn2+pAW3jX5JL9aFTjJvt/fe8
         X3r91ENB/5D96gGcs4+uL9Q5LrdPfPfa2Z03HkgldEhPOCcsbKEanHKinQHIm+qfQaCo
         U1ixeioJCWpfp388gn3EOwssOEanepcGgC8K8BrDPHNzwcAcia840EEBhdB3X2W4uAvd
         a5HX6GbOkStaF4XFbRC9hbyyIjt6W+1eXhOgHudfAjOpQK8YDRG5aTglTILxdZ33r0Yq
         DzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=okTIjusbtU6d1ty8+Q1jI6Vvd0+KoomCNv2GIe8K3wg=;
        b=MbeTop/euqS/E7nAeEitL7obhvpNxvjhTYGo8nmvZkRk2VrzbOWb5XI9AnISg1vkK5
         IT6xLCJn2vcnSMfMRgyANrW2kesd0GfYkT2l09QoSPK0WLSUC8S7tLcVJ8JGfkQLHdxI
         Z6BhQBOtd29uaXbQGncmnhY53dHEM6kfW2nY4moBqHDVpPmvF2McVDH/D0l0Gq+tcAOf
         z11pSrJbraB253ii1B9XX/9rCCfc+onCDCNDwUj140NagpDIdgdHaZKoqcWDRWHCm/Mh
         MJ1d1/Xw7rEyK9LUZu93VHpLpCRyhiFAuMliC3zY2RhdSJUE/y0+Kkr3VWUoslEV4Wzr
         a0YQ==
X-Gm-Message-State: AOAM530TPzAWZQR84fXQKTA7LY54Nfy4ELQB094kPTcPXM5+gQNeEoLv
        oeWHVAkX05kMkm9i77R6gUE=
X-Google-Smtp-Source: ABdhPJyfCRD6GZ5W6fCjqhpPZGz0PV8a/OGxBchJVK8AdxzsHrxWd4QpYaAS2isvN5c+QwDLFWEpwg==
X-Received: by 2002:a65:6416:: with SMTP id a22mr9093578pgv.392.1595004996050;
        Fri, 17 Jul 2020 09:56:36 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y63sm7945867pgb.49.2020.07.17.09.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 09:56:35 -0700 (PDT)
Subject: Re: [PATCH 3/7] bdc: Fix bug causing crash after multiple disconnects
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Sasi Kumar <sasi.kumar@broadcom.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20200717152307.36705-1-alcooperx@gmail.com>
 <20200717152307.36705-4-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0ef07c97-83a2-616e-3d43-46cefa7c95f1@gmail.com>
Date:   Fri, 17 Jul 2020 09:56:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717152307.36705-4-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2020 8:23 AM, Al Cooper wrote:
> From: Sasi Kumar <sasi.kumar@broadcom.com>
> 
> Multiple connects/disconnects can cause a crash on the second
> disconnect. The driver had a problem where it would try to send
> endpoint commands after it was disconnected which is not allowed
> by the hardware. The fix is to only allow the endpoint commands
> when the endpoint is connected. This will also fix issues that
> showed up when using configfs to create gadgets.
> 
> refs #SWLINUX-5477

This internal reference should be removed and maybe we should be
providing a Fixes tag as well since this is a bug fix?
-- 
Florian
