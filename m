Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C04C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FA42073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jzs4m41k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbgG0QHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgG0QHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:07:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27034C061794;
        Mon, 27 Jul 2020 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2aQmIJDaFTj/Kf9z4Bfaajb+6jbNo420+J7NaCJSi0E=; b=Jzs4m41kN5iL1/gualbsul8T/y
        cw4AZk4oqI7HMAnzxgjm5NiBMUORs3Q1BHldhz8+BUZ7DOuVz4VjJum57i6TOXIWZvjSl64osO29N
        zutaD/Sp9RREubVIBg54Nelz22OU6LYT4kXCt4AsQoMJH9xay8IDCZtgPLn7xB5tN8Scve560/oWh
        SnBwPBbhLFOsQIDOWKLTqhGqfj4mca2E84r8gD66FzBvJbofThKrI1uwWtg/TlKlhZfuN9OdSfe5u
        KMILkhmtCx5VJy6RKXJK6zUOhjE+iPwOw2UOcDgEIn/on55e7XeUsBWOq1EBTWNSXTld5k9Y7yPUw
        TbG0y9cw==;
Received: from [2001:4bb8:18c:2acc:aa45:8411:1fb3:30ec] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k05fH-0002mL-1O; Mon, 27 Jul 2020 16:07:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: fixes for: decruft the early init / initrd / initramfs code v2
Date:   Mon, 27 Jul 2020 18:07:41 +0200
Message-Id: <20200727160744.329121-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series fixes up a few issues found in my

    git://git.infradead.org/users/hch/misc.git init-user-pointers

tree.  The patches are relative to it.
