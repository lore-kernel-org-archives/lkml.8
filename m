Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB04C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373A0206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJPF4tfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404883AbgFYNTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404740AbgFYNTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:19:14 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD8EC08C5C1;
        Thu, 25 Jun 2020 06:19:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so5525139wmj.2;
        Thu, 25 Jun 2020 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f9FUAM+HjG/LNLfRosbcl3bBMMrLzklOHZMKb4wAc2k=;
        b=jJPF4tfyLUblaZ9xEP9PyVmRFHjEJE28Rm7BBb7ghx7/ryPYyoafyW+SesPePiMMPp
         +M6Q/DyIMOGEnIpflZtDw0Z/JA3PyXN6nyDqebpKNB9nVQwZPZJuYnHkWxx/bW1pUic8
         Ftk18bITSkNaM55FK80qPPzEiHo4POjL/6UY+3hazZxZmdTRmqrK4x3LkUIf4CJ4OUMU
         y4coP1x/G4Hjx3LvpnFt6j05/5bZHnVI5f2udFD2jsQDAGKkhg5vuu0nEyzpRAD2jhfm
         w5RL2IaGy+x71+O1AUag1OogNBtt4rnKylYNpYlSTT/2zxtz2C2wuSPuPr8qCigc3SQO
         MqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9FUAM+HjG/LNLfRosbcl3bBMMrLzklOHZMKb4wAc2k=;
        b=hqN+ZqL9IJiTpWOGTDOfvyAn0HE+5FUKFM/qpYue6/yyTzWUkFLkJ/ownwVUNh/W3t
         UDCm8feAst59Hr3WX0lwgD5JwZroegaMBM4sSUhpDswy7DMG8DckIuipNuAPxJ/r2xgE
         do4siueAz6f/G6op7wR7eFIPnYxLuQiFh3VYHpI2YS1LYgr4yBH3KVhsOuNAZofqo7H7
         O2gaob0clC73PGvNxhcYL18fIbJL5pg6mrUFOAguWL+vlW98Qutmx/oFpEi4YelKEsGD
         aM4zFwCkl6a3GovMva/QiglcGNNOkSXEhGgnKytdr9yMEMmzF4RRrF4LSLLeijWadmZ+
         CGlA==
X-Gm-Message-State: AOAM531L0yqKatmn4QxojOTqEBNo6qzbuHyAsOmCuyFGkKY+8uf3aNn5
        FHpokHct8xPaG/btkWqSrEg=
X-Google-Smtp-Source: ABdhPJydz7UW3IjrP79n4UTVjNFqvxkFq946vQ06ktm3ym/5WufH1QBd//0vsIPtFRo8scssm4Woyw==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr3284619wmt.105.1593091151960;
        Thu, 25 Jun 2020 06:19:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:4cc:a210:8e70:5aff:fe7e:da0a])
        by smtp.gmail.com with ESMTPSA id w128sm68974wmb.19.2020.06.25.06.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 06:19:11 -0700 (PDT)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org
Cc:     Antonio Borneo <borneo.antonio@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usbip: tools: add in man page how to load the client's module
Date:   Thu, 25 Jun 2020 15:17:32 +0200
Message-Id: <2da8fc9e34440c1fa5f9007baaa3921767cdec50.1593090874.git.borneo.antonio@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618000831.1048255-1-borneo.antonio@gmail.com>
References: <20200618000831.1048255-1-borneo.antonio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the man page usbipd.8 already informs the user on which
kernel module has to be used on server side, the man page usbip.8
does not provide any equivalent information on client side.
Also, it could be hard for a newbie to identify the proper usbip
client kernel module, due to the name "vhci-hcd" that has no
immediate assonance with usbip.

Add in usbip.8 the command to add the module vhci-hcd, similarly
as it's already present in usbipd.8 for usbip-host.
While there, rephrase the description of the command "usbip list
--remote=server".

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
--

v1->v2: rephrase the description of command "usbip list ..."
        fix a typo in commit message
---
 tools/usb/usbip/doc/usbip.8 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/usb/usbip/doc/usbip.8 b/tools/usb/usbip/doc/usbip.8
index a6097be25d28..a15d20063b98 100644
--- a/tools/usb/usbip/doc/usbip.8
+++ b/tools/usb/usbip/doc/usbip.8
@@ -83,7 +83,9 @@ List local USB devices.
 .SH EXAMPLES
 
     client:# usbip list --remote=server
-        - List exportable usb devices on the server.
+        - List devices exported by remote server.
+
+    client:# modprobe vhci-hcd
 
     client:# usbip attach --remote=server --busid=1-2
         - Connect the remote USB device.

base-commit: 48778464bb7d346b47157d21ffde2af6b2d39110
-- 
2.27.0

