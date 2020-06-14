Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4642CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 01:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1677320739
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 01:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="dnGgxZhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgFNBW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 21:22:28 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:33742 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgFNBW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 21:22:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49kxXL6kwtz9vK03
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 01:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E_QQfrHdQb_q for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 20:22:26 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49kxXL57zpz9vJyx
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 20:22:26 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49kxXL57zpz9vJyx
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49kxXL57zpz9vJyx
Received: by mail-io1-f71.google.com with SMTP id d20so8863298iom.16
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 18:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWaD4fQyHbWq3bbusGJa3obvcK40dmIFPt4HBS/vC+8=;
        b=dnGgxZhWilGEvZAkDKg8+Db3hNX1+NOCy/4oK32fpCcuIBiSCLn37R9dMCTvR5yOnN
         m9KEtdopyhDK6ah8M4C/7Ae9EnXaPpr7b6yJHQL8m/jac7VXpHQVtKYFn8bmbq9lSJro
         ABG7Whrj7bznZW+sAz3bnIzAN9MG0WAH84cqBVbc+2zq+fJd22+zK1m/hZozqp6+NbrO
         +6OwzFLwRZau6lJ11+eb9xfW5Ew88zoMf1Wlg/Gw79N1J7+tFJJ6PK4TcLjrugCBhiro
         AgHbHwNXra0eLZ2T1ZjYU+QKKaraFrGqUywmBUY+NPz1nwRsriTRIle/R+A6z7qIMd3d
         FvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWaD4fQyHbWq3bbusGJa3obvcK40dmIFPt4HBS/vC+8=;
        b=o/PkX2XRg7akPM2QKKFVOmNfCOPr1/wRVX4Cbpv1Lq8bYfcSVtCnhDy9omWvJkKzqw
         HBIdzp9YKG3EBfyMhiTaGAILYxHkzZpVZXxDm97UCsOtvY+cflfRlRo+EYMKEondX9/T
         JgkKrOwT57sANxUKRbeZzxoG2KxzGwbzcTc41cbJ1B/PmZEMrwJg7SP/y28pNcxcNV1V
         laowdavGI5TqegYy2tk4lVpJfGBDVVg2P2FQ1dVkNrYsCHctTU6Iga6BYPbZ/2PwypVn
         nwGjZDXNqT9rr+AM6s7M/0bUTwOqjXOgawCTcSva0upRrEK3HuHKJLcmYgbplS5p7zDl
         dwOA==
X-Gm-Message-State: AOAM532S8LAnvo8z2W6vdjCJlrbv+c5+O9LbjPWuZqk2/hkflh3iJUdM
        8agXx/0tDjE6A5uvVXcviDn8AbJJIXfMSfrcu6JibOLuYihOTJrMtaasA8jgfFEXQtRT6NZCtwk
        pVNGQOkYzmQcva2Zs4AfF3JtRADM8
X-Received: by 2002:a5e:dd07:: with SMTP id t7mr21202631iop.21.1592097746366;
        Sat, 13 Jun 2020 18:22:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG9/5j6jwcpTDWma6pdM8Bkh2xp31WtVsWXYi2gCUmVJhMzt5E2i8yikc3nH8lOVjzJe+aTg==
X-Received: by 2002:a5e:dd07:: with SMTP id t7mr21202621iop.21.1592097746172;
        Sat, 13 Jun 2020 18:22:26 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:d65:8ac4:1b02:86ac])
        by smtp.gmail.com with ESMTPSA id j63sm5760966ilg.50.2020.06.13.18.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 18:22:25 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Fix reference count leak in nouveau_connector_detect
Date:   Sat, 13 Jun 2020 20:22:23 -0500
Message-Id: <20200614012223.121019-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nouveau_connector_detect() calls pm_runtime_get_sync and in turn
increments the reference count. In case of failure, decrement the
ref count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 1b383ae0248f..ef8ddbe44581 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -572,8 +572,10 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
 		pm_runtime_get_noresume(dev->dev);
 	} else {
 		ret = pm_runtime_get_sync(dev->dev);
-		if (ret < 0 && ret != -EACCES)
+		if (ret < 0 && ret != -EACCES) {
+			pm_runtime_put_autosuspend(dev->dev);
 			return conn_status;
+		}
 	}
 
 	nv_encoder = nouveau_connector_ddc_detect(connector);
-- 
2.25.1

