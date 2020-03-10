Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79095C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD7A2468D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845293;
	bh=QL+iDxpAQ55WZzcdTxqZzCarwSHL5yq6UkiU0yJfmbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fCV7+sU82lJ53NucPuDMWUgQ/VxkCe7II7RKDhpbzu8EtP1ZjoXEPxeRjNdFNqfWw
	 HtIscI7E+UD9bDm3QxPjQ0bJgcCKBxFDHBD09N+7M2hLrLuZ59jEikOGv4sp5dhfDb
	 JhWbKCsrylcT8djbR2wo6GnpAQavGYpP1txEPzMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgCJNBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730056AbgCJNB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:01:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D6872468D;
        Tue, 10 Mar 2020 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845286;
        bh=QL+iDxpAQ55WZzcdTxqZzCarwSHL5yq6UkiU0yJfmbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/Ocnjhk2f5ltAIp5WpeA8uZWuMuWFIzlX/YJICLr3mF/DXKSm/l+QtzvmVc3L+Oh
         tLLddg2Rk2ll+eHYso7MFNWwvc7wHZfvU7IZjF8QnVahfnaCYrIG7lasOvFtJ2BooG
         gttcioams+QjEF3De+Fn/T3JsrFvY1OyzUW1pVHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dragos Tarcatu <dragos_tarcatu@mentor.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.5 130/189] ASoC: topology: Fix memleak in soc_tplg_link_elems_load()
Date:   Tue, 10 Mar 2020 13:39:27 +0100
Message-Id: <20200310123652.954236710@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dragos Tarcatu <dragos_tarcatu@mentor.com>

commit 2b2d5c4db732c027a14987cfccf767dac1b45170 upstream.

If soc_tplg_link_config() fails, _link needs to be freed in case of
topology ABI version mismatch. However the current code is returning
directly and ends up leaking memory in this case.
This patch fixes that.

Fixes: 593d9e52f9bb ("ASoC: topology: Add support to configure existing physical DAI links")
Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Link: https://lore.kernel.org/r/20200207185325.22320-2-dragos_tarcatu@mentor.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-topology.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2335,8 +2335,11 @@ static int soc_tplg_link_elems_load(stru
 		}
 
 		ret = soc_tplg_link_config(tplg, _link);
-		if (ret < 0)
+		if (ret < 0) {
+			if (!abi_match)
+				kfree(_link);
 			return ret;
+		}
 
 		/* offset by version-specific struct size and
 		 * real priv data size


