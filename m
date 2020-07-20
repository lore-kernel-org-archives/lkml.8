Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D780C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4959D2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260448;
	bh=lye9nEJslbJYSdaSkBheYwWegDQY9ewGWMpaayLWwxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yBoCxQHKqlVmnG8ZGslBDh6lz2x6QScLBjOJK+peA2ShLac4a+bJyILRZADFqKEPM
	 42P9mt4+NFDKme9Q9cHyFCjK3GAiazDdyhI8ZrEunODlvotZk8fhGxKqWz0/fUkp19
	 axifui9jvCCw4KW3pg/gAgaiLSg7j6DwbwbiHaUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbgGTPyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731265AbgGTPyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:54:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 588FB2064B;
        Mon, 20 Jul 2020 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260443;
        bh=lye9nEJslbJYSdaSkBheYwWegDQY9ewGWMpaayLWwxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbuNc0MKgQJw3CKAe7WMcnhcRsISFbSHPJ83O7WhK0G25iluwmm/IbXa03lyp7iNK
         DbtoMufk6wg5LmokPcrAITIKDDDvwiriW/AHJysYM/sIBg0zegI11I/EI5sSMytuS6
         /FJ3i1pyF/jgLxfG0fhuOyd3pzsQO7ruZEFO1HyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Ian Abbott <abbotti@mev.co.uk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/133] staging: comedi: verify array index is correct before using it
Date:   Mon, 20 Jul 2020 17:36:50 +0200
Message-Id: <20200720152806.781603649@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit ef75e14a6c935eec82abac07ab68e388514e39bc ]

This code reads from the array before verifying that "trig" is a valid
index.  If the index is wildly out of bounds then reading from an
invalid address could lead to an Oops.

Fixes: a8c66b684efa ("staging: comedi: addi_apci_1500: rewrite the subdevice support functions")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20200709102936.GA20875@mwanda
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/comedi/drivers/addi_apci_1500.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/drivers/addi_apci_1500.c b/drivers/staging/comedi/drivers/addi_apci_1500.c
index 45ad4ba92f94f..689acd69a1b9c 100644
--- a/drivers/staging/comedi/drivers/addi_apci_1500.c
+++ b/drivers/staging/comedi/drivers/addi_apci_1500.c
@@ -456,9 +456,9 @@ static int apci1500_di_cfg_trig(struct comedi_device *dev,
 	unsigned int lo_mask = data[5] << shift;
 	unsigned int chan_mask = hi_mask | lo_mask;
 	unsigned int old_mask = (1 << shift) - 1;
-	unsigned int pm = devpriv->pm[trig] & old_mask;
-	unsigned int pt = devpriv->pt[trig] & old_mask;
-	unsigned int pp = devpriv->pp[trig] & old_mask;
+	unsigned int pm;
+	unsigned int pt;
+	unsigned int pp;
 
 	if (trig > 1) {
 		dev_dbg(dev->class_dev,
@@ -471,6 +471,10 @@ static int apci1500_di_cfg_trig(struct comedi_device *dev,
 		return -EINVAL;
 	}
 
+	pm = devpriv->pm[trig] & old_mask;
+	pt = devpriv->pt[trig] & old_mask;
+	pp = devpriv->pp[trig] & old_mask;
+
 	switch (data[2]) {
 	case COMEDI_DIGITAL_TRIG_DISABLE:
 		/* clear trigger configuration */
-- 
2.25.1



