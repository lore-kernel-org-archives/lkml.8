Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45069C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB6020671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823927;
	bh=whLZqJ4O2o7JyMgCL/E/IdRRjGMiXMlO2C7ihhGEA5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UyEcG6/irTf2yHypEFSz86Vx85p5zsRxMf2vFExqCUU+KTN1uKgq7i+8fjMB5Jy0n
	 qGBUHUXcP8TborquA3loLdmw3KIbvPdw9nK29J9yNwiRlIFVuunWIzCP4xGyul3EnF
	 YY8uELom7b5WrQGcG7SpAKFf4knujMqdyzjtPtKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgERRp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:45:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728721AbgERRpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:45:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A20420671;
        Mon, 18 May 2020 17:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823922;
        bh=whLZqJ4O2o7JyMgCL/E/IdRRjGMiXMlO2C7ihhGEA5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UPFYx+YrnWwf6/63d1ZqITDIZbVomY8XW9STjmEjUr0HS0N6TjBA5eqQ+QOwztMBh
         5X7u7hTo9zDsyFXKdhmVv7fGpkuRlG6Ri/eiLcXVylEJpNt7H4hFqZ1TbatJ5fRLoa
         MdvyscS3fsidCNlo5wj1UlkBTl8NjOBOcNz4khrI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sergei Trofimovich <slyfox@gentoo.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Backlund <tmb@mageia.org>
Subject: [PATCH 4.9 90/90] Makefile: disallow data races on gcc-10 as well
Date:   Mon, 18 May 2020 19:37:08 +0200
Message-Id: <20200518173509.336728757@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
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
@@ -665,6 +665,7 @@ endif
 
 # Tell gcc to never replace conditional load with a non-conditional one
 KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
+KBUILD_CFLAGS	+= $(call cc-option,-fno-allow-store-data-races)
 
 # check for 'asm goto'
 ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)


