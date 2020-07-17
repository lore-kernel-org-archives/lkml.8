Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E525C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57F220704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMiS0Euj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgGQS62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgGQS60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:58:26 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2364C0619D2;
        Fri, 17 Jul 2020 11:58:25 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so8433648qtg.4;
        Fri, 17 Jul 2020 11:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hBvIeKpc8mQa1QNo2CbdpaGmkT6vXPu7c1HQXieSSXY=;
        b=SMiS0EujTMQ0Ssy/m4KNAWglXKPR0SZriQTAmjQ61spo+D+NvNVej1THZ3VdFP3nuE
         wofL+Oe1hqyEj4bQiAPEHhj5RKiBUGyKHQkGGNx42wwXwv+XMc+09AEAh89H0OMhVdpP
         /vO+AHv0vTXrytJTqT3VZX5rmfjWrX0085ic6HJoNZixgCFv1NVcieC9ydpCnLhAbZVh
         4NkkShkQjkOKwNITN21jWoAFR9f/Wei6bAsX7hDAAO88sY4hU132xQkpvpWB+VYScXWk
         ydE2qDnzGE3Ba7ncB4NYM4WC453DhTa0SaWyKa3aFsMlNIcLC3k9YW/l+AmBQCTiJoqN
         wVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hBvIeKpc8mQa1QNo2CbdpaGmkT6vXPu7c1HQXieSSXY=;
        b=bDMCb3CJzl9Jc0H3nyddaw3HrcJ35w8SeXi2hyWZbsGtIcuOQ5GwnRGkzP6rjL/NW7
         6FpNMIw1cPNmiZrMd8SyulBmHe0X49GuzzfWSCVV9dNqR8xw5E9A50sa6WhqzuBYZ6eO
         3eSlXtcYEm+rUns83weEgjxFxWA/5R+UHL3mSefQ4ICqSaQXNjzpZ5RY5zk734U4BTUf
         77AZlziY31GyNL+YcDXs4adhxKH/XBdzKCe6zgBgifPfNCa7NLeaVUSsPnvhu4HYuRFt
         5qO3QqlY+MkjdE/aCL42jy/5zO4pMBs3ALSDT101H8GIVw94meO1ZMSzj29huuSyEdhc
         nRvg==
X-Gm-Message-State: AOAM532SXo76Xd3RO/PJ+vPmVkBZQIXTc83ZMZfSL65/uCw3Stfc83lU
        LACxlSmzxBF5Ng4Z4kaLgwU=
X-Google-Smtp-Source: ABdhPJyhBMF4LSQmiZCEmGWxdnr62yr0g/ZwxvcSlizxDuSYW7wkaMmnYRwpPhRkTMO2nGQlEdyRfQ==
X-Received: by 2002:ac8:4419:: with SMTP id j25mr12576200qtn.0.1595012305095;
        Fri, 17 Jul 2020 11:58:25 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:58:24 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/25] Documentation/admin-guide/index.rst: fix sphinx warning
Date:   Fri, 17 Jul 2020 15:56:20 -0300
Message-Id: <20200717185624.2009393-21-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warning:

Documentation/admin-guide/pstore-blk.rst:
WARNING: document isn't included in any toctree

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 58c7f9fc2396c..ed1cf94ea50c2 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -41,6 +41,7 @@ problems and bugs in particular.
    init
    kdump/index
    perf/index
+   pstore-blk
 
 This is the beginning of a section with information of interest to
 application developers.  Documents covering various aspects of the kernel
-- 
2.27.0

