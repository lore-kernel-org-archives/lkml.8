Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB1FC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EA1206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E0W1M6kG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgD0UGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725919AbgD0UGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:06:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5281AC0610D5;
        Mon, 27 Apr 2020 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Pgt9n10x6KRiZOZPjup3LlEFIcfQcp73LadxpXYth7I=; b=E0W1M6kGW15+PkkUEtMgB3h6eK
        zvty8HW55iWeClU4ZYGl2WaQ95Pu0GPuTFUWPWW+M/4uHlEnWgOtyaqmOEGNmL5qRYbGQOt7oySd+
        cDnfgv50hXyRbRsW4nuk6P3fbjh1ikaTKYXaymykBrLrlu4LrivtFl2Biqwsj+SoJARNPJN68DSlT
        axiTfxFhXHARDUXjsyBdUdSsSyBsHDZay6/aIpo6nvbix42mr8BIuLjN2B8H5a2o3nmnnYlFgVrKZ
        4+MEZoZohIYw5bqiG53gkM8DJA1ab1C50PPCFWU2/2R/Mc5QNrE1boGTpFTw9tVUnTzFzSmEQag4W
        FpCHrxRw==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTA1M-000174-F9; Mon, 27 Apr 2020 20:06:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: remove set_fs calls from the coredump code v4
Date:   Mon, 27 Apr 2020 22:06:20 +0200
Message-Id: <20200427200626.1622060-1-hch@lst.de>
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

Changes since v3:
 - fix x86 compilation with x32 in the new version of the signal code
 - split the exec patches into a new series

Changes since v2:
 - don't cleanup the compat siginfo calling conventions, use the patch
   variant from Eric with slight coding style fixes instead.

Changes since v1:
 - properly spell NUL
 - properly handle the compat siginfo case in ELF coredumps

