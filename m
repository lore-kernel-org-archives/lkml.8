Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979B9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE19207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="sco0b1c8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHSV6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:58:11 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:20616 "EHLO
        o1.dev.nutanix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHSV6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:58:11 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Aug 2020 17:58:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
        h=from:subject:to:cc:content-type:content-transfer-encoding;
        s=smtpapi; bh=RweNdBfxaey3EF78d652+yQmedwVnAX9SizQ/HnGRlo=;
        b=sco0b1c81xhJt5tC+jjdRtqhWdezzZ02Y1WALBn1GjzcwFO64hx7RwDfbipyxokVN9cI
        XNAhY6mpZiS6YpGEbR1k2Fk+rE78F7zoUV/MBmhLJEtzcL0a23Du0AbHDj2SBKfZlkEICD
        cvAhzktfPPTAXJXRQtCIkaV9s6unzXwx4=
Received: by filterdrecv-p3las1-5785d94c6b-zt28f with SMTP id filterdrecv-p3las1-5785d94c6b-zt28f-18-5F3D9F45-2E
        2020-08-19 21:53:09.602511941 +0000 UTC m=+537817.541799769
Received: from raphael-norwitz.ubvm.nutanix.com (unknown)
        by ismtpd0004p1sjc2.sendgrid.net (SG) with ESMTP
        id 0m3AFR_IRquw8QzV4Pkf4A
        Wed, 19 Aug 2020 21:53:09.490 +0000 (UTC)
From:   Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH] Fix typo in irq_domain documentation
Date:   Wed, 19 Aug 2020 21:53:09 +0000 (UTC)
Message-Id: <1597873980-204052-1-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
X-SG-EID: =?us-ascii?Q?YCLURHX+pjNDm1i7d69iKyMnQi=2FdvWah9veFa8nllaoUC0ScIWrCgiaWGu43Vg?=
 =?us-ascii?Q?xFdB4istXUBpN9H93OJgc8zYXmCLpm3FbZpla=2FS?=
 =?us-ascii?Q?jaZdmqeP=2FHKhNZZtwOjHry3ycb959v7jMJAeU52?=
 =?us-ascii?Q?2DoXVIFSbAdjL2yrB9+qvmqhuYnWwJ4PQEeVmzc?=
 =?us-ascii?Q?4aNICSyJXQG17CKbkVGZ2=2FYBIx3d8xWC6AEXPmd?=
 =?us-ascii?Q?XnRN=2F=2FzpsRpLVf=2FFOBVJ8wtJ9oUwF2C5qo5jblv?=
 =?us-ascii?Q?XngtxNt1yNucM2MtJq3yQ+rFwEcvL+=2FUGqAhA2W?=
 =?us-ascii?Q?8i4=3D?=
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     raphael.s.norwitz@gmail.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq_domain documentation states that "Here the interrupt number
loose all kind of correspondence to hardware interrupt numbers:...".
It's clear from the context that the author means to use "loses" instead
of "loose". To avoid future confusion, this change fixes the
aforementioned wording.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 Documentation/core-api/irq/irq-domain.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index 096db12..eba5e41 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -15,7 +15,7 @@ such as GPIO controllers avoid reimplementing identical callback
 mechanisms as the IRQ core system by modelling their interrupt
 handlers as irqchips, i.e. in effect cascading interrupt controllers.
 
-Here the interrupt number loose all kind of correspondence to
+Here the interrupt number loses all kind of correspondence to
 hardware interrupt numbers: whereas in the past, IRQ numbers could
 be chosen so they matched the hardware IRQ line into the root
 interrupt controller (i.e. the component actually fireing the
-- 
2.9.3

