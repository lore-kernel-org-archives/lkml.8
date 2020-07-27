Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE469C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB382075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595874703;
	bh=R7cluhQdKSmyPhF548B9z79DQvmXzhxn5rn/ErrXPuU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Oo9g58SNMET7yUDwlSArQi2gptnVMdKqjbErcGjHf7MnfNjNqJ/b0DqFnUmggamlC
	 oNTsRBMBBsub4F+HTE2EH1CjoZ0OFYdHdOkNvRIMZ0kew8b5rVimvdaXCSazJDuIYY
	 JIh6KNkr5IaHm0Gz2zrXLyVU5ZlytJQpH9enq1iY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgG0Sbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729498AbgG0Sbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:31:41 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 833CA2073E;
        Mon, 27 Jul 2020 18:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595874701;
        bh=R7cluhQdKSmyPhF548B9z79DQvmXzhxn5rn/ErrXPuU=;
        h=Date:From:To:Cc:Subject:From;
        b=ld1EDnCdPTUt5CXgrQjRXVppZZvv/sIgH3bCWcA9VylXkh9BbBbGjuIJ/0FUlciNt
         lo3oWBiD7M5TgI2AORJIhYqUt7wxlBqxzwH6p5cX0GKlkou5An2TLnYUECftOyDF4X
         vbQ/twyNmXn7Kpc/3tXpa2Sztm8jWBSXXUaQ2qhE=
Date:   Mon, 27 Jul 2020 13:37:34 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] staging: vc04_services: Use fallthrough pseudo-keyword
Message-ID: <20200727183734.GA28824@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index af64cde82d36..5a361e8e7c6c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2710,7 +2710,7 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 
 	case VCHIQ_SRVSTATE_OPENSYNC:
 		mutex_lock(&state->sync_mutex);
-		/* fall through */
+		fallthrough;
 	case VCHIQ_SRVSTATE_OPEN:
 		if (close_recvd) {
 			if (!do_abort_bulks(service))
-- 
2.27.0

