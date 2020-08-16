Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD7EC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8408820708
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqG4KJNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgHPRWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 13:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgHPRWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 13:22:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD76C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 10:22:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r4so12629025wrx.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 10:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4HYSjJrSFbsKSpAjQ67ycGR7vDjT9ve1UESwTHkkkXI=;
        b=DqG4KJNvN/4SaxKEUnB/lPtAsnBT+0hftqgEbD/ELCi11rHCN37HnLFWRg7z/TPjcu
         RjLn2Jz6ClO+qvALHNVx18vuJTnSZpa6/01Fm9IbvrDbvh5g2oTB2REorFLoj2zRbsTz
         H1CmbgT+dHD2iaetUduqjbZ7J8Z/nAa+r+L+AdUBHJq0ricgeXhvbetZr+oC3rMj5Nwx
         CJAWZJcNrLn4CMSCVClcdUc2bqtz1NqY4htBSZ86aAXeAfAqeMhTLchb+eRTB+lwXs6W
         RErNdIPdP3Wze55IxRYk9afAfE2Jck4gwmfdUzwTWOwHwhb8eKJkbFS2lV907TI4fAJu
         XJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4HYSjJrSFbsKSpAjQ67ycGR7vDjT9ve1UESwTHkkkXI=;
        b=JMBJDe46Ww/A9WQRFYXuC7YTuEefn3q53YqsA+2YjJ1CZmgsVYdo1sSiDX6tlxNw+9
         kAuKrQQogw/ySfupKiAIx2oFpUek5dndCPitBzTp6Dq4k0y+00Quw0rKPfl+WK74DUix
         8nm2EYXn9VPZ+ysZWyAaAuQMhu4b4Zh0Sz6bZuX3ZjTlMCyrt4D/bH8cuEnMmxip4Nee
         tzGJu7J9iOBuXTbPKbIqn6Y1/IcIzAa+vXBBD2ufZ+HGbxy4j1B0ppmcZNM6SxPsGDpm
         KgbLtlmyIgOIqsiYdUxH7hPqtJ6OMZGDIyjCmO9axJlar7k+15Gfo49VBNY/PgbqbIPN
         ARLw==
X-Gm-Message-State: AOAM531gE2fTl0TYwjFdWFcDzIEljKoc01hRwjRwTTMCqJ4lghzrlpk2
        J7uEBMNe7laOTRP2P2fgjsU=
X-Google-Smtp-Source: ABdhPJzy1vPocCt/eIvyGsJigo6Dhh4MR4Zy5q2onubILtVAnZm5kyjJMAnHnm1ZiMt3s+q2sOwhwg==
X-Received: by 2002:adf:f207:: with SMTP id p7mr12392922wro.292.1597598538151;
        Sun, 16 Aug 2020 10:22:18 -0700 (PDT)
Received: from tsnow ([94.159.146.190])
        by smtp.gmail.com with ESMTPSA id m14sm27342247wrx.76.2020.08.16.10.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 10:22:17 -0700 (PDT)
Date:   Sun, 16 Aug 2020 20:22:14 +0300
From:   Tomer Samara <tomersamara98@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Riley Andrews <riandrews@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: androind: Add error handling to
 ion_page_pool_shrink
Message-ID: <b061899043eba10091cdba36ef0adde170eda801.1597597955.git.tomersamara98@gmail.com>
References: <cover.1597597955.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597597955.git.tomersamara98@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add error check to ion_page_pool_shrink after calling
ion_page_pool_remove, due to converting BUG_ON to WARN_ON.

Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
---
 drivers/staging/android/ion/ion_page_pool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index 4acc0eebf781..c61548ecf7f2 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -128,6 +128,8 @@ int ion_page_pool_shrink(struct ion_page_pool *pool, gfp_t gfp_mask,
 			break;
 		}
 		mutex_unlock(&pool->mutex);
+		if (!page)
+			break;
 		ion_page_pool_free_pages(pool, page);
 		freed += (1 << pool->order);
 	}
-- 
2.25.1

