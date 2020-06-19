Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C297BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9641C217A0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583508;
	bh=FzJ2l1Zrk2ln+tDm9VxvPk4dg6XfhbBN6EMOdX273xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=htOb3Vxsh3R717YeuhY2RCnIquP4ArVp0vuhwBUuFlU2zQ3jLdau/U1g/stRRu+eI
	 yUgam+P4nlieuifJBG7YU99hUXwzfzJj9Qay/icwzUZJtq7zpLSv/gULwamI8jW9ST
	 JNtiCfPQmUIPPqjQY43Pb8D4l2eHKTa/8OoTX5fI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394542AbgFSQS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:18:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390752AbgFSPBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:01:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26AF820734;
        Fri, 19 Jun 2020 15:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578913;
        bh=FzJ2l1Zrk2ln+tDm9VxvPk4dg6XfhbBN6EMOdX273xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GcQvQQPIrl9SgHwrs3T0IbbiwRvC2RKreINtYsrbCaoESIPm2d9r4EocgnbEyVwyi
         HxmKiQpwZljc2YSlzgL6P2ToePrGk1ATo1Ivaz9Qh8bi9wvgLD2zBXCtfR+jAhyoCm
         XB+/yfzZg9eNXHVxRm6KActm1UHlBJU7ysgyAsHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 204/267] PCI: Remove unused NFP32xx IDs
Date:   Fri, 19 Jun 2020 16:33:09 +0200
Message-Id: <20200619141658.523640739@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 1ccce46c5e8b8a0d2606fb8bb72bff069ffdc3ab ]

Defines for NFP32xx are no longer used anywhere, remove them.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pci_ids.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d157983b84cf..f4e278493f5b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2539,8 +2539,6 @@
 #define PCI_VENDOR_ID_HUAWEI         	0x19e5
 
 #define PCI_VENDOR_ID_NETRONOME		0x19ee
-#define PCI_DEVICE_ID_NETRONOME_NFP3200	0x3200
-#define PCI_DEVICE_ID_NETRONOME_NFP3240	0x3240
 #define PCI_DEVICE_ID_NETRONOME_NFP4000	0x4000
 #define PCI_DEVICE_ID_NETRONOME_NFP5000	0x5000
 #define PCI_DEVICE_ID_NETRONOME_NFP6000	0x6000
-- 
2.25.1



