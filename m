Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC40C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203F72075B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjXa6TNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbgAOK3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:29:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39264 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729650AbgAOK3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:29:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so8013861pga.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 02:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GZGVdYkXGD9r067czQDmOYY3BF/KYHfnpdKqP6c88Yw=;
        b=qjXa6TNLOt2bFuYFYscXJ1rz8enYvfZy40A1erx6lIUX9znLX5dSdk0zUHlYSjwlkk
         tMGc4xCyzOkiulAc+BtbMCialYxXCH1KX35w6bkbpPvJV4i7DJ/emLUlQiMmdTw3GLO4
         N5JbokL+Pa+xg4o1Dn4bBe4emDX6Mfcl0ifAENfNilUA1QOyIAXI27rD5WU6TJGbN5Xz
         z6ld2Dz1m2kcHMAc8x2tmFGIXXQBXKJjtPs3DBFvrfIBrkvd4sxKqfkFfv+nY1gbybb7
         Em4eEuKA7lSAsOk3+D/7F37m/MpJpqep/ZBagMP9560jqOdKLNn08PptkM10rzdGBqDt
         aLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GZGVdYkXGD9r067czQDmOYY3BF/KYHfnpdKqP6c88Yw=;
        b=EI8T4suyRR++wADu7JTRZF6QfSEoCVwDtFjjo/X2+Sk/AlcBh4qQsDWZkyaDt86b1R
         2SRhsIfp93M4jtxuMLe3S07iy1xY034fe8dFe5gODpDXLqPQEx2Z+xccXx2mUoh3mWKz
         fQTBGIofEQgsjpYlvPrjUAzpLBcQ58LZoMvvSmYk1QSKSPWX8fmBPtHu7hFBQ1uaIv+v
         uahalgzgxOVbH4pK2MF/OA3+aWeH1wHkYI111JVQP7jG02Y77zv+KWoyOrjLYWb+YCuJ
         K2e3YfOdkzBS5M+/5KDQV6Apec35uKQPa84Z6a8coywQa5nmjy1Kpq86pcKEAAB0aSYI
         60SA==
X-Gm-Message-State: APjAAAVPEK/0e89HZhqvbBU7E6XIdb1XAa8lvpIr1Qm0Eb+ih1SuAOEP
        9MKaKx/QUGeNzkjNwt1B6FUvsst6
X-Google-Smtp-Source: APXvYqxAGCVejC6y4jIVoWu+VamO/gU912z2pDTtkng8WCrC9bJX7/OY1aV8VWRLTazearIqQWww9A==
X-Received: by 2002:a63:134e:: with SMTP id 14mr32789780pgt.115.1579084163792;
        Wed, 15 Jan 2020 02:29:23 -0800 (PST)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id 11sm21756342pfz.25.2020.01.15.02.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 02:29:23 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/vt-d: fix the wrong printing in RHSA parsing
Date:   Wed, 15 Jan 2020 18:28:15 +0800
Message-Id: <20200115102815.264-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When base address in RHSA structure doesn't match base address in
each DRHD structure, the base address in last DRHD is printed out.

This doesn't make sense when there are multiple DRHD units, fix it
by printing the buggy RHSA's base address.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 3acfa6a..78bb03e 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -475,7 +475,7 @@ static int dmar_parse_one_rhsa(struct acpi_dmar_header *header, void *arg)
 		1, TAINT_FIRMWARE_WORKAROUND,
 		"Your BIOS is broken; RHSA refers to non-existent DMAR unit at %llx\n"
 		"BIOS vendor: %s; Ver: %s; Product Version: %s\n",
-		drhd->reg_base_addr,
+		rhsa->base_address,
 		dmi_get_system_info(DMI_BIOS_VENDOR),
 		dmi_get_system_info(DMI_BIOS_VERSION),
 		dmi_get_system_info(DMI_PRODUCT_VERSION));
-- 
1.8.3.1

