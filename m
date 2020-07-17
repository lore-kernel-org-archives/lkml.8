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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69574C433F8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 410D2207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPOJ3+uL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgGQS6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgGQS6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:58:39 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B64C0619D2;
        Fri, 17 Jul 2020 11:58:39 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z63so9698583qkb.8;
        Fri, 17 Jul 2020 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bl/fvzezwaxFPDiXZ3cXYB7DzCuwr8VAt2yMojE7WHs=;
        b=jPOJ3+uLv6KWv3SC6T+IuCn7eApGSFc3wsAIKwrP6pXdCXefqzkV21fE1CQcoyFChN
         lMg1xevHQ1MPZ4RvfIMcCIlzSA1Xxc3bc3kuQfJ9102Trhw/PPWKrUebOwKlzNp+u75x
         5tj1cPa7WOgP60xio/FGtv2ekelvLERMg1vxn7CkUfty1DCKu09xKeOG2itdSXbJdZhg
         y8Rm8iLdVVN4rvbvPfZXoYXqfzNddw1xQsqa7eRh7qVqZaol76wIcY72ywKWv0yvX3eJ
         8xGJQ5hexe8GuMxqhy+udvBau1rkYQxD7h8FiWsg//ZarPfOT1KzgD9mxZ1idM0NzgeU
         +NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bl/fvzezwaxFPDiXZ3cXYB7DzCuwr8VAt2yMojE7WHs=;
        b=AEvLXv/IwIaP1z/WyYgRvqb9lS7bRSAV316KPNbgRP94DyneP9Ml4i/w1jKA+Vxxoa
         n7vp9MXo6QYsO8ezjWWEAEodp5SdCLEYElBbpI570jQwp8D917w6nkLCAi5zg0YNPBzG
         CgSmN37YWpQx8URjJO3+pQqdqXoUEnqRAH3XcwFakZBqa0xj2X1zZmMoHZSancb/QEqB
         GlHRkDhScjE6L6M7MxOzyQPlF4s71AAcVNrxmgvjZfOjDDJRS6layxLIiATcZ3hI2Yft
         N7a2YvAVnaU3BRMV5WqFAhhWn5aJ3pC3hzpIpKAUZ+Fd7m+onIibGCdnXUyoT/G+AFMr
         S1rw==
X-Gm-Message-State: AOAM532SR3ut06TAZzw7Fr9eD5AYgcgBW72G3eTBYC1bcLZd0ODh+0EP
        YBhbeZhNBfxp/dfz7MvVFwizKoXkaD0=
X-Google-Smtp-Source: ABdhPJzpZDbgS3IY1hTF9DI2PPrTfOCzipBAb43snNr9nwONUlmXBkfOLe60JxNEuLI9RnEi/kVoJw==
X-Received: by 2002:a37:e217:: with SMTP id g23mr10641710qki.108.1595012318450;
        Fri, 17 Jul 2020 11:58:38 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:58:37 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/25] Documentation/index.rst: Add watch_queue
Date:   Fri, 17 Jul 2020 15:56:24 -0300
Message-Id: <20200717185624.2009393-25-dwlsalmeida@gmail.com>
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

Fix the following sphinx warning:

Documentation/watch_queue.rst:
WARNING: document isn't included in any toctree

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 3b491af0122de..57719744774c2 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -193,6 +193,7 @@ to ReStructured Text format, or are simply too old.
    :maxdepth: 2
 
    staging/index
+   watch_queue
 
 
 Translations
-- 
2.27.0

