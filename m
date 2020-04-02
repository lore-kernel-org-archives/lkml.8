Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E9FC2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B6D2078E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbgDBHTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:19:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbgDBHTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:19:10 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032746DO135229;
        Thu, 2 Apr 2020 03:18:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304r50dx3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 03:18:46 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03274I3P136203;
        Thu, 2 Apr 2020 03:18:45 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304r50dx36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 03:18:45 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0327HYj6030992;
        Thu, 2 Apr 2020 07:18:44 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 301x77728p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 07:18:44 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0327IhYT56099218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Apr 2020 07:18:43 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 584F178060;
        Thu,  2 Apr 2020 07:18:43 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91F2F7805C;
        Thu,  2 Apr 2020 07:18:42 +0000 (GMT)
Received: from [9.70.82.143] (unknown [9.70.82.143])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Apr 2020 07:18:42 +0000 (GMT)
Subject: [PATCH v10 12/14] powerpc/vas: Display process stuck message
From:   Haren Myneni <haren@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     mikey@neuling.org, srikar@linux.vnet.ibm.com,
        frederic.barrat@fr.ibm.com, ajd@linux.ibm.com,
        linux-kernel@vger.kernel.org, npiggin@gmail.com, hch@infradead.org,
        oohall@gmail.com, clg@kaod.org, sukadev@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, herbert@gondor.apana.org.au
In-Reply-To: <1585810846.2275.23.camel@hbabu-laptop>
References: <1585810846.2275.23.camel@hbabu-laptop>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 02 Apr 2020 00:18:41 -0700
Message-ID: <1585811921.2275.64.camel@hbabu-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_04:2020-03-31,2020-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 suspectscore=1 mlxscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Process can not close send window until all requests are processed.
Means wait until window state is not busy and send credits are
returned. Display debug messages in case taking longer to close the
window.

Signed-off-by: Haren Myneni <haren@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-window.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 4b5adf5..3d80f37 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -1181,6 +1181,7 @@ static void poll_window_credits(struct vas_window *window)
 {
 	u64 val;
 	int creds, mode;
+	int count = 0;
 
 	val = read_hvwc_reg(window, VREG(WINCTL));
 	if (window->tx_win)
@@ -1199,10 +1200,27 @@ static void poll_window_credits(struct vas_window *window)
 		creds = GET_FIELD(VAS_LRX_WCRED, val);
 	}
 
+	/*
+	 * Takes around few milliseconds to complete all pending requests
+	 * and return credits.
+	 * TODO: Scan fault FIFO and invalidate CRBs points to this window
+	 *       and issue CRB Kill to stop all pending requests. Need only
+	 *       if there is a bug in NX or fault handling in kernel.
+	 */
 	if (creds < window->wcreds_max) {
 		val = 0;
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(msecs_to_jiffies(10));
+		count++;
+		/*
+		 * Process can not close send window until all credits are
+		 * returned.
+		 */
+		if (!(count % 10000))
+			pr_debug("VAS: pid %d stuck. Waiting for credits returned for Window(%d). creds %d, Retries %d\n",
+				vas_window_pid(window), window->winid,
+				creds, count);
+
 		goto retry;
 	}
 }
@@ -1216,6 +1234,7 @@ static void poll_window_busy_state(struct vas_window *window)
 {
 	int busy;
 	u64 val;
+	int count = 0;
 
 retry:
 	val = read_hvwc_reg(window, VREG(WIN_STATUS));
@@ -1224,6 +1243,15 @@ static void poll_window_busy_state(struct vas_window *window)
 		val = 0;
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(msecs_to_jiffies(5));
+		count++;
+		/*
+		 * Takes around few milliseconds to process all pending
+		 * requests.
+		 */
+		if (!(count % 10000))
+			pr_debug("VAS: pid %d stuck. Window (ID=%d) is in busy state. Retries %d\n",
+				vas_window_pid(window), window->winid, count);
+
 		goto retry;
 	}
 }
-- 
1.8.3.1



