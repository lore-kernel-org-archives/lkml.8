Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBECC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8B920873
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVYR9gRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCCFDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 00:03:31 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:38185 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgCCFDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 00:03:31 -0500
Received: by mail-pj1-f42.google.com with SMTP id a16so783081pju.3;
        Mon, 02 Mar 2020 21:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N/iUS9xlwhnRwn8ycV3kyYeyWXGgYeSILX+l2MBUv2c=;
        b=pVYR9gRXdunMZ2xCOqSGRxL/S4cyc6o/in4nF/Kqz47Oe1Yv4+C22w0qIDZXbMDgMr
         QmFda8Vv0CRHHgeYaDJWwLw2EmOBncDN0JV69c/iErEUpRhLfU6sf5QbJCKAFozqnb2x
         N7WRrlQExOYxIlPmNDdCMVKfLP8lh9x5sSxDFLDStVNjLPOM9ZkSo7AIpcwSnyhrEiuV
         0hQ7NTBkCLbt9FA6AaUGVjpx+jbLkn7/sGe/Kus9lHXajgBHSCBSGhRl/xIAPncgxj5d
         sCufOxY7WmTEO7Spb9MwKPa6K2alHw2uOEaL+7jtoHd5WOoRaZNah3+m4WAdQHfeEFuE
         CgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N/iUS9xlwhnRwn8ycV3kyYeyWXGgYeSILX+l2MBUv2c=;
        b=SxSSXMUQyGq/f45vPexsOxPrzi9PU/LG5P2J7q3X5WxSd7MOflHrkdhvOXhyqR1Umf
         grYRDoXlBzeZMMnDq8p+o7ooTPyrEbgHe3UVvOAkC56TwVFA9PeCfE9cn6P+Fk50vVSO
         JxD+JUDvLfbs0Jd5adqpjyg5Wt/gpsCc1ShN8UcLVMuYYdvlNl8SXu24rf1Ohi91phl2
         yChhwjvNtIQDCyv0Parke7ntwVGQITioErd0WjAD4rvfEuxzquwWCflUu89tqaVV0QMF
         H70fBdIEy5ua3DS8Siy0ceGDhe8pCliYUSiR5o8oS3FHtY2qAZz3vAFUKkvLgSxsBm11
         /cdQ==
X-Gm-Message-State: ANhLgQ2M3i6SS0gnj4gg/Nb4NwTJyHoEgWecvpO70JEow4W0exRO9eWJ
        7flhsKi0TDHMVwFn3TUxYEw=
X-Google-Smtp-Source: ADFU+vsStuckLpVn2CMO8otbm7LSh6nbqTchYUDl9xj5VPs6RCRr+PtrOezcRY96gHAGgqMRWvC5hw==
X-Received: by 2002:a17:90a:678e:: with SMTP id o14mr2235635pjj.24.1583211809750;
        Mon, 02 Mar 2020 21:03:29 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c8aa:e481:f8d3:6de2:77f9:5602])
        by smtp.gmail.com with ESMTPSA id b2sm780446pjc.40.2020.03.02.21.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 21:03:29 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v3 2/2] Documentation: Add io_ordering.rst to driver-api manual
Date:   Tue,  3 Mar 2020 10:33:01 +0530
Message-Id: <20200303050301.5412-3-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303050301.5412-1-pragat.pandya@gmail.com>
References: <20200302114300.34875f69@lwn.net>
 <20200303050301.5412-1-pragat.pandya@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add io_ordering.rst under Documentation/driver-api and reference it from
the Sphinx TOC Tree present in Documentation/driver-api/index.rst

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 Documentation/driver-api/index.rst                            | 1 +
 Documentation/{io_ordering.txt => driver-api/io_ordering.rst} | 0
 2 files changed, 1 insertion(+)
 rename Documentation/{io_ordering.txt => driver-api/io_ordering.rst} (100%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index e9da95004632..9335412e3832 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -80,6 +80,7 @@ available subsections can be seen below.
    isa
    isapnp
    io-mapping
+   io_ordering
    generic-counter
    lightnvm-pblk
    memory-devices/index
diff --git a/Documentation/io_ordering.txt b/Documentation/driver-api/io_ordering.rst
similarity index 100%
rename from Documentation/io_ordering.txt
rename to Documentation/driver-api/io_ordering.rst
-- 
2.17.1

