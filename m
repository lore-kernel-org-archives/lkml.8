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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64438C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C592078D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSjipeYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHQIKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgHQIK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:10:28 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581B5C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a79so7843486pfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pdIJjny9D2jgWVeCI9nYJimGzTera5WNgADtbJ8YXDE=;
        b=XSjipeYZMmDA8zRg8x2SsXfp2Jhr+d0PlIDgkWlY2tO9bFDJdnAQ40Ua0gtXG/g9kc
         QHtzYoiLq1/e8E0xhNkuMtoXw+U4ScBKf7Ym2DN5ftUBThFR/RUJKEuWfc1UjegEIHti
         xF+YmcEboQ6vcnthDllRioUfqz0S7QriDkfmROrrMpdZ6fG91nbW4RO71lXZz61xrWIV
         L60f1ctUGqRyzK/sWnccUABOBpaXcHAsLACBo7ClFY7s1QvA0a3fZQl0Omr9Gy7kUPYd
         4v4+uyxRfPRQMKqpt6oWXNzjLuE4nvp9dixEgispq5w+1/GnNOuPltS95VTjbJY+HusW
         5OBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pdIJjny9D2jgWVeCI9nYJimGzTera5WNgADtbJ8YXDE=;
        b=SbFjQbs2ibWo97hjKeai+ZsRcmubnzN7+oexmHH0fz/2ev1R5/XWJRENmY0wlfFXjG
         ygVJRvfJsMegin/ZRkpBd4POCe7g/1f2k6vA66omg6vFZXRrIU5PIcx4RqCeU3U2A/h5
         7Ei4kT5HsHG5exqVUUpXvr0nzIB6j5pTlreOMeyv9uzK9W/Y2sDCOWDkcFnSCbUDL1gK
         flTSHNAM79+JDdT06lChuWW+ejL8wC6u2dGHjsN17oqMfq4nkjByVGOuaCSxm19MrQRC
         Rz1BSIv+MPIFsCT4HQr1tkKy5IRHpX4O8i8DCcH3AQZ0FjPenQBMIVExt5pvITM5TtRz
         3V+A==
X-Gm-Message-State: AOAM532Ij5HBx6fKAK9Mk4vmgZinz8yzBWXNJC3l16xEnOFI5uH8wt0x
        fn1lqqMh/AljROPIDxya4I8=
X-Google-Smtp-Source: ABdhPJz1Mv7cb88mTt7H3O/EWktxl+4V8q9iZeglkGY6CWFYaPHnaSAelMpVwSczFKAaMF8dD298GQ==
X-Received: by 2002:a62:f904:: with SMTP id o4mr10820050pfh.14.1597651827314;
        Mon, 17 Aug 2020 01:10:27 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:10:26 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, heiko@sntech.de,
        matthias.bgg@gmail.com
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        inux-mediatek@lists.infradead.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 05/19] crypto: cavium: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:39:27 +0530
Message-Id: <20200817080941.19227-6-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817080941.19227-1-allen.lkml@gmail.com>
References: <20200817080941.19227-1-allen.lkml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/crypto/cavium/cpt/cptvf_main.c       |  9 ++++-----
 drivers/crypto/cavium/nitrox/nitrox_common.h |  2 +-
 drivers/crypto/cavium/nitrox/nitrox_isr.c    | 13 +++++--------
 drivers/crypto/cavium/nitrox/nitrox_reqmgr.c |  4 ++--
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/cavium/cpt/cptvf_main.c b/drivers/crypto/cavium/cpt/cptvf_main.c
index a15245992cf9..485105ee3178 100644
--- a/drivers/crypto/cavium/cpt/cptvf_main.c
+++ b/drivers/crypto/cavium/cpt/cptvf_main.c
@@ -21,10 +21,10 @@ struct cptvf_wqe_info {
 	struct cptvf_wqe vq_wqe[CPT_NUM_QS_PER_VF];
 };
 
-static void vq_work_handler(unsigned long data)
+static void vq_work_handler(struct tasklet_struct *t)
 {
-	struct cptvf_wqe_info *cwqe_info = (struct cptvf_wqe_info *)data;
-	struct cptvf_wqe *cwqe = &cwqe_info->vq_wqe[0];
+	struct cptvf_wqe *cwqe = from_tasklet(cwqe, t, twork);
+	struct cptvf_wqe_info *cwqe_info = container_of(cwqe, typeof(*cwqe_info), vq_wqe[0]);
 
 	vq_post_process(cwqe->cptvf, cwqe->qno);
 }
