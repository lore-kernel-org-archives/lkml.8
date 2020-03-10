Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC011C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C2420675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846871;
	bh=keBkMP94BtWq1g3ImFu3VctsUJmVS3ofMC1A7jzoSuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fK5j9LE7S6+9RWkpwcMKxkZ7wHgf/d4B2pQfAP6vt4MRDUq5+mr7nrJi7TU27IdOW
	 e+OZoIChJP2pDMjdKq/UdTS9rTlYrplyjDNlN4AtXphFTMc/m7NB0tzKOasUPxsAKF
	 OOlhZGi9Ir9U6AkILFNAZjp8+XhsyZ0N635UP7yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgCJN1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgCJMxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:53:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E9AE2468F;
        Tue, 10 Mar 2020 12:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844835;
        bh=keBkMP94BtWq1g3ImFu3VctsUJmVS3ofMC1A7jzoSuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPwsNXILNJD0y+ZS+FrL/MCQKDBc828mZlK3figWd5zX0joMg0v97SuTj1gj5B+68
         HBoXhpRUk5QSaYShHonRBYqUwTA+SjanzntsuWyiBR36CSlblltorldGCoTA/FQPX/
         cFWVX4J9Eem1Zktl/KorSMKMOE+NOtxV8citkDlw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 5.4 136/168] drm/i915/selftests: Fix return in assert_mmap_offset()
Date:   Tue, 10 Mar 2020 13:39:42 +0100
Message-Id: <20200310123649.267599238@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit f4aaa44e8b20f7e0d4ea68d3bca4968b6ae5aaff upstream.

The assert_mmap_offset() returns type bool so if we return an error
pointer that is "return true;" or success.  If we have an error, then
we should return false.

Fixes: 3d81d589d6e3 ("drm/i915: Test exhaustion of the mmap space")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20200228141413.qfjf4abr323drlo4@kili.mountain
(cherry picked from commit efbf928824820f2738f41271934f6ec2c6ebd587)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -375,7 +375,7 @@ static bool assert_mmap_offset(struct dr
 
 	obj = i915_gem_object_create_internal(i915, size);
 	if (IS_ERR(obj))
-		return PTR_ERR(obj);
+		return false;
 
 	err = create_mmap_offset(obj);
 	i915_gem_object_put(obj);


