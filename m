Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E40C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E202020B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055537;
	bh=7VAsGNAFAa6wIG1YrBMZI+NGgGY/usWxa71Rzj1Z1rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MR1U40XDAGqKz1YTWb4kCtHnkoi0itHjD87Eg5p5D7GddCYhfWdL+SxpmGkrdsLYu
	 RAQD/RH6Rlq40D01XPACg7XV1ynHJPt9cJ+ag2H8Y3UVAp2LsZC6qjSPqfpqWYuQu7
	 3HNPS+2RZgzYnItw1wpDu1uzF9EuyZciZx8XhAqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCXNMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbgCXNMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:12:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 865B5208E4;
        Tue, 24 Mar 2020 13:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055533;
        bh=7VAsGNAFAa6wIG1YrBMZI+NGgGY/usWxa71Rzj1Z1rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ypEAgjL+9/+eNdrY9BcTriwDzKMqEDgKXkmbKqvuWkhqDiiv7CsMgo4sgR/k03qmM
         Nh4TvjSPTVM23rmfj+/fK4HJIAXOJ/SeGkHNZ4JwCPjFkCnug9eYyTNknNMFaFunzA
         vp1KclgZyI/ueQMgVxx9sE9p3xsXwOnZc3Og8r+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josip Pavic <Josip.Pavic@amd.com>,
        Aric Cyr <Aric.Cyr@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 15/65] drm/amd/display: fix dcc swath size calculations on dcn1
Date:   Tue, 24 Mar 2020 14:10:36 +0100
Message-Id: <20200324130758.839333432@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josip Pavic <Josip.Pavic@amd.com>

[ Upstream commit a0275dfc82c9034eefbeffd556cca6dd239d7925 ]

[Why]
Swath sizes are being calculated incorrectly. The horizontal swath size
should be the product of block height, viewport width, and bytes per
element, but the calculation uses viewport height instead of width. The
vertical swath size is similarly incorrectly calculated. The effect of
this is that we report the wrong DCC caps.

[How]
Use viewport width in the horizontal swath size calculation and viewport
height in the vertical swath size calculation.

Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
index 1ea91e153d3a6..c1adac888fd83 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
@@ -684,8 +684,8 @@ static void hubbub1_det_request_size(
 
 	hubbub1_get_blk256_size(&blk256_width, &blk256_height, bpe);
 
-	swath_bytes_horz_wc = height * blk256_height * bpe;
-	swath_bytes_vert_wc = width * blk256_width * bpe;
+	swath_bytes_horz_wc = width * blk256_height * bpe;
+	swath_bytes_vert_wc = height * blk256_width * bpe;
 
 	*req128_horz_wc = (2 * swath_bytes_horz_wc <= detile_buf_size) ?
 			false : /* full 256B request */
-- 
2.20.1



