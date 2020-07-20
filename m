Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056BDC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04CE20656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261797;
	bh=ebxHgfFKVyhOruLi0OxNK2vq06D8LezsBVbx0iunYLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xFUbvxwYt8xb+Lscg8lsUdENAYG+oOt41jjfKDbQC8lAzG/RzzylR2ylGEIhGv5k5
	 hcLp+5o87hUstWuTGw00bW2RRzCsuCmB++bvy+v980Cnli5Seb22BgJlpHcZApniTZ
	 oO+yvTN6BV/ODMLS/mmZSync3xDb0cpyVkINR66w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbgGTQQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388565AbgGTQQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:16:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBABB2064B;
        Mon, 20 Jul 2020 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261794;
        bh=ebxHgfFKVyhOruLi0OxNK2vq06D8LezsBVbx0iunYLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dz2L13jR7136L8Oet2tCGyd9gcYRETat6ZtfJABYoFNS1V5xAcjBplo9uuETrKY+D
         H9WiDBnHn92UKUwLkuFbWsk9aRXBTbYtrQeH2HVgQFJV1oSA8Ql7GKCkjofuYSMKDy
         5IHRi07sZj6dBS34o5ilEGKGZdz7AESFmxYgrJRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 5.7 214/244] arm64: dts: stratix10: add status to qspi dts node
Date:   Mon, 20 Jul 2020 17:38:05 +0200
Message-Id: <20200720152836.026379867@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinguyen@kernel.org>

commit 263a0269a59c0b4145829462a107fe7f7327105f upstream.

Add status = "okay" to QSPI node.

Fixes: 0cb140d07fc75 ("arm64: dts: stratix10: Add QSPI support for Stratix10")
Cc: linux-stable <stable@vger.kernel.org> # >= v5.6
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts      |    1 +
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts |    1 +
 2 files changed, 2 insertions(+)

--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -155,6 +155,7 @@
 };
 
 &qspi {
+	status = "okay";
 	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
@@ -188,6 +188,7 @@
 };
 
 &qspi {
+	status = "okay";
 	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;


