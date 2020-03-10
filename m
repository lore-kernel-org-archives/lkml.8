Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F316C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85F624696
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844878;
	bh=sCrSOMdqJ6/BW5rilN1/UH6u6POlrqAmnRwzGl1k3pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dJr8EMfq6/o5OMM3e1JiWIRVgk5gX5AEL1YMxt580GTQtik9+Cj/pRO4XrQxmfww9
	 yzeLp0N6HEiS3yJloQ212E1q+b/co0GIq1hN2CXXpUszQ0IIksP+Cb4ycj44XL7wSr
	 7U0c8XjxC9INVeQwLdqb7K+Pc/Yz9rcHm3JJqack=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgCJMyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:54:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:32990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729377AbgCJMye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:54:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63DD424692;
        Tue, 10 Mar 2020 12:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844873;
        bh=sCrSOMdqJ6/BW5rilN1/UH6u6POlrqAmnRwzGl1k3pY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpfjui7X8NyMIWIQT5Tz2bAVrd1JVE9rpOsz67U7MPsBmrEuUIdv690FpOjpKsxlR
         Bo+aAw0cJMZELIG6e/g7PTuaA5nLMMWQjFKODQTi3tlG9nzeFyoK5++hDT5dscoYHZ
         pkn586Vfp4ijcRuDDTSPEpzqKQ+wciKIQN1mjihk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume La Roque <glaroque@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 5.4 112/168] arm64: dts: meson-sm1-sei610: add missing interrupt-names
Date:   Tue, 10 Mar 2020 13:39:18 +0100
Message-Id: <20200310123646.724859318@linuxfoundation.org>
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

From: Guillaume La Roque <glaroque@baylibre.com>

commit 5bea1336ed2c939328999c64de28792e8dc0699b upstream.

add missing "host-wakeup interrupt names

Fixes: 30388cc07572 ("arm64: dts: meson-sm1-sei610: add gpio bluetooth interrupt")

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lore.kernel.org/r/20200117133423.22602-1-glaroque@baylibre.com
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -363,6 +363,7 @@
 		compatible = "brcm,bcm43438-bt";
 		interrupt-parent = <&gpio_intc>;
 		interrupts = <95 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wakeup";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
 		max-speed = <2000000>;
 		clocks = <&wifi32k>;


