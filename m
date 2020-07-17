Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1B6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA33020717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgGQMfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:35:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38749 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgGQMfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:35:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id z13so10895104wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 05:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LMlJy6wOrhNkKa4XkVHfxAFVkzL5mhjIxwrUsBxg66M=;
        b=PljGJlo1TYw/Za7hZygG4J0VJiBO1SqYoZVH2BSh+y3BTGaK+szR9T67gNS1teJUTJ
         Cut2w9YfRu++Qg8sM7snwVRjGXLxIw3kVfgTkK/Yi6tAk1O8mD3yHOo2Ie8y+IwB4ZrP
         85amcidb502RftiaYj3KlMBMMyzs9zzEIpXTqoZujNBBuiy/x5Z56l5NloRI1JuxQc4x
         48m1fmlTScwPfC9VTQbsAqSfXt9HadVl7F9Dqt5l8g9QLldua2x9mF3SQQCo3tMxBflO
         iw+WKw8QDU29lkq0gvXJR6cNFrkuRT1//2SFq/GwE/TKuNT9YbtVcOqv0deJwCQuSGVt
         hdlA==
X-Gm-Message-State: AOAM53128DBlmc7jQIecQyWFi/H6tY9eRX7GrlumPFXtq2YuKLwtTvmq
        bOPJKRgeAsT8tAWR62N1CvZGjtvpR4g=
X-Google-Smtp-Source: ABdhPJxamTel4GRbJdczjOpGTMpacyOtEG5oZShOC1IKuAW3y5ywbiax/ApHwj+QU76etivkADss9g==
X-Received: by 2002:a05:6000:1288:: with SMTP id f8mr2158588wrx.62.1594989332416;
        Fri, 17 Jul 2020 05:35:32 -0700 (PDT)
Received: from msft-t490s.fritz.box (host-80-104-32-206.retail.telecomitalia.it. [80.104.32.206])
        by smtp.gmail.com with ESMTPSA id v5sm13348724wmh.12.2020.07.17.05.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 05:35:31 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: update Kconfig description
Date:   Fri, 17 Jul 2020 14:35:27 +0200
Message-Id: <20200717123527.26291-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

nvmem can't be built as module anymore, update its Kconfig description.

Fixes: 2a37ce25d9f2 ("nvmem: disallow modular CONFIG_NVMEM")
Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 drivers/nvmem/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index d7b7f6d688e7..954d3b4a52ab 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -7,9 +7,6 @@ menuconfig NVMEM
 	  This framework is designed to provide a generic interface to NVMEM
 	  from both the Linux Kernel and the userspace.
 
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem_core.
-
 	  If unsure, say no.
 
 if NVMEM
-- 
2.26.2

