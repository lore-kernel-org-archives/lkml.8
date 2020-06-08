Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C9FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034E8206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663048;
	bh=zESFxIFR4j5NKmOI/snMfU7cpIAaidE+dty64bB3DYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=08v3vCHWwCyCdyD22IcEQmIWaM4WGmXJmJvQQBijW4vyCnn9/oGl4gkD0uRpv2VZ/
	 AXaOABIHxS2o7xr8JvaGxHPKDWzD0TCZ+xL17i61IG1GSYPdg7f4u7LWzkw1eHoYJX
	 3e+rVHTizEjV05F4LXiy7oAOIWMvkejbEduN63Fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733139AbgFIAh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728226AbgFHXNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:13:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E572F2151B;
        Mon,  8 Jun 2020 23:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658026;
        bh=zESFxIFR4j5NKmOI/snMfU7cpIAaidE+dty64bB3DYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yl7m359BXnoO073N3qpqv2BjJfoJA5iTeg0jliyijLvp81IytqPPy2iohmEBRtQTh
         q+z/OPdFta5q4oOIaA+jwyWP5p/qeMZ43kY7K1CvF6zEiVfzJbTQWpPQrWjjWyykbQ
         sTAoiKY5QX5QrWHfqVq9pQ3qRrKJEMR+i6IJ43Mg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Backlund <tmb@mageia.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 078/606] Makefile: disallow data races on gcc-10 as well
Date:   Mon,  8 Jun 2020 19:03:23 -0400
Message-Id: <20200608231211.3363633-78-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Trofimovich <slyfox@gentoo.org>

commit b1112139a103b4b1101d0d2d72931f2d33d8c978 upstream.

gcc-10 will rename --param=allow-store-data-races=0
to -fno-allow-store-data-races.

The flag change happened at https://gcc.gnu.org/PR92046.

Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Cc: Thomas Backlund <tmb@mageia.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 955b57a8ec15..7afb6942d3f7 100644
--- a/Makefile
+++ b/Makefile
@@ -710,6 +710,7 @@ endif
 
 # Tell gcc to never replace conditional load with a non-conditional one
 KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
+KBUILD_CFLAGS	+= $(call cc-option,-fno-allow-store-data-races)
 
 include scripts/Makefile.kcov
 include scripts/Makefile.gcc-plugins
-- 
2.25.1

