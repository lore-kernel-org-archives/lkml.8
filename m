Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEA3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE0D20809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596036178;
	bh=Mqm+v+w5poDn7xqgKlNb4CvnEuQ5NgbJKXuzUpJ1CWs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AI1xaUfBRdmkmRcD3JTVkZB/4bHNNoiRC3fw9AO8q1UDeoetY+/R4m/sPhUSUTnPs
	 Lp4CVTgTDhT7bsOYCcYwzCFp9k4bw8Heg+fJDBqp2trly3pddsn66R6and/hVumZ0d
	 qeMiqY6OmBMlvJ1lMLwLpZzaUekZsSC9SS3ZdNVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgG2PW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:22:57 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:19923 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2PW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:22:56 -0400
Received: from oscar.flets-west.jp (softbank126025067101.bbtec.net [126.25.67.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 06TFMckp011856;
        Thu, 30 Jul 2020 00:22:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 06TFMckp011856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1596036159;
        bh=nL/PsJ+z1j4leCHQeINSSFVX/dSyo+hdDZaLl6YsRls=;
        h=From:To:Cc:Subject:Date:From;
        b=uTQ/IxWTlmYIUmKgot2p/pucEjqQnHdCrY/jY2JIAkJ+/mYWZiAL+LO0Krweruiuq
         I2+6eQGg2m6iRnm2sb9z7Fh3H3cdmrFBV3u1Pv3EAmjmDUR/dDtwu42QL2HZMDGJx/
         7nK50trfdeH2UK+0DMaLWylldNoTBH1HFl2euJZp2dcSsX75zoazP6fuIdb68fZ1Bq
         C4i7lHOLBHKu/f71gz4qd4ENbviamZnIoxjbS6sAsYgN7VATZ0B42tE/Z+dlVSJHn0
         DOLLzvTR0fW+BeVUEOVw/NcEFDk6T1xnXY+EUeIOdFuN56oGKJIaG0nCNeE9HLUXbI
         AGHXL4Gn6EjrQ==
X-Nifty-SrcIP: [126.25.67.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: clean qconf.moc by 'make mrproper'
Date:   Thu, 30 Jul 2020 00:22:37 +0900
Message-Id: <20200729152237.134028-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make mrproper' does not clean scripts/kconfig/qconf.moc

Clean it up.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 426881ea954f..7faab8eeb198 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -195,6 +195,8 @@ quiet_cmd_moc = MOC     $@
 $(obj)/%.moc: $(src)/%.h $(obj)/qconf-cfg
 	$(call cmd,moc)
 
+clean-files += qconf.moc
+
 # gconf: Used for the gconfig target based on GTK+
 hostprogs	+= gconf
 gconf-objs	:= gconf.o images.o $(common-objs)
-- 
2.25.1

