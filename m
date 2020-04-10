Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE28EC2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8594D206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="KcUnmzdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDJOci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:32:38 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:30692 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbgDJOci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:32:38 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03AESH4r027085;
        Fri, 10 Apr 2020 16:32:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=TShubh2H2AdHxwazjuLdxZIzK8knwtSXhUp0llm02dE=;
 b=KcUnmzdoIgmrNUbeA646O6mMfPVdoUJRFXLOILsSVLUcs4HtevWuhAkCB2RRDGGp8wjV
 gBiafiVe1fOH6swpMuwQ10bwUSFe1xg1UlVQ93Q6QRqS17FN9Y8GgEihedhL0Q+EdYOx
 utWD+GjTOYpt+U3K7gBymXmomDcpf2+MQjEUAY8/gExEi+yTr82nENT1kgIQXkdwNS8o
 PAuvyL2gKxioB2k2WVoA88lFzUIiqtEb5K6bSKphThxp6t5d+UpkMQBhFNs66TLGWtc9
 8gVvDy+NcoFAQjkWHUHTCUWZ975HrPd9jkpU6twa0lrps5efDvYn5u1F2jaamH8IaIe/ hQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3091k78xah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Apr 2020 16:32:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 344EA10002A;
        Fri, 10 Apr 2020 16:32:22 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 19BD82BF9C5;
        Fri, 10 Apr 2020 16:32:22 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Apr 2020 16:32:21
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <hminas@synopsys.com>
CC:     <gregkh@linuxfoundation.org>, <balbi@ti.com>,
        <johnyoun@synopsys.com>, <gregory.herrero@intel.com>,
        <Grigor.Tovmasyan@synopsys.com>, <amelie.delaunay@st.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] usb: dwc2: only prevent new request when power_down is possible
Date:   Fri, 10 Apr 2020 16:31:54 +0200
Message-ID: <1586529114-25211-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_05:2020-04-09,2020-04-10 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When controller is suspended, registers mustn't be touched. This is not
the case when 'power_down' is set to none. In this case, power saving
routines are skipped.

This fixes a case where gadget driver (f_acm) gets opened (cat /dev/ttyGS0)
but the bus has been suspended by the host:
- configfs-gadget gadget: acm ttyGS0 can't notify serial state, -11

Fixes: 7ababa926c66 ("usb: dwc2: gadget: prevent new request submission during suspend")
Fixes: 88b02f2cb1e1 ("usb: dwc2: Add core state checking")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/usb/dwc2/gadget.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 92ed32e..45a8782 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -1375,7 +1375,8 @@ static int dwc2_hsotg_ep_queue(struct usb_ep *ep, struct usb_request *req,
 		req->zero, req->short_not_ok);
 
 	/* Prevent new request submission when controller is suspended */
-	if (hs->lx_state != DWC2_L0) {
+	if (hs->params.power_down != DWC2_POWER_DOWN_PARAM_NONE &&
+	    hs->lx_state != DWC2_L0) {
 		dev_dbg(hs->dev, "%s: submit request only in active state\n",
 			__func__);
 		return -EAGAIN;
-- 
2.7.4

