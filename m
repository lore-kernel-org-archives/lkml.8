Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545B5C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A562467C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996249;
	bh=sxt41ZUR01k9Pokfbgttc7WQXl5hw+ofgwT9/AOwVu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vHngPO2fO7T3LZ3UNq+/jm6URB8pS9ji/X14sMCtKtuNGq4m/2I83hXhXvYxKvDI7
	 EdClxNBHdxlmlEqbn0ol0QAxSANwVihVnVzbNH7GaImfVnBY9hPUAQSKuYHx4PDOHV
	 lkWSRfvw97IGRrpxnBhLx+c+XFDc12yI5kc/JqkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgANKEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:04:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbgANKEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:04:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765E32465B;
        Tue, 14 Jan 2020 10:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996246;
        bh=sxt41ZUR01k9Pokfbgttc7WQXl5hw+ofgwT9/AOwVu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VikksPI51yyHsR98rin1gVVLxlD1pKdK61Uali81GobONO0glam63xwIdMZVY2HxV
         e+H5t+HTdfauqsKKBMFC6QMEGTeC4wGXMQrja4BrayYE+v5zNjuaNTCg9PweJE+iNp
         oShJTw/B3HAGJafCofWzAzmKvIVNrT8E9EwY8LiA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 5.4 30/78] drm/i915/gt: Mark up virtual engine uabi_instance
Date:   Tue, 14 Jan 2020 11:01:04 +0100
Message-Id: <20200114094357.715222720@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

commit 1325008f5c8dbc84aa835d98af8447fa0569bc4d upstream.

Be sure to initialise the uabi_instance on the virtual engine to the
special invalid value, just in case we ever peek at it from the uAPI.

Reported-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Fixes: 750e76b4f9f6 ("drm/i915/gt: Move the [class][inst] lookup for engines onto the GT")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: <stable@vger.kernel.org> # v5.4+
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200106123921.2543886-1-chris@chris-wilson.co.uk
(cherry picked from commit f75fc37b5e70b75f21550410f88e2379648120e2)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gt/intel_lrc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/i915/gt/intel_lrc.c
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
@@ -3716,9 +3716,11 @@ intel_execlists_create_virtual(struct i9
 	ve->base.i915 = ctx->i915;
 	ve->base.gt = siblings[0]->gt;
 	ve->base.id = -1;
+
 	ve->base.class = OTHER_CLASS;
 	ve->base.uabi_class = I915_ENGINE_CLASS_INVALID;
 	ve->base.instance = I915_ENGINE_CLASS_INVALID_VIRTUAL;
+	ve->base.uabi_instance = I915_ENGINE_CLASS_INVALID_VIRTUAL;
 
 	/*
 	 * The decision on whether to submit a request using semaphores


