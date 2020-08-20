Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B9CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF00207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597927891;
	bh=hrY0NhL1R5l5ToViiwDTlNThpTbAJifen/N2VMBxI74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SgYhdP6lwD7ZuWnDDrsQObbeGSE8e77CB44BV49u3pJakqasrsNJUohotqMRp8STH
	 rmssL2JXmMJovPzt0ho6StRAahzGcI7rWRdPJ9I+XPOpnZ3RwvcwieUr5sGI+9PKMi
	 d5ctlkgOZcKI9DpR5a3c8i7RSjzx82MEYzyH4JwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgHTMv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbgHTJoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:44:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2720B2224D;
        Thu, 20 Aug 2020 09:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916640;
        bh=hrY0NhL1R5l5ToViiwDTlNThpTbAJifen/N2VMBxI74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dv4dBGD6GDlwGWoLPPiYWQofeK7ybLH3NqHtUemPsP8MQaEd3/BF++DU3ixLECART
         /4mZQx4uVImbDDLhqZbOpEXTDkjxDwxWGwwsfzOxLSAXE53j1I90d3fMS8tCPYVFIb
         /HjR8FKBo4TO104GXQLVPmzetgTtXi4DynC7e0H0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marius Iacob <themariusus@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 5.7 200/204] drm: Added orientation quirk for ASUS tablet model T103HAF
Date:   Thu, 20 Aug 2020 11:21:37 +0200
Message-Id: <20200820091616.173932256@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Iacob <themariusus@gmail.com>

commit b5ac98cbb8e5e30c34ebc837d1e5a3982d2b5f5c upstream.

Signed-off-by: Marius Iacob <themariusus@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20200801123445.1514567-1-themariusus@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_panel_orientation_quirks.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -121,6 +121,12 @@ static const struct dmi_system_id orient
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T101HA"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* Asus T103HAF */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T103HAF"),
+		},
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/* GPD MicroPC (generic strings, also match on bios date) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Default string"),


