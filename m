Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86245C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606CE2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VuPN3MiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgHaQX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:23:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33794 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbgHaQXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:23:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VGK4OL021856;
        Mon, 31 Aug 2020 16:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=RpZrAjaF5qVRKMKVziStX4EIVycnEig2p+gTO6CUt9k=;
 b=VuPN3MiIU3I18AcA4+BYpj2ACg7pWey0Zw7gteGx0x9/KNatC2QqOW7LaibjGbKs1bY3
 b2D+ObtClmoF3QGbJesAiTNG8VpkfwtaGmiTttt0SMPNG/VVY0O89bEURo7KYXkxF25M
 Tn9k54UxleGoOtdaCb4hjomKU60hOlJOTG4fpiBq9z9Ao+fVv5kbYcvYTRS0hZjvi2lP
 +Jpr+nwn2M9lylJWGWnzBaLO3vVUfOA0wg/ygCsM3I5ZuWuvpl4ZHpmW9MxUumedGQHq
 briPoKzQbWtn6iUanztZ6f6j2NzsKbwlpBOYZCWIDMomfRYfx13Gl3Tbx618rXiVGwgB SQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 337eyky66k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 16:23:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VGKvJC101042;
        Mon, 31 Aug 2020 16:23:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3380sq7ytd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 16:23:41 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07VGNeqh007758;
        Mon, 31 Aug 2020 16:23:40 GMT
Received: from concerto.us.oracle.com (/10.65.179.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 31 Aug 2020 09:23:40 -0700
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        erkka.talvitie@vincit.fi
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
Subject: [RFC RESEND PATCH 1/1] usb: ehci: Remove erroneous return of EPROTO upon detection of stall
Date:   Mon, 31 Aug 2020 10:23:31 -0600
Message-ID: <8248a5f80a8aa7cd391fa36a907d342fad38563b.1598887346.git.khalid@gonehiking.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1598887346.git.khalid@gonehiking.org>
References: <cover.1598887346.git.khalid@gonehiking.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200831162331.ClLuQH7RzlqXmqYvf0_Ipjb_cx88w941Qu8uvFPg6JI@z>

With the USB 3.0/3.1 controller on MSI B450-A Pro Max motherboard,
full speed and low speed devices see constant resets making
keyboards and mouse unreliable and unusable. These resets are caused
by detection of stall in qtd_copy_status() and returning EPROTO
which in turn results in TT buffers in hub being cleared. Hubs do
not seem to repsond well to this and seem to hang which causes
further USB transactions to time out. A reset finally clears the
issue until we repeat the cycle all over again.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
---
 drivers/usb/host/ehci-q.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 8a5c9b3ebe1e..7d4b2bc4633c 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -214,10 +214,6 @@ static int qtd_copy_status (
 		 * When MMF is active and PID Code is IN, queue is halted.
 		 * EHCI Specification, Table 4-13.
 		 */
-		} else if ((token & QTD_STS_MMF) &&
-					(QTD_PID(token) == PID_CODE_IN)) {
-			status = -EPROTO;
-		/* CERR nonzero + halt --> stall */
 		} else if (QTD_CERR(token)) {
 			status = -EPIPE;
 
-- 
2.25.1

