Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD82C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508BB206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7KPqbyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgFPH6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgFPH6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:58:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F3BC05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:58:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t194so2023803wmt.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zkpEUYkVmnjSkCa7M9yUMVXxz2rW/49cI/qWtv7pReE=;
        b=D7KPqbyyWMy/8cI1heqRPj1ri2gK0clJjrKnUIcmJgW8gC4xFRXoVkloHJ/X0Sd1tK
         hiZYR/PMNBPZqUmF7TX7kF1pM8zZA1WtxgF4B3+V+4vhB5Enx/YebaUN4XqEnhtIngBy
         VFe05tzUWoPuvpqORVtOaVxbY3qvucvjXAivvhc1EabFYwRxK2/Hazc4N8Xv29w7Mu2n
         Sx1hFRVipzrScU+TKliNjyHgzGStL2J17vca/NfOxjafLbskypg1eGkhjPHqelvT2WVJ
         UTf7Cxg7qfYe2IzJeXtwnjYrZPm46e934fPpPyO4e94fY+6C/uBGh5b2rAM/4PoKrAWn
         d9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zkpEUYkVmnjSkCa7M9yUMVXxz2rW/49cI/qWtv7pReE=;
        b=nWLxPEDB9P2zFQhfrpN1SBY0G/HPNzoEwPsHCra5+BJLgO8kqTEEWcvHNTF0eVLmAQ
         VK4aqWzz2vTs8oEkQz9PbmH6+r0Htp4wYy4CgADBo0Af0GhvwqqR1kKYtvr56uMjupg7
         gUgAYIQcyFm9oXc7WaB7ds/BMCQOCKwiVwrlgQfZXp5jH2NBL4CJ2k1GtfIskMNfhcJN
         767O8M9sC6aUG5dbCv+dFuZNfKbYLgQiblkQ/UsSqN/k6/gLESP7UdjgOq+wOGDoEjeT
         Oy2uyYR9ixcru5F2AJ/JhmHrXFqrPgcg1UxVpK/6n/IholeEw5ST5gny21hUgcV4Pau3
         fRuw==
X-Gm-Message-State: AOAM530GWo/rZeryZqOEUkhNOYByiLKHJRd9BEF8dACFdJXvLkFK6gZD
        uTDBPGBMUmVxxzD0y131UoLCEC2mviU=
X-Google-Smtp-Source: ABdhPJx415U6C/I4+X1fEAxA7Dpxoc+jNs6NkzVlZKjrabjduWFpth+lCq5HgTlikDz5i5YdscS/Xw==
X-Received: by 2002:a1c:6056:: with SMTP id u83mr1800951wmb.138.1592294316432;
        Tue, 16 Jun 2020 00:58:36 -0700 (PDT)
Received: from dell ([109.180.115.156])
        by smtp.gmail.com with ESMTPSA id 104sm29488309wrl.25.2020.06.16.00.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:58:35 -0700 (PDT)
Date:   Tue, 16 Jun 2020 08:58:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v2 1/2] mfd: mfd-core: Add mechanism for removal of a
 subset of children
Message-ID: <20200616075834.GF2608702@dell>
References: <20200615150722.5249-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615150722.5249-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020, Charles Keepax wrote:

> Currently, the only way to remove MFD children is with a call to
> mfd_remove_devices, which will remove all the children. Under
> some circumstances it is useful to remove only a subset of the
> child devices. For example if some additional clean up is required
> between removal of certain child devices.
> 
> To accomplish this a tag field is added to mfd_cell, and a
> corresponding mfd_remove_devices_by_tag function is added to
> remove children with a specific tag. This allows a good amount of
> flexibility in which child devices a driver wishes to remove, as a
> driver could target specific drivers or a large group. Allowing other
> use-cases such as removing drivers for functionality that is no longer
> required.
> 
> Some investigation was done of using the mfd_cell name and id fields,
> but it is hard to achieve a good level of flexibility there, at least
> without significant complexity. Since the id gets modified by the core
> and can even by automatically generated. Using the name alone would
> work for my usecase but it is not hard to imagine a situation where it
> wouldn't.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Following on from our discussions here:                                                                                                                                                                                                        │··················
>                                                                                                                                                                                                                                                │··················
> https://lore.kernel.org/lkml/20200122110842.10702-2-ckeepax@opensource.cirrus.com/#t                                                                                                                                                           │··················
>                                                                                                                                                                                                                                                │··················
> Happy to discuss other approaches as well, but this one was quite                                                                                                                                                                              │··················
> appealing as it was very simple but affords quite a lot of flexibility.                                                                                                                                                                        │··················

What about this?

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index f5a73af60dd40..a06e0332e1e31 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -283,7 +283,7 @@ int mfd_add_devices(struct device *parent, int id,
 }
 EXPORT_SYMBOL(mfd_add_devices);
 
-static int mfd_remove_devices_fn(struct device *dev, void *data)
+static int mfd_remove_devices_fn(struct device *dev, void *level)
 {
        struct platform_device *pdev;
        const struct mfd_cell *cell;
@@ -294,6 +294,9 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
        pdev = to_platform_device(dev);
        cell = mfd_get_cell(pdev);
 
+       if (cell->level && (!level || cell->level != *level))
+               return 0;
+
        regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
                                               cell->num_parent_supplies);
 
@@ -303,7 +306,11 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 
 void mfd_remove_devices(struct device *parent)
 {
+       int level = MFD_DEP_LEVEL_HIGH;
+
        device_for_each_child_reverse(parent, NULL, mfd_remove_devices_fn);
+       device_for_each_child_reverse(parent, &level, mfd_remove_devices_fn);
 }
 EXPORT_SYMBOL(mfd_remove_devices);

No need for special calls from the parent driver in this case.

Just a requirement to set the cell's dependency level.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
