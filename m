Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0922CC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC64920848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="LEUl6BRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbgBKTgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:36:40 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.155]:14749 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730960AbgBKTgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:36:38 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id C9D2B400C5AB2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 13:36:37 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1bKnjfioiAGTX1bKnjs7vb; Tue, 11 Feb 2020 13:36:37 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UM0S/XX22/eXnz8emf2UzrArwB+5xzNNImR9J+pKjzA=; b=LEUl6BRslj1G7JB0krKO9LhFO+
        TtVynXO3yhi2pAvhqYjAn3QzO2D2W1urUOIBbth6z9A3oi+IbdJZLsC9GTxjLDdneqfCBiOkdgpk9
        WnaAF9hp2Y7AwOgpwk9nsp7HOEJKl6j1TOuLwj/w6GKN5iqfgxrl60+SUG5d92yp5Y92rZWxxguIT
        mPuoBbRqyQTHUj5lXPVcTWudocAzlkJeIzKHzY8mYikjoVtDxGqY6fikZSrEIr7n2TPhhIpe2pkBB
        HTIOpnm1ieqm9HR2H7ge31UCcJ+modFhD5GDvUEoazAabs2X3girzdicFvbPmr6fvhwdEcT7lMeCk
        zKyVGjfw==;
Received: from [200.68.140.36] (port=5745 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1bKm-001Hcy-7Z; Tue, 11 Feb 2020 13:36:36 -0600
Date:   Tue, 11 Feb 2020 13:39:10 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: core: Replace zero-length array with flexible-array
 member
Message-ID: <20200211193910.GA4596@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.68.140.36
X-Source-L: No
X-Exim-ID: 1j1bKm-001Hcy-7Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:5745
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertenly introduced[3] to the codebase from now on.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/core/oss/rate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/oss/rate.c b/sound/core/oss/rate.c
index 2fa9299a440d..e9f20fefb117 100644
--- a/sound/core/oss/rate.c
+++ b/sound/core/oss/rate.c
@@ -47,7 +47,7 @@ struct rate_priv {
 	unsigned int pos;
 	rate_f func;
 	snd_pcm_sframes_t old_src_frames, old_dst_frames;
-	struct rate_channel channels[0];
+	struct rate_channel channels[];
 };
 
 static void rate_init(struct snd_pcm_plugin *plugin)
-- 
2.25.0

