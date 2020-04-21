Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABA5C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B68B206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2N/BJbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgDUQpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725870AbgDUQpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:45:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B7CC061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:45:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nu11so1583855pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dkKRjvPolkdN+Xm1/24QKsRrOCdugSbTYL+Ykb1FDCo=;
        b=B2N/BJbg+oipDuuEOBfnU5D/XYc6sWk8sb9VJi8vR8iB5YmcJCPG7/gBesD+9EvChX
         P7kzpgmrXvDzCIiBUOtt/k264UAk9f+yMho3icl19QaFfrRS/qmY+y+L3gTyzpsNP/RR
         t/ieyjgMNqu++s8hbJXwi3osDm/xt3XFPk1U27V/akXBXLcc7u3aoomrlyXmWeqExnrb
         ZiSPfgmqaz0OA/WW2BPxF2YT1DliXTIBK4Q2Z0FAgNjCAXWhdg/Bq8zYYyxMUVtCCtRT
         9ZMFdM/6CLY2mhhBjG+2Gmd44bn4QHLlbe3+U061qZ66C3YjX9/MS2k+xSIdkSOx3DKf
         UOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dkKRjvPolkdN+Xm1/24QKsRrOCdugSbTYL+Ykb1FDCo=;
        b=Hw3bOUwVLcCa2vDe5KPqwZBtYTM8knItEvXspgi5SJZakilpbHyZ+NfB3GYITk74Y+
         siIDcDIb9qqci0a04rZzBBZXD+C1hxLMsynCRH6ph8iYVNKkZjE05ZdtAAdqUu++cLgX
         1DtvgfIZrA8mpvU8RmuMQ8kGrYPfCpBgmkDgcDIpnP8uk7sE8uqiH95OoxxKLxImpilo
         XmlgDvtYj0oHWXDuFLILexAz611vZwefLNjt4UP3M9+jNtS+wpT5/etRRaD7MqHF077R
         PBqQnp4tb/0ESLN3u+ZQlzu5yPof5SXaLOLWSUnG5qJPANAGffn8szgK2k99BQhKDS0s
         1XcA==
X-Gm-Message-State: AGi0PuYu7FmVF7N2pbsBkvnsvm+Z8eK2l6V8McOzV5+UxURPAl8yeNx+
        nFmc2vvqJor8Szl/PQ1lVKI=
X-Google-Smtp-Source: APiQypLB13ofxCwS/78iQuE5OdOvYv3QrdBMPpIfjfv/UbebnxbXovFAxGys+oSvkwRrMX/HbCmQEQ==
X-Received: by 2002:a17:90b:297:: with SMTP id az23mr6439510pjb.85.1587487551539;
        Tue, 21 Apr 2020 09:45:51 -0700 (PDT)
Received: from localhost ([89.208.244.140])
        by smtp.gmail.com with ESMTPSA id p2sm1948574pgh.25.2020.04.21.09.45.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Apr 2020 09:45:51 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     kraxel@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1] drm/bochs: fix an issue of ioremap() leak
Date:   Wed, 22 Apr 2020 00:45:43 +0800
Message-Id: <20200421164543.16605-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It forgot to call bochs_hw_fini() to release related resources when
bochs_pci_probe() fail. eg: io virtual address get by ioremap().

Fixes: 81da8c3b8d3df6 ("drm/bochs: add drm_driver.release callback.")
CC: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index addb0568c1af..210a60135c8a 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -138,6 +138,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
 	return ret;
 
 err_unload:
+	bochs_hw_fini(dev);
 	bochs_unload(dev);
 err_free_dev:
 	drm_dev_put(dev);
-- 
2.25.0

