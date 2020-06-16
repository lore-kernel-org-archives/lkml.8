Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF58C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15212098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592318975;
	bh=ovSysk6kOqKTv082hockt1TpSKGLzWO2f3kVdMiM78o=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Ot8D6dmsa25dVomfw035EA4dxdcRWzV/1acUxb2RpO30U9lwtvfmnt7qRZejC2vgg
	 7eQuTzlIMXVEkD5MeEzMpJjRfYm3bEdN8ozCykaXTWjHCrktfnlPGtUHAG322Tav07
	 c4Pf6UphrFGOM+Robg8am1PTb5O/79vS6PL/LKHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgFPOte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbgFPOtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:49:33 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82ED0208B3;
        Tue, 16 Jun 2020 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592318973;
        bh=ovSysk6kOqKTv082hockt1TpSKGLzWO2f3kVdMiM78o=;
        h=Date:From:To:Cc:Subject:From;
        b=loYJF9f7xfeyaBWVBmiXz3O8oEAEuwPE8LD1LEc01/05HTs9EHi54G2MNShbF+4x6
         GzSFw2VZCxY5rpp+mqH0wnwRznSKF8IqqQP5JC2g7fzuum4louloudFhn08jJevpDG
         Vel8U2AphFpDC2kHy71bI/PtRONOMefkJYCBStKs=
Date:   Tue, 16 Jun 2020 09:54:52 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] drm/i915/selftests: Fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20200616145452.GA25291@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix inconsistent IS_ERR and PTR_ERR in live_timeslice_nopreempt().

The proper pointer to be passed as argument to PTR_ERR() is ce.

This bug was detected with the help of Coccinelle.

Fixes: b72f02d78e4f ("drm/i915/gt: Prevent timeslicing into unpreemptable requests")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/i915/gt/selftest_lrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_lrc.c b/drivers/gpu/drm/i915/gt/selftest_lrc.c
index 91543494f595..393339de0910 100644
--- a/drivers/gpu/drm/i915/gt/selftest_lrc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_lrc.c
@@ -1337,7 +1337,7 @@ static int live_timeslice_nopreempt(void *arg)
 
 		ce = intel_context_create(engine);
 		if (IS_ERR(ce)) {
-			err = PTR_ERR(rq);
+			err = PTR_ERR(ce);
 			goto out_spin;
 		}
 
-- 
2.27.0

