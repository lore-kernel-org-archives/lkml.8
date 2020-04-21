Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453A6C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231F8206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JFPUu4yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgDUPm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725960AbgDUPm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:42:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CBCC0610D5;
        Tue, 21 Apr 2020 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=f152nRjSYvV+eMw/fALng3AkfZikt7gm61bUg8UTS34=; b=JFPUu4yw/6UB9q3h6V32zVamm5
        zxymF4hEUx8UfY35t7SoEpJd4Ibzompx56UBcITTY/q5eRpHnl0vt2WqsCvWZHhN1DHdBJviyLnnL
        KP7U4UV+Kyzkq4G0sjYIkVPiHRVahwxtuoVyAZIU/5sqqIc2ybKFIHWyR3pdVwGP7j8iEaOCk+vrN
        ZGD7aGnUK3+ax+b6rnWJjWT7yo1tLvGeWKnn73pNavAvLDzCjGz6TM59btGjzhWX6h/WOFkidPc/a
        Qpqt6QXhD9sQk4kPQcoPLKTbkYvcYSyqH1zCTMWkpKVbjXjrmx0qIhA00BiCi+KwFKX9pIerLoMFx
        IeQ/aqUg==;
Received: from [2001:4bb8:191:e12c:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQv2E-0007pX-Uc; Tue, 21 Apr 2020 15:42:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: remove set_fs calls from the exec and coredump code v3
Date:   Tue, 21 Apr 2020 17:41:57 +0200
Message-Id: <20200421154204.252921-1-hch@lst.de>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series gets rid of playing with the address limit in the exec and
coredump code.  Most of this was fairly trivial, the biggest changes are
those to the spufs coredump code.

Changes since v2:
 - don't cleanup the compat siginfo calling conventions, use the patch
   variant from Eric with slight coding style fixes instead.

Changes since v1:
 - properly spell NUL
 - properly handle the compat siginfo case in ELF coredumps

