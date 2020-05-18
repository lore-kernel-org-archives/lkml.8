Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01146C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB7420885
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825274;
	bh=CIq2PPOSmWi4JHR64jSM3ji9I2BJ5a3qOEkHQhHiRQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m071Uf8CLMjiJEeZik0xm2SBeB3NWlVbmcndIhP8RTAUSuX7H3iQJCOy9dyGNKG8H
	 Mg9zHwA2ulDYxlqkO9jIUptgmVJ2AvdnQ/P1k+JstmxEyqCaDpu74n/Jjm2uXPqPJf
	 XgAH2sJ36AADUgel2obUJ6QS9RCHyu4oX7iBcLpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbgERSHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733068AbgERSHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:07:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B8C220826;
        Mon, 18 May 2020 18:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825264;
        bh=CIq2PPOSmWi4JHR64jSM3ji9I2BJ5a3qOEkHQhHiRQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O89FJJM1xFLlekOzaFNnGuHf7QbkZgxeeD2LztbcPwcjvkN0OBmR5ztbOMgHELBTv
         QlJ9UjQW4TY5QH4idvShkwPDny8R8jhVcKhkmFs0kdDbgTiNZs7Wg4/RX0jgrggS7M
         s0HH7QzdRlE6Zjh+fRePZCGoD5/usVVGUf8m4iVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sergei Trofimovich <slyfox@gentoo.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Backlund <tmb@mageia.org>
Subject: [PATCH 5.6 194/194] Makefile: disallow data races on gcc-10 as well
Date:   Mon, 18 May 2020 19:38:04 +0200
Message-Id: <20200518173547.533880996@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/Makefile
+++ b/Makefile
@@ -710,6 +710,7 @@ endif
 
 # Tell gcc to never replace conditional load with a non-conditional one
 KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
+KBUILD_CFLAGS	+= $(call cc-option,-fno-allow-store-data-races)
 
 include scripts/Makefile.kcov
 include scripts/Makefile.gcc-plugins


