Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3A4C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5B82072D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583259225;
	bh=fh/0xdOoh175PJRRkgF0SxozxLY14ZyoQVxKq3XrrVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Aoe0C3+TQtF3z6hVChaF2ViVMo9UFugWeWufTvijBJ9XulqcfyCH377YlcmC4nPMm
	 lYOisXZ51CmVqQk6PwlyY3G1URzp7lSYFwx7JN/O8NG1nOAm4R/P5FVHVqLy1KNZ8J
	 U0ART9QbFsFED/jfdNkUlWJBKVMJtUO4FHHTGVdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbgCCRpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:45:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729831AbgCCRpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:45:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAE882166E;
        Tue,  3 Mar 2020 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257535;
        bh=fh/0xdOoh175PJRRkgF0SxozxLY14ZyoQVxKq3XrrVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3sbkpZSP3Zwsc1+k/w9LiYsS3hH6AK1AMRf6Nh5wVGzMuxl46AsesKEcprK3uPLS
         LLdaYp/z4SpzgnxFK7jYZrIrt8kgKvzjQN0s1KJnaKWJesQrZNWT3oyThQdAwCF+qi
         RV69HWH6M71OP6uTyj4FeSwHfjLaJzEOEyNiXbuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 031/176] mac80211: consider more elements in parsing CRC
Date:   Tue,  3 Mar 2020 18:41:35 +0100
Message-Id: <20200303174308.110828718@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit a04564c99bb4a92f805a58e56b2d22cc4978f152 ]

We only use the parsing CRC for checking if a beacon changed,
and elements with an ID > 63 cannot be represented in the
filter. Thus, like we did before with WMM and Cisco vendor
elements, just statically add these forgotten items to the
CRC:
 - WLAN_EID_VHT_OPERATION
 - WLAN_EID_OPMODE_NOTIF

I guess that in most cases when VHT/HE operation change, the HT
operation also changed, and so the change was picked up, but we
did notice that pure operating mode notification changes were
ignored.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Link: https://lore.kernel.org/r/20200131111300.891737-22-luca@coelho.fi
[restrict to VHT for the mac80211 branch]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/util.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 32a7a53833c01..739e90555d8b9 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1063,16 +1063,22 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 				elem_parse_failed = true;
 			break;
 		case WLAN_EID_VHT_OPERATION:
-			if (elen >= sizeof(struct ieee80211_vht_operation))
+			if (elen >= sizeof(struct ieee80211_vht_operation)) {
 				elems->vht_operation = (void *)pos;
-			else
-				elem_parse_failed = true;
+				if (calc_crc)
+					crc = crc32_be(crc, pos - 2, elen + 2);
+				break;
+			}
+			elem_parse_failed = true;
 			break;
 		case WLAN_EID_OPMODE_NOTIF:
-			if (elen > 0)
+			if (elen > 0) {
 				elems->opmode_notif = pos;
-			else
-				elem_parse_failed = true;
+				if (calc_crc)
+					crc = crc32_be(crc, pos - 2, elen + 2);
+				break;
+			}
+			elem_parse_failed = true;
 			break;
 		case WLAN_EID_MESH_ID:
 			elems->mesh_id = pos;
-- 
2.20.1



