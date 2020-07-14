Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A70BC433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B4A21D90
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fx6MU4ki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgGNIdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNIdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:33:07 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADDAC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 01:33:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so4024755wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 01:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZ8sXgc4O5wGM0NeFKNvAvgtUFt05AlY27etdLwPk2Q=;
        b=fx6MU4kioiP6of1mQ5lTe4Cl3aouCNyDNnbyUmwK/RifMwXKHl9bs9si+sWPZzt5Sd
         3gqxr4buJJ5xI6DGT2EBPeA7/ftd8qJHdomouQvdc7LV2TeWvqLrv1tukJO84iC+9QP/
         tKNsEKjDUrg/A4DIQY8b8eQxOEBi1Fkf8YxifHrRP3IBACBYDJsLZDBLUwAQgyK6HwyR
         UR7g6xxbLICF6EZuMpsNRWknFs0shMHL87qOQEuybZRmwqGgBwUb+NTNMlKDsWqogt+m
         Pcbd539UYPRISXXO57GEWVMIvNdqZ++8MMwGFYA/xBiUsXBnQXmQ8cda87X33keO9282
         QAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZ8sXgc4O5wGM0NeFKNvAvgtUFt05AlY27etdLwPk2Q=;
        b=JDY0lJ7FPdWS3Qp0IQutAKegm5ca62+tDOQOMEwlUCT5NFNPdinIj/zqnvqVZkH/Qp
         SoEsI8RyhunT567QyN81rHOdNIXZrbLyT3aoD0fuVHM1yAdmARkNHAwBc38nGgkp3ITr
         63jxCLn62psx75EQF68PuiOcM+pEj4ojO0PiB4DV8MR4ZKKm+F+mAEuMX7ZlTSIfxaQG
         YF7A93KOonC7h413lUngQpi1vVDfvyQvweTS3qAcKru83kN1+bd7xCjCutC4Nbiac7dn
         vaFisAyFBlPYfjqD10+aVDEorg36QGeAOg8Em3UgE/n+i2BRmgEG7cM8rfijjWN9Dfsg
         CSHA==
X-Gm-Message-State: AOAM532fDJ1Hjwdokn3WzWUtEaGnMbg+fbEZGR3NUjkXAATO2jRGhh39
        8dQ0+hDyw8NjBKc3HVdS5Xs7xA==
X-Google-Smtp-Source: ABdhPJycHx3NV6xfOaylzcYOnFH7Ad981YfRgvOt73meNM8CdcaMXW/nM44A30Yt/V+OFsAxoNVvbA==
X-Received: by 2002:a1c:acc3:: with SMTP id v186mr3269476wme.79.1594715586356;
        Tue, 14 Jul 2020 01:33:06 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id u10sm3188209wml.29.2020.07.14.01.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:33:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        "Eurotech S.p.A" <info@eurotech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/1] misc: c2port: core: Make copying name from userspace more secure
Date:   Tue, 14 Jul 2020 09:32:59 +0100
Message-Id: <20200714083259.1313267-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the 'c2dev' device data is not zeroed when its allocated.
Coupled with the fact strncpy() *may not* provide a NUL terminator
means that a 1-byte leak would be possible *if* this was ever copied
to userspace.

To prevent such a failing, let's first ensure the 'c2dev' device data
area is fully zeroed out and ensure the buffer will always be NUL
terminated by using the kernel's strscpy() which a) uses the
destination (instead of the source) size as the bytes to copy and b)
is *always* NUL terminated.

Cc: Rodolfo Giometti <giometti@enneenne.com>
Cc: "Eurotech S.p.A" <info@eurotech.it>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/c2port/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
index 80d87e8a0bea9..0de538a1cc1c6 100644
--- a/drivers/misc/c2port/core.c
+++ b/drivers/misc/c2port/core.c
@@ -899,7 +899,7 @@ struct c2port_device *c2port_device_register(char *name,
 		unlikely(!ops->c2d_get) || unlikely(!ops->c2d_set))
 		return ERR_PTR(-EINVAL);
 
-	c2dev = kmalloc(sizeof(struct c2port_device), GFP_KERNEL);
+	c2dev = kzalloc(sizeof(struct c2port_device), GFP_KERNEL);
 	if (unlikely(!c2dev))
 		return ERR_PTR(-ENOMEM);
 
@@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
 	}
 	dev_set_drvdata(c2dev->dev, c2dev);
 
-	strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
+	strscpy(c2dev->name, name, sizeof(c2dev->name));
 	c2dev->ops = ops;
 	mutex_init(&c2dev->mutex);
 
-- 
2.25.1

