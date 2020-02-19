Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49117C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC0524655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582074956;
	bh=dgqtIWD0L8ScdXh2q1SSLy1IjtKo/3HQUJh/ytmk58w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0Ttf+GdYMeEkstDzbtlonrJZJFmkrJlGq9MF2ZnJmfMLfzpzaQnMXwyujAR0v+Usp
	 r/c9LVlj/PcF6eLbhcmimhY8T0rbGngjPW/DMObV7FmuOpDaRrTDNfBzgIbwHRvJA0
	 rnvrFVltXtBrUXCfHHRZEHSVf8p38P/5sSy9mk3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgBSBPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:15:55 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:49770 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgBSBPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:15:54 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 01J1FOWs024252;
        Wed, 19 Feb 2020 10:15:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 01J1FOWs024252
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582074924;
        bh=x5q5ov7Cw9u4udBCfk7SDYEcaEVCvCFCUa560+L2gIs=;
        h=From:To:Cc:Subject:Date:From;
        b=eF5b7/rIckmhO2sOvwLQL9BB6SHnKop2wzh2JAeGOq/pgEGJcaJ3/Borx/3jcbezx
         WMcIWG7EYsk74t+c3W3gf4SjFOFpEFYtjT/wvunZBZSW35zCQl4yTq7naU1LcOZJw+
         J5y+3WDYgKwmxQmiQQMwXVKWwfx5sMVI06zs+bt/VV3XukBUZhxfizVgx67si5LoTe
         8A8Jhqqo2DIjfNak/lVGGvUGcAh/uyDQmoNQ7q1CgVQnGcx0JLjlNnvXMMqhzM11kw
         OntSOjubpo8yhLemFkY/5r9asuS0UxgGCGAJCV2cIAbasEXctcuZG4jtcXnNt/44Uw
         uwHjJkrHXA8AA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove wrong documentation about mandatory-y
Date:   Wed, 19 Feb 2020 10:15:19 +0900
Message-Id: <20200219011519.22148-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sentence does not make sense in the section about mandatory-y.

This seems to be a copy-paste mistake of commit fcc8487d477a ("uapi:
export all headers under uapi directories").

The correct description would be "The convention is to list one
mandatory-y per line ...".

I just removed it instead of fixing it. If such information is needed,
it could be commented in include/asm-generic/Kbuild and
include/uapi/asm-generic/Kbuild.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/kbuild/makefiles.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 0e0eb2c8da7d..4018ad7c7a11 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -1379,9 +1379,6 @@ See subsequent chapter for the syntax of the Kbuild file.
 	in arch/$(ARCH)/include/(uapi/)/asm, Kbuild will automatically generate
 	a wrapper of the asm-generic one.
 
-	The convention is to list one subdir per line and
-	preferably in alphabetic order.
-
 8 Kbuild Variables
 ==================
 
-- 
2.17.1

