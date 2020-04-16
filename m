Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EC2C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB8B20786
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587045424;
	bh=qeJIGrrKdtjjhYFAXGoPTkTclmMEdQSo7v/P9jFqUMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rHaoimls+nIxW1/LrynpUQT8QrPfPUfFRmPddZOxUCrmfAf/k2jhFFqXCL5e2S0G+
	 x/eyxC6E3tY49xl6nbi9gWWy8w7/3npMIYHRjBnlYRAkej+cOwhtwMrO9aicjsm60I
	 WBnuoGrNko3MWI8KxZvAu4UvNiIJPJVMoYRNjwaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441835AbgDPN5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897786AbgDPNi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:38:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED85B22202;
        Thu, 16 Apr 2020 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044338;
        bh=qeJIGrrKdtjjhYFAXGoPTkTclmMEdQSo7v/P9jFqUMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b24VPXW/zjC+7uKUOYHXoe5syDFUrsEB5rfCFSJdhRwZrynOHNPN+MD0dlnUFpoX1
         CWPQp78H0aV6sTiPNCrUQ5oXoNrAalo2jYMSLtTAOWdvcZSxezO19AZzH2PZUPVfll
         2F7hYDAK8FOgC/jr7iNmSrWEW4UJEIcniyfeeObk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.5 178/257] arm64: dts: allwinner: h5: Fix PMU compatible
Date:   Thu, 16 Apr 2020 15:23:49 +0200
Message-Id: <20200416131348.603331667@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime@cerno.tech>

commit 4ae7a3c3d7d31260f690d8d658f0365f3eca67a2 upstream.

The commit c35a516a4618 ("arm64: dts: allwinner: H5: Add PMU node")
introduced support for the PMU found on the Allwinner H5. However, the
binding only allows for a single compatible, while the patch was adding
two.

Make sure we follow the binding.

Fixes: c35a516a4618 ("arm64: dts: allwinner: H5: Add PMU node")
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -77,8 +77,7 @@
 	};
 
 	pmu {
-		compatible = "arm,cortex-a53-pmu",
-			     "arm,armv8-pmuv3";
+		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,


