Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF61BC54FD2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 03:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED7620724
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 03:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585106218;
	bh=PpN8HO+etRQ3C118vI/EhxCye1jMDayQ2Fk7aJgEd8E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NLAE2GLF4qBhDy+e/B64Tru64h7oxokahEt4erzruHfIIG7Ir0q/KN3bJT6FL/TGp
	 qAgtsw32mMVUfVZRoofiddXp4H1MW4Bvq05M8lnA1ajS1muezwcSVhdrQycxaM3vuy
	 ZIq9+0DNMFLD3u71+Se+7Bt7j1EpJcNQf705F7fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgCYDQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 23:16:57 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:21065 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYDQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 23:16:57 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 02P3Gnbt020502;
        Wed, 25 Mar 2020 12:16:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 02P3Gnbt020502
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585106210;
        bh=6vv+eVvDHqkFYZWqHBLbxL69GQZNn7tsATCYd/KlsQM=;
        h=From:To:Cc:Subject:Date:From;
        b=t6ucqTn/g/eBpNR1c4WszMJWAeLCVLFkZKz0IqjQJersiAaukBt2IZWAUpfD1Enud
         VKQP6VpbylmzSMg1ePql8Ct4k2YcJkbDmG6chWPDzDuyTW5f7NvJTVto4bMQLpgk+E
         06ssPP8P+027NBPNM6zunGL9mc/lApgpWfLlDqMXJdOhYSopPxnuFmGrCvB1IHtszw
         09ZXozTthvzVfu4F9Tn9UzF0Ed0HawbIMJqSJxXSLb0+TB1B6zljakMslwJU74PYKW
         HzNbg7MkL7PEt+aijiGvxZBysQXSCOk6gEzlrxdk9oh/i/zTSJUU1IOGFy4OTvOPI6
         GYrW6MFxihTxA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: add comment about grouped target
Date:   Wed, 25 Mar 2020 12:16:30 +0900
Message-Id: <20200325031630.28512-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GNU Make commit 8c888d95f618 ("[SV 8297] Implement "grouped targets"
for explicit rules.") added the '&:' syntax.

I think '&:' is a perfect fit here, but we cannot use it any time
soon. Just add a TODO comment.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 593d8f1bbe90..4fd51f045440 100644
--- a/Makefile
+++ b/Makefile
@@ -674,6 +674,7 @@ $(KCONFIG_CONFIG):
 #
 # This exploits the 'multi-target pattern rule' trick.
 # The syncconfig should be executed only once to make all the targets.
+# (Note: use the grouped target '&:' when we bump to GNU Make 4.3)
 %/auto.conf %/auto.conf.cmd: $(KCONFIG_CONFIG)
 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
 else # !may-sync-config
-- 
2.17.1

