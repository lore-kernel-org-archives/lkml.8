Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D3EC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A72D2495C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340521;
	bh=H9/BvLXZS1pY3l92KsMnzT6NS6j3NtYA6L+sxVYnLkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZL+giqt+CgTF9K+UrlEB95m57E8ZATMnXSDZ4Mdo5ycOcYbdQzuZ6wlFxoB9ZydDs
	 gs8FJmXp9Zi2eEySQ0/X9rskz/wiyYUjSUXmZ7YMm5NpXhHCHBWqOxgJHK6+z6hPwU
	 qKH9s+NOYuFJA+UBr8yXDyHywB/CBfy9a22VaF5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbgEANl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730948AbgEANly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:41:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1806208DB;
        Fri,  1 May 2020 13:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340514;
        bh=H9/BvLXZS1pY3l92KsMnzT6NS6j3NtYA6L+sxVYnLkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYSu0hafTGW4QIbqYnv6jgUoRGrBwe+DlBBmTrXM1ALwToomCp9SO23MTVQkIlE3R
         AS16jZfveCFRx6iBDlRJhvxypvbfIjZ8meCYqYKYICrrl182CTXmf1fs0YUpRzFN/Z
         ksgb2x+BjJiOqE4b+aHbThXxb8hyAYv+6ypA82dw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5.6 025/106] ARM: dts: OMAP3: disable RNG on N950/N9
Date:   Fri,  1 May 2020 15:22:58 +0200
Message-Id: <20200501131547.069242395@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
References: <20200501131543.421333643@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>

commit 07bdc492cff6f555538df95e9812fe72e16d154a upstream.

Like on N900, we cannot access RNG directly on N950/N9. Mark it disabled in
the DTS to allow kernel to boot.

Fixes: 308607e5545f ("ARM: dts: Configure omap3 rng")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/omap3-n950-n9.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -341,6 +341,11 @@
 	status = "disabled";
 };
 
+/* RNG not directly accessible on N950/N9. */
+&rng_target {
+	status = "disabled";
+};
+
 &usb_otg_hs {
 	interface-type = <0>;
 	usb-phy = <&usb2_phy>;


