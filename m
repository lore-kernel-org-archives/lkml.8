Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FCFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E178522CBB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259523;
	bh=i6z5wAOGKay2yoCvdUnPgPzFvWJm4qfzKtRJ0+eiRlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XQ4RuTdI+TWDmlyBJ+oXmJUHQdZY1QkLk6ctqp5MbIKfFpggoLJ/fsxDGvMX7Tt3J
	 xlhqPw8YQs1fNYYWPirrIzCPUFsb9BUEERkBtiLCZRk5IhM0JHJmdqvSGgDUoUIceB
	 P3SCTJ3HEC+lo/XSgJhjhlqiUlopLNgAEuS/j0ss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgGTPil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729218AbgGTPif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:38:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1441922CBB;
        Mon, 20 Jul 2020 15:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259514;
        bh=i6z5wAOGKay2yoCvdUnPgPzFvWJm4qfzKtRJ0+eiRlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUF44jjgIpvNJwYfIfvT4XyPHe7h742KrQJeY9BM7ZB4N7pYWZn8ouYSemEEeBY6A
         pkEO8k3fdxJKuNmLt6zONe6Y51gtu0V9gh+M0Ggt6ycsIXCSuI76eUvaiLattZ94e2
         Fa/FrQvInv4G4CZ+YjoOVJGXnIwcdHuzRQLwTEoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Ian Abbott <abbotti@mev.co.uk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 34/58] staging: comedi: verify array index is correct before using it
Date:   Mon, 20 Jul 2020 17:36:50 +0200
Message-Id: <20200720152748.894780419@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152747.127988571@linuxfoundation.org>
References: <20200720152747.127988571@linuxfoundation.org>
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
index 63991c49ff230..79a8799b12628 100644
--- a/drivers/staging/comedi/drivers/addi_apci_1500.c
+++ b/drivers/staging/comedi/drivers/addi_apci_1500.c
@@ -465,9 +465,9 @@ static int apci1500_di_cfg_trig(struct comedi_device *dev,
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
@@ -480,6 +480,10 @@ static int apci1500_di_cfg_trig(struct comedi_device *dev,
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



