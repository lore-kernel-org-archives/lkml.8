Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909D9C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6232D205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443468;
	bh=5YZR+KQsu8U4RTvoyjtGOblA2D6ELg4tXBfICGzn98A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n7KdJ6g7u/9NsQNA5sLqXndkJC938Bl6FJPA9Nw6jd1ZiR98AAanUxP9LS7viJgmJ
	 ZHIy6144E2/Kdx+Za2KEDf2XpH5NSErAr1OnSQFqKqJRbY0DIPdRBxu471WFf179MO
	 FSiCNXlbdX76YjFkRS09f/E/j7tm1yB5SrqwozE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgCQLLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbgCQLK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:10:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E1B720658;
        Tue, 17 Mar 2020 11:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443458;
        bh=5YZR+KQsu8U4RTvoyjtGOblA2D6ELg4tXBfICGzn98A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=POTUngKGrl4krEe39lGBkEdEYZUQNTl3Lx0OE+470NJKrBVe3GFmIlMlNRJiyxAqQ
         4FSE79pQdSlf7rlhjskfn65y63h+c6X8HcapCEBTtsSpqyTbSpBSDidSFst4O/JFKu
         Eka61j0axhEw9sXuWxOQi6fObttbSx5AW2QlMU7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Auld <matthew.auld@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 5.5 087/151] drm/i915: be more solid in checking the alignment
Date:   Tue, 17 Mar 2020 11:54:57 +0100
Message-Id: <20200317103332.630634260@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Auld <matthew.auld@intel.com>

commit 1d61c5d711a2dc0b978ae905535edee9601f9449 upstream.

The alignment is u64, and yet is_power_of_2() assumes unsigned long,
which might give different results between 32b and 64b kernel.

Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20200305203534.210466-1-matthew.auld@intel.com
Cc: stable@vger.kernel.org
(cherry picked from commit 2920516b2f719546f55079bc39a7fe409d9e80ab)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c |    3 ++-
 drivers/gpu/drm/i915/i915_utils.h              |    5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -441,7 +441,8 @@ eb_validate_vma(struct i915_execbuffer *
 	if (unlikely(entry->flags & eb->invalid_flags))
 		return -EINVAL;
 
-	if (unlikely(entry->alignment && !is_power_of_2(entry->alignment)))
+	if (unlikely(entry->alignment &&
+		     !is_power_of_2_u64(entry->alignment)))
 		return -EINVAL;
 
 	/*
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -234,6 +234,11 @@ static inline u64 ptr_to_u64(const void
 	__idx;								\
 })
 
+static inline bool is_power_of_2_u64(u64 n)
+{
+	return (n != 0 && ((n & (n - 1)) == 0));
+}
+
 static inline void __list_del_many(struct list_head *head,
 				   struct list_head *first)
 {


