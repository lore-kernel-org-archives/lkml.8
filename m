Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D801DC33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 12:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1EB24698
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 12:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgARMtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 07:49:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728803AbgARMtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 07:49:36 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00ICb2Nt066923
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 07:49:35 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xkydam3jg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 07:49:35 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Sat, 18 Jan 2020 12:49:33 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 18 Jan 2020 12:49:31 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00ICmeUQ44499410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jan 2020 12:48:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8996F52050;
        Sat, 18 Jan 2020 12:49:29 +0000 (GMT)
Received: from localhost (unknown [9.145.67.188])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 2BE965204F;
        Sat, 18 Jan 2020 12:49:29 +0000 (GMT)
Date:   Sat, 18 Jan 2020 13:49:27 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.5-rc7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
x-cbid: 20011812-0016-0000-0000-000002DE89CD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011812-0017-0000-0000-00003341290F
Message-Id: <your-ad-here.call-01579351767-ext-7089@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-18_03:2020-01-16,2020-01-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=7 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001180102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.5-rc7.

Thank you,
Vasily

The following changes since commit c79f46a282390e0f5b306007bf7b11a46d529538:

  Linux 5.5-rc5 (2020-01-05 14:23:27 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.5-5

for you to fetch changes up to 40260b01d029ba374637838213af500e03305326:

  s390/setup: Fix secure ipl message (2020-01-09 16:59:18 +0100)

----------------------------------------------------------------
s390 updates for 5.5-rc7

- Fix printing misleading Secure-IPL enabled message when it is not.

- Fix a race condition between host ap bus and guest ap bus doing
  device reset in crypto code.

- Fix sanity check in CCA cipher key function (CCA AES cipher key
  support), which fails otherwise.

----------------------------------------------------------------
Harald Freudenberger (2):
      s390/zcrypt: Fix CCA cipher key gen with clear key value function
      s390/zcrypt: move ap device reset from bus to driver code

Philipp Rudo (1):
      s390/setup: Fix secure ipl message

 arch/s390/kernel/setup.c             | 2 +-
 drivers/s390/crypto/ap_bus.c         | 2 --
 drivers/s390/crypto/ap_bus.h         | 2 +-
 drivers/s390/crypto/ap_queue.c       | 5 +++--
 drivers/s390/crypto/zcrypt_ccamisc.c | 4 ++--
 drivers/s390/crypto/zcrypt_cex2a.c   | 1 +
 drivers/s390/crypto/zcrypt_cex2c.c   | 2 ++
 drivers/s390/crypto/zcrypt_cex4.c    | 1 +
 8 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 9cbf490fd162..d5fbd754f41a 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -1052,7 +1052,7 @@ static void __init log_component_list(void)
 
 	if (!early_ipl_comp_list_addr)
 		return;
-	if (ipl_block.hdr.flags & IPL_PL_FLAG_IPLSR)
+	if (ipl_block.hdr.flags & IPL_PL_FLAG_SIPL)
 		pr_info("Linux is running with Secure-IPL enabled\n");
 	else
 		pr_info("Linux is running with Secure-IPL disabled\n");
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index a1915061932e..5256e3ce84e5 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -793,8 +793,6 @@ static int ap_device_probe(struct device *dev)
 		drvres = ap_drv->flags & AP_DRIVER_FLAG_DEFAULT;
 		if (!!devres != !!drvres)
 			return -ENODEV;
-		/* (re-)init queue's state machine */
-		ap_queue_reinit_state(to_ap_queue(dev));
 	}
 
 	/* Add queue/card to list of active queues/cards */
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 433b7b64368d..bb35ba4a8d24 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -261,7 +261,7 @@ void ap_queue_prepare_remove(struct ap_queue *aq);
 void ap_queue_remove(struct ap_queue *aq);
 void ap_queue_suspend(struct ap_device *ap_dev);
 void ap_queue_resume(struct ap_device *ap_dev);
-void ap_queue_reinit_state(struct ap_queue *aq);
+void ap_queue_init_state(struct ap_queue *aq);
 
 struct ap_card *ap_card_create(int id, int queue_depth, int raw_device_type,
 			       int comp_device_type, unsigned int functions);
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index dad2be333d82..37c3bdc3642d 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -638,7 +638,7 @@ struct ap_queue *ap_queue_create(ap_qid_t qid, int device_type)
 	aq->ap_dev.device.type = &ap_queue_type;
 	aq->ap_dev.device_type = device_type;
 	aq->qid = qid;
