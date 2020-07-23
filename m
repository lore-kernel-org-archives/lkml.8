Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2EFC433F8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE26206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7iTBu6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgGWM0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbgGWMZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:25:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E895C0619E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so4955570wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EocuI/v8dMGAgziexe3ETAgpgON59vWZbZOU+TdWcao=;
        b=S7iTBu6TIjSJT9lhyIg+YJr8IZo3qTqoKB4l1HwFH6Yxl5aaRRU4n+oBwQu130P2Ks
         sq2howsZNiIYBIUOPdPJjji/uqA574RfrXiW+g3GQgpongvY0tmmZ5j9GDJO5IP8N0sf
         aI+l6KjfNk3Yp+P6QIMHWINQKS94OLgynWUI4uLFXCwoovOEmUs+kLgPBMENG4jxPOQ2
         3CMxtks+EOf+T7KV/anCeQJt+/p4LoiNftuqImi2Ua9LeFcD+rx96t2pCu5DOlD1Lkeg
         WuUvgX3aTE+a2OETnGp4WsXka1VhtlCAK8zisNcSsoNizljQjq4qG9Jp8RYPPBb2rn5a
         oX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EocuI/v8dMGAgziexe3ETAgpgON59vWZbZOU+TdWcao=;
        b=CXHiWQMxJK08JUiLoQfeZO1fywjtKf4uRy7OYXOWYNr9qbRdUCkNFxvTf9X4kzUbNK
         MG0ikoa1wZPStCWNMvv4PNBPpKIzew5SLp08LNE7YjTfFRv3oT6CEc0adTQpVjCgP89z
         hJd6iLWGTxND9cCZHawxjEiJh4CS9IfpeBR2fU3XUCpr6zlFlOVuAf1Kd2bddwaqt5by
         ZiB5VIFOb2PbQUIAP9MdNx8TzjiLDlxSOHtoyIwDXhfw+4oLEj2hGfRWlfm963DyML1A
         Y04nf8jJ46wkWhZikaEeXOtX3Qa70HIF2kHa5mt1wcYF2gsSj/D6BtEW8mI+IcGYodP7
         FZHQ==
X-Gm-Message-State: AOAM5324b5FImvgm1sTyWSgRssb3MvnPnZdV1HgihivuYtcBBfrulxks
        Z5xHwp7lxXkVwfjNIhcbvxsDYw==
X-Google-Smtp-Source: ABdhPJyJvzXQnTwZ1RNq92ZfHV+XpgztidF3x8njT7epkUJHrqMDSd6v6B+D1Xc4vP1zy5QOwPXs6w==
X-Received: by 2002:adf:c401:: with SMTP id v1mr3678093wrf.379.1595507107890;
        Thu, 23 Jul 2020 05:25:07 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j5sm3510651wma.45.2020.07.23.05.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:25:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 15/40] scsi: lpfc: lpfc_init: Use __printf() format notation
Date:   Thu, 23 Jul 2020 13:24:21 +0100
Message-Id: <20200723122446.1329773-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723122446.1329773-1-lee.jones@linaro.org>
References: <20200723122446.1329773-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/lpfc/lpfc_init.c: In function ‘lpfc_dbg_print’:
 drivers/scsi/lpfc/lpfc_init.c:14212:6: warning: function ‘lpfc_dbg_print’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
 14212 | sizeof(phba->dbg_log[idx].log), fmt, args);
 | ^~~~~~

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/lpfc/lpfc_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 20edf001fdd97..ccfae1c0c0963 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -14187,6 +14187,7 @@ void lpfc_dmp_dbg(struct lpfc_hba *phba)
 	atomic_set(&phba->dbg_log_dmping, 0);
 }
 
+__printf(2, 3)
 void lpfc_dbg_print(struct lpfc_hba *phba, const char *fmt, ...)
 {
 	unsigned int idx;
-- 
2.25.1

