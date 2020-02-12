Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0B5C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A484C2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581504251;
	bh=RAzotG298/4wKds2MHt6NNhEzy+DucS65/x2N6wwQCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gOw72bMsCz4q4d3WxHfpA7n3J10mEIgf2n6YrpEI7WqcRP7D01unzylp5QCqMRsUk
	 x/KHa8ii+Gg3x2dLYzJvORVoDkpQptnuXZ5eI3jb4y1+mEp/enWVlTpb3faebyLq3O
	 8nzTKyU+BVqHeuF4ABYPK27wZK2weeBYJKrhFqns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgBLKoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:44:10 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36235 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgBLKoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:44:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so1747701ljg.3;
        Wed, 12 Feb 2020 02:44:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKlCRyIiMtnqAsTUzds53Dv6bIjyCavUz2JwE+5Q86U=;
        b=q5HVRDWhwRbnE9XD+o+E9xAjOAPh7hQLfxuR2Q8IDVZ9T4TM1epaVOtVyrlu8rGABh
         yFqCmc8lkO7Cafl/HYhWllqXiIuLapsvVAQnGGQcjsqxaammtQ08szh/unYlYUU7/aVn
         5Y3eK5B2eLMSiN4yawADQadAg6x+qVO8ETp7np/hh4aiE/y3aTnL30BjSCFWlOM0LEUK
         td2zjvNBwoIws7FJZtQbuHZF0cSwe9TfZs+qsUqy1+gm8TKYyrBdhoddFPoiOZyROZAx
         4AUMHjV+kM0rXe59nSsEt0+w7iLyrsNYMIQHQxtbyBaexbKAv1lDD0w6rEbSKtyjKUtE
         Q1MQ==
X-Gm-Message-State: APjAAAXdH6yUdrcRJ+JyB2DNrRd0fEFCMh+e7/up4E+c/raNqoNUtsR8
        KlNzXbkgf21uto2iOoHGwE3mfSN2
X-Google-Smtp-Source: APXvYqw7J+T5Ysy2HXL8fB1EY4rHD15OKtFOpMRNPxVKAu0ydkSwOONjjAYScm3qUiyiEjWtrDI6RA==
X-Received: by 2002:a2e:9e03:: with SMTP id e3mr7402721ljk.186.1581504241717;
        Wed, 12 Feb 2020 02:44:01 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id a8sm13450ljn.74.2020.02.12.02.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 02:43:59 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1j1pUs-0005Cc-An; Wed, 12 Feb 2020 11:43:58 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Barry Song <Baohua.Song@csr.com>,
        Johan Hovold <johan@kernel.org>, Dongli Li <Kasin.Li@csr.com>
Subject: [PATCH 3/3] ARM: dts: atlas7: fix space in g2d compatible string
Date:   Wed, 12 Feb 2020 11:43:48 +0100
Message-Id: <20200212104348.19940-4-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212104348.19940-1-johan@kernel.org>
References: <20200212104348.19940-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the space between manufacturer and model in the SiRF compatible
string in the g2d node so that it matches the recommended format.

Note that there are no in-kernel drivers that use this compatible and
it is not present in any binding.

Fixes: d9615f8bf5d9 ("ARM: dts: atlas7: add lost G2D node")
Cc: Dongli Li <Kasin.Li@csr.com>
Cc: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/boot/dts/atlas7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index f1e8c772a59e..c3104b85813b 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -1930,7 +1930,7 @@ lvds@10e10000 {
 				resets = <&car 29>;
 			};
 			g2d@17010000 {
-				compatible = "sirf, atlas7-g2d";
+				compatible = "sirf,atlas7-g2d";
 				reg = <0x17010000 0x10000>;
 				interrupts = <0 61 0>;
 				clocks = <&car 104>;
-- 
2.24.1

