Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1C6C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6C52080C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624432;
	bh=OuDtSoNcule+00UeYjBaiEv6kX/1ADTjAIh3YAtvMNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WBaH+rakmBh8fFSac/81UIoOQ8FyMxx1hqKoq6AOjAjnIxPLbkk9Do2aC3pVrFt1A
	 zyk6XifRum/oaty3EiPXomSdhRbZ/Q2aVFNCGc9WmiZHS+c0818uJZhh5LGBaEgPtV
	 /hdv2BBM8F04Omj/NUKpaVAj8JQ7h+gnqXoDdSQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbgCSN1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730831AbgCSN1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:27:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EE9E207FC;
        Thu, 19 Mar 2020 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624426;
        bh=OuDtSoNcule+00UeYjBaiEv6kX/1ADTjAIh3YAtvMNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ycM+ph7TnpTg9rfVfLPkuvDeV2tU4T+LcGSumN7/NUn53ri05Y9wBm4EdUfvkOL00
         k3cWvvqHVuh1b54CU/DwvuFMfT3SDIhGIP6uWFa/saau0tdcjoonSQzOpLaaSG8ose
         FLvOIKHShzgEWZRRrt3l7HDCuOU0NEARkv7PWn90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 38/65] kbuild: add dt_binding_check to PHONY in a correct place
Date:   Thu, 19 Mar 2020 14:04:20 +0100
Message-Id: <20200319123938.502337938@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123926.466988514@linuxfoundation.org>
References: <20200319123926.466988514@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit c473a8d03ea8e03ca9d649b0b6d72fbcf6212c05 ]

The dt_binding_check is added to PHONY, but it is invisible when
$(dtstree) is empty. So, it is not specified as phony for
ARCH=x86 etc.

Add it to PHONY outside the ifneq ... endif block.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 362f1e2ca63ff..dcc0053ed18ad 100644
--- a/Makefile
+++ b/Makefile
@@ -1239,7 +1239,7 @@ ifneq ($(dtstree),)
 %.dtb: include/config/kernel.release scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
 
-PHONY += dtbs dtbs_install dtbs_check dt_binding_check
+PHONY += dtbs dtbs_install dtbs_check
 dtbs dtbs_check: include/config/kernel.release scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree)
 
@@ -1259,6 +1259,7 @@ PHONY += scripts_dtc
 scripts_dtc: scripts_basic
 	$(Q)$(MAKE) $(build)=scripts/dtc
 
+PHONY += dt_binding_check
 dt_binding_check: scripts_dtc
 	$(Q)$(MAKE) $(build)=Documentation/devicetree/bindings
 
-- 
2.20.1



