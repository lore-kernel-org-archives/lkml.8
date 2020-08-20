Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B1AC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 02:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A119520760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 02:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="Ekwlpd2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgIECGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 22:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgIECGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 22:06:39 -0400
X-Greylist: delayed 337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Sep 2020 19:06:38 PDT
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1923C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 19:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=WDY/ng54ptRjxNOdlrNswcBzY0b31g2Ob6RSh0Ebatc=; b=E
        kwlpd2IWey2PfXRRtQAsFBhUlEpungtVhMjTadjjYfJUZ4dapmPP49RhQ38PrD8L
        cEGHlhNLYSbRvxg4Uu5A/vROGUozaLXi2HJEihnq2KHj/Bz9RieE44xOe08exZ2m
        pXPgnP48QlFLTMS8UlxZxCX5FGy84SawI0e1gDk+YM=
Received: from localhost.localdomain (unknown [112.32.131.40])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBXcZ9Q8VJfUjcCAA--.4145S2;
        Sat, 05 Sep 2020 10:00:49 +0800 (CST)
From:   Calvin Zhang <zhq2014@mail.ustc.edu.cn>
To:     yhs@fb.com
Cc:     mhiramat@kernel.org, daniel@iogearbox.net, songliubraving@fb.com,
        acme@redhat.com, zhq2014@mail.ustc.edu.cn,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] tools: fix incorrect setting of CC_NO_CLANG
Date:   Wed, 19 Aug 2020 20:50:56 -0400
Message-Id: <20200820005056.3357743-1-zhq2014@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.18.4
X-CM-TRANSID: LkAmygBXcZ9Q8VJfUjcCAA--.4145S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrykCw1fJr1fKrWfKr17ZFb_yoW8Aw18pa
        n0kw47C3y8trW0kw1kCa1qqr1UJa18tryqqFyvg3WkZF4fCrn2vrZ3tr45KF43uFsFya1U
        ta4agryUX3WDG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK6x804I0_KFvE3s1l8cAvFVAK0II2c7
        xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
        xK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr
        I_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0E
        wIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_
        WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
        IYCTnIWIevJa73UjIFyTuYvjfUFYFADUUUU
X-CM-SenderInfo: h2ktjiyru6zt1loo32lwfovvfxof0/1tbiAQsHAVQhnwvOKAAesV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC_NO_CLANG should be set according to the value of CC after overridden.

I have linked /usr/bin/cc to /usr/bin/clang and I built perf with a gcc
cross-compiler:

    $ ARCH=arm64 CROSS_COMPILE=aarch64-calvin-linux-gnu- make -C \
        ../linux/tools/perf/ O=$(pwd)

It worked well. But when I tried to rebuild that with FIXDEP=1:

    $ ARCH=arm64 CROSS_COMPILE=aarch64-calvin-linux-gnu- make -C \
        ../linux/tools/perf/ O=$(pwd) FIXDEP=1

Every .o files were rebuilt since EXTRA_WARNINGS was changed due to
false value of CC_NO_CLANG. Things worked in first build because submake
of Makefile.perf inherited CC from first make and CC_NO_CLANG was
rectified in submake.

Signed-off-by: Calvin Zhang <zhq2014@mail.ustc.edu.cn>
---
 tools/scripts/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index a7974638561c..dc887669828b 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -39,8 +39,6 @@ EXTRA_WARNINGS += -Wundef
 EXTRA_WARNINGS += -Wwrite-strings
 EXTRA_WARNINGS += -Wformat
 
-CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
-
 # Makefiles suck: This macro sets a default value of $(2) for the
 # variable named by $(1), unless the variable has been set by
 # environment or command line. This is necessary for CC and AR
@@ -59,6 +57,8 @@ $(call allow-override,LD,$(CROSS_COMPILE)ld)
 $(call allow-override,CXX,$(CROSS_COMPILE)g++)
 $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
 
+CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
+
 ifeq ($(CC_NO_CLANG), 1)
 EXTRA_WARNINGS += -Wstrict-aliasing=3
 endif
-- 
2.18.4


