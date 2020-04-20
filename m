Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C68C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1DF206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387359;
	bh=7/OwSy2yt7GrKmn18S23qy1KM373O/ZBmrERSye++hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ev3T06wgoJsYhjY6+Vq8t40B6XAUXQ3kDeifi4VtebZbVA6t9HY26iOF3DJB5pxll
	 KnVwST4nmMvCGvIm3hHCl7djUZ8+HQtqGuHGCQtAhyy6vnicct4A6jPO9Mxv+oDGN5
	 uRYzZP9buVVPhcFss4u72iW9anlCWHe26gWmUM9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgDTMz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728730AbgDTMpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:45:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52EBD20736;
        Mon, 20 Apr 2020 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386723;
        bh=7/OwSy2yt7GrKmn18S23qy1KM373O/ZBmrERSye++hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MgN2esJFL5E4Y6JkpXcwNORXqpX2+4qXm6tRQBQ8/2gz0sBMPBAGMJkvBCGCQqT22
         n+QN+MsCNClaVtxxYJu9TC18dJk8RukfbJbjaE5jlSpopECMFsN/Nw7xGF/RHeGT2w
         oGjRlHe5a1Lc2dbSi2pMEhnf7+UQNIU3EmdRoplQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sergei Lopatin <magist3r@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.6 58/71] drm/amd/powerplay: force the trim of the mclk dpm_levels if OD is enabled
Date:   Mon, 20 Apr 2020 14:39:12 +0200
Message-Id: <20200420121520.705644820@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121508.491252919@linuxfoundation.org>
References: <20200420121508.491252919@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Lopatin <magist3r@gmail.com>

commit 8c7f0a44b4b4ef16df8f44fbaee6d1f5d1593c83 upstream.

Should prevent flicker if PP_OVERDRIVE_MASK is set.

bug: https://bugs.freedesktop.org/show_bug.cgi?id=102646
bug: https://bugs.freedesktop.org/show_bug.cgi?id=108941
bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1088
bug: https://gitlab.freedesktop.org/drm/amd/-/issues/628

Signed-off-by: Sergei Lopatin <magist3r@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -3804,9 +3804,12 @@ static int smu7_trim_single_dpm_states(s
 {
 	uint32_t i;
 
+	/* force the trim if mclk_switching is disabled to prevent flicker */
+	bool force_trim = (low_limit == high_limit);
 	for (i = 0; i < dpm_table->count; i++) {
 	/*skip the trim if od is enabled*/
-		if (!hwmgr->od_enabled && (dpm_table->dpm_levels[i].value < low_limit
+		if ((!hwmgr->od_enabled || force_trim)
+			&& (dpm_table->dpm_levels[i].value < low_limit
 			|| dpm_table->dpm_levels[i].value > high_limit))
 			dpm_table->dpm_levels[i].enabled = false;
 		else


