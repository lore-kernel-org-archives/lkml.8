Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A160C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2852072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvldG98l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgDMLrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgDMLrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 07:47:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C045C03BC91;
        Mon, 13 Apr 2020 04:47:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so2914059wrg.11;
        Mon, 13 Apr 2020 04:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ma5Z+ECsZBFx2q5FvmtQfMSDeLdqj1C7WfsxB0TOu7Y=;
        b=dvldG98lbyzYXAj/6EuEtw0i/B8r9upKEzAGdcyxUeaYblGloU9RoMqu97f8ivsJQn
         0Lf+mtVk0TEzpkUiDIw1WAgNE8jq/pAjIN6qKbZj9hGepjBw3M1Gz7LZfh4VKrzycZLK
         XrwNsP7biMAAcyfjCgWaqyU8HaMGh9OBCCdXORiGJz0Ufnw8HMFC+BVIkVM3viDPpwPe
         gJKotzCPaWvQboGb67M8+EbNKNzYMDzlef2w7meb0zfNZbmkuLx5ypAwkPPN6nNcvPb9
         AvnL/5whdGcnhuNpjWxAKULO2Yyhm0bDRfipay5fvbCh47uLRlw5cB/gt1IphFF9QLfx
         aPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ma5Z+ECsZBFx2q5FvmtQfMSDeLdqj1C7WfsxB0TOu7Y=;
        b=fQ0VXzRDgAVET5cBBJifC/DktMfw4g10aNiIGPrP33OrjZLdG5etLLJI+WgWGjYJhD
         ChhD3qr0v5IJ7qZl9RE9nxsS3RRRNXhnXXGkELtA8t2vkeuwlP/0/b/r+SBmISUeYjul
         fhjufFpynMQvvYlFk7QMEmlfbcxQ94r20Ebb6x2JmJ2YU6uqcV6RuoI5Mz2Ubuj2ErfE
         bMZHz83KalxMZehAL0y+iTpxDOaf8QOMezhHd88e0E4h6JCshHumH9MI6iWS7Tk+7qSY
         VWQCiKYR8UnV4s9fduZcL8Xk+ijQSsAKKdUOIlX3IXnMdtsFqFM2hAXWLjZ0/1K1HND/
         WXOg==
X-Gm-Message-State: AGi0Pub6h1imIXptjPWNLH961Cm6g2hfizlBGAqdU8DS9DeSMi5H9meZ
        zS7btxYrqtssVh3Z9nvq5Vg=
X-Google-Smtp-Source: APiQypJ8XpcmMfL9rBNlOD+n3vOrA1R0IYnODT1p02mmvU2zd1OfA9y42vimgSsQJR03p9fU0PwPTA==
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr17975869wrv.78.1586778434998;
        Mon, 13 Apr 2020 04:47:14 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2da9:2f00:3165:1687:284f:4993])
        by smtp.gmail.com with ESMTPSA id l15sm14008827wmi.48.2020.04.13.04.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 04:47:14 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        Yash Shah <yash.shah@sifive.com>, linux-edac@vger.kernel.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] MAINTAINERS: place sifive_l2_cache.c only in SIFIVE DRIVERS
Date:   Mon, 13 Apr 2020 13:47:02 +0200
Message-Id: <20200413114702.6372-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9209fb51896f ("riscv: move sifive_l2_cache.c to drivers/soc") moved
arch/riscv/mm/sifive_l2_cache.c to drivers/soc/sifive/sifive_l2_cache.c
and adjusted the MAINTAINERS EDAC-SIFIVE entry but slipped in a mistake.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: drivers/soc/sifive_l2_cache.c

Boris suggested that sifive_l2_cache.c is considered part of the SIFIVE
DRIVERS, not part of EDAC-SIFIVE. So, we can simply drop this entry, and
by the sifive keyword pattern in SIFIVE PATTERNS, it is automatically part
of the SIFIVE DRIVERS.

Suggested-by: Borislav Petkov <bp@alien8.de>
Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Paul, please pick this patch.

v1: https://lore.kernel.org/lkml/20200304144045.15060-1-lukas.bulwahn@gmail.com/
  - was not picked up.

v1-resend: https://lore.kernel.org/lkml/20200413073447.9284-1-lukas.bulwahn@gmail.com/

v2: reworked based on Boris comment; applies on v5.7-rc1


 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..e28676766b26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6172,7 +6172,7 @@ M:	Yash Shah <yash.shah@sifive.com>
 L:	linux-edac@vger.kernel.org
 S:	Supported
 F:	drivers/edac/sifive_edac.c
-F:	drivers/soc/sifive_l2_cache.c
+F:	drivers/soc/sifive/sifive_l2_cache.c
 
 EDAC-SKYLAKE
 M:	Tony Luck <tony.luck@intel.com>
-- 
2.17.1

