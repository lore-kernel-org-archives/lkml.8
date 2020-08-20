Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5496C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C4E2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597927850;
	bh=Bgf8F92t/ZAyenynqhNM6Yf/xAbcyUQKG4+V7kmmPnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FI3mfhqFVN8MdTH/diJZyJ2H34/6iBytKUoi/C/Q7vLF/0dF5GIbkbzgAu62B7gM8
	 CS5GjfBbcSZbPNkkF/DMinr2etJ1ExzJfAWqYPCDyXWlzcTBsqq3fhlIvWM1BQXfwI
	 qfUQo9M+PHB22WTSsegzTUjPDvCJU5c1B5ikwoLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbgHTMut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729194AbgHTJpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:45:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 022D922D08;
        Thu, 20 Aug 2020 09:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916670;
        bh=Bgf8F92t/ZAyenynqhNM6Yf/xAbcyUQKG4+V7kmmPnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2Uo7GwTX8OH3ioNvPrE4QtJv0UZhiml2VVYQMnnOYMcjujxytheCMUZyGd6H99Vl
         V3Al9V3CifVabkrrgGMh1RFCM0Jd8oHGhuUXtsz9yH3W3BOE9R8ZmQTVjP/iauURZB
         wxOiVM4xTS4WDoJnimrevc0BS+H76DPKRweAqG4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Efremov <efremov@linux.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH 5.7 195/204] drm/panfrost: Use kvfree() to free bo->sgts
Date:   Thu, 20 Aug 2020 11:21:32 +0200
Message-Id: <20200820091615.921958132@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

commit 114427b8927a4def2942b2b886f7e4aeae289ccb upstream.

Use kvfree() to free bo->sgts, because the memory is allocated with
kvmalloc_array() in panfrost_mmu_map_fault_addr().

Fixes: 187d2929206e ("drm/panfrost: Add support for GPU heap allocations")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Efremov <efremov@linux.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200608151728.234026-1-efremov@linux.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/panfrost/panfrost_gem.c |    2 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -46,7 +46,7 @@ static void panfrost_gem_free_object(str
 				sg_free_table(&bo->sgts[i]);
 			}
 		}
-		kfree(bo->sgts);
+		kvfree(bo->sgts);
 	}
 
 	drm_gem_shmem_free_object(obj);
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -486,7 +486,7 @@ static int panfrost_mmu_map_fault_addr(s
 		pages = kvmalloc_array(bo->base.base.size >> PAGE_SHIFT,
 				       sizeof(struct page *), GFP_KERNEL | __GFP_ZERO);
 		if (!pages) {
-			kfree(bo->sgts);
+			kvfree(bo->sgts);
 			bo->sgts = NULL;
 			mutex_unlock(&bo->base.pages_lock);
 			ret = -ENOMEM;


