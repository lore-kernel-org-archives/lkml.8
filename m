Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFA6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B463320775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JEfhTPR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgGHM5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgGHM5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:57:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D059C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:57:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so2962576wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WrHdVRqRuRzC2abNzBBxH5yo5qIXqK+aQJ6bXP1i/X0=;
        b=JEfhTPR+SeGpNUZCQBqGTXEMSFZdQ+gWZEn3XHTU/fpv2HpTquONCtKChbFfgifByL
         ZpnpH5Forh28LFkwh15KhIDutLJnQ5BblB5H/ybvUyUdHIRPyuTJR+bmQCFNqQLJbut+
         h7Nujgamkoy56q2Am9XCTe7V3nwdw7tcFl9iRwwvI91/Ah2nhshTl/yWNie1an/MKmPg
         7RvXjYZXq7oQrU6Rjx8Ydq9M1iIFGNsQ4pK3JoZW/7/7hdUn+yXQgvI1wUzVtean7TwN
         qCoRJ35Layh188P3yYyjVFXjVBA1Ip1QKNq0FBrbAE8Hu2CxPz9dqrQPGSZ+apEto5uu
         V6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WrHdVRqRuRzC2abNzBBxH5yo5qIXqK+aQJ6bXP1i/X0=;
        b=LCWh/lz84+9ZNA43nucWPdmh4rfLwp9dxJAr+cfrxJGfudEyZYPjkvpvKXMR/Ps+Ej
         tGY3/aeNCQZCeoKwN/PC3V7daelCJttoQOuj0VsvH0CMYgFSEee8pv2xT6fPsmjabAeM
         dVUkwZFFkgzrVWvifZdEL3tghaT21aofBHVI/mo5g4faXMbHYPl1uWN4A4IRXd7Z9sqJ
         QdTrVR4LgdmgY5W5VripafiYwY93k0XowLPZ35SI2eP/xxxc49JckcrRoS4qO007Ovl2
         sR3yqGkMXHdJLBfX4vzdaESOq69/UPv7wE2gvGq9wAYdZU8G0X+nHXONYN9SWHL+dBc7
         c4gA==
X-Gm-Message-State: AOAM532ky36NGAJk/KMmYZm+RLQ83td+dYVwQ944HPJBc33noloY9xz9
        Nr0OnTnNW7B3adUTL/AupmdJcQ==
X-Google-Smtp-Source: ABdhPJwnfRCg9b8rxaxicn5qfwqD8rz9EKtTkbXl7E6D2qxyWvN1ik7U0zOV/Sll7PL39butZi9sHA==
X-Received: by 2002:a05:600c:281:: with SMTP id 1mr9461187wmk.143.1594213034863;
        Wed, 08 Jul 2020 05:57:14 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v9sm6993885wri.3.2020.07.08.05.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:57:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        George Zhang <georgezhang@vmware.com>
Subject: [PATCH 1/3] misc: vmw_vmci_defs: Mark 'struct vmci_handle VMCI_ANON_SRC_HANDLE' as __maybe_unused
Date:   Wed,  8 Jul 2020 13:57:09 +0100
Message-Id: <20200708125711.3443569-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708125711.3443569-1-lee.jones@linaro.org>
References: <20200708125711.3443569-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmw_vmci_defs.h is included by multiple source files.  Some of which
do not make use of 'struct vmci_handle VMCI_ANON_SRC_HANDLE' rendering
it unused.  Ensure the compiler knows that this is in fact intentional
by marking it as __maybe_unused.  This fixes the following W=1 warnings:

 In file included from drivers/misc/vmw_vmci/vmci_context.c:8:
 include/linux/vmw_vmci_defs.h:162:33: warning: ‘VMCI_ANON_SRC_HANDLE’ defined but not used [-Wunused-const-variable=]
 162 | static const struct vmci_handle VMCI_ANON_SRC_HANDLE = {
 | ^~~~~~~~~~~~~~~~~~~~
 In file included from drivers/misc/vmw_vmci/vmci_datagram.c:8:
 include/linux/vmw_vmci_defs.h:162:33: warning: ‘VMCI_ANON_SRC_HANDLE’ defined but not used [-Wunused-const-variable=]
 162 | static const struct vmci_handle VMCI_ANON_SRC_HANDLE = {
 | ^~~~~~~~~~~~~~~~~~~~

Cc: George Zhang <georgezhang@vmware.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/vmw_vmci_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index fefb5292403bc..be0afe6f379ba 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -159,7 +159,7 @@ static inline bool vmci_handle_is_invalid(struct vmci_handle h)
  */
 #define VMCI_ANON_SRC_CONTEXT_ID   VMCI_INVALID_ID
 #define VMCI_ANON_SRC_RESOURCE_ID  VMCI_INVALID_ID
-static const struct vmci_handle VMCI_ANON_SRC_HANDLE = {
+static const struct vmci_handle __maybe_unused VMCI_ANON_SRC_HANDLE = {
 	.context = VMCI_ANON_SRC_CONTEXT_ID,
 	.resource = VMCI_ANON_SRC_RESOURCE_ID
 };
-- 
2.25.1

