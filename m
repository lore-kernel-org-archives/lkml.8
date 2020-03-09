Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ACEC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB31024692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wnc8fYr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgCIQSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:18:06 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33925 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgCIQSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:18:03 -0400
Received: by mail-pj1-f67.google.com with SMTP id 39so113836pjo.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/h8DNnukgi/i/4uI4UrYhVF/plnr6/iBW/VDVCb89d4=;
        b=Wnc8fYr3jeH0yzUL6wuPybRSTLkPM2ILTBT3LIJ1mdu+VXi975OoCJIljkYL2QOZJ9
         8b7paZ8nRHV8cscGIonJsvSD64cjOVKBIHEOY90yVjZKBSgqF1iKz/ub5moQVDO3nDOj
         mSJQE3hZVU0DBr0ghSJ7By6MpIKl+/n0Qx2sltHkv/ft+u8Hsp6H/pNNXE7lfvTbVZmk
         BCMvPVDr/Y6RpJxJQxtKSxCzNsKLqSpS5k7a9fGwZJGLaTWYge+u1U3RgN//V3HuqaG6
         jFvp9UWYQv/WtU/CRI7sQRZABxXs/8n35RMv6SLtRVTge5iNuXMvj+GHNZFYpZMvqg1I
         ZmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/h8DNnukgi/i/4uI4UrYhVF/plnr6/iBW/VDVCb89d4=;
        b=tGr29oE9Eql8VYaZ89JOM9VrryH/UmPoO96067MnWsbP5RMvLUMaFu6/Ig0+jpvbMq
         ryzZLFeF32M/lZBWeSjoWwyZJ2eMbbJejkBQnWREB0MWSEpOq4jUExF/W+aRS2USOUyw
         9dxMyc1x9EKYXM9Ms43FsxUJtKGscnzU1ksMnJMlRFnQs/+OqORkODQ5mhaXQUL8Qe8X
         SwhrGZr5M7MI71MGldOggtqJDWYdBxb7cfF99I2NesUZdNN0z+qczLdl1+sNKpAEMzb0
         Raf2AJ77euuTxkP9T4W6fM8gVSY7eTdTMJq2tZULnJQZlX4+ked8PPf5pEasAOTObmng
         fEUg==
X-Gm-Message-State: ANhLgQ1KNksUK9ERENnBZwyZIEGZagT8Pq/C4szuaM8nGmfEaGGsNq4r
        THhOS8H7ey4EFOEgF9pvxqe+cH5et4M=
X-Google-Smtp-Source: ADFU+vvf+A+UFjrpqzlDMJdlo3HBdRJl2jJu5NsAEArjghaPB2NL+qZHYVZMsmA6y5o9kG/Z4DyScA==
X-Received: by 2002:a17:902:bd94:: with SMTP id q20mr5853060pls.305.1583770682227;
        Mon, 09 Mar 2020 09:18:02 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m11sm38403pjl.18.2020.03.09.09.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 09:18:01 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] Update MAINTAINERS to add reviewer for CoreSight
Date:   Mon,  9 Mar 2020 10:17:47 -0600
Message-Id: <20200309161748.31975-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309161748.31975-1-mathieu.poirier@linaro.org>
References: <20200309161748.31975-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

Added myself as a designated reviewer for the CoreSight infrastructure
at the request of Mathieu Poirier.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5eae6e180174..07934de50a48 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1676,6 +1676,7 @@ F:	arch/arm/mach-ep93xx/micro9.c
 ARM/CORESIGHT FRAMEWORK AND DRIVERS
 M:	Mathieu Poirier <mathieu.poirier@linaro.org>
 R:	Suzuki K Poulose <suzuki.poulose@arm.com>
+R:	Mike Leach <mike.leach@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/hwtracing/coresight/*
-- 
2.20.1

