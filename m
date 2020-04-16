Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3DDC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB39A2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046455;
	bh=xwwvXdkTLkHv6AGvthi0kajQIzbM5WF2VxClMmRruQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nv2p3tDTE7updc5bCT0bS9EQOsvLsTSCjw4j7AGbyfZw0Q8GEVDIaJ5c7q5mjXRrj
	 tbHWyQlNDRD1EEuZ6pfEzGkWXjA6tWYTbhD9DywK7WDq4Wf9xzi00C5brtSLnIVnHu
	 b3CsJzpq5Ip3FtRufSlWCSRvYrmyZskyxh/xtGEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390769AbgDPOOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgDPNua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:50:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4463B21744;
        Thu, 16 Apr 2020 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045028;
        bh=xwwvXdkTLkHv6AGvthi0kajQIzbM5WF2VxClMmRruQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LkMAi9r6O21412xbyOsZWXHz0J2bNFj2smGp3rPMlmO5LvxaIylJ9t0PdWn/GZSr+
         l7oFNHxCqME5D2hhZ6Bud7EcJb6APMwbTw1+vLBtTmjmLxxScalX8GP3l95TN0kdJM
         HFNeBSVy29b6WlphontYPEBqVLl/Wz88MM7T00Y4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.4 200/232] clk: ingenic/TCU: Fix round_rate returning error
Date:   Thu, 16 Apr 2020 15:24:54 +0200
Message-Id: <20200416131340.282150287@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

commit edcc42945dee85e9dec3737f3dbf59d917ae5418 upstream.

When requesting a rate superior to the parent's rate, it would return
-EINVAL instead of simply returning the parent's rate like it should.

Fixes: 4f89e4b8f121 ("clk: ingenic: Add driver for the TCU clocks")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Link: https://lkml.kernel.org/r/20200213161952.37460-2-paul@crapouillou.net
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/ingenic/tcu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/ingenic/tcu.c
+++ b/drivers/clk/ingenic/tcu.c
@@ -189,7 +189,7 @@ static long ingenic_tcu_round_rate(struc
 	u8 prescale;
 
 	if (req_rate > rate)
-		return -EINVAL;
+		return rate;
 
 	prescale = ingenic_tcu_get_prescale(rate, req_rate);
 


