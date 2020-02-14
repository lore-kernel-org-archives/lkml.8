Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57018C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D83322314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWbNVN0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389762AbgBNUuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:50:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37961 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388735AbgBNUtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:49:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id a9so12159618wmj.3;
        Fri, 14 Feb 2020 12:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zjr/tAS/dgk7oDUjadfYCF+NEQyK468tvuW7wnQKG8U=;
        b=VWbNVN0F91N2qSv/8jnIESRtqmMHF7ZDVOMvC24P+VkV+Nl3SRxWFa+voUgMJbs7Dj
         A1mDe01tt73aEE2XgktVL2ZND5MkulpHKO0/gqVrVk+fMfyw0GyIqNCjZLVxGFgPvMuH
         F52dt4WELzfGpeeypnkZCCXVHurmZ1fAMQwVXU9tq2Qud4dRn4m+HjzQu68KtTYBPKxt
         +YnqQgzc6Dq927MCleyAYgJN++w37b6iLrIECNmbewSALNygJPEqMET/gODZIvIDvLRg
         9dTRJvkBgAAN/ar2PEnCYTYj720XxkX5NneE72MuF5fmf7AcBzRh2LMA5g9QGgiZOasj
         u1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjr/tAS/dgk7oDUjadfYCF+NEQyK468tvuW7wnQKG8U=;
        b=Lj4cyzYkkgi4UjhlwLJRbrJU2S6NTJ/Cou0x85Wj6X/iva1hFTdMaoFcsX+/R+v/N0
         s7g7VH/QSgO1mDYSwDmVEdiFHivmuYJILauda5o4s6/O5sohDH/iOVs1Gdbp/IpfSi79
         YtdiAMnUeMt770b/XDxT/ehUhyyMS8k3B4jR5PMWJzHioJ6ZNAFaL6KJmaUTChDUgbCG
         uiLUYFvZVSeSVY2b4lqv4J7jqmVvo1V+WURkEMgKCJkdU1ni2t5t0uhZS3LOCqjT+mGg
         kuQmCM/ZB284+4XU+3RGerreFM0GSL1NwLkcUZJLIgyK9wTAisGh04zzoSTrEFtpcFKc
         KQzg==
X-Gm-Message-State: APjAAAVhPF1LKtpTe4btbxmwEffm4ltcahu1lnhi18KMmFGRa0ZDpggh
        vZnNsY9Nx5JpMzH9WRTU6eecFamPv2X7
X-Google-Smtp-Source: APXvYqyvt2QDlppNdFVmPopWYo5J3xPion0fEQF7Dj+WIJ6w11bxpma/l+Et2njgAB0d09gk+nPcQw==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr6359861wmk.15.1581713339230;
        Fri, 14 Feb 2020 12:48:59 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:58 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB XHCI DRIVER)
Subject: [PATCH 23/30] xhci: Add missing annotation for xhci_enter_test_mode
Date:   Fri, 14 Feb 2020 20:47:34 +0000
Message-Id: <20200214204741.94112-24-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at xhci_enter_test_mode()

warning: context imbalance in  xhci_enter_test_mode - unexpected unlock

The root cause is the missing annotation at xhci_enter_test_mode()
Add the missing __must_hold(&xhci->lock) annotattion

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/usb/host/xhci-hub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 57e3f2c5475a..38839308557e 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -609,6 +609,7 @@ static void xhci_port_set_test_mode(struct xhci_hcd *xhci,
 
 static int xhci_enter_test_mode(struct xhci_hcd *xhci,
 				u16 test_mode, u16 wIndex, unsigned long *flags)
+	__must_hold(&xhci->lock)
 {
 	int i, retval;
 
-- 
2.24.1

