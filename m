Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18683C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71852080C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580740785;
	bh=0171nx6hufXe+g+trDymTiyK2AFIkJCHRwvy73yrDSk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=xn7HwECy0ZpnAV7VjC7x3Vn6vqVVrUvmso6CZBqpZhqdwZJ40+p1w4JplFWw2NduN
	 7loGS4zdNg+pG5N4jb0oDbgFwpNZ3o3qoNcRMVzWMEvw01RR7uxA9di68CMaBYqH5Z
	 1Q0EPtyN1q/uFOggcXNUpyE8ksfwG+jCRj3EIHdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgBCOjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:39:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbgBCOjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:39:43 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 867752080C;
        Mon,  3 Feb 2020 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580740782;
        bh=0171nx6hufXe+g+trDymTiyK2AFIkJCHRwvy73yrDSk=;
        h=Date:From:To:Cc:Subject:From;
        b=SFy1NQXRERnuiF6lz2JpIZl8MquJGMyk2jttbo68hBPP/qfDRRwB13eQp5WnNJSje
         NMcvwrHpxDcHxsZfQVtZOEWRLcaXhhQYoLh1aoxKzZXcUzIbEJCliRZQbLxtDyJqnY
         Qkti9j2uQf4VB+0UU0zjDT4xVSm5tL4lhG1DR9uI=
Date:   Mon, 3 Feb 2020 14:39:39 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fix for 5.6-rc1
Message-ID: <20200203143939.GA3221812@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 15d6632496537fa66488221ee5dd2f9fb318ef2e:

  Merge branch 'urgent-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu (2020-01-29 11:04:49 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.6-rc1-2

for you to fetch changes up to 98c49f1746ac44ccc164e914b9a44183fad09f51:

  char: hpet: Fix out-of-bounds read bug (2020-01-30 06:58:33 +0100)

----------------------------------------------------------------
Char/Misc fix for 5.6-rc1

Here is a single patch, that fixes up a commit that came in the previous
char/misc merge.

It fixes a bug in the hpet driver that everyone keeps tripping over in
their automated testing.  Good thing is, people are catching it.  Bad
thing it wasn't caught by anyone testing before this.  Oh well...

This has been in linux-next for a few days with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      char: hpet: Fix out-of-bounds read bug

 drivers/char/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
