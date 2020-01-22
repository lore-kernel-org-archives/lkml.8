Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5086C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E53E24697
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686300;
	bh=aSV8YN8FUxhKqGyvl1LF4GoWMng6nckjMxuUvtSrAJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MjxVW4c7uLcrPYzBGZ8/8+RkxDNk+HdPtOtfivd5EXW/3DKvQ1gbYGZ1pX42vzzjy
	 WdFnBCb8mqYbQRRvEU6mAQoK/kopwGLJn1XoH26KvYTnlZriyv+WcsqTADKcEA0W4F
	 YbBjFk9uYJ3mxt9m+pUbL43G7ZdZWEqHd8ZI546M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbgAVJo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:44:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387642AbgAVJox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:44:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E31BC24689;
        Wed, 22 Jan 2020 09:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686293;
        bh=aSV8YN8FUxhKqGyvl1LF4GoWMng6nckjMxuUvtSrAJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTdD+1GEVo5zIH3h/uJHS35BWpij+OfAXW7wnaSILyt2itVxni21xuy4DKhV/wYpb
         iH6fiTfkwGghF8zu/j39fUPu+I9+mOS0SC/X4tSSS2gBCMA2WbS+jbh5tBe859/zY5
         r+wCZQ3FiA7izyrp3rlXDlxRJj1iS4hTn/r3kh3k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.4 019/222] ARM: dts: imx7ulp: fix reg of cpu node
Date:   Wed, 22 Jan 2020 10:26:45 +0100
Message-Id: <20200122092834.776704477@linuxfoundation.org>
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

From: Peng Fan <peng.fan@nxp.com>

commit b8ab62ff7199fac8ce27fa4a149929034fabe7f8 upstream.

According to arm cpus binding doc,
"
      On 32-bit ARM v7 or later systems this property is
        required and matches the CPU MPIDR[23:0] register
        bits.

        Bits [23:0] in the reg cell must be set to
        bits [23:0] in MPIDR.

        All other bits in the reg cell must be set to 0.
"

In i.MX7ULP, the MPIDR[23:0] is 0xf00, not 0, so fix it.
Otherwise there will be warning:
"DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map"

Fixes: 20434dc92c05 ("ARM: dts: imx: add common imx7ulp dtsi support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx7ulp.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -37,10 +37,10 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu0: cpu@0 {
+		cpu0: cpu@f00 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
-			reg = <0>;
+			reg = <0xf00>;
 		};
 	};
 


