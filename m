Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58FBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B025F20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590601413;
	bh=g3K+YeZ1yYJxyeiZYfgVMKP3rgbKk0R7FZQrOzGYFD4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Q22YuvLbwwyrE/COiS2pAj4LRBIYlEDjA2OImjzieEdoSdhOlotbhs0zIWvGl4LGk
	 6U8BrgYxGOVkLmAB7aA2s1cQEfvj/7zXYst/5LtP1aQW6olGqD7vrRQvquBJEkn++L
	 8S/7ykvZNbPPsEs+qAC0UzZ1LHS9xUwq82siMr0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388724AbgE0Rnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:43:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387564AbgE0Rnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:43:32 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C628B20663;
        Wed, 27 May 2020 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590601412;
        bh=g3K+YeZ1yYJxyeiZYfgVMKP3rgbKk0R7FZQrOzGYFD4=;
        h=From:To:Cc:Subject:Date:From;
        b=JMWwka5vNpbNGWnUUgtimzSN0G8Pvb5P/VTBVcE7vDaIMLZWSEFxt4+jVAomle1UR
         QaZ7Ig7WnzizcmKoBp2qZ+EAKlmGgcPaKhzeJPEPoQNUCrAe7vLoAMfpJ0g8wLPkyv
         Kf2ABixKI9pZl67nVgy2SLj51DIdykhx0R+T+qPY=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] xen: Use dev_printk() when possible
Date:   Wed, 27 May 2020 12:43:24 -0500
Message-Id: <20200527174326.254329-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use dev_printk() when possible to include device and driver information in
the conventional format.

Bjorn Helgaas (2):
  xen-pciback: Use dev_printk() when possible
  xenbus: Use dev_printk() when possible

 drivers/xen/xen-pciback/conf_space.c        | 16 +++++----
 drivers/xen/xen-pciback/conf_space_header.c | 40 +++++++++------------
 drivers/xen/xen-pciback/conf_space_quirks.c |  6 ++--
 drivers/xen/xen-pciback/pci_stub.c          | 38 +++++++++-----------
 drivers/xen/xen-pciback/pciback_ops.c       | 38 ++++++++------------
 drivers/xen/xen-pciback/vpci.c              | 10 +++---
 drivers/xen/xenbus/xenbus_probe.c           | 11 +++---
 7 files changed, 70 insertions(+), 89 deletions(-)


base-commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
-- 
2.25.1

