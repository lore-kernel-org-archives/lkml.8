Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD70C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784A6207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DF62PKG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgG2Vnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgG2Vni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:43:38 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCD2C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:43:37 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so15202224pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VbVXehIaTj8YaGbM3QRDkpcQWUuuD2sDylw5SpuvrVk=;
        b=DF62PKG3r228xH5xPlBlCS+CLV+oT0EtEV+MbIIfDon6ena/cJ/7dr/9Do+J5pEhYI
         ufUla8BtLmEnX8DiRCOLznm5sBn+WZvxDAj2q2OVM1GcOOm8RKbJVXvKwDnYTQ2gHQil
         Ykdk594sg4dxAjMP60+cregaSujyPMSoP7Mtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VbVXehIaTj8YaGbM3QRDkpcQWUuuD2sDylw5SpuvrVk=;
        b=J7phY7k+/qafxONR87UNiMq5dGmtu//wfjkZ6NHrYD22wXwAfFpfTnFKMEN52+GpHG
         En2nlvqgJTD0t59eZac+lWiq7dQI43jy8Tx5ECtBSoNDW1XkXldxp2XwwJlkpdPfGLam
         p0Dzjwfko1T4nrAogaQOiFDjsP1YkkxGjaE9Sw9MURt8ZYqxinahmYeuaXepZ2WEsiZQ
         ft5sTaleydH43QoBS9QLDqjtKgllirs9YL8ozQjJobevcMnh/U9DCKCisYnCcTq9WtmL
         LY4cgcpU1pSGq48KFm2CI8UV+wQrc9fTYN5M9f+YdSM9iTW9VqIOqMOg581ahVl8eHBL
         WFYw==
X-Gm-Message-State: AOAM533rFiSK2heiYpncXhHzzPlkm2bhT5aRRWqfDnEcKiu5WR4fnfSd
        yPq+q1IG5s4kelUjawtJalFAZw==
X-Google-Smtp-Source: ABdhPJxom5BvWuDI010XDIOBiziKJwmxn3rEKc8q8T3Bz3CsBn4Wdsnr90tO/VEFCq6SpoZ2XBT13Q==
X-Received: by 2002:a65:64c7:: with SMTP id t7mr29866416pgv.89.1596059017419;
        Wed, 29 Jul 2020 14:43:37 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b82sm3547527pfb.215.2020.07.29.14.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 14:43:36 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 3/3] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Wed, 29 Jul 2020 14:43:21 -0700
Message-Id: <20200729214321.11148-4-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729214321.11148-1-scott.branden@broadcom.com>
References: <20200729214321.11148-1-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f0569cf304ca..10e4e286baeb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3658,6 +3658,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VK DRIVER
+M:	Scott Branden <scott.branden@broadcom.com>
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Supported
+F:	drivers/misc/bcm-vk/
+F:	include/uapi/linux/misc/bcm_vk.h
+
 BROCADE BFA FC SCSI DRIVER
 M:	Anil Gurumurthy <anil.gurumurthy@qlogic.com>
 M:	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
-- 
2.17.1

