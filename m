Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B8FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB8D7207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457638;
	bh=gInQwPd+EnPSeAJ4zDWgp2u5GpqqQwc2FKg5EWUzg+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YsVd/ejHihPtUYfC5O9xq82IYg/ixxalzI8HjY7Vt0r4HeShC7T+qya+UT5o7LvWV
	 GxZii0qdw5U+Dwsg2P+IUWJl53onIaOa/p96kciZ8sdFc9lJk3Bmeb2VmszoCU+iUl
	 NOvWOz1uZg2KotqM4PvZM9UyDx8RBa/7FJ2XQcsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgHCM1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbgHCM1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:27:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 443B3204EC;
        Mon,  3 Aug 2020 12:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457632;
        bh=gInQwPd+EnPSeAJ4zDWgp2u5GpqqQwc2FKg5EWUzg+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KufTDBQJeDnuVCw2zksjQnvrkIl1xVTp8+wv9c73Gpx1a/DVN3pVH9qqqYutSspCO
         5i8sLp+AgOwAzLdjC8fxnzYBLJNLKbTuoc8ZOqm1RsEm+G2k4Iw51aJUHHhLGInXf4
         v2tmBE4TT95EotwnaDJVOXoJPSpUaeYdVqSes4R4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.4 18/90] ARM: dts: imx6sx-sabreauto: Fix the phy-mode on fec2
Date:   Mon,  3 Aug 2020 14:18:40 +0200
Message-Id: <20200803121858.501349151@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

commit d36f260718d83928e6012247a7e1b9791cdb12ff upstream.

Commit 0672d22a1924 ("ARM: dts: imx: Fix the AR803X phy-mode") fixed the
phy-mode for fec1, but missed to fix it for the fec2 node.

Fix fec2 to also use "rgmii-id" as the phy-mode.

Cc: <stable@vger.kernel.org>
Fixes: 0672d22a1924 ("ARM: dts: imx: Fix the AR803X phy-mode")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6sx-sabreauto.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -99,7 +99,7 @@
 &fec2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet2>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
 	fsl,magic-packet;
 	status = "okay";


