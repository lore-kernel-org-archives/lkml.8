Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE351C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4902072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9xRYkKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgGMIBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgGMIAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:00:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C87CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so12211057wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RfY0NWdcaY2EP3FmoORbq4kbjZDAFhNLFjss0f92Lio=;
        b=O9xRYkKfJFOUSu6r6sulvmymmV/K0Q48jvoehWofsopiMUzkbVLj/jQtjzkQQgZS4W
         I70gNWxE74qk5fb0fPDjkZiRMbH+BEVIDJRzoM0YWFiDNDhtVj8z7wjYR39SmFBntJDB
         RTyinMEu4DZIKP5iSiTLdZ9rjo4Eso4pEhONj+dwWQxLErHb07mWAXkSrJvgdArSei6l
         k6O7QW2vrRlDj5tAk1Akio7Uwmo5sqAhxtB2TBJ14pjmuT95LntdC4NtuPWjIqMkDZqq
         ZPl3ECDb+i6LP7rJqb8WZIgsjLwVfXMVKr222PEiC7UAnuoiVnlA3ILEjYxJVFFyh6oa
         Bc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RfY0NWdcaY2EP3FmoORbq4kbjZDAFhNLFjss0f92Lio=;
        b=bXC9w3gFtetrvipCCdWIFWn+UpGjodlCt7m3UN+kqSX3bu6dH8C51eK/5h2sDwU9+V
         f/bs51MbmgqF4PLQ40kXfTwSCPj98shOwUcfTaSyB1wFfyoUFW5GQLiX09iXgBhuIuF5
         8jUAuDiltjT7Ya3mbs1doN9mgvey8w6E10bTaO17Sm3AmJamCb4NaY7GcRJzKgxQcamy
         hgWcRLEZYtdhzNMEEXv/fz+Upnj/qTBXBHFSzJGCK22+B12iEJCX18TAPpic2XT+jAWa
         35i98LAw3iCZVbkZcUPUtYM6cDhf+31PlRuDvq+bMSto26itFAZckhSOaS7Mfpbe3XuE
         87eQ==
X-Gm-Message-State: AOAM532INTo8p7as9eomC4PD7W8uW/A+Sq1IakhY587iVoCaAx6N98Gh
        pq0xAsQK1p3hUpos/Y9tYBnSUA==
X-Google-Smtp-Source: ABdhPJxXd85K+swID9T4RkK43CBRG3ojcaY5XxDJZVBFei+PqLdZeUuO9fArANTpD3xoZn2O+8MnIA==
X-Received: by 2002:a1c:5418:: with SMTP id i24mr17024203wmb.47.1594627214244;
        Mon, 13 Jul 2020 01:00:14 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id 33sm24383549wri.16.2020.07.13.01.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 01:00:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Luben Tuikov <luben_tuikov@adaptec.com>
Subject: [PATCH v2 06/24] scsi: aic94xx: aic94xx_seq: Document 'lseq' and repair asd_update_port_links() header
Date:   Mon, 13 Jul 2020 08:59:43 +0100
Message-Id: <20200713080001.128044-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713080001.128044-1-lee.jones@linaro.org>
References: <20200713080001.128044-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/aic94xx/aic94xx_seq.c:587: warning: Function parameter or member 'lseq' not described in 'asd_init_lseq_mip'
 drivers/scsi/aic94xx/aic94xx_seq.c:674: warning: Function parameter or member 'lseq' not described in 'asd_init_lseq_mdp'
 drivers/scsi/aic94xx/aic94xx_seq.c:958: warning: Function parameter or member 'lseq' not described in 'asd_init_lseq_cio'
 drivers/scsi/aic94xx/aic94xx_seq.c:1364: warning: Function parameter or member 'asd_ha' not described in 'asd_update_port_links'
 drivers/scsi/aic94xx/aic94xx_seq.c:1364: warning: Function parameter or member 'phy' not described in 'asd_update_port_links'
 drivers/scsi/aic94xx/aic94xx_seq.c:1364: warning: Excess function parameter 'sas_phy' description in 'asd_update_port_links'

Cc: Luben Tuikov <luben_tuikov@adaptec.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/aic94xx/aic94xx_seq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_seq.c b/drivers/scsi/aic94xx/aic94xx_seq.c
index 11853ec29d87a..c0f685c86851b 100644
--- a/drivers/scsi/aic94xx/aic94xx_seq.c
+++ b/drivers/scsi/aic94xx/aic94xx_seq.c
@@ -582,6 +582,7 @@ static void asd_init_cseq_scratch(struct asd_ha_struct *asd_ha)
 /**
  * asd_init_lseq_mip -- initialize LSEQ Mode independent pages 0-3
  * @asd_ha: pointer to host adapter structure
+ * @lseq:  link sequencer
  */
 static void asd_init_lseq_mip(struct asd_ha_struct *asd_ha, u8 lseq)
 {
@@ -669,6 +670,7 @@ static void asd_init_lseq_mip(struct asd_ha_struct *asd_ha, u8 lseq)
 /**
  * asd_init_lseq_mdp -- initialize LSEQ mode dependent pages.
  * @asd_ha: pointer to host adapter structure
+ * @lseq:  link sequencer
  */
 static void asd_init_lseq_mdp(struct asd_ha_struct *asd_ha,  int lseq)
 {
@@ -953,6 +955,7 @@ static void asd_init_cseq_cio(struct asd_ha_struct *asd_ha)
 /**
  * asd_init_lseq_cio -- initialize LmSEQ CIO registers
  * @asd_ha: pointer to host adapter structure
+ * @lseq:  link sequencer
  */
 static void asd_init_lseq_cio(struct asd_ha_struct *asd_ha, int lseq)
 {
@@ -1345,7 +1348,8 @@ int asd_start_seqs(struct asd_ha_struct *asd_ha)
 
 /**
  * asd_update_port_links -- update port_map_by_links and phy_is_up
- * @sas_phy: pointer to the phy which has been added to a port
+ * @asd_ha: pointer to host adapter structure
+ * @phy: pointer to the phy which has been added to a port
  *
  * 1) When a link reset has completed and we got BYTES DMAED with a
  * valid frame we call this function for that phy, to indicate that
-- 
2.25.1

