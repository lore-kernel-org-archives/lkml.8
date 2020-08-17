Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B9FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C379C204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuSPMPYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgHQPGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbgHQPGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:06:51 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF6AC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:06:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id qc22so18139621ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BwT5QgC9r7+fbBsN1p9RbcOBuPQLftk2G1gYkJO//ag=;
        b=nuSPMPYc716kN06kN3iW8/tKYe3bxQJGFTFdMmLsGvs+aQQeH+IdbiD6O//kVg2tO/
         zsNCsUI+rRcuoHh2aAuLCj7QAWlXq1cEXTABrqJvpqAsyaSFBpOyAAQWZw55Tb24ElH5
         pSlU0k7ld6nlksBDA4IxoUHk832J5t/MHUPWZAyXr4S8aJ3fdDubunZeZH8SXBaHqXXd
         Qn9IzukbrEYDCaGc9F5Z29pPMO+VN5fdUF/4IasPx1qJjchfZe44ACz3RZsAdRMqbPCC
         Ri0/gOIFn9EeoZSZP1pQvAosHCphLdDgbp36k4w5gVTjxJLu/ZpYPjjZMh/wH/r1HZrY
         4J9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BwT5QgC9r7+fbBsN1p9RbcOBuPQLftk2G1gYkJO//ag=;
        b=BuXBqgvhUqWMrT8lJFw094WHGwcx8WCw7bRyxLtr6x39qmuWJwokehmvcohIHysOys
         iLdlhBM28EN1hrqaG1pTZ9Z3P3bmutn/HUtjEYTj3nvaFJckw90ziCFIs79ERGfcpEoE
         RnBtdKbHQNC77sstNNeLGP93PygaPEHpnXNW4ooJDBKUC47L1JJlV9Zk37W5cjzUi1Hg
         m7SZtj64b25rbrF2q9lUl+zCWfeZdnyHbGBZaGiK3zt/dSalltrsqcFiLqN5ncxzKWTu
         mSTVHLpv105zYImPBFXRseD9Hop9Wq90NEA6OlrJsGZr+XzVJnyVIhl+H9zelwiolh2S
         XXMQ==
X-Gm-Message-State: AOAM533KWp3zoPyKlh8LINV9fry/EGlLvOvRWlUMknNCXC5njFAZKnUp
        m7tdeNTc75uSkwB+C1qVKiXtlJD3GAk=
X-Google-Smtp-Source: ABdhPJzxN4CgCYZJ5MKyFThgGxjsHt3JNBDnDhPawXRhhC9EPyXGVByS8bi5CWPEchQFwk5DzFV2ZQ==
X-Received: by 2002:a17:906:180b:: with SMTP id v11mr16286346eje.427.1597676809998;
        Mon, 17 Aug 2020 08:06:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:598:b884:fa67:1d41:83f0:a723:a7e3])
        by smtp.gmail.com with ESMTPSA id m6sm14424952ejq.85.2020.08.17.08.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 08:06:49 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Bean Huo <beanhuo@micron.com>
Subject: [PATCH] mm: change prev_offset type to unsigned long
Date:   Mon, 17 Aug 2020 17:06:37 +0200
Message-Id: <20200817150637.4244-1-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index cf4bdf7803b6..d736c7a4b826 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2025,7 +2025,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	pgoff_t last_index;
 	pgoff_t prev_index;
 	unsigned long offset;      /* offset into pagecache page */
-	unsigned int prev_offset;
+	unsigned long prev_offset;
 	int error = 0;
 
 	if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
-- 
2.17.1

