Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02874C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BE121582
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580746825;
	bh=wV3EqIuuGbB79eip1FqxumZ6nHGkbGQzO68Nyo5GlX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nzvNfm+Y4jtKje/vCQAbOnzGUBegoPYcJWGaYNWQqRYqjDALAlVvcGrb4eY1/wI9G
	 rSGrPnP+WZkBz6DfHbIbrPyuoDd/lpFQs6R+Lg+PiD8FKvhSTEZcefv+D2NS3E9biX
	 BjbJE1h4e712VrVDfijPg6aXLG+A1Kz68bcjjKGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgBCQUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:20:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728840AbgBCQUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:20:22 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02DCC21744;
        Mon,  3 Feb 2020 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580746821;
        bh=wV3EqIuuGbB79eip1FqxumZ6nHGkbGQzO68Nyo5GlX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHfEYz9R9NZSTp3hvuyt/Ldp6SBD8xfrtaQG15+S9zXIdBLrMIHef6lRR2S0tX+k6
         vmm44oYrTXfcRzfXEeKpNqR644oJOCfkAPCEA9iakb/idlVG5gqv5pPKVVdE9pZeME
         fzhmvNvm3Cl3UlpVAddJW5idMCDJ9lFZTU2WExdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steven Ellis <sellis@redhat.com>,
        Pacho Ramos <pachoramos@gmail.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 20/53] usb-storage: Disable UAS on JMicron SATA enclosure
Date:   Mon,  3 Feb 2020 16:19:12 +0000
Message-Id: <20200203161906.795449582@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
References: <20200203161902.714326084@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laura Abbott <labbott@fedoraproject.org>

[ Upstream commit bc3bdb12bbb3492067c8719011576370e959a2e6 ]

Steve Ellis reported incorrect block sizes and alignement
offsets with a SATA enclosure. Adding a quirk to disable
UAS fixes the problems.

Reported-by: Steven Ellis <sellis@redhat.com>
Cc: Pacho Ramos <pachoramos@gmail.com>
Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/storage/unusual_uas.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index 8ed80f28416fa..9aad6825947c8 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -162,12 +162,15 @@ UNUSUAL_DEV(0x2537, 0x1068, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_IGNORE_UAS),
 
-/* Reported-by: Takeo Nakayama <javhera@gmx.com> */
+/*
+ * Initially Reported-by: Takeo Nakayama <javhera@gmx.com>
+ * UAS Ignore Reported by Steven Ellis <sellis@redhat.com>
+ */
 UNUSUAL_DEV(0x357d, 0x7788, 0x0000, 0x9999,
 		"JMicron",
 		"JMS566",
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
-		US_FL_NO_REPORT_OPCODES),
+		US_FL_NO_REPORT_OPCODES | US_FL_IGNORE_UAS),
 
 /* Reported-by: Hans de Goede <hdegoede@redhat.com> */
 UNUSUAL_DEV(0x4971, 0x1012, 0x0000, 0x9999,
-- 
2.20.1



