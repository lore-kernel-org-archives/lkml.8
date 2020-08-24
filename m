Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29074C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7EE32071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262896;
	bh=F/gIfcVzY2RkNxLBsEGNp4xs2jQaSGUzMb8jQ+jY9RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C51DNkAZ1A8/i+UtDBx2k/3BCxfkAAecQQ/1Uo0wruOFrx+75pnN4RbIV4abOc0qM
	 rEgwUewMTAB//HaLK2uARh4/1MEkgXOvAm2qzJ+H27Q2ry+ayvABp7DmiL5BWJU8BI
	 DXlUe2BuKEOAdoBzH2fzeZJEthHLTy5XDkmUzPfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgHXJyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:54:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgHXIhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:37:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F65A221E2;
        Mon, 24 Aug 2020 08:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258235;
        bh=F/gIfcVzY2RkNxLBsEGNp4xs2jQaSGUzMb8jQ+jY9RU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQkydwl8FlEenVnqdoaE5gwA8nZXe3U+n296ftYX86zUG4PolP5/AOfWpB5W1JAqM
         fBCuFNVumw32btOno95HjlCXUw5ySUBM9I+/ZGAvp2EjlH1++4jgVI6HDbwcrvwEQH
         8j2Q78MmTXdB39HTJmJSjMPYGVMAWDNDhSdc/j/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronald Warsow <rwarsow@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 125/148] kconfig: qconf: remove qInfo() to get back Qt4 support
Date:   Mon, 24 Aug 2020 10:30:23 +0200
Message-Id: <20200824082420.001871424@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 53efe2e76ca2bfad7f35e0b5330e2ccd44a643e3 ]

qconf is supposed to work with Qt4 and Qt5, but since commit
c4f7398bee9c ("kconfig: qconf: make debug links work again"),
building with Qt4 fails as follows:

  HOSTCXX scripts/kconfig/qconf.o
scripts/kconfig/qconf.cc: In member function ‘void ConfigInfoView::clicked(const QUrl&)’:
scripts/kconfig/qconf.cc:1241:3: error: ‘qInfo’ was not declared in this scope; did you mean ‘setInfo’?
 1241 |   qInfo() << "Clicked link is empty";
      |   ^~~~~
      |   setInfo
scripts/kconfig/qconf.cc:1254:3: error: ‘qInfo’ was not declared in this scope; did you mean ‘setInfo’?
 1254 |   qInfo() << "Clicked symbol is invalid:" << data;
      |   ^~~~~
      |   setInfo
make[1]: *** [scripts/Makefile.host:129: scripts/kconfig/qconf.o] Error 1
make: *** [Makefile:606: xconfig] Error 2

qInfo() does not exist in Qt4. In my understanding, these call-sites
should be unreachable. Perhaps, qWarning(), assertion, or something
is better, but qInfo() is not the right one to use here, I think.

Fixes: c4f7398bee9c ("kconfig: qconf: make debug links work again")
Reported-by: Ronald Warsow <rwarsow@gmx.de>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/qconf.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 91ed69b651e99..5ceb93010a973 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1228,7 +1228,6 @@ void ConfigInfoView::clicked(const QUrl &url)
 	struct menu *m = NULL;
 
 	if (count < 1) {
-		qInfo() << "Clicked link is empty";
 		delete[] data;
 		return;
 	}
@@ -1241,7 +1240,6 @@ void ConfigInfoView::clicked(const QUrl &url)
 	strcat(data, "$");
 	result = sym_re_search(data);
 	if (!result) {
-		qInfo() << "Clicked symbol is invalid:" << data;
 		delete[] data;
 		return;
 	}
-- 
2.25.1



