Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E943C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AAB8207BB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqlI+0Ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgGUQmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbgGUQmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:42:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C353C0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so21825913wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CO8ltPArAPUdBjw6bWGQZLeu5Bx+TgrPvU6n01tz240=;
        b=IqlI+0Ot+ZGos0Pp8ZRMuoIUJu6pSsr8FMdpqo50jn/q3zZpH7TZ6Vq+f5Pxhyi9GN
         UnXYs2QsSxbWFJ/eRfnrT9q8pyIGLN0A3mgDmdPPOh51XJW3lHaRcRFkzmQcwndgaoy0
         oPFlQ28ri2qn9nTPKm+2VWQCD1J4eNRYNHGSq+w2ADI9EhjGFLha2ywEIgfGk5zFL8vY
         CEKzLsSWACDvw2Ts+CE7im8G+WTi6EP4MzKdWU2+HnxjlxJw+4IQ+vr11RhXfmYF27dN
         NRpW1mpVFQvei+y9GrufbPbuXHmDFoTzkJk/5L8w9jbG3a1fAwxynu2sk4UtDsEf1MjN
         MuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CO8ltPArAPUdBjw6bWGQZLeu5Bx+TgrPvU6n01tz240=;
        b=jnQS6U9ChCjqDKsElg1O6Kf2mrIPeURCf940shL/QW0K7YkulRYXctIW4Z1QGP2Bob
         jOYrJ7yquq/e1dbA+2dFXsTJ9fqqECEF9OCRyR6IZHkkzdSC1vI2A80XCSXhksvkPUWt
         i4fcp0SBPm2jIjWStqndxQVwoPkYzxMS0L0WT8gZB2LmHQ12NwqCcuVu3jeNH5jgh6Hr
         H842Zv13k0DnyvUMnhRFlWppGxLaiHWtQ+jYRLYisaZKdY5QpjufcxqSDZHBvb3YTYFG
         FVCbmv2cpyYLnH2wFJkmnkaki6z+TbW0R8ff4KZkiABWbA1SBa9plNuu1tWhX9WsCMwu
         wt4w==
X-Gm-Message-State: AOAM533nI/PCdzOqc6YiJPisuI2JGBKOkRfFX4dgl0/fNgGItOHQVeOy
        pSPLYd37wpKe//D1WYPNIu/ibg==
X-Google-Smtp-Source: ABdhPJwNVbDAYojp2CjDF+i1OzxbUBejGrOQEVglMRAPBlKuVKe0LZXQjaN8lWErukT81SQphXvdzw==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr26816377wro.406.1595349767955;
        Tue, 21 Jul 2020 09:42:47 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id m4sm3933524wmi.48.2020.07.21.09.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:42:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 36/40] scsi: lpfc: lpfc_sli: Ensure variable has the same stipulations as code using it
Date:   Tue, 21 Jul 2020 17:41:44 +0100
Message-Id: <20200721164148.2617584-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200721164148.2617584-1-lee.jones@linaro.org>
References: <20200721164148.2617584-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'pg_addr' is only used when CONFIG_X86 is defined.  So only declare it
if CONFIG_X86 is defined.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/lpfc/lpfc_sli.c: In function ‘lpfc_wq_create’:
 drivers/scsi/lpfc/lpfc_sli.c:15813:16: warning: unused variable ‘pg_addr’ [-Wunused-variable]
 15813 | unsigned long pg_addr;
 | ^~~~~~~

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/lpfc/lpfc_sli.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index c44eed709d5fc..278ea0d74b4a8 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -15810,8 +15810,10 @@ lpfc_wq_create(struct lpfc_hba *phba, struct lpfc_queue *wq,
 	uint16_t pci_barset;
 	uint8_t dpp_barset;
 	uint32_t dpp_offset;
-	unsigned long pg_addr;
 	uint8_t wq_create_version;
+#ifdef CONFIG_X86
+	unsigned long pg_addr;
+#endif
 
 	/* sanity check on queue memory */
 	if (!wq || !cq)
-- 
2.25.1

