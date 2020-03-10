Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6FBC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6182468E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844686;
	bh=FXX8B0x0n9nfbA091PCc2o//Nqx3Gj8KH1PPBSL/LpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mej/sFznbF/DEOIHqlYTqawx5AqmO+p2rQGACmJMyg1bjjTEvpqghuP5uQbwT7e6O
	 g86yVv/0mvV4BtyzpCevEL+4OP2exUV2ycORjxqy8MyVAfEsYXjGp7PzkvYhlIQQR9
	 3ZvlIZYxFuko9O7kmRIqYEB7mDTPeUU+6CCnOJnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgCJMvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728891AbgCJMvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:51:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C64112468E;
        Tue, 10 Mar 2020 12:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844682;
        bh=FXX8B0x0n9nfbA091PCc2o//Nqx3Gj8KH1PPBSL/LpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPkqC9abs+TCWzytEpA8xSvrfOE6h5JRf8OR5o/iZBEplLRGH1VsBifiwyyxj4EAb
         j//EFXBN7Ex1F6WENLyLQyN61Zf16cdoZWtkjqhMe450xP11zk0yOLSadOvs+rM/Gy
         0oUhrL3+YvjKoNILqyeSbnF1GF+WCrUBfNvWEmpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5.4 081/168] arm: dts: dra76x: Fix mmc3 max-frequency
Date:   Tue, 10 Mar 2020 13:38:47 +0100
Message-Id: <20200310123643.490848614@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

commit fa63c0039787b8fbacf4d6a51e3ff44288f5b90b upstream.

dra76x is not affected by i887 which requires mmc3 node to be limited to
a max frequency of 64 MHz. Fix this by overwriting the correct value in
the the dra76 specific dtsi.

Fixes: 895bd4b3e5ec ("ARM: dts: Add support for dra76-evm")
Cc: stable@vger.kernel.org
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/dra76x.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -86,3 +86,8 @@
 &usb4_tm {
 	status = "disabled";
 };
+
+&mmc3 {
+	/* dra76x is not affected by i887 */
+	max-frequency = <96000000>;
+};


