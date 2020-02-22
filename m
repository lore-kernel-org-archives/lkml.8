Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F21C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 19:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D3A20707
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 19:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582398299;
	bh=fwbT9Mep0GZjK9Bl6lO7YTQUECfVKAMH7RJytq0zw0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S6pXXDw/TIxCQh4Kuvw74XvV7/I1rcxyOd58JwWNuAZWhVc5RM1Dz5XRza5ywbW50
	 cqPQPPmKSMtEwnsiC0AOB73DnD93eXslnsuNLb5YVktP3DtlXMbgstxxnGovU37rAc
	 y6GI0eOEBAk6PQSZ7pBF5AOg9WaUVauGd3M05JGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgBVTE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 14:04:57 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:23005 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgBVTEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 14:04:55 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 01MJ4cZ5012807;
        Sun, 23 Feb 2020 04:04:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 01MJ4cZ5012807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582398280;
        bh=mrcXVofupgO4d3c0vzyQKQn7NS2LwHZgk1SmeQ1M0CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENwtBFQCC6YJf2mbU6dDo5FZWRPT+R9/FRc2vSXAGAatC3yS+xArurV1ylVHsN4vA
         rOmUEFRmeTAqouuS5JdUx8HrJYOrDbnDyISxwXdE/as1zryF99vUsXL5hXlZF6kFoG
         z+14SVvgCosITMo/tLqa/Tbc4qUHx48mzZlmTQrImSxPnNqWO2NT/l4BXMr64SPwUo
         ADlBEnutKk1OWjcTV29gSoeRIZpFLg9ZidVkcVFUx0jm0R0IsRP/L1n+G0XDMRBip5
         Csk93cWEypB7PVs0ka4g3vkw6oe0VdNrfjRlTE4Ymu6Tb0NjxKEqxgsj2ZpAD1Wky5
         CZU0WREsxBijg==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] kbuild: add dtbs_check to PHONY
Date:   Sun, 23 Feb 2020 04:04:33 +0900
Message-Id: <20200222190435.11767-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200222190435.11767-1-masahiroy@kernel.org>
References: <20200222190435.11767-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dtbs_check should be a phony target, but currently it is not
specified so.

'make dtbs_check' works even if a file named 'dtbs_check' exists
because it depends on another phony target, scripts_dtc, but we
should not rely on it.

Add dtbs_check to PHONY.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index aab38cb02b24..102710a9228c 100644
--- a/Makefile
+++ b/Makefile
@@ -1238,7 +1238,7 @@ ifneq ($(dtstree),)
 %.dtb: include/config/kernel.release scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
 
-PHONY += dtbs dtbs_install dt_binding_check
+PHONY += dtbs dtbs_install dtbs_check dt_binding_check
 dtbs dtbs_check: include/config/kernel.release scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree)
 
-- 
2.17.1

