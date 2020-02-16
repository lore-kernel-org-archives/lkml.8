Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACF9C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 19:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F13F2072C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 19:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="bMNA2fs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgBPTVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 14:21:11 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.101]:36624 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgBPTVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 14:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581880865;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=x19Yc0lwgVFAHPYdn2uCmqE96DBTXWvCWwEjKHcs+zU=;
        b=bMNA2fs65RrwGNGGQGziAS8PIpPY/YhTOUNGQyp3JUs7zK1Ae2QL3Gc9mNHSyafHhv
        Poqr/d171MM7v1jF1BxYGQAIaX+XGEJV0fmKfWn+HWh0BV0WKBAR8ySLn2eQ53amqaTx
        SZBeLdI189egGqUPQw/wvzpevw4c3xIdyr4U58yo+Bkzb+Y+2G+UB/pb+aQsG+szEP2a
        8G6oqa7nFUb3cjc83CxEs6F01xNigZLwJtMs9eM/4v+q0EvZNzxfPZKGxJrohfaBYnta
        rorBZg6uSVLcTPRtusDqPNBO1TXZD77xJoJCls0t3Y3R5XU7ARNnagn9qvPLwNrpNtAv
        TqPA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M0OoPPevMB"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.1.12 DYNA|AUTH)
        with ESMTPSA id U06217w1GJKtJla
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 16 Feb 2020 20:20:55 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andi Kleen <ak@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: [RFC v3 3/9] Bindings: nvmem: add bindings for JZ4780 efuse
Date:   Sun, 16 Feb 2020 20:20:45 +0100
Message-Id: <39c7917248e29e365b6939fed2be0d00d30b11df.1581880851.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1581880851.git.hns@goldelico.com>
References: <cover.1581880851.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

This patch brings support for the JZ4780 efuse. Currently it only expose
a read only access to the entire 8K bits efuse memory.

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../bindings/nvmem/ingenic,jz4780-efuse.txt     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt
new file mode 100644
index 000000000000..339e74daa9a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt
@@ -0,0 +1,17 @@
+Ingenic JZ EFUSE driver bindings
+
+Required properties:
+- "compatible"		Must be set to "ingenic,jz4780-efuse"
+- "reg"			Register location and length
+- "clocks"		Handle for the ahb clock for the efuse.
+- "clock-names"		Must be "bus_clk"
+
+Example:
+
+efuse: efuse@134100d0 {
+	compatible = "ingenic,jz4780-efuse";
+	reg = <0x134100d0 0x2c>;
+
+	clocks = <&cgu JZ4780_CLK_AHB2>;
+	clock-names = "bus_clk";
+};
-- 
2.23.0

