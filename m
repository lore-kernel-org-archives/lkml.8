Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EAAC33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560092082E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="QsXbABDH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iaa1lIeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbgAMEto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 23:49:44 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:40503 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733187AbgAMEtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:49:40 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 833CF6286;
        Sun, 12 Jan 2020 23:49:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 23:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=9YxF7o4BldhI8
        e6OFwdV3KAX/NNXrRs/YnHG4TVAwOU=; b=QsXbABDHTOUoyn5fVsU+1XAwDOjfm
        Saivg0ZnDPqoS28joUVuq0PHiJrI7oecGFMSRYMKtzI0s10+uLnNo+QqsBsBOE/l
        K7Y8TlwTiiuopj8zW5F7HLh/aTkMjJb6ZeVLIfgEFag00+y4anOUK7BUDsjrbEbN
        oMlvzrq90p5BcYEohB4vR9tSqZa0u35kscTyrAYbYS9Ct+fG3kE9YzPuX8CKAa3p
        qMukJL25zZqh4/Z3ZEw4MAHzAX3Z96kwyKasM3Gd7J5FJQ6lKPD99n3gUOCgE5CA
        pvu0PefzTvFJS7o0a1lL5TOJomqh31+he8zZ09nBR4Rz2jxyB5wZnFs/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=9YxF7o4BldhI8e6OFwdV3KAX/NNXrRs/YnHG4TVAwOU=; b=iaa1lIeE
        F35Mfv3kjGfQE1lNgnkNRAsD+NAeo2OfPBNDUsJbD27J1xBfN7iNSrQB4N0rCxyf
        YI7i+yad0bLMR+E3B/adDwlxRDiKOkDycmtYmntmbkOoPc6ACCz2b6darUVWEnbp
        BpLEKjong1C+b2324f+OCuBNlQFkVqYC2yAsijGQfLoMiXPaXkgwjxeOIpHTIF1L
        8C6y34Y+AgZ7K6W3apxcETgQFfWwruIDc0EBYM6WkBdD4v6ULIv4GDTmCPAYmPZn
        34/mZMBj08bzo3RKIcvZAsw3H7VCoRk1qsov97IY+KAk2SVksI207RA9++fb4POT
        PIyZtN/V0WkoOA==
X-ME-Sender: <xms:4_YbXvUPBNuGmdaxYZFpBKwzv6fvphF6dC9iX4W_173bhsn2izPGIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:4_YbXl-EBWqpz8_sC8YyUZsJOtjvbRYvGf_fW6GizEXXshqdu-Lh0w>
    <xmx:4_YbXjfC6tVkI4bXcs5oEyF8gj8rTP72KzH3n4cqBr6URqHLeXbKag>
    <xmx:4_YbXvibB7Tq2qjcdo_6G0Q6q8JB1JjqUMAcgkAxvUnTPuaoIHOe5Q>
    <xmx:4_YbXktKn8pkeOZg3618L_HAxYOKxfsPzM8xW4d0voaQyOsq1MqQ_g>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C46F930607BE;
        Sun, 12 Jan 2020 23:49:38 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 3/9] dt-bindings: irq: Add a compatible for the H3 R_INTC
Date:   Sun, 12 Jan 2020 22:49:30 -0600
Message-Id: <20200113044936.26038-4-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113044936.26038-1-samuel@sholland.org>
References: <20200113044936.26038-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner H3 SoC contains an R_INTC that is, as far as we know,
compatible with the R_INTC present in other sun8i/sun50i SoCs starting
with the A31. Since the R_INTC hardware is undocumented, introduce a new
compatible for the R_INTC variant in this SoC, in case there turns out
to be some difference.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
index 0eccf5551786..fffffcd0eea3 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
@@ -29,6 +29,9 @@ properties:
       - items:
         - const: allwinner,sun8i-a83t-r-intc
         - const: allwinner,sun6i-a31-r-intc
+      - items:
+        - const: allwinner,sun8i-h3-r-intc
+        - const: allwinner,sun6i-a31-r-intc
       - const: allwinner,sun9i-a80-sc-nmi
       - items:
         - const: allwinner,sun50i-a64-r-intc
-- 
2.23.0

