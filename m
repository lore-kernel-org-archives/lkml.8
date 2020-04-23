Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBF1C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C5F52077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="xhTn1DqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgDWL4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:56:40 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35754 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728224AbgDWL40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:56:26 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NBqKO8011770;
        Thu, 23 Apr 2020 13:56:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=XOcOfmk0mzp2LNDxp8A7DBUhCmQQA1WzS4pxBJFuT4I=;
 b=xhTn1DqCTNiB6MC3QSOhHXOHl+6uENMYp+BHRabyiljbI1s9yITrmlCkfO2Bt7zZ/d5k
 KBsbFDgMWOgpVHkdbI1EWEYYvm6A/d3Po2R64rk3q3QLStmGITOkNwCC5pTUe3e+RsbO
 2x4Eu5cS4AcLh6RRdHBnOZ5k+xsi6psipKmKgBzLH7820fc4RodphPMwVpi0lR8MAOC9
 dS0jOus+tNZEJSAvsm31ctnXePrkFqkssyVScpgYlvMZjB2Vm83seuXs7rr/n31sKjMl
 SuHMi21UKK81EVxB7qtxQcmY2kMdS8emGdeCj8FTfRpOj2aSSxaxY3gN6+M3ismhhMTg 9g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fq11vjj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Apr 2020 13:56:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4029C10002A;
        Thu, 23 Apr 2020 13:56:19 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 371C72B8A00;
        Thu, 23 Apr 2020 13:56:19 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Apr 2020 13:56:18
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@st.com>, <fabrice.gasnier@st.com>
Subject: [PATCH v2 4/4] usb: gadget: f_acm: add suspend resume callbacks
Date:   Thu, 23 Apr 2020 13:55:56 +0200
Message-ID: <1587642956-8157-5-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587642956-8157-1-git-send-email-fabrice.gasnier@st.com>
References: <1587642956-8157-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_07:2020-04-22,2020-04-23 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend resume callbacks to notify u_serial of the bus suspend/resume
state.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/usb/gadget/function/f_acm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/gadget/function/f_acm.c b/drivers/usb/gadget/function/f_acm.c
index 7c152c2..200596e 100644
--- a/drivers/usb/gadget/function/f_acm.c
+++ b/drivers/usb/gadget/function/f_acm.c
@@ -723,6 +723,20 @@ static void acm_free_func(struct usb_function *f)
 	kfree(acm);
 }
 
+static void acm_resume(struct usb_function *f)
+{
+	struct f_acm *acm = func_to_acm(f);
+
+	gserial_resume(&acm->port);
+}
+
+static void acm_suspend(struct usb_function *f)
+{
+	struct f_acm *acm = func_to_acm(f);
+
+	gserial_suspend(&acm->port);
+}
+
 static struct usb_function *acm_alloc_func(struct usb_function_instance *fi)
 {
 	struct f_serial_opts *opts;
@@ -750,6 +764,8 @@ static struct usb_function *acm_alloc_func(struct usb_function_instance *fi)
 	acm->port_num = opts->port_num;
 	acm->port.func.unbind = acm_unbind;
 	acm->port.func.free_func = acm_free_func;
+	acm->port.func.resume = acm_resume;
+	acm->port.func.suspend = acm_suspend;
 
 	return &acm->port.func;
 }
-- 
2.7.4

