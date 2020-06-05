Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2B7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A04320663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591366949;
	bh=ihlDfgG3j3xz4bDy2bhDZn4pw55pV0TlDHOrGsmuZdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F3wHVMyuQqpdgtRWQigyUTrte0U1nvlJwFBpBO2nXH3B7wkjnVO1sNK+Ez0slEn90
	 pmfMSFOVmvXW7vnJzl5PGH4jNbPuNrgu/9emd10sgY/YMH4AxkgpGulyoZ7fUIjV4E
	 WA+enbJ5jJKeU7XCsMBZ2WmRstKuMEsZL59pq1QE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgFEOW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbgFEOTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:19:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69FF4208A7;
        Fri,  5 Jun 2020 14:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366748;
        bh=ihlDfgG3j3xz4bDy2bhDZn4pw55pV0TlDHOrGsmuZdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YTNoBnk5/ST8fjK5bO9o3yz+WL7v2QL9mWQMsbAKR1dPJulYFRDAdNOHgPvaTf65l
         6m7VzrZtjYaUsl/tCBZ4mwKETrItxN0PXz6VyFPdcAynbAMRqDCF7OZKYfkp975ba1
         HSQNj6wKhBQmPQXG0pcj20yL/w8HUm5VfWY8oCYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Schmidt <jan@centricular.com>,
        Dave Airlie <airlied@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 32/38] drm/edid: Add Oculus Rift S to non-desktop list
Date:   Fri,  5 Jun 2020 16:15:15 +0200
Message-Id: <20200605140254.774264644@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605140252.542768750@linuxfoundation.org>
References: <20200605140252.542768750@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Schmidt <jan@centricular.com>

[ Upstream commit 5a3f610877e9d08968ea7237551049581f02b163 ]

Add a quirk for the Oculus Rift S OVR0012 display so
it shows up as a non-desktop display.

Signed-off-by: Jan Schmidt <jan@centricular.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200507180628.740936-1-jan@centricular.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_edid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index ea2849338d6c..9b69e55ad701 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -191,10 +191,11 @@ static const struct edid_quirk {
 	{ "HVR", 0xaa01, EDID_QUIRK_NON_DESKTOP },
 	{ "HVR", 0xaa02, EDID_QUIRK_NON_DESKTOP },
 
-	/* Oculus Rift DK1, DK2, and CV1 VR Headsets */
+	/* Oculus Rift DK1, DK2, CV1 and Rift S VR Headsets */
 	{ "OVR", 0x0001, EDID_QUIRK_NON_DESKTOP },
 	{ "OVR", 0x0003, EDID_QUIRK_NON_DESKTOP },
 	{ "OVR", 0x0004, EDID_QUIRK_NON_DESKTOP },
+	{ "OVR", 0x0012, EDID_QUIRK_NON_DESKTOP },
 
 	/* Windows Mixed Reality Headsets */
 	{ "ACR", 0x7fce, EDID_QUIRK_NON_DESKTOP },
-- 
2.25.1



