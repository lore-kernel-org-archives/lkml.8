Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C52DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F40120FC3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258706;
	bh=dNQJGTnxMsF584O7umDa+KSGGth+PvByq5CxuPybTnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vlcFU3lWViKmzKqcotAFAlWJmvVobJcDq1KWRlueTs7Vr/28pXNMJxX8s7/O5992E
	 z/aNoes5sn273sx4hSJGmtYgQfoBsT4QbX6KBL5qTLbrAlpUYSvaomrrlHuWpaJGKB
	 0may0dHY0FEoneT5mbqOrh/a4UniCfCUYcTuYgAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgHXIpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728328AbgHXIow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:44:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AF462074D;
        Mon, 24 Aug 2020 08:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258691;
        bh=dNQJGTnxMsF584O7umDa+KSGGth+PvByq5CxuPybTnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WiOdxEmVCkKe9tbdw+Ge1ICI9zCrMl2CJWOeo9A+zvFgTSmXcewCIXcl996/ZRCU6
         Eslr9AVljvEnGuai6Wut3mxQg6PgQadwc2CSkc8rRMKpRFhBmQ3xtIAIyzqVIybA2n
         Jp9/flz8ydNTK4zOwZXjZiIFL5BuEqsru11eASP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 5.4 004/107] net: wan: wanxl: use $(M68KCC) instead of $(M68KAS) for rebuilding firmware
Date:   Mon, 24 Aug 2020 10:29:30 +0200
Message-Id: <20200824082405.247666021@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

commit 734f3719d3438f9cc181d674c33ca9762e9148a1 upstream.

The firmware source, wanxlfw.S, is currently compiled by the combo of
$(CPP) and $(M68KAS). This is not what we usually do for compiling *.S
files. In fact, this Makefile is the only user of $(AS) in the kernel
build.

Instead of combining $(CPP) and (AS) from different tool sets, using
$(M68KCC) as an assembler driver is simpler, and saner.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wan/Makefile |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/wan/Makefile
+++ b/drivers/net/wan/Makefile
@@ -40,16 +40,16 @@ $(obj)/wanxl.o:	$(obj)/wanxlfw.inc
 
 ifeq ($(CONFIG_WANXL_BUILD_FIRMWARE),y)
 ifeq ($(ARCH),m68k)
-  M68KAS = $(AS)
+  M68KCC = $(CC)
   M68KLD = $(LD)
 else
-  M68KAS = $(CROSS_COMPILE_M68K)as
+  M68KCC = $(CROSS_COMPILE_M68K)gcc
   M68KLD = $(CROSS_COMPILE_M68K)ld
 endif
 
 quiet_cmd_build_wanxlfw = BLD FW  $@
       cmd_build_wanxlfw = \
-	$(CPP) -D__ASSEMBLY__ -Wp,-MD,$(depfile) -I$(srctree)/include/uapi $< | $(M68KAS) -m68360 -o $(obj)/wanxlfw.o; \
+	$(M68KCC) -D__ASSEMBLY__ -Wp,-MD,$(depfile) -I$(srctree)/include/uapi -c -o $(obj)/wanxlfw.o $<; \
 	$(M68KLD) --oformat binary -Ttext 0x1000 $(obj)/wanxlfw.o -o $(obj)/wanxlfw.bin; \
 	hexdump -ve '"\n" 16/1 "0x%02X,"' $(obj)/wanxlfw.bin | sed 's/0x  ,//g;1s/^/static const u8 firmware[]={/;$$s/,$$/\n};\n/' >$(obj)/wanxlfw.inc; \
 	rm -f $(obj)/wanxlfw.bin $(obj)/wanxlfw.o


