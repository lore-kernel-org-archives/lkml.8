Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED40AC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49DE20661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609062;
	bh=ZDuLrSCJOFSSpKWX6MNOS1abnctVLaODKY4DGqUkhfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EhjP4eRHF/wG421yfW5ETMAY2FD7La3kDsJhA+Usj+sIwP8J2R9Xjfshwg82XCn9A
	 yR8p90ZL4AUNSJv90drw2MPUoXj9uKMYGps/+CXtkxrqccCDc2WH/5rqaKeF/GL2mK
	 TkU8cwGMXxVjGs7N9iiuEjwgOiOLaoIMLO5MhRcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgBMPvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:51:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728747AbgBMP0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:21 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FB86218AC;
        Thu, 13 Feb 2020 15:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607580;
        bh=ZDuLrSCJOFSSpKWX6MNOS1abnctVLaODKY4DGqUkhfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ban3ip2J8GxGRMOFFuFuXaAM7DlFg+OiSgsDsZQBOoNC70Dap0Zvlhfp0DbeMEl5f
         qnXB4Y7U3uol4WQNUiH2UzzGAcbdp9wQwAV7ShDY/RdFz3FJyu0Nry/QrgVvQ/tZsP
         yK79hFShDmh8gPPgFnedMGLzvLZF8bNN6YQW5Qso=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qing Xu <m1s5p6688@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 171/173] mwifiex: Fix possible buffer overflows in mwifiex_cmd_append_vsie_tlv()
Date:   Thu, 13 Feb 2020 07:21:14 -0800
Message-Id: <20200213152014.080520382@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qing Xu <m1s5p6688@gmail.com>

[ Upstream commit b70261a288ea4d2f4ac7cd04be08a9f0f2de4f4d ]

mwifiex_cmd_append_vsie_tlv() calls memcpy() without checking
the destination size may trigger a buffer overflower,
which a local user could use to cause denial of service
or the execution of arbitrary code.
Fix it by putting the length check before calling memcpy().

Signed-off-by: Qing Xu <m1s5p6688@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index c013c94fbf15f..0071c40afe81b 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2890,6 +2890,13 @@ mwifiex_cmd_append_vsie_tlv(struct mwifiex_private *priv,
 			vs_param_set->header.len =
 				cpu_to_le16((((u16) priv->vs_ie[id].ie[1])
 				& 0x00FF) + 2);
+			if (le16_to_cpu(vs_param_set->header.len) >
+				MWIFIEX_MAX_VSIE_LEN) {
+				mwifiex_dbg(priv->adapter, ERROR,
+					    "Invalid param length!\n");
+				break;
+			}
+
 			memcpy(vs_param_set->ie, priv->vs_ie[id].ie,
 			       le16_to_cpu(vs_param_set->header.len));
 			*buffer += le16_to_cpu(vs_param_set->header.len) +
-- 
2.20.1



