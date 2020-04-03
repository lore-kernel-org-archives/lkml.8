Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84D7C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90672080C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+Q5xBnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgDCEZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:25:12 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39665 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgDCEZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:25:12 -0400
Received: by mail-pj1-f66.google.com with SMTP id z3so2396644pjr.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 21:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyD2kX0rtGFxJhOxxjgdsGTPUrD/FjXjSvw4eMWluYU=;
        b=I+Q5xBnw6OlNyc1WeYEuiKJUTVH7pscJdTTt0CEbl2LzbrJ9EOwk04CgLOETAycBeQ
         0GyVQ2DWmVk0q5GewcChYtUHbGpq2sr/KkEvTTeZjZ99GSl3oVE6JvDmWhDwOoRGvmdl
         HwBKGy5bBPEL9ZB6jGxhb+k02kWIErPtOdWSmKDH8nRok/kagwYsZGxVIE4MS1O2VyDc
         nyI5qdFNfX4MZMNJQnuvlHqjiol3dLFc7SDOUYIbG25OJs3onxxEG09q5xMyM6LlD0wD
         YFsyfoxiBFCX/BaijsYn8l830uwB5L/C1MAJL0M0D7psWtuGNZwy2sBzuQFIFFPUcABL
         4dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AyD2kX0rtGFxJhOxxjgdsGTPUrD/FjXjSvw4eMWluYU=;
        b=qOWQq6Yq2XN8Uv10ZtztMLUyq/zIrrd3at8+mCVsFIJFekrun2jUriTp992S+Dv18d
         3+Z8jsFeusidXihjRg4CQGC/v1E5ZvmzzPn36CagUrS4/Uy5EzOVMWJeIT/Y8z0Pbcjk
         0ki9LvavgCZyPho438v7snLdVi8pXhVnZtuTHDHQGu41NRPQO1EzwDpaVfVzqufaXrtT
         Ybml09bpiyxHjx+IK2YaFNWrx54bSJHHy9BC1WgTd7BbW/PZ/wLAdGt0mfAEMyXFN9jT
         k+7gQX7mfsu0hQMaSdt5DBQrPVYaKjqB8hGKomAnsyLaTyiVyPyyBwTdwebvw2xk9VEN
         I/rQ==
X-Gm-Message-State: AGi0PubMbb6FdHmFd1l2cHtxNVZ0Oc9kvzn9JTi6W6+0Mj89xIRlpGBb
        atpv7yNvWLOPCy17PUlbMHQ=
X-Google-Smtp-Source: APiQypLUFoTcgC53/RD9U2GcTptF5bIO1QeLIw/HD5iIXFZnYExMi6C3tKHE3v7Uavp2U/mKA1dw5Q==
X-Received: by 2002:a17:902:82c5:: with SMTP id u5mr6320102plz.254.1585887911382;
        Thu, 02 Apr 2020 21:25:11 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id l190sm4760286pfl.212.2020.04.02.21.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 21:25:10 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Julia Lawall <julia.lawall@inria.fr>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH v2] staging: android: ion: Align with parenthesis
Date:   Thu,  2 Apr 2020 21:24:48 -0700
Message-Id: <20200403042448.863689-1-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align two different lines of arguments with the parenthesis
of their respected function definitions. Fix style warnings
of matching alignment.

Reported by checkpatch.

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
v2: Change comment title and summary
    Suggested-by: Julia Lawall <julia.lawall@inria.fr>

 drivers/staging/android/ion/ion_page_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index f85ec5b16b65..0198b886d906 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -37,7 +37,7 @@ static void ion_page_pool_add(struct ion_page_pool *pool, struct page *page)
 	}
 
 	mod_node_page_state(page_pgdat(page), NR_KERNEL_MISC_RECLAIMABLE,
-							1 << pool->order);
+			    1 << pool->order);
 	mutex_unlock(&pool->mutex);
 }
 
@@ -57,7 +57,7 @@ static struct page *ion_page_pool_remove(struct ion_page_pool *pool, bool high)
 
 	list_del(&page->lru);
 	mod_node_page_state(page_pgdat(page), NR_KERNEL_MISC_RECLAIMABLE,
-							-(1 << pool->order));
+			    -(1 << pool->order));
 	return page;
 }
 
-- 
2.25.1

