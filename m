Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730F4C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EF620772
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585202308;
	bh=OhekPoJuC9vwRp78NfmnSRFuigvA7fJX+5w6f1PSSFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H/70098MjoM6ip35coXtsjrXZQOBvXT4H5AzmE+7rOPDr5xXFnBV4k58EU92TuSnl
	 y/kEP3BgNf9dH3l/TEvLeUqGfpU0loFQ9sIBsvlEdtKo5QjFPHlZ5XveuajQ6YjTVa
	 tBNEZ+Y85IVsxDtRYJbcTTrSn+Ong25jkQH6M0z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgCZF60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 01:58:26 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:47754 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgCZF60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 01:58:26 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 02Q5ve96008573;
        Thu, 26 Mar 2020 14:57:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 02Q5ve96008573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585202262;
        bh=RjmAIJifJD5EjYLBPngifFMr8SyoOw1VRH4zJbCaW44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0npEybbV/z2lQiHwEs9TcPf5+poHUosRxXgwWfTNlY0D593Lc5sxgg3TW8bgnxjmY
         7hX43Es4EaTmdEOf4fzkcusWx/1+rz6MrwYd6v+Sgx5BafCADuzRTM9ELLBUC7o/V0
         p0CChm95KUAbSKBF8tUVnBi2vopRnHPeWX6kc4ikco8XHPW2fuRYfqS5ef6B5L67yx
         l82dEkMArUHtg2RAAgAAkB68/UWwxidScmcuTX1Jrgch3QVGFzcj0jzOKZLW6EaLJB
         DWXLqcaQCOUX5TqMRC+xe0gQ8t3tlF3zs+s5tPdGhdAB4j9vo6qHcv2R1J7YOvSgkh
         mP0gwu3qrBwjA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 3/4] net: wan: wanxl: refactor the firmware rebuild rule
Date:   Thu, 26 Mar 2020 14:57:17 +0900
Message-Id: <20200326055719.16755-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326055719.16755-1-masahiroy@kernel.org>
References: <20200326055719.16755-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the big recipe into 3 stages, compile, link, and hexdump.

After this commit, the build log with CONFIG_WANXL_BUILD_FIRMWARE
will look like this:

  M68KAS  drivers/net/wan/wanxlfw.o
  M68KLD  drivers/net/wan/wanxlfw.bin
  BLDFW   drivers/net/wan/wanxlfw.inc
  CC [M]  drivers/net/wan/wanxl.o

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 drivers/net/wan/Makefile | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wan/Makefile b/drivers/net/wan/Makefile
index cf7a0a65aae8..380271a011e4 100644
--- a/drivers/net/wan/Makefile
+++ b/drivers/net/wan/Makefile
@@ -47,14 +47,23 @@ else
   M68KLD = $(CROSS_COMPILE_M68K)ld
 endif
 
-quiet_cmd_build_wanxlfw = BLD FW  $@
-      cmd_build_wanxlfw = \
-	$(M68KCC) -D__ASSEMBLY__ -Wp,-MD,$(depfile) -I$(srctree)/include/uapi -c -o $(obj)/wanxlfw.o $<; \
-	$(M68KLD) --oformat binary -Ttext 0x1000 $(obj)/wanxlfw.o -o $(obj)/wanxlfw.bin; \
-	hexdump -ve '"\n" 16/1 "0x%02X,"' $(obj)/wanxlfw.bin | sed 's/0x  ,//g;1s/^/static const u8 firmware[]={/;$$s/,$$/\n};\n/' >$(obj)/wanxlfw.inc; \
-	rm -f $(obj)/wanxlfw.bin $(obj)/wanxlfw.o
-
-$(obj)/wanxlfw.inc:	$(src)/wanxlfw.S
-	$(call if_changed_dep,build_wanxlfw)
-targets += wanxlfw.inc
+quiet_cmd_build_wanxlfw = BLDFW   $@
+      cmd_build_wanxlfw = hexdump -ve '"\n" 16/1 "0x%02X,"' $< | \
+	sed 's/0x  ,//g;1s/^/static const u8 firmware[]={/;$$s/,$$/\n};\n/' > $@
+
+$(obj)/wanxlfw.inc: $(obj)/wanxlfw.bin FORCE
+	$(call if_changed,build_wanxlfw)
+
+quiet_cmd_m68kld_bin_o = M68KLD  $@
+      cmd_m68kld_bin_o = $(M68KLD) --oformat binary -Ttext 0x1000 $< -o $@
+
+$(obj)/wanxlfw.bin: $(obj)/wanxlfw.o FORCE
+	$(call if_changed,m68kld_bin_o)
+
+quiet_cmd_m68kas_o_S = M68KAS  $@
+      cmd_m68kas_o_S = $(M68KCC) -D__ASSEMBLY__ -Wp,-MD,$(depfile) -I$(srctree)/include/uapi -c -o $@ $<
+
+$(obj)/wanxlfw.o: $(src)/wanxlfw.S FORCE
+	$(call if_changed_dep,m68kas_o_S)
 endif
+targets += wanxlfw.inc wanxlfw.bin wanxlfw.o
-- 
2.17.1

