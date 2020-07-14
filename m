Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34812C433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6DD22AAA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752584;
	bh=XShLMHFLIslsFzvvnDfxIF44y2nXE8NLb7s1NS6Wa0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B3ulclkaGIuM2L5Co+hMptTXFesaLgel6rA17kc+aUe8JIc0Ko5aisLT7gh7RRYM0
	 KWh0L/y+mPcBxN3hTuHA1SA8E/1G1ri5gX7wCfHYSf28Z01wI6jv8iZRGZfySMUPh5
	 mThvUC3rPY/m0qIYbfODdtj66XJvoegibq+uL/0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgGNStm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730175AbgGNStj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:49:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62DD522B3F;
        Tue, 14 Jul 2020 18:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752579;
        bh=XShLMHFLIslsFzvvnDfxIF44y2nXE8NLb7s1NS6Wa0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzwqC0ocEg4isUEJ1fiC7r573W8v0Z9Q7McyYkPl0xkTWJY0bkQXuhrSNconX0fb4
         4DVZrMott2rgPf+LtB4IQ80XM7EKD5rZchK9A+fpdrZVtFpgI89K3/ZOzh1nnM6QPB
         RxQ3ZyvmV1ETvKSwTQZ3Vns/nsjwb/RaPjJlt+3k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 030/109] usb: dwc3: pci: Fix reference count leak in dwc3_pci_resume_work
Date:   Tue, 14 Jul 2020 20:43:33 +0200
Message-Id: <20200714184106.963706477@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 2655971ad4b34e97dd921df16bb0b08db9449df7 ]

dwc3_pci_resume_work() calls pm_runtime_get_sync() that increments
the reference counter. In case of failure, decrement the reference
before returning.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index b67372737dc9b..96c05b121fac8 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -206,8 +206,10 @@ static void dwc3_pci_resume_work(struct work_struct *work)
 	int ret;
 
 	ret = pm_runtime_get_sync(&dwc3->dev);
-	if (ret)
+	if (ret) {
+		pm_runtime_put_sync_autosuspend(&dwc3->dev);
 		return;
+	}
 
 	pm_runtime_mark_last_busy(&dwc3->dev);
 	pm_runtime_put_sync_autosuspend(&dwc3->dev);
-- 
2.25.1



