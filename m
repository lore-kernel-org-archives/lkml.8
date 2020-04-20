Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F2BC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E6372070B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386480;
	bh=0EGY66fsxLPM8SesOHH0e4VqaPDSb1hdf79Q4j0V9AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MKj1jDcGIF75CKGTroQbf4Q4dD8EKIFMw7GSwgNbgz4lwNHFhjinW6Ny/7Ij6x74T
	 c2c1AX3/LmxjZmgCgjYLX/KbKay87x4KxG3oLHQlx5yl0VhgdKpZYKvrMywpa1N3sw
	 vabatSoqBcAjg+K8gdemsQ8wcqrr/RV+0aV/tjfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgDTMlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:41:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgDTMlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:41:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2F242072B;
        Mon, 20 Apr 2020 12:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386474;
        bh=0EGY66fsxLPM8SesOHH0e4VqaPDSb1hdf79Q4j0V9AU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f28uBNnZR+rAGpHKvvesjMCr3ge4gsiUqn6icwisphzDEEqEamWF0lUoOPY3R38pj
         7wT7aIi2QQtdYXLpckLacySNyhCcMPvsFHCZ7/q2v7vkob5vfjMT2y+YwQDSTGsIIJ
         aFTwp1WihxrL+UThpw28NvEezyl9LMiQIoMFgpT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.5 36/65] arm64: dts: librem5-devkit: add a vbus supply to usb0
Date:   Mon, 20 Apr 2020 14:38:40 +0200
Message-Id: <20200420121514.100912290@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121505.909671922@linuxfoundation.org>
References: <20200420121505.909671922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angus Ainslie (Purism) <angus@akkea.ca>

commit dde061b865598ad91f50140760e1d224e5045db9 upstream.

Without a VBUS supply the dwc3 driver won't go into otg mode.

Fixes: eb4ea0857c83 ("arm64: dts: fsl: librem5: Add a device tree for the Librem5 devkit")
Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -743,6 +743,7 @@
 };
 
 &usb3_phy0 {
+	vbus-supply = <&reg_5v_p>;
 	status = "okay";
 };
 


