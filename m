Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175EDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89D420873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Lvo2Y+qk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l65K9OGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgE0PqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:46:25 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40647 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389946AbgE0PqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:46:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 053785C0220;
        Wed, 27 May 2020 11:46:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 May 2020 11:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=87eNKXUXLK3tl
        nLtCpRNlpSIF8WfpGhrUkNfAEF99uc=; b=Lvo2Y+qkUjbo3DDu0fzrcR2f1wgTW
        UJZ5UvkUhM65Fd76Uei/flqLULaXV0AEHgdClcT2Gi53GpgBSZ2Di9EgowZvaCPX
        7L8fOAadlHob08WuF6Lls01Rflyr3oI9hdF7Saw/TCUEBjH7n/7nGg5EFFN4UI9z
        wWHNauMu6xIiySMy0holRk9wgS8dztfcu0Ls2fG3lU+UHY7fHa9173ZV0yDiS82E
        bLmag+oSkzKf0HxwRM/pdIFCmZr5jJpXyfaZnzV0NRt0o+fL3/mTNlLHuWewa9O2
        o+7ITsinNck/SYsVvPNYyxhIjSYMLM4hbtFvjxx6CpkGVwNBDq3g0V66A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=87eNKXUXLK3tlnLtCpRNlpSIF8WfpGhrUkNfAEF99uc=; b=l65K9OGZ
        TSbIrtWXlZu9MVogylcJ8/dHF30saDK8dc30RM7Va5QzcmimMbGWaU+rxZiKmuq/
        PvW1qOYpDg9CwxGxJnm2jF2ANwJHGd5zmH7BT1dz8Bwl2HJFhhFx5kQUgX0z+2Yx
        sb1Ydhf/5pBzeh+VPDfX+g/HCh27xVl/SYg+hrmpLO5jccSonf52sfE/T39K1Fqb
        QwSfvSU+BDGIS1A3Fd8HKdir4MhozeMdiq3beIlcuuhDuZ4RMhP0vxnW5Qmc6LZ7
        hNQ5KZDFK/HJpYhHQtlhO1d8kEarYPHHP5ZBDQpWeobbSESlJhHoAVjZFL6Zgo64
        mJFZ+xlvjcDD4w==
X-ME-Sender: <xms:PYvOXoY_ybKs2nv92JfY7Nnxm3Y5IzRdFdQp5AkOWR-TGEHDh7m6gA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvddvne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:PYvOXjaMQPqg5dpar60mvJ6uAfMj3KXapdS1XitN4jiLMQvSeDq6lQ>
    <xmx:PYvOXi-PnJjpBlIzpKqJn5lNoFWJnoZTzFgR3fWStdTwD74vcmbNkQ>
    <xmx:PYvOXiqdhKkG5itgr8mcgAGyGU9haKcrAaUk8RCfB9t-vkBfHJW_xQ>
    <xmx:PovOXkCm27yFuWpONNGk0jlJ0YX0jnovff8pvQjk2q7WQkQGtu3LWw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 832A230614FA;
        Wed, 27 May 2020 11:46:05 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 25/25] ARM: dts: bcm2711: Add firmware clocks node
Date:   Wed, 27 May 2020 17:45:21 +0200
Message-Id: <ec9e6942c9f16390e530c2aea2a565f95fe6e929.1590594293.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a clock driver for the clocks exposed by the firmware,
let's add the device tree nodes for it.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index c7f1d97e69bb..222d7825e1ab 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -69,6 +69,11 @@
 };
 
 &firmware {
+	firmware_clocks: clocks {
+		compatible = "raspberrypi,firmware-clocks";
+		#clock-cells = <1>;
+	};
+
 	expgpio: gpio {
 		compatible = "raspberrypi,firmware-gpio";
 		gpio-controller;
-- 
git-series 0.9.1
