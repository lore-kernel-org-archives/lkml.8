Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4855FC3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CE12078E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587146822;
	bh=Oty3QgChT/ley53VNMwqfYQxhwuZj6u4rbCRY3t0lAs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=h3gGn3Ns/Gs5scRP/jXR6OLP8zamaQTGRl1EvWkerd+rVQQBRpDTd2j/Xvoh/eRGJ
	 EJA5s+cOw2bJbSf5vxJyLnjXDiU43jSFJEToH73HeeSMNXTUxPB69rC9jSX819Uixg
	 k3ehZlTqHwriR6b/4ys8t5fbOlw7r3eflXwIV0zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgDQSHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:07:01 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:37940 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbgDQSHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:07:00 -0400
Received: from oscar.flets-west.jp (softbank060142179096.bbtec.net [60.142.179.96]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 03HI5ABN029932;
        Sat, 18 Apr 2020 03:05:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 03HI5ABN029932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587146711;
        bh=SFGIrF50APy5dH88SntYVAB40FrC6WituPFt2il885M=;
        h=From:To:Cc:Subject:Date:From;
        b=khCtS4XBOln4glzBZmoYcVnO3BquMr7u+AR+bU/tCPRR9LyZVixoBaxeoHhLDVLfV
         lDXnnNcgNaV0Oei0lEmP/r2/vt4cxEv8O4fF2n27X7jGwyWh8glK1eUljcn0vjcU+D
         35fBGnhLPjNGFJj662itfmv0wa5AgXX62V3RQ1MNTIPKPSFOCyOmvnnWhAHLYQBjd3
         dkCaUuz8AmHF0vBqWk7zF4vWEdx11stnl/4UK6R84IiXdSkWpTbqqUc+yvoaeO5hwd
         OOskfDPcclqNhE1KA9vtE2iN1Z+HQgJY7DIwJ9RDUlGQYUhlcTR363CltdrsWg8gzp
         wdgjc8Bkxv2Ew==
X-Nifty-SrcIP: [60.142.179.96]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Dewar <alex.dewar@gmx.co.uk>,
        Erel Geron <erelx.geron@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] um: do not evaluate compiler's library path when cleaning
Date:   Sat, 18 Apr 2020 03:04:55 +0900
Message-Id: <20200417180455.1174340-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a83e4ca26af8 ("kbuild: remove cc-option switch from
-Wframe-larger-than="), 'make ARCH=um clean' emits an error message
as follows:

  $ make ARCH=um clean
  gcc: error: missing argument to '-Wframe-larger-than='

We do not care compiler flags when cleaning.

Use the '=' operator for lazy expansion because we do not use
LDFLAGS_pcap.o or LDFLAGS_vde.o when cleaning.

While I was here, I removed the redundant -r option because it
already exists in the recipe.

Fixes: a83e4ca26af8 ("kbuild: remove cc-option switch from -Wframe-larger-than=")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/um/drivers/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index a290821e355c..2a249f619467 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -18,9 +18,9 @@ ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
 
-LDFLAGS_pcap.o := -r $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
+LDFLAGS_pcap.o = $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
 
-LDFLAGS_vde.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
+LDFLAGS_vde.o = $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
 
 targets := pcap_kern.o pcap_user.o vde_kern.o vde_user.o
 
-- 
2.25.1

