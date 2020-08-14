Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2211C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CAE207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFCQVMh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgHNR1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgHNR1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:27:30 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0BAC061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:29 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id f14so3570552wrm.22
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g4f+/WfnZkrMe/HqGvZOb2vGCvbeoVKA+YRTcEBLbjI=;
        b=OFCQVMh5lzbnBQRKf9DzZ6/nqGpqP5QdzE3+Go27TRAD1wu9FUmQBIqrtwtXp033kL
         ueoA2WLGaoGyWIQtb/uaZ1WXmF09DPSdo8U3sxzgxw2qcTqsz7jq7MG5mrYoxawUZbjF
         9uodD7HWUHhEC3SjuGmyyo3Typ7gaCqV9/oPMpxYLYrSyjobie1Gray9lIlWuyRLOYG6
         E24uIjoP3jNnPxN0RDvyabdUCLRZUwcW9o7YkLDNy+9+4Epf/d8gA2R2U1I0lPCdd0fS
         ZCXwv38NAlJrbYxWdy2lcvetzJF+9zGRhAnTYuRi0OG5ZxfPrVSHlqMaOZfnSMWuRJy6
         UkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g4f+/WfnZkrMe/HqGvZOb2vGCvbeoVKA+YRTcEBLbjI=;
        b=nBwsgXF267sClSdKS8v2t5BmXiGfgtPLKFmZKCI2islVmDkcy5Ju5/SbtmO94CIOOh
         k3+xEa0v+E55YcVn6QX7nYOF/egPG6Bd/UwJs/AAIhJWNAghDRjEoL/4xDMu5NssnPoi
         x1lsoGQme6Nc07YEDcH65dOF1vr5iCkDV9wtTlVP+19FkZ25c7RRQ9QgaBvPdoEgI+Si
         eXyXpNIIpFjrIFdBeG72IVD2tUGKJLhe2O5XruJXRBGw6dst/h6fCpCiwE7DLBx4yYgx
         9FHpaGWEsnqdAhYwmHeIZxjTKG1+gWFXOGs1lJlRt1ntufV9OAkJnHu93vlvjdpG5iJn
         k3Xw==
X-Gm-Message-State: AOAM5331OsGSnv5Mf3WjQ8sL3ffBYk+5cFbQtAZhZtrY8fRzwC3NYRJJ
        bmJswzvdn8dA4DMA4Kv42lS043uqTxQwBO1W
X-Google-Smtp-Source: ABdhPJxOR7vAGPMjFiP7k8NtFovu5yIEAl2ydWx6+eJUUnvoGiIE7kwWWrEIbMIlI3WWHWNdSqg3gZl1Rx7j+UKA
X-Received: by 2002:a7b:cd97:: with SMTP id y23mr3561956wmj.21.1597426046055;
 Fri, 14 Aug 2020 10:27:26 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:26:43 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <c36842a403be0fbf3dd63b16a7cd231ebd6d4d5b.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 01/35] kasan: KASAN_VMALLOC depends on KASAN_GENERIC
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only generic KASAN mode supports vmalloc, reflect that
in the config.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/Kconfig.kasan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 047b53dbfd58..e1d55331b618 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -156,7 +156,7 @@ config KASAN_SW_TAGS_IDENTIFY
 
 config KASAN_VMALLOC
 	bool "Back mappings in vmalloc space with real shadow memory"
-	depends on HAVE_ARCH_KASAN_VMALLOC
+	depends on KASAN_GENERIC && HAVE_ARCH_KASAN_VMALLOC
 	help
 	  By default, the shadow region for vmalloc space is the read-only
 	  zero page. This means that KASAN cannot detect errors involving
-- 
2.28.0.220.ged08abb693-goog

