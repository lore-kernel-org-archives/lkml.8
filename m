Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1136C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5C5205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220193;
	bh=L5b7E28Fmf+Ro7wfsy7cxFoBjNsdh/r3wjnSveHbKRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MUhQ3VpnZohIOfZ183k/ZoQGYsS8urVWUw3hCCDkVc1RLJu7DBtk6JQ7vG4I+BoUw
	 cTr3hACR5SXMYlCaoKE2tqmabRv5wTIVsqCdjRtiGPZQfZU2ANtm5+Ku+WkxKbdYtR
	 CIOV03XruWxqnSiKLmTBL40bcVcBEATNoYVHETCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgA1ODM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:03:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgA1ODK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:03:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1964D24683;
        Tue, 28 Jan 2020 14:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220189;
        bh=L5b7E28Fmf+Ro7wfsy7cxFoBjNsdh/r3wjnSveHbKRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x5Uqg7iTe7PLQ0m4eX5qgjVRvTTdeWR4xdHWB5YzY5mXlFWjYaSoIprmDbQyCIXvW
         oLNfuv2KNZK1AlitkLFcr0+mogQLPq167mL2nM9MCYrgUq0u50oPEVUfScu7U6Fq9P
         2QkI1ZKNJcji3sBWIHzVBiE3TP0xH2DijobpRBFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Boyan Ding <boyan.j.ding@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.4 053/104] pinctrl: sunrisepoint: Add missing Interrupt Status register offset
Date:   Tue, 28 Jan 2020 15:00:14 +0100
Message-Id: <20200128135824.958262197@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135817.238524998@linuxfoundation.org>
References: <20200128135817.238524998@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boyan Ding <boyan.j.ding@gmail.com>

commit 9608ea6c6613ced75b2c41703d99f44e6f8849f1 upstream.

Commit 179e5a6114cc ("pinctrl: intel: Remove default Interrupt Status
offset") removes default interrupt status offset of GPIO controllers,
with previous commits explicitly providing the previously default
offsets. However, the is_offset value in SPTH_COMMUNITY is missing,
preventing related irq from being properly detected and handled.

Fixes: f702e0b93cdb ("pinctrl: sunrisepoint: Provide Interrupt Status register offset")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=205745
Cc: stable@vger.kernel.org
Signed-off-by: Boyan Ding <boyan.j.ding@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/intel/pinctrl-sunrisepoint.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/pinctrl/intel/pinctrl-sunrisepoint.c
+++ b/drivers/pinctrl/intel/pinctrl-sunrisepoint.c
@@ -49,6 +49,7 @@
 		.padown_offset = SPT_PAD_OWN,		\
 		.padcfglock_offset = SPT_PADCFGLOCK,	\
 		.hostown_offset = SPT_HOSTSW_OWN,	\
+		.is_offset = SPT_GPI_IS,		\
 		.ie_offset = SPT_GPI_IE,		\
 		.pin_base = (s),			\
 		.npins = ((e) - (s) + 1),		\


