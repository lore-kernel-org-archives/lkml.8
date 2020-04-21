Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84F0C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C94282076E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="sB7xK0lE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgDUMd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:33:26 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13408 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728853AbgDUMdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:33:22 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LCOCbE002725;
        Tue, 21 Apr 2020 14:33:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=kO+cRwxzp6MTRP0BhgQn00h4Jvgtw6HO9Mccuab6nNs=;
 b=sB7xK0lERq51IXDlyGZOCu7iKpv0O3+r/L6Of+Ft7xWKxsTYBJtHDVCg0RzjNGcifOSW
 /87ylOnSdy6jU73BfCEow0nSHEWwgkcTYM536JV5IZtI8NwzmaYoJR/mvZmhE+tJUojp
 OcNKZHoMH8vCiPsDbydk8fhyBFP0Z5fCmcIJROIFO5TK3K8AFgsLrKsT8/9r+EGYmlY7
 zYDe9xyyV0urvnIqqCVxZK6ljvayDM9VWt0bCOK3VbL3VpxbHGSllCFxXzwUu+SBCsV3
 0U0leklll+y57LyfIYtZQZ9KRI54987O0USnFpOa2h6GkKfupUm8pywcA59RV4m6z/iF ZQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fq11g3ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 14:33:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 158EB10002A;
        Tue, 21 Apr 2020 14:33:14 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0ACC42B0FCB;
        Tue, 21 Apr 2020 14:33:14 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Apr 2020 14:33:13
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <hminas@synopsys.com>, <balbi@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@st.com>
Subject: [PATCH 3/4] usb: gadget: f_serial: add suspend resume callbacks
Date:   Tue, 21 Apr 2020 14:32:20 +0200
Message-ID: <1587472341-17935-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587472341-17935-1-git-send-email-fabrice.gasnier@st.com>
References: <1587472341-17935-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_05:2020-04-20,2020-04-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend resume callbacks to notify u_serial of the bus suspend/resume
state.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/usb/gadget/function/f_serial.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/gadget/function/f_serial.c b/drivers/usb/gadget/function/f_serial.c
index 1406255..e627138 100644
--- a/drivers/usb/gadget/function/f_serial.c
+++ b/drivers/usb/gadget/function/f_serial.c
@@ -348,6 +348,20 @@ static void gser_unbind(struct usb_configuration *c, struct usb_function *f)
 	usb_free_all_descriptors(f);
 }
 
+static void gser_resume(struct usb_function *f)
+{
+	struct f_gser *gser = func_to_gser(f);
+
+	gserial_resume(&gser->port);
+}
+
+static void gser_suspend(struct usb_function *f)
+{
+	struct f_gser *gser = func_to_gser(f);
+
+	gserial_suspend(&gser->port);
+}
+
 static struct usb_function *gser_alloc(struct usb_function_instance *fi)
 {
 	struct f_gser	*gser;
@@ -369,6 +383,8 @@ static struct usb_function *gser_alloc(struct usb_function_instance *fi)
 	gser->port.func.set_alt = gser_set_alt;
 	gser->port.func.disable = gser_disable;
 	gser->port.func.free_func = gser_free;
+	gser->port.func.resume = gser_resume;
+	gser->port.func.suspend = gser_suspend;
 
 	return &gser->port.func;
 }
-- 
2.7.4

