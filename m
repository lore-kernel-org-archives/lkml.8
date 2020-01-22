Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6A4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984742468A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686408;
	bh=SpDzbbOwicUHa4Zm+r4y/NZKqNvo4lpUqQrWehgGjZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jf6RLuAFNMA4ynTG1GeapCJMOCdHZHliqWHh9dZy7Mgw/c0UH6qV2fnFxiN1V8y1z
	 nbB85zTZnimRW1jbf+43PTa2JPVIVxQDUqVfDsuMsG7zsC+8MPpT7X3hlhLYAjYSiT
	 V+WKi0P1EtwqkRpN1fD+3e5kbmnrxKGiA9i5fbOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbgAVJqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:46:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387513AbgAVJnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:43:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB4F224689;
        Wed, 22 Jan 2020 09:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686197;
        bh=SpDzbbOwicUHa4Zm+r4y/NZKqNvo4lpUqQrWehgGjZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ONzDCBBE1d8sX5MX2Mi5xhA7RSCfTVmtbrY4yZuszxsVc3px3zjAEl6/kHQxlM34y
         plcfhW2cby7SiY8m4gw+feDRJdQJA3lxc608WVsOacmc6ht0lS4kzzQXjTKZrnOhqE
         PoruTBw5WZAwRUjPp7MsPA7jUTKxAHXMLGeZY46k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 4.19 083/103] arm64: dts: meson-gxl-s905x-khadas-vim: fix gpio-keys-polled node
Date:   Wed, 22 Jan 2020 10:29:39 +0100
Message-Id: <20200122092815.061520037@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
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


