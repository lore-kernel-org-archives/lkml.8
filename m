Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FEEC3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7F0217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IPZYguxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgBNCoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:44:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42709 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgBNCoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:44:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id w21so4169033pgl.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 18:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=niNApjCO06O7a+lFbqctq/E/HFCOZGM44slzM8VnlEo=;
        b=IPZYguxYwiX88hRwH7QTLPVac3hJ/RngX14B4KoZqW6OiO/2xsVmTwj+HhOFyfg7nh
         TT0vT38gm9VGUvEz2ocWIbn+qo8hKz8aOteojzMKPNJwdp3Ifg8ap0Hv7Ilq+x9zZLw8
         7xsWgM62nwwp1kelkqj+SxQtFQoO+K1f4zu1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=niNApjCO06O7a+lFbqctq/E/HFCOZGM44slzM8VnlEo=;
        b=YOG/VhKvibBmgNhrqdxAWk/YwyoYf2knkyk+gwUBVYBh7yEZbUN+8ggaGEisxfLLzH
         qzu4MD4wUPEaA0WpaS7RbT31AXgUS8IA1yEE2mkY5L4yC+PxLnNsDQnGX8zq0jtqUsuA
         y/9SatQFN2n1mtpE9P4NGu2afDBt2QhkNz/OM7fUfGva9WRSJQ8TWJgxDAXKGkDISXoJ
         CaPMOUsvZkW3GuAJ1SxKeDoZ4OmYJhlf1c6tKMwlCG+zfDIFUPIlTJdUMgS0a0KYtOFR
         Y1bkytvUxBxgSM+RP6XHLN3aN62Wez8JnXfkMCg5RFc/VMoXKu0t1zVctlx2VsPmJE66
         7MOQ==
X-Gm-Message-State: APjAAAVtyZ5vTTeZsVu0mQJT3uNZTXCyPyTPtmOwJmbOT5QDpOIvwKxP
        mqJh4Vw2ZRySllLXYuFBDhj5Jw==
X-Google-Smtp-Source: APXvYqwzYj+wvXbHesIqdU5LMCnildAw4yCq+8revIbEfOsWKVii3zdqeKtfxcBEcLKIdQKk+eTHGA==
X-Received: by 2002:a63:74b:: with SMTP id 72mr1052514pgh.162.1581648252362;
        Thu, 13 Feb 2020 18:44:12 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c10sm4575360pgj.49.2020.02.13.18.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 18:44:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e7ba4dbd8e9c8aedd6f5db1b3453d9782b7943cd.1579692800.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1579692800.git.saiprakash.ranjan@codeaurora.org> <e7ba4dbd8e9c8aedd6f5db1b3453d9782b7943cd.1579692800.git.saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 1/2] iommu: arm-smmu-impl: Convert to a generic reset implementation
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>
Date:   Thu, 13 Feb 2020 18:44:10 -0800
Message-ID: <158164825099.184098.18396989716299086067@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2020-01-22 03:48:01)
> Currently the QCOM specific smmu reset implementation is very
> specific to SDM845 SoC and has a wait-for-safe logic which
> may not be required for other SoCs. So move the SDM845 specific
> logic to its specific reset function. Also add SC7180 SMMU
> compatible for calling into QCOM specific implementation.
>=20
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
