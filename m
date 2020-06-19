Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8C5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CE6206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="USraJ6uJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395498AbgFSQl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395364AbgFSQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:41:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A91EC0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:41:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b82so9014840wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZ1Uio63dmuNEhXDmZNkCOwutdIAFTQ3JpFVR/jATEY=;
        b=USraJ6uJJgOpaLyV7LTp629t+SEaklFWFsblSKoee94xsdrhI9qxgiKZaAMnVchQ+1
         la/vALehhsahnS4p1ASeyOzn1SzuKTuAO+itiuLu0Yz4lWPqyFC8shNylvWRLKAIZ7AF
         wQsuvc9HKPp+wtDXmh+XdSEPkSz+MabCse+mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZ1Uio63dmuNEhXDmZNkCOwutdIAFTQ3JpFVR/jATEY=;
        b=c8ZTQA9YDFOR9spUwnLZzG6/GxbX7amTstGBag2ZEXQFkMt0jCAkt/vEgVic0l/jYH
         yxAqW6qvXf7CAIo1/aGcdQhdLvaktBC3C0CPc+1Y6Ak91WZSujmPh8G2qr2LSu1NN2qH
         ei/5+xEDe+GF6BZUX4zGyoINxMmpYyjslgenxgiIdtHuX1+8R+lN49v3fzKVZnn6/pBP
         ttHn3nmNOVB99XvnyIcJTtLzHLyxZgNhPHbSqZflfqqKIgeblxiGki1TshbAvBTe47UQ
         h1nmAOFe27y4hGmeJZIRihGwRMt/RoPHln5ZGnYRFErlkm+dcW4Rb4VNBBSA4ikF2LW3
         3Bng==
X-Gm-Message-State: AOAM530M3pKDNVP59yT+JRO0xrgNui0qn1vu0t6GZGzHiQwx4JGvvneq
        LbG8PtJGakW/kFsFH/uQk0YW0g==
X-Google-Smtp-Source: ABdhPJwNIN4u822IVaJlHewCqFRluApyx6KfWP+jRlqlnOMB4gXpoDBtiWzMavMuYgAQXAIV9fEX2g==
X-Received: by 2002:a1c:9d09:: with SMTP id g9mr4496560wme.31.1592584912929;
        Fri, 19 Jun 2020 09:41:52 -0700 (PDT)
Received: from localhost.localdomain (88-144-169-85.host.pobb.as13285.net. [88.144.169.85])
        by smtp.gmail.com with ESMTPSA id j4sm7521901wma.7.2020.06.19.09.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:41:52 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        dm-crypt@saout.de, linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [RFC PATCH 1/1] Add DM_CRYPT_FORCE_INLINE flag to dm-crypt target
Date:   Fri, 19 Jun 2020 17:41:32 +0100
Message-Id: <20200619164132.1648-2-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200619164132.1648-1-ignat@cloudflare.com>
References: <20200619164132.1648-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes extra thread offloading imposed by dm-crypt hurts IO latency. This is
especially visible on busy systems with many processes/threads. Moreover, most
Crypto API implementaions are async, that is they offload crypto operations on
their own, so this dm-crypt offloading is excessive.

