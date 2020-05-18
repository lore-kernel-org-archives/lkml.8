Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB6CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 536602083E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825213;
	bh=x2k6H2u4z4R3Mw2PyUDpbwdtIYEjroK2GYUDNPg6l3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BZmoH07PmzhBzCPnVY3aOaYkS5BCsCfRtyJXU8aRF7hcNpEtXrg0bee/JLoMdNJE2
	 ss+by8g3HKA9Jn6C9WMZ7WPLT2T05ubaihJORefjvBInpvKIETmf5wxTxhH3n3CWZP
	 88ZUk4/w/CBoMV4aVXQLDpIO3VlnAOO1CBnk3kFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733225AbgERSGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732602AbgERSGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:06:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87B29208FE;
        Mon, 18 May 2020 18:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825207;
        bh=x2k6H2u4z4R3Mw2PyUDpbwdtIYEjroK2GYUDNPg6l3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z4mD39vn9gjnlvJLiRRm9xvGFgJouaUgRZzEnnrq037fvPq7w51OQ4S0bPUrM23fb
         3w0ie9GajJ0aKVmvtPF2ok3EgBh6U7hfVCb109JSpVStp9UbNIffLUt2wT30IgThv2
         eGcpCgRkfvn/8xD3RCHnDHehCfyqfdbv/IrqWtEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 5.6 173/194] arm64: dts: meson-g12b-khadas-vim3: add missing frddr_a status property
Date:   Mon, 18 May 2020 19:37:43 +0200
Message-Id: <20200518173546.071184445@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

commit 5ac0869fb39b1c1ba84d4d75c550f82e0bf44c96 upstream.

In the process of moving the VIM3 audio nodes to a G12B specific dtsi
for enabling the SM1 based VIM3L, the frddr_a status = "okay" property
got dropped.
This re-enables the frddr_a node to fix audio support.

Fixes: 4f26cc1c96c9 ("arm64: dts: khadas-vim3: move common nodes into meson-khadas-vim3.dtsi")
Reported-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20191018140216.4257-1-narmstrong@baylibre.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
@@ -152,6 +152,10 @@
 	clock-latency = <50000>;
 };
 
+&frddr_a {
+	status = "okay";
+};
+
 &frddr_b {
 	status = "okay";
 };


