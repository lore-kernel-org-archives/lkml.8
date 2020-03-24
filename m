Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA9CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8577F20774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585066579;
	bh=QKMEnxBYMIsVGoEr2RqMombfHcAeNtr6LMiMvWqa9Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a7XpArNaPf2nFChEnwM2jyi/P3PIJZG9P0XjwkLQNCuYl8B7AH36QQdV/+WkG+qv4
	 80x7n7oleH3TSOJ7WOS7BCDL4bHfnIC7JUb/UrUHRVtRPtVzJURS8A5TQSA67PICkj
	 eq6ApOkj0J3dpxhm+WnYUT9PIrC+tUPp/BWPX1B4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgCXQQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:16:13 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:61250 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgCXQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:16:13 -0400
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 02OGFgQa015903;
        Wed, 25 Mar 2020 01:15:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 02OGFgQa015903
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585066544;
        bh=6U1SMKUP1mv8p0i1rCMwaF/RlF0pKJ0ys8hmyjfZYno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NS46Otd0y+b0vVCRnyv5xN1h3Xk0LBwbCBbBykQaPMOAvDPrX2Qwno0pFo2YWKmXX
         Q3Iq+mWhfYLumcdbT9cmPVWuH8JHHC71qlwoqrgZaCjom86vVtA+928ThOTvvSqEls
         83S08I6mtIIwyzLYoR9PDDGaPpv//uDprUiIbq5OUfBk+enuFvrMBZDOhc3zsqInu0
         qL50zOOvnZsaqaR9I0uvmR7XpGltFbWjd4kfv8DSrsBIeikSJKJYCzXqYMVag/YXVS
         DXX9rDI19rNZLG+cLXrdFxMeXL2eD8l2TOplQI+b8PUOdqdAjzJsnY3o31MNzZX3x7
         V+tGrdDJZYrsQ==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/3] net: wan: wanxl: refactor the firmware rebuild rule
Date:   Wed, 25 Mar 2020 01:15:38 +0900
Message-Id: <20200324161539.7538-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324161539.7538-1-masahiroy@kernel.org>
References: <20200324161539.7538-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the big recipe into 3 stages: compile, link, and hexdump.

After this commit, the build log with CONFIG_WANXL_BUILD_FIRMWARE
will look like this:

  AS68K   drivers/net/wan/wanxlfw.o
  LD68K   drivers/net/wan/wanxlfw.bin
  BLDFW   drivers/net/wan/wanxlfw.inc
  CC [M]  drivers/net/wan/wanxl.o

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/net/wan/Makefile | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wan/Makefile b/drivers/net/wan/Makefile
index d21a99711070..b667eae65066 100644
--- a/drivers/net/wan/Makefile
+++ b/drivers/net/wan/Makefile
@@ -47,14 +47,23 @@ else
   LD68K = ld68k
 endif
 
-quiet_cmd_build_wanxlfw = BLD FW  $@
-      cmd_build_wanxlfw = \
-	$(CC68K) -D__ASSEMBLY__ -Wp,-MD,$(depfile) -I$(srctree)/include/uapi -c -o $(obj)/wanxlfw.o $<; \
-	$(LD68K) --oformat binary -Ttext 0x1000 $(obj)/wanxlfw.o -o $(obj)/wanxlfw.bin; \
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
+quiet_cmd_m68kld_bin_o = LD68K   $@
+      cmd_m68kld_bin_o = $(LD68K) --oformat binary -Ttext 0x1000 $< -o $@
+
+$(obj)/wanxlfw.bin: $(obj)/wanxlfw.o FORCE
+	$(call if_changed,m68kld_bin_o)
+
+quiet_cmd_m68kas_o_S = AS68K   $@
+      cmd_m68kas_o_S = $(CC68K) -D__ASSEMBLY__ -Wp,-MD,$(depfile) -I$(srctree)/include/uapi -c -o $@ $<
+
+$(obj)/wanxlfw.o: $(src)/wanxlfw.S FORCE
+	$(call if_changed_dep,m68kas_o_S)
 endif
+targets += wanxlfw.inc wanxlfw.bin wanxlfw.o
-- 
2.17.1