-	aq->state = AP_STATE_RESET_START;
+	aq->state = AP_STATE_UNBOUND;
 	aq->interrupt = AP_INTR_DISABLED;
 	spin_lock_init(&aq->lock);
 	INIT_LIST_HEAD(&aq->list);
@@ -771,10 +771,11 @@ void ap_queue_remove(struct ap_queue *aq)
 	spin_unlock_bh(&aq->lock);
 }
 
-void ap_queue_reinit_state(struct ap_queue *aq)
+void ap_queue_init_state(struct ap_queue *aq)
 {
 	spin_lock_bh(&aq->lock);
 	aq->state = AP_STATE_RESET_START;
 	ap_wait(ap_sm_event(aq, AP_EVENT_POLL));
 	spin_unlock_bh(&aq->lock);
 }
+EXPORT_SYMBOL(ap_queue_init_state);
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index c1db64a2db21..110fe9d0cb91 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1037,8 +1037,8 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	prepparm = (struct iprepparm *) prepcblk->rpl_parmb;
 
 	/* do some plausibility checks on the key block */
-	if (prepparm->kb.len < 120 + 5 * sizeof(uint16_t) ||
-	    prepparm->kb.len > 136 + 5 * sizeof(uint16_t)) {
+	if (prepparm->kb.len < 120 + 3 * sizeof(uint16_t) ||
+	    prepparm->kb.len > 136 + 3 * sizeof(uint16_t)) {
 		DEBUG_ERR("%s reply with invalid or unknown key block\n",
 			  __func__);
 		rc = -EIO;
diff --git a/drivers/s390/crypto/zcrypt_cex2a.c b/drivers/s390/crypto/zcrypt_cex2a.c
index c50f3e86cc74..7cbb384ec535 100644
--- a/drivers/s390/crypto/zcrypt_cex2a.c
+++ b/drivers/s390/crypto/zcrypt_cex2a.c
@@ -175,6 +175,7 @@ static int zcrypt_cex2a_queue_probe(struct ap_device *ap_dev)
 	zq->queue = aq;
 	zq->online = 1;
 	atomic_set(&zq->load, 0);
+	ap_queue_init_state(aq);
 	ap_queue_init_reply(aq, &zq->reply);
 	aq->request_timeout = CEX2A_CLEANUP_TIME,
 	aq->private = zq;
diff --git a/drivers/s390/crypto/zcrypt_cex2c.c b/drivers/s390/crypto/zcrypt_cex2c.c
index 35c7c6672713..c78c0d119806 100644
--- a/drivers/s390/crypto/zcrypt_cex2c.c
+++ b/drivers/s390/crypto/zcrypt_cex2c.c
@@ -220,6 +220,7 @@ static int zcrypt_cex2c_queue_probe(struct ap_device *ap_dev)
 	zq->queue = aq;
 	zq->online = 1;
 	atomic_set(&zq->load, 0);
+	ap_rapq(aq->qid);
 	rc = zcrypt_cex2c_rng_supported(aq);
 	if (rc < 0) {
 		zcrypt_queue_free(zq);
@@ -231,6 +232,7 @@ static int zcrypt_cex2c_queue_probe(struct ap_device *ap_dev)
 	else
 		zq->ops = zcrypt_msgtype(MSGTYPE06_NAME,
 					 MSGTYPE06_VARIANT_NORNG);
+	ap_queue_init_state(aq);
 	ap_queue_init_reply(aq, &zq->reply);
 	aq->request_timeout = CEX2C_CLEANUP_TIME;
 	aq->private = zq;
diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index 442e3d6162f7..6fabc906114c 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -381,6 +381,7 @@ static int zcrypt_cex4_queue_probe(struct ap_device *ap_dev)
 	zq->queue = aq;
 	zq->online = 1;
 	atomic_set(&zq->load, 0);
+	ap_queue_init_state(aq);
 	ap_queue_init_reply(aq, &zq->reply);
 	aq->request_timeout = CEX4_CLEANUP_TIME,
 	aq->private = zq;

