Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C76C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A904D206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JROVTSMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388409AbgF3Nv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388313AbgF3NvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5507C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:22 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so18190993wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xbSUqKBCxymsC6lBBef3Qyn0QkDTIAKXJyfnYrQoXC8=;
        b=JROVTSMxcYpya04e8YJ8NvbOL9s6Y8mdWsTPgTWrjU6LHmLpBqI+RWcUkPq3iU12Ce
         Oh+Byu/dqxO3e7TDVyj21qrQM80IuHA9vi8gT+czeAw1IWM5YBrS1FjDXkUkeNGpb8n7
         0inwVFXMPKT5ghvUXxvbM3OAEBSbZHRjzhzoV8JDCRs+tFLRv3Ky7RDB+6PglnHeMFpo
         9n4VRksZq8uKFBm3VX8GA8J/ivxO+xegMzjP84WffpO7u/NoT6bFy73L5ljK2jAry31O
         BOKtaDEWKMnua+idVaSdZsHXOC0ejVXpf2SeDpzPJ5molGB5WIftQn0uGLBaqVmDfG/D
         fidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbSUqKBCxymsC6lBBef3Qyn0QkDTIAKXJyfnYrQoXC8=;
        b=pPOstOrSRYFCzfeoehzDJgQQOA4rzn35l1FRNzj16RvwgjU/6gTRG79yQ1FVO7TYjM
         bc86AW3LyWZ+rSvsXtLVipTsBV3jHu+9Ax65GdE1taBVSMFBauLyETqnA2YCeKssJBDG
         PuSupAArqhYGF7QQu6zeiD3TLkodBhVEe5IZx8zB1Rtha69fdgj8S4TdSL1CT+ztoMz0
         NgnlCLpaUsf2UwNEkviiwp1S/ukxY4Exgx7nNEFHQk9Z3rEmqA11m47vREZ0IsFvGSYJ
         L90MgrWnfcV9VCKM+qU/kfjpL3PNbbm99Bo4K5jTG+uRV5GRojp8oimYF6dr5dsvOSrR
         Md/Q==
X-Gm-Message-State: AOAM5333Yel6XuQpXjBipYqdALKYIIYlndmau23ua33H7QQMLHx7NNwS
        uCLJDYtR1Hh/hNXaWjNDeJj7RxQzq7M=
X-Google-Smtp-Source: ABdhPJw0jWJJPA9KNfsgcxxlrnj5t8iBR+bMqFMhI7nW9X7rHQGhd1hfd2q0Q1rm2llFxBbChW9waA==
X-Received: by 2002:a1c:e285:: with SMTP id z127mr21764312wmg.162.1593525081517;
        Tue, 30 Jun 2020 06:51:21 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        George Zhang <georgezhang@vmware.com>
Subject: [PATCH 07/30] misc: vmw_vmci_defs: 'struct vmci_handle VMCI_ANON_SRC_HANDLE' cannot be static
Date:   Tue, 30 Jun 2020 14:50:47 +0100
Message-Id: <20200630135110.2236389-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header file is included into source files which do not make
use to 'struct vmci_handle VMCI_ANON_SRC_HANDLE' which results in
the following W=1 warnings:

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
index fefb5292403bc..0374dd3cda3df 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -159,7 +159,7 @@ static inline bool vmci_handle_is_invalid(struct vmci_handle h)
  */
 #define VMCI_ANON_SRC_CONTEXT_ID   VMCI_INVALID_ID
 #define VMCI_ANON_SRC_RESOURCE_ID  VMCI_INVALID_ID
-static const struct vmci_handle VMCI_ANON_SRC_HANDLE = {
+const struct vmci_handle VMCI_ANON_SRC_HANDLE = {
 	.context = VMCI_ANON_SRC_CONTEXT_ID,
 	.resource = VMCI_ANON_SRC_RESOURCE_ID
 };
-- 
2.25.1

