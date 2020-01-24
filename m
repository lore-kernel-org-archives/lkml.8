Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7F8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7C12075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863829;
	bh=NkNf3aHS1upQgjgQ3AQuK+g2qELN1J0voucf72zHYP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wv0VSAYbhYEGxB7GRazxZciqekwfh6d6Xj4zhIR2dHiNsmey34jGjbTwgQEix9jb4
	 mFrOW66mhgvpV7FCjDnnC8S1oNsrWWiV8/rJ7r59f7PzIKod8+XFohKbwkYX+rTajw
	 OoZEfzoC8KLiVK6nOMsDd3LtpiTy6d24VjZpJQwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388421AbgAXLDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:03:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388348AbgAXLDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:03:44 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C408A2075D;
        Fri, 24 Jan 2020 11:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863823;
        bh=NkNf3aHS1upQgjgQ3AQuK+g2qELN1J0voucf72zHYP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZqfWgq5sHdcao5dxlEz6Q+DwF5/htfguXx8Z7wX3XKDaY7lR8BPaSSfSjBstu6Qcm
         guXV0WiFwCM3yFollBbr8129S56MD6unljhTWdlnDCqqccwaVvK8E0AO/8vRCm5p4x
         kBUdqWY5BJnGWgVRp5Dx7iXjHMFrLewym/uH1cqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 085/639] pinctrl: sh-pfc: r8a7740: Add missing REF125CK pin to gether_gmii group
Date:   Fri, 24 Jan 2020 10:24:15 +0100
Message-Id: <20200124093058.007745874@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 1ebc589a7786f17f97b9e87b44e0fb4d0290d8f8 ]

The gether_gmii_mux[] array contains the REF125CK pin mark, but the
gether_gmii_pins[] array lacks the corresponding pin number.

Fixes: bae11d30d0cafdc5 ("sh-pfc: r8a7740: Add GETHER pin groups and functions")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 35f436bcb8491..d8077065636e3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -1982,7 +1982,7 @@ static const unsigned int gether_gmii_pins[] = {
 	 */
 	185, 186, 187, 188, 189, 190, 191, 192, 174, 161, 204,
 	171, 170, 169, 168, 167, 166, 173, 172, 176, 184, 183, 203,
-	205, 163, 206, 207,
+	205, 163, 206, 207, 158,
 };
 static const unsigned int gether_gmii_mux[] = {
 	ET_ERXD0_MARK, ET_ERXD1_MARK, ET_ERXD2_MARK, ET_ERXD3_MARK,
-- 
2.20.1



