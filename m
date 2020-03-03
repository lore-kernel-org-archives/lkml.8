Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA2BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC002146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257775;
	bh=FnzoUfbU4XGvURm4/EiVNcLjZo35WEklWlICANhp3AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KZqU5jzEZ+yJQQn7VmzY0afVoxThLK5p4J9lIYUT5XBKS2gdysgwRKg6d/0T5tsxo
	 GqMd+IWvtijch8byuX0HB+T9qwB/6KVs+7A7sjzCRCziQktlMHpSuaxSguUUfdPCIg
	 qz9H7ffSEeVh8LIqyQagqHX11o4U4zU46fdKtk3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbgCCRte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:49:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730834AbgCCRtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:49:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C9B82146E;
        Tue,  3 Mar 2020 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257770;
        bh=FnzoUfbU4XGvURm4/EiVNcLjZo35WEklWlICANhp3AI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdgYHvnVLSGqWePtYzf7X7Q4UVPe9wbqw3bSNy++lDPF8eYBnl8pOmvkBkyaVLJom
         D4NeMWcAxOyb0PiELhasPM+Yx9WSb2BtuSYJM7XqD2wtooCIjEkuX+Ub0Fm6HhGQRD
         DQDwRMkksCoYEI+C1bKRZ8zzjjtou2QTM4fQQOsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 122/176] usb: charger: assign specific number for enum value
Date:   Tue,  3 Mar 2020 18:43:06 +0100
Message-Id: <20200303174318.913165621@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
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


