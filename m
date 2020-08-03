Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43115C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16BD220738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457310;
	bh=BVwzFKiVpuCd9zR8RL2bcPlOG5HmNG3KEtqme8bzdcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rlBE+VvSFnYRBGWhJdsiZl+VpFN+GVu0R2JbzeLSok757rPxZ6Emx9/Xt23yg+emM
	 5NLxHLKqd4n3cc4p4jDDfkPgtxEiczn5iajEVtFTWpCupXA3OXiSRKm5YeJePUKtyy
	 7jtGXEquobvx9MI4HHpTpMbHdmWfE/hZpHaY5W7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgHCMVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgHCMVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:21:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 997BC20775;
        Mon,  3 Aug 2020 12:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457299;
        bh=BVwzFKiVpuCd9zR8RL2bcPlOG5HmNG3KEtqme8bzdcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmzuVN98oZqEwVnhQiDN2mOTJncjl6llupVvDxoL79KlrIoCOaEJPpP7nifPABKhu
         dtPKP4OGFhTEV/EpBSolPjOAU+kckFJVvwLjQOmRCvIdXUBrxSRvNVeBsv+nWgwTEh
         lk06h57lMyzgAag7fApBQ3f8Fg16PsH5D6V7LE0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.7 018/120] ARM: dts: imx6sx-sdb: Fix the phy-mode on fec2
Date:   Mon,  3 Aug 2020 14:17:56 +0200
Message-Id: <20200803121903.739270751@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121902.860751811@linuxfoundation.org>
References: <20200803121902.860751811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

commit c696afd331be1acb39206aba53048f2386b781fc upstream.

Commit 0672d22a1924 ("ARM: dts: imx: Fix the AR803X phy-mode") fixed the
phy-mode for fec1, but missed to fix it for the fec2 node.

Fix fec2 to also use "rgmii-id" as the phy-mode.

Cc: <stable@vger.kernel.org>
Fixes: 0672d22a1924 ("ARM: dts: imx: Fix the AR803X phy-mode")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6sx-sdb.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -213,7 +213,7 @@
 &fec2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet2>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy2>;
 	status = "okay";
 };


