Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BEBC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078C920678
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699788;
	bh=SpDzbbOwicUHa4Zm+r4y/NZKqNvo4lpUqQrWehgGjZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jvBu2I0yKZLeFlVgz+lA6HPXTGVyO/GESZWy/aNBeCLNJ0WqX4jOm8njKzocDEAdw
	 9Nc6fCtNd9ZGFmWArtPqjMKwCPPC8Nufc8+wbWebznaJi12Mg0uAX1bvln6KxyBndl
	 zirQFoIG6eTJcZ6paZLWAtHwhFEaD8RdHYU+ki4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbgAVN0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:26:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729774AbgAVNZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:25:59 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A15F92467E;
        Wed, 22 Jan 2020 13:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699557;
        bh=SpDzbbOwicUHa4Zm+r4y/NZKqNvo4lpUqQrWehgGjZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b49UKK4Zvd9Ly8KK8QKhFG7QKLDSmXyBJvCIWpoxvfsl50DtCty7S7/1ZQ/IN8n0z
         elFOvc0UYzCP7NXn/7/QQ5dv8bi95519gQ5LHa0aZ6Jj61qAyhxV4s8ZrOqPjZEXs1
         Z01deUI3PTESrllwhiQ+rAjZ3iSe18xOxJvKhMhY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 5.4 178/222] arm64: dts: meson-gxl-s905x-khadas-vim: fix gpio-keys-polled node
Date:   Wed, 22 Jan 2020 10:29:24 +0100
Message-Id: <20200122092846.441350088@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

commit d5f6fa904ecbadbb8e9fa6302b0fc165bec0559a upstream.

Fix DTC warnings:

arch/arm/dts/meson-gxl-s905x-khadas-vim.dtb: Warning (avoid_unnecessary_addr_size):
   /gpio-keys-polled: unnecessary #address-cells/#size-cells
      without "ranges" or child "reg" property

Fixes: e15d2774b8c0 ("ARM64: dts: meson-gxl: add support for the Khadas VIM board")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -33,11 +33,9 @@
 
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		poll-interval = <100>;
 
-		button@0 {
+		power-button {
 			label = "power";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;


