Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AE5C76199
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF35208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581902889;
	bh=qmLXkGMbDMktuNG0NuSLN+vSviWg/lfxASqQ0U2OkHU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=D6NHDVnSoKLH+Q19neC7e6q6iNu55dXRSBT+FaeyIs0nzWfTSLj7oRf04/6eUoLBy
	 zINtxKPw0GdoGBJ94rYoh9nUtHh397Crc2pVflqwfG4IHsjm78o4OhivyiJTMXkik4
	 r38ULAC8YAvY4FUNrMIligxPRO9kLyCnC0GlwlMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBQB2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 20:28:08 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:24959 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgBQB2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 20:28:07 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 01H1Rgfc021181;
        Mon, 17 Feb 2020 10:27:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 01H1Rgfc021181
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581902863;
        bh=npiBDu1sgUOXM3tc4L5AL9NAyEO74A69RwtfAvLKdWg=;
        h=From:To:Cc:Subject:Date:From;
        b=L84dy2QT3OSNyynoKAFCJlevvo79hSm4xP0K/lyfZKHP0iF77MJcMLxDZLHDE4nog
         jEF3cFfPprieoPHf1+/39YfwhQoG90hcSDkcB2iMTMywmTCXG+zyqj0jmwyXjB/YHV
         KWMQG5WQ6HN3II/HZP2++TMkKLuSYFWlK4Q3dE5nuVRjVnumigQ30WtYAg6A2a1s/i
         vTSDw+8JxCJrH5FjehyCb+AZORH5rNd4YwK9UCoTcN5lp6/GJQfR/EpMbBOmTpaUJY
         MbvqD3sRGkKcpl6WP4dFdSPxJoNxRS4vNolfpZTKiPY1SaECvtwqA8B/1JkWVNvOc2
         ZDpTYE2+CN8+g==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] kconfig: remove unused variable in qconf.cc
Date:   Mon, 17 Feb 2020 10:27:40 +0900
Message-Id: <20200217012741.22100-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If this file were compiled with -Wall, the following warning would be
reported:

scripts/kconfig/qconf.cc:312:6: warning: unused variable ‘i’ [-Wunused-variable]
  int i;
      ^

The commit prepares to turn on -Wall for host programs written in C++.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/qconf.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 82773cc35d35..50a5245d87bb 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -309,8 +309,6 @@ ConfigList::ConfigList(ConfigView* p, const char *name)
 	  showName(false), showRange(false), showData(false), mode(singleMode), optMode(normalOpt),
 	  rootEntry(0), headerPopup(0)
 {
-	int i;
-
 	setObjectName(name);
 	setSortingEnabled(false);
 	setRootIsDecorated(true);
-- 
2.17.1

