Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D74C54FD2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 03:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B6720724
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 03:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585106128;
	bh=Gk/rn2UqHth8lmNE5KfU023OnUyn+AVJUcAqCJjP/+w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=j6/aYYE/vs32EJ1XGNU+DzqEgsdoi7/xAzz0H3bf5jOTF2kB8hAK6t1RykFRli2qK
	 PQeQasZZoWiUPv2fYSmh/xw7dZiFwucQPaOwqWY6XOhK8ZfeDQcNjTjb0IY2wyhnpW
	 SMdz5m0lj0YCKiWD7wHGyup9oOUOwPt0nHnWxdgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgCYDP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 23:15:27 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:48434 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYDP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 23:15:27 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 02P3EoCw025927;
        Wed, 25 Mar 2020 12:14:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 02P3EoCw025927
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585106091;
        bh=S5jEMGj/iPjxiPM2qpwETTmm50qFMMgViufRDHA4UYY=;
        h=From:To:Cc:Subject:Date:From;
        b=Fn32tZyU6S/FbmgTUNVYw/4mgJsDn7KA/fxkT/MCad0McZ3zqYtMJSj1sCVuNl+2A
         NaXYDYrLmdttewD0irHM2OQFQ5x3LwX9JHjnrDrEifjNgcGJmXmJC06KwqYD4N73Pk
         EUt3WS4kao/rxOcQKWldzMdttDHJWApWk+mIbFcP8v2g+VmvsKk9pOWd3d8NRUAwO/
         M3I3R8DR6SAeiyj/Wg3QZ47DJGNdVm16I1eR5nkz0Npa79NVQCGz7C10cMkQ4nfWFd
         9kIx/6WnzyqL6LvmcOtW+HfbETF2duFoijog6PE+opUO84lGozT7Nuxa+dNAoy+q2A
         oxyeCKZaYP2uA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kconfig: remove unused variable in qconf.cc
Date:   Wed, 25 Mar 2020 12:14:31 +0900
Message-Id: <20200325031433.28223-1-masahiroy@kernel.org>
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

The commit prepares to turn on -Wall for C++ host programs.

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