This adds a new flag, which directs dm-crypt not to offload crypto operations
and process everything inline. For cases, where crypto operations cannot happen
inline (hard interrupt context, for example the read path of the NVME driver),
we offload the work to a tasklet rather than a workqueue.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 drivers/md/dm-crypt.c | 55 +++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 000ddfab5ba0..5a9bac4fdffb 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -69,6 +69,7 @@ struct dm_crypt_io {
 	u8 *integrity_metadata;
 	bool integrity_metadata_from_pool;
 	struct work_struct work;
+	struct tasklet_struct tasklet;
 
 	struct convert_context ctx;
 
@@ -127,7 +128,7 @@ struct iv_elephant_private {
  * and encrypts / decrypts at the same time.
  */
 enum flags { DM_CRYPT_SUSPENDED, DM_CRYPT_KEY_VALID,
-	     DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD };
+	     DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD, DM_CRYPT_FORCE_INLINE = (sizeof(unsigned long) * 8 - 1) };
 
 enum cipher_flags {
 	CRYPT_MODE_INTEGRITY_AEAD,	/* Use authenticated mode for cihper */
@@ -1458,13 +1459,18 @@ static void crypt_alloc_req_skcipher(struct crypt_config *cc,
 
 	skcipher_request_set_tfm(ctx->r.req, cc->cipher_tfm.tfms[key_index]);
 
-	/*
-	 * Use REQ_MAY_BACKLOG so a cipher driver internally backlogs
-	 * requests if driver request queue is full.
-	 */
-	skcipher_request_set_callback(ctx->r.req,
-	    CRYPTO_TFM_REQ_MAY_BACKLOG,
-	    kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));
+	if (test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags))
+		/* make sure we zero important fields of the request */
+		skcipher_request_set_callback(ctx->r.req,
+	        0, NULL, NULL);
+	else
+		/*
+		 * Use REQ_MAY_BACKLOG so a cipher driver internally backlogs
+		 * requests if driver request queue is full.
+		 */
+		skcipher_request_set_callback(ctx->r.req,
+	        CRYPTO_TFM_REQ_MAY_BACKLOG,
+	        kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));
 }
 
 static void crypt_alloc_req_aead(struct crypt_config *cc,
@@ -1566,7 +1572,8 @@ static blk_status_t crypt_convert(struct crypt_config *cc,
 			atomic_dec(&ctx->cc_pending);
 			ctx->cc_sector += sector_step;
 			tag_offset++;
-			cond_resched();
+			if (!test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags))
+				cond_resched();
 			continue;
 		/*
 		 * There was a data integrity error.
@@ -1892,6 +1899,11 @@ static void kcryptd_crypt_write_io_submit(struct dm_crypt_io *io, int async)
 
 	clone->bi_iter.bi_sector = cc->start + io->sector;
 
+	if (test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags)) {
+		generic_make_request(clone);
+		return;
+	}
+
 	if (likely(!async) && test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags)) {
 		generic_make_request(clone);
 		return;
@@ -2031,12 +2043,26 @@ static void kcryptd_crypt(struct work_struct *work)
 		kcryptd_crypt_write_convert(io);
 }
 
+static void kcryptd_crypt_tasklet(unsigned long work)
+{
+	kcryptd_crypt((struct work_struct *)work);
+}
+
 static void kcryptd_queue_crypt(struct dm_crypt_io *io)
 {
 	struct crypt_config *cc = io->cc;
 
-	INIT_WORK(&io->work, kcryptd_crypt);
-	queue_work(cc->crypt_queue, &io->work);
+	if (test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags)) {
+		if (in_irq()) {
+			/* Crypto API will fail hard in hard IRQ context */
+			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
+			tasklet_schedule(&io->tasklet);
+		} else
+			kcryptd_crypt(&io->work);
+	} else {
+		INIT_WORK(&io->work, kcryptd_crypt);
+		queue_work(cc->crypt_queue, &io->work);
+	}
 }
 
 static void crypt_free_tfms_aead(struct crypt_config *cc)
@@ -2838,7 +2864,7 @@ static int crypt_ctr_optional(struct dm_target *ti, unsigned int argc, char **ar
 	struct crypt_config *cc = ti->private;
 	struct dm_arg_set as;
 	static const struct dm_arg _args[] = {
-		{0, 6, "Invalid number of feature args"},
+		{0, 7, "Invalid number of feature args"},
 	};
 	unsigned int opt_params, val;
 	const char *opt_string, *sval;
@@ -2868,6 +2894,8 @@ static int crypt_ctr_optional(struct dm_target *ti, unsigned int argc, char **ar
 
 		else if (!strcasecmp(opt_string, "submit_from_crypt_cpus"))
 			set_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags);
+		else if (!strcasecmp(opt_string, "force_inline"))
+			set_bit(DM_CRYPT_FORCE_INLINE, &cc->flags);
 		else if (sscanf(opt_string, "integrity:%u:", &val) == 1) {
 			if (val == 0 || val > MAX_TAG_SIZE) {
 				ti->error = "Invalid integrity arguments";
@@ -3196,6 +3224,7 @@ static void crypt_status(struct dm_target *ti, status_type_t type,
 		num_feature_args += !!ti->num_discard_bios;
 		num_feature_args += test_bit(DM_CRYPT_SAME_CPU, &cc->flags);
 		num_feature_args += test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags);
+		num_feature_args += test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags);
 		num_feature_args += cc->sector_size != (1 << SECTOR_SHIFT);
 		num_feature_args += test_bit(CRYPT_IV_LARGE_SECTORS, &cc->cipher_flags);
 		if (cc->on_disk_tag_size)
@@ -3208,6 +3237,8 @@ static void crypt_status(struct dm_target *ti, status_type_t type,
 				DMEMIT(" same_cpu_crypt");
 			if (test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags))
 				DMEMIT(" submit_from_crypt_cpus");
+			if (test_bit(DM_CRYPT_FORCE_INLINE, &cc->flags))
+				DMEMIT(" force_inline");
 			if (cc->on_disk_tag_size)
 				DMEMIT(" integrity:%u:%s", cc->on_disk_tag_size, cc->cipher_auth);
 			if (cc->sector_size != (1 << SECTOR_SHIFT))
-- 
2.20.1

