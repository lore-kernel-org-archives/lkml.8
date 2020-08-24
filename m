Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1917CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95D722B3F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdaarUoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgHXSaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHXSaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:30:11 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC9AC061573;
        Mon, 24 Aug 2020 11:30:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d4so4639818pjx.5;
        Mon, 24 Aug 2020 11:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SzSkUtPUy4wSVm8hpGwKYIsMtSZm67ZS2O89snx6pwI=;
        b=gdaarUoqCIiwABxnpMXnnZ2mqx23KMdtcFUddAcGaLfi6EiKe87Sd4RcWgzIyc1eas
         ZJgxK6sKT54qQjg0ljWEvKmZ3ZSzJ/ZKbFk1EyugLWWNBUrKya0Ghrt/8z4sFy2Gx8VU
         kjAJlJOGY0eTan2ks3iEi3FfH7VIyiSNemFFXitUbXOQAK+QHfSYZK6MvzNeV/IMpsGJ
         9B2yYVHvKak1G2fFW+S8OsPmUdj0oWouxZ6PN3C6D84Q/xJHRmMorjQKDaRJPMuZ6jUm
         Nq3WUqb1tkAiCVGw4WYOPj+9RGn3qaNG3v7bEGs+djoL+NmccNhxhcMAF/fqVa3B20Qe
         ZXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SzSkUtPUy4wSVm8hpGwKYIsMtSZm67ZS2O89snx6pwI=;
        b=XPAUe9uem4P6eRBom3AO7hU3hVNUVMfE0TuSG9qb4HRLVcv51rTb5qFyMlgsHfz/r/
         LQFAYAwavl/XDCrKlSazIg2XOGx9+ISmSq8F8YnGNF5H+he7HO31qPGdFcoyJ2NqqU5j
         OCa8sJNhxTxK0Lqv3AcH7icY9PBE8+M4+krySJL0+1PxvQu4OUJitvzO6iQaTUcQO7Q6
         cS/iNXMY+2D+xJMdxzZZ33miD8zyosCSQpVU8Poud3MOAaRpVlKLOZ3kt0UwQurd1oel
         qvbs3Mc/SRTvLRDOTEvrkj4GO5QazNc42pVluaeXqRi7j5pb9a3Aop2GkfN2z7I9BckQ
         RC4w==
X-Gm-Message-State: AOAM530vZlYL9nvduWHbk4lOjsFA6q/i7D/A0DiHJ14jeI6LhZPrj1TY
        5LFW1OFrVD3ws3EcY8d2w/Q=
X-Google-Smtp-Source: ABdhPJyQl90yeiPKm6q0o8ykCH0TN4o1q1PbqZ5ByEogQFJ2Fyp7SaLSzFATDLheHgv4Megk9cEKzQ==
X-Received: by 2002:a17:90b:1214:: with SMTP id gl20mr456752pjb.225.1598293810528;
        Mon, 24 Aug 2020 11:30:10 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id a66sm3920460pfa.176.2020.08.24.11.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 11:30:10 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 1/2] ARM: dts: aspeed: wedge40: Update FMC flash0 label
Date:   Mon, 24 Aug 2020 11:29:54 -0700
Message-Id: <20200824182955.7988-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824182955.7988-1-rentao.bupt@gmail.com>
References: <20200824182955.7988-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Update FMC flash0's label to "spi0.0" so it's consistent with all the
other Facebook OpenBMC platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
index 8ac23ff6b09e..3f2a48fa77b3 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -48,7 +48,7 @@
 	flash@0 {
 		status = "okay";
 		m25p,fast-read;
-		label = "fmc0";
+		label = "spi0.0";
 #include "facebook-bmc-flash-layout.dtsi"
 	};
 };
-- 
2.17.1

