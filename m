Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E850DC433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 13:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96F720DD4
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 13:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599397712;
	bh=UmyArtRIW5J5QuKVhnzZgbnd7tvhRyU6fqRKtyxG9BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qM62eHtpQ+JGr7qfNlom29cyUW8qqmcY7EB+rs04wsNhasFmje437VRLjP1lb7HB+
	 qfQA4HYGItkSkt5Cz62T5cHEha0zdXJ3rnT4Sb797hYICDnpdGv1FuSu+0PFZP9eO+
	 dMqzW5iFkr+SXnl5iry4o67llAvJXpoFF4S5OFrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgIFNIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 09:08:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35981 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgIFNG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 09:06:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id w1so10101353edr.3;
        Sun, 06 Sep 2020 06:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q92gvnzq1KDD9sdjw9UpZFI+TxFuTVSseQFtpKVlou0=;
        b=Elh+0BbiDHjPkdTf6ZnRPPkAmxyv+MO/jEcW73Y/UnTq1gVnPXPDmCzf+2Pon37PtX
         X6hnOhgdY4B5GeRHGOwOEFb7mOd2PKnwQoXM1XUneC8jtGjiJWk5M1ZQn3yaGNu/3Erw
         /vFKObxkSmhV5D1AjCbIoVIp7ZOcbxhgRE926ONSP3TCcACHOLztkm7DUr3T+okwd+aX
         OV1rFU+hSfxeDufxg7DVMD3ThPRNsofKicv46n+63rGhgTxYldhJRGxvDBSfmZDABp5p
         nTI2/7KATR3jpRzD6xes4dDEMGv5LaxBPeae6Zku+R5syr4C1Q9AhaYU4DwFOwv5Amb+
         Imzw==
X-Gm-Message-State: AOAM531TDMKMdBS751S5MbFuUaCMHzFjm63+Y6cj65vTztcbxfXjegzK
        FNKlJ5APGg0PpnqSRJb340M=
X-Google-Smtp-Source: ABdhPJwXwFbby6FpAtz+yPxA07vNTFv7hzV01/brw5RfYXU77VFYpvM4adzxjQaBESrXXJr4QmE6uw==
X-Received: by 2002:a50:ce11:: with SMTP id y17mr16761568edi.86.1599397615675;
        Sun, 06 Sep 2020 06:06:55 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id d7sm12076911ejk.99.2020.09.06.06.06.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Sep 2020 06:06:54 -0700 (PDT)
Date:   Sun, 6 Sep 2020 15:06:52 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <snawrocki@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: exynos: Add assigned clock parent to
 CMU in Exynos5422 Odroid XU3
Message-ID: <20200906130652.GA11579@kozik-lap>
References: <20200903181425.5015-1-krzk@kernel.org>
 <20200903181425.5015-3-krzk@kernel.org>
 <d83912b7-d829-4912-9659-de4a9a5e0d1d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d83912b7-d829-4912-9659-de4a9a5e0d1d@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 12:20:36PM +0200, Sylwester Nawrocki wrote:
> On 9/3/20 20:14, Krzysztof Kozlowski wrote:
> > Commit 78a68acf3d33 ("ARM: dts: exynos: Switch to dedicated Odroid XU3
> > sound card binding") added assigned clocks under sound device node.
> > 
> > However the dtschema expects "clocks" property if "assigned-clocks" are
> > used.  Add reference to input clock, the parent used in
> > "assigned-clock-parents" to silence the dtschema warnings:
> 
> I'm afraid it doesn't improve anything, we just add another violation of
> the DT binding rules as the 'sound' node doesn't represent a real HW and
> shouldn't have 'clocks' property. Instead we could move the assigned-clock*
> properties to the I2S node, as in below patch. I have tested that already 
> on xu3.
> 
> ----------------------------------8<---------------------------
> From f98d2f5ac86d1ae13a77ef481fcbf073a1740f26 Mon Sep 17 00:00:00 2001
> From: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Date: Fri, 4 Sep 2020 12:02:11 +0200
> Subject: [PATCH] ARM: dts: samsung: odroid-xu3: Move assigned-clock*
>  properties to i2s0 node
> 
> The purpose of those assigned-clock-* properties is to configure clock for
> for the I2S device so move them to respective node.
> 
> This suppresses the dtbs_check warning:
> arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml: sound: 'clocks' is a dependency 
> of 'assigned-clocks'

Thanks, this is a good idea.

Applied.

Best regards,
Krzysztof

