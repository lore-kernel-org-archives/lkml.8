Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866B1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8302078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597927869;
	bh=IUdl4LSAPkAcHLf7yKtnIwaTi7lhz1VhW2dasR7m3KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tp63wW4Se/sShXdaooFn4rkXLcZA0hUylI7+/8dnuu7yYtc5YZBSwuhD29JFCbKT1
	 1CkfD5uoLGz+GqCyS/w4izpDrVLCpnRnewc4J6HxUNiRZ+OEDR/HK6HM+QGQPJEtym
	 MadsLQloiwRB+XiZw0a2F//6o8s/L1Y2pq7Fmgkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgHTMvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729195AbgHTJpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:45:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2F8722D04;
        Thu, 20 Aug 2020 09:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916667;
        bh=IUdl4LSAPkAcHLf7yKtnIwaTi7lhz1VhW2dasR7m3KU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aI6lN2cio4hdmuTWvq/+dRJdieopDlcQbfZJn1zizuQDzSIwjJ3V84TsGbyuknfGJ
         WYighinnjy1HPGCATHlMKVzyG+JJJ6iT5kp2qvHlDJJyj5K7uj4y6b8sx2LJTGSHeA
         y9QYQGjnj+S0p+Z9LHx7fHK3gih7ExfZ5dbPqjiQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        stable@kernel.org, Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: [PATCH 5.7 194/204] drm/i915/gt: Force the GT reset on shutdown
Date:   Thu, 20 Aug 2020 11:21:31 +0200
Message-Id: <20200820091615.881205586@linuxfoundation.org>
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

From: Chris Wilson <chris@chris-wilson.co.uk>

commit 7c4541a37bbbf83c0f16f779e85eb61d9348ed29 upstream.

Before we return control to the system, and letting it reuse all the
pages being accessed by HW, we must disable the HW. At the moment, we
dare not reset the GPU if it will clobber the display, but once we know
the display has been disabled, we can proceed with the reset as we
shutdown the module. We know the next user must reinitialise the HW for
their purpose.

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/489
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: stable@kernel.org
Reviewed-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200525151459.12083-1-chris@chris-wilson.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gt/intel_gt.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/i915/gt/intel_gt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt.c
@@ -656,6 +656,11 @@ void intel_gt_driver_unregister(struct i
 void intel_gt_driver_release(struct intel_gt *gt)
 {
 	struct i915_address_space *vm;
+	intel_wakeref_t wakeref;
+
+	/* Scrub all HW state upon release */
+	with_intel_runtime_pm(gt->uncore->rpm, wakeref)
+		__intel_gt_reset(gt, ALL_ENGINES);
 
 	vm = fetch_and_zero(&gt->vm);
 	if (vm) /* FIXME being called twice on error paths :( */


