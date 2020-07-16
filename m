Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4563CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F39C206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgGPGya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:54:30 -0400
Received: from lonlinode-sdnproxy-1.icoremail.net ([139.162.193.133]:51568
        "HELO lonlinode-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1725921AbgGPGya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:54:30 -0400
X-Greylist: delayed 711 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jul 2020 02:54:28 EDT
Received: from localhost.localdomain (unknown [106.19.113.251])
        by c1app1 (Coremail) with SMTP id AQINCgDnyZLC9g9f7dSfAQ--.20987S2;
        Thu, 16 Jul 2020 14:42:12 +0800 (CST)
From:   Qiu Wenbo <qiuwenbo@phytium.com.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Linux Driver Project Developer List 
        <driverdev-devel@linuxdriverproject.org>
Cc:     Qiu Wenbo <qiuwenbo@phytium.com.cn>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Villegas <git@marvil07.net>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: Fixes coding style in several headers
Date:   Thu, 16 Jul 2020 14:41:12 +0800
Message-Id: <20200716064118.61243-1-qiuwenbo@phytium.com.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQINCgDnyZLC9g9f7dSfAQ--.20987S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGryUGF48WrWrGw4kKFW7Arb_yoW5tFWrpr
        srX3ySyw1Uta1UWrnxtFyUuF1fKa4xCrWkG39rt34YvF1rurWFgFy7Aa4UJr43Gas5AF13
        tFWUGry5W34UKrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUndb1UUUUU
X-Originating-IP: [106.19.113.251]
X-CM-SenderInfo: 5tlx4vhqerq15k1wx33pof0zgofq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes warnings in several headers found by the checkpatch.pl tool.

Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>
---
 drivers/staging/rtl8712/rtl871x_event.h   | 15 ++++++++++-----
 drivers/staging/rtl8712/rtl871x_io.h      |  3 ++-
 drivers/staging/rtl8712/rtl871x_pwrctrl.h | 15 ++++++++++-----
 drivers/staging/rtl8712/rtl871x_xmit.h    | 15 ++++++++++-----
 4 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_event.h b/drivers/staging/rtl8712/rtl871x_event.h
index d9a5476d2426..0e59d0ee6aae 100644
--- a/drivers/staging/rtl8712/rtl871x_event.h
+++ b/drivers/staging/rtl8712/rtl871x_event.h
@@ -78,13 +78,16 @@ struct event_node {
 	unsigned char *node;
 	unsigned char evt_code;
 	unsigned short evt_sz;
-	/*volatile*/ int *caller_ff_tail;
+	/*volatile*/
+	int *caller_ff_tail;
 	int	caller_ff_sz;
 };
 
 struct c2hevent_queue {
-	/*volatile*/ int	head;
-	/*volatile*/ int	tail;
+	/*volatile*/
+	int	head;
+	/*volatile*/
+	int	tail;
 	struct	event_node	nodes[C2HEVENT_SZ];
 	unsigned char	seq;
 };
@@ -92,8 +95,10 @@ struct c2hevent_queue {
 #define NETWORK_QUEUE_SZ	4
 
 struct network_queue {
-	/*volatile*/ int	head;
-	/*volatile*/ int	tail;
+	/*volatile*/
+	int	head;
+	/*volatile*/
+	int	tail;
 	struct wlan_bssid_ex networks[NETWORK_QUEUE_SZ];
 };
 
diff --git a/drivers/staging/rtl8712/rtl871x_io.h b/drivers/staging/rtl8712/rtl871x_io.h
index c20dd5a6bbd1..2e269b71072c 100644
--- a/drivers/staging/rtl8712/rtl871x_io.h
+++ b/drivers/staging/rtl8712/rtl871x_io.h
@@ -101,7 +101,8 @@ struct	_io_ops {
 struct io_req {
 	struct list_head list;
 	u32	addr;
-	/*volatile*/ u32	val;
+	/*volatile*/
+	u32	val;
 	u32	command;
 	u32	status;
 	u8	*pbuf;
diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.h b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
index dd5a79f90b1a..e6b740c09120 100644
--- a/drivers/staging/rtl8712/rtl871x_pwrctrl.h
+++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
@@ -77,14 +77,19 @@ struct reportpwrstate_parm {
 
 struct	pwrctrl_priv {
 	struct mutex mutex_lock;
-	/*volatile*/ u8 rpwm; /* requested power state for fw */
+	/*volatile*/
+	u8 rpwm; /* requested power state for fw */
 	/* fw current power state. updated when 1. read from HCPWM or
 	 * 2. driver lowers power level
 	 */
-	/*volatile*/ u8 cpwm;
-	/*volatile*/ u8 tog; /* toggling */
-	/*volatile*/ u8 cpwm_tog; /* toggling */
-	/*volatile*/ u8 tgt_rpwm; /* wanted power state */
+	/*volatile*/
+	u8 cpwm;
+	/*volatile*/
+	u8 tog; /* toggling */
+	/*volatile*/
+	u8 cpwm_tog; /* toggling */
+	/*volatile*/
+	u8 tgt_rpwm; /* wanted power state */
 	uint pwr_mode;
 	uint smart_ps;
 	uint alives;
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8712/rtl871x_xmit.h
index f227828094bf..6d2e12b35670 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.h
+++ b/drivers/staging/rtl8712/rtl871x_xmit.h
@@ -182,11 +182,16 @@ struct sta_xmit_priv {
 };
 
 struct	hw_txqueue {
-	/*volatile*/ sint	head;
-	/*volatile*/ sint	tail;
-	/*volatile*/ sint	free_sz;	/*in units of 64 bytes*/
-	/*volatile*/ sint      free_cmdsz;
-	/*volatile*/ sint	 txsz[8];
+	/*volatile*/
+	sint	head;
+	/*volatile*/
+	sint	tail;
+	/*volatile*/
+	sint	free_sz;	/*in units of 64 bytes*/
+	/*volatile*/
+	sint      free_cmdsz;
+	/*volatile*/
+	sint	 txsz[8];
 	uint	ff_hwaddr;
 	uint	cmd_hwaddr;
 	sint	ac_tag;
-- 
2.27.0