@@ -45,8 +45,7 @@ static int init_worker_threads(struct cpt_vf *cptvf)
 	}
 
 	for (i = 0; i < cptvf->nr_queues; i++) {
-		tasklet_init(&cwqe_info->vq_wqe[i].twork, vq_work_handler,
-			     (u64)cwqe_info);
+		tasklet_setup(&cwqe_info->vq_wqe[i].twork, vq_work_handler);
 		cwqe_info->vq_wqe[i].qno = i;
 		cwqe_info->vq_wqe[i].cptvf = cptvf;
 	}
diff --git a/drivers/crypto/cavium/nitrox/nitrox_common.h b/drivers/crypto/cavium/nitrox/nitrox_common.h
index e4be69d7e6e5..f73ae8735272 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_common.h
+++ b/drivers/crypto/cavium/nitrox/nitrox_common.h
@@ -19,7 +19,7 @@ void nitrox_put_device(struct nitrox_device *ndev);
 int nitrox_common_sw_init(struct nitrox_device *ndev);
 void nitrox_common_sw_cleanup(struct nitrox_device *ndev);
 
-void pkt_slc_resp_tasklet(unsigned long data);
+void pkt_slc_resp_tasklet(struct tasklet_struct *t);
 int nitrox_process_se_request(struct nitrox_device *ndev,
 			      struct se_crypto_request *req,
 			      completion_t cb,
diff --git a/drivers/crypto/cavium/nitrox/nitrox_isr.c b/drivers/crypto/cavium/nitrox/nitrox_isr.c
index 3dec570a190a..cc6b7c78e070 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_isr.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_isr.c
@@ -200,9 +200,9 @@ static void clear_bmi_err_intr(struct nitrox_device *ndev)
 	dev_err_ratelimited(DEV(ndev), "BMI_INT  0x%016llx\n", value);
 }
 
-static void nps_core_int_tasklet(unsigned long data)
+static void nps_core_int_tasklet(struct tasklet_struct *t)
 {
-	struct nitrox_q_vector *qvec = (void *)(uintptr_t)(data);
+	struct nitrox_q_vector *qvec = from_tasklet(qvec, t, resp_tasklet);
 	struct nitrox_device *ndev = qvec->ndev;
 
 	/* if pf mode do queue recovery */
@@ -342,8 +342,7 @@ int nitrox_register_interrupts(struct nitrox_device *ndev)
 		cpu = qvec->ring % num_online_cpus();
 		irq_set_affinity_hint(vec, get_cpu_mask(cpu));
 
-		tasklet_init(&qvec->resp_tasklet, pkt_slc_resp_tasklet,
-			     (unsigned long)qvec);
+		tasklet_setup(&qvec->resp_tasklet, pkt_slc_resp_tasklet);
 		qvec->valid = true;
 	}
 
@@ -363,8 +362,7 @@ int nitrox_register_interrupts(struct nitrox_device *ndev)
 	cpu = num_online_cpus();
 	irq_set_affinity_hint(vec, get_cpu_mask(cpu));
 
-	tasklet_init(&qvec->resp_tasklet, nps_core_int_tasklet,
-		     (unsigned long)qvec);
+	tasklet_setup(&qvec->resp_tasklet, nps_core_int_tasklet);
 	qvec->valid = true;
 
 	return 0;
@@ -441,8 +439,7 @@ int nitrox_sriov_register_interupts(struct nitrox_device *ndev)
 	cpu = num_online_cpus();
 	irq_set_affinity_hint(vec, get_cpu_mask(cpu));
 
-	tasklet_init(&qvec->resp_tasklet, nps_core_int_tasklet,
-		     (unsigned long)qvec);
+	tasklet_setup(&qvec->resp_tasklet, nps_core_int_tasklet);
 	qvec->valid = true;
 
 	return 0;
diff --git a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
index 5826c2c98a50..1c113be87ada 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
@@ -579,9 +579,9 @@ static void process_response_list(struct nitrox_cmdq *cmdq)
 /**
  * pkt_slc_resp_tasklet - post processing of SE responses
  */
-void pkt_slc_resp_tasklet(unsigned long data)
+void pkt_slc_resp_tasklet(struct tasklet_struct *t)
 {
-	struct nitrox_q_vector *qvec = (void *)(uintptr_t)(data);
+	struct nitrox_q_vector *qvec = from_tasklet(qvec, t, resp_tasklet);
 	struct nitrox_cmdq *cmdq = qvec->cmdq;
 	union nps_pkt_slc_cnts slc_cnts;
 
-- 
2.17.1

