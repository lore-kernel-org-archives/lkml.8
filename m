Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D634C18E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5268020873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845659;
	bh=FnzoUfbU4XGvURm4/EiVNcLjZo35WEklWlICANhp3AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RgjjrPxdo3sjGzepjB4A4cec+DujkKnM4LjbFzdPOvh9HmQt3T+dmVAnvhM9iulWe
	 9XkqQqB2dF3tOZ7JtdyXhTij18arewV1DylZ79e7tdgEALd5wG+S5Yfvbf+IdnuNgc
	 oBB070IdWDRtf1fG14bYqmfm0tUUIPIdfbBp4NU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbgCJNHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbgCJNHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:07:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28F8F24691;
        Tue, 10 Mar 2020 13:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845652;
        bh=FnzoUfbU4XGvURm4/EiVNcLjZo35WEklWlICANhp3AI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FZc/iy8JPh4AFJdppVSMLaaahorL9mfrmaE0SVjU9FR7d3a/pOQUCvh2hr/s8ouXA
         6IdYjiKe5MKdK6pa3K99pbJiqsG+S2kBwLbCU/uXWqo6pHNzyNciE80EJqbMvGbbHV
         euyYGp3tH5TtNo3m9koLfJUXkTxo/K5M/Ks7R0rA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 049/126] usb: charger: assign specific number for enum value
Date:   Tue, 10 Mar 2020 13:41:10 +0100
Message-Id: <20200310124207.390396773@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
References: <20200310124203.704193207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Chen <peter.chen@nxp.com>

commit ca4b43c14cd88d28cfc6467d2fa075aad6818f1d upstream.

To work properly on every architectures and compilers, the enum value
needs to be specific numbers.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Link: https://lore.kernel.org/r/1580537624-10179-1-git-send-email-peter.chen@nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/usb/charger.h |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/include/uapi/linux/usb/charger.h
+++ b/include/uapi/linux/usb/charger.h
@@ -14,18 +14,18 @@
  * ACA (Accessory Charger Adapters)
  */
 enum usb_charger_type {
-	UNKNOWN_TYPE,
-	SDP_TYPE,
-	DCP_TYPE,
-	CDP_TYPE,
-	ACA_TYPE,
+	UNKNOWN_TYPE = 0,
+	SDP_TYPE = 1,
+	DCP_TYPE = 2,
+	CDP_TYPE = 3,
+	ACA_TYPE = 4,
 };
 
 /* USB charger state */
 enum usb_charger_state {
-	USB_CHARGER_DEFAULT,
-	USB_CHARGER_PRESENT,
-	USB_CHARGER_ABSENT,
+	USB_CHARGER_DEFAULT = 0,
+	USB_CHARGER_PRESENT = 1,
+	USB_CHARGER_ABSENT = 2,
 };
 
 #endif /* _UAPI__LINUX_USB_CHARGER_H */


