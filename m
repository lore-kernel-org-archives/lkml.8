Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E408AC3F366
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BD424697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813039;
	bh=0t2kYAsODT2lhOl+jQme+GSvt5/Gi8zhsfODqfavzOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ywA0tR9hdyVvU3n7I5mesNf9NBT81dgD46dcqXPrhzQTMDelXn0TO2hL/bBY0QluT
	 sJC9kR2Wh639LKqAbD/dW9qXTMYbxXdztcNCKO4eY6C0yiznp5VnvKCNrumavmWWk+
	 eCvulKnUyQIfac7b7D11/S9wLZiEC1v6mpfHxqNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389687AbgB0ORT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:17:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389681AbgB0ORO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:17:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E562C2468F;
        Thu, 27 Feb 2020 14:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582813034;
        bh=0t2kYAsODT2lhOl+jQme+GSvt5/Gi8zhsfODqfavzOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jyd3M18EbXo7IzHaTW+XUcpvXrCz+L5h9ZrBhzg9NF25kYCHNRr+XGTr9bWWMQgBo
         /44xpfEDZa+MJy50n0bttgS5AsZqdBgMMZFR1TcZlZlveIrRrgIiCRnhTLBTGWRb8B
         BJM65tIinyBUm9GdSEt6Y7Ch0NtQdq3euMNCNo8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Druzhinin <igor.druzhinin@citrix.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 5.5 112/150] drm/i915/gvt: more locking for ppgtt mm LRU list
Date:   Thu, 27 Feb 2020 14:37:29 +0100
Message-Id: <20200227132249.302479089@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Druzhinin <igor.druzhinin@citrix.com>

commit 0e9d7bb293f3f9c3ee376b126141407efb265f31 upstream.

When the lock was introduced in commit 72aabfb862e40 ("drm/i915/gvt: Add mutual
lock for ppgtt mm LRU list") one place got lost.

Fixes: 72aabfb862e4 ("drm/i915/gvt: Add mutual lock for ppgtt mm LRU list")
Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Link: http://patchwork.freedesktop.org/patch/msgid/1580742421-25194-1-git-send-email-igor.druzhinin@citrix.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gvt/gtt.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1956,7 +1956,11 @@ void _intel_vgpu_mm_release(struct kref
 
 	if (mm->type == INTEL_GVT_MM_PPGTT) {
 		list_del(&mm->ppgtt_mm.list);
+
+		mutex_lock(&mm->vgpu->gvt->gtt.ppgtt_mm_lock);
 		list_del(&mm->ppgtt_mm.lru_list);
+		mutex_unlock(&mm->vgpu->gvt->gtt.ppgtt_mm_lock);
+
 		invalidate_ppgtt_mm(mm);
 	} else {
 		vfree(mm->ggtt_mm.virtual_ggtt);


