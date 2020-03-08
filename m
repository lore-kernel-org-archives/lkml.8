Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BE4C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 09:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CFF20838
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 09:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583661194;
	bh=7z5w5Mo9GoOfooKxpQz035prhFQReuF5ube04Cvb6hQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=dSaDFTUN78Rbi/Cx2lvHaA0QmG9Ytm95ZiZLEgDUtpQIBi60kNJwEJwg38YStAzqw
	 Hh0Go0jBrpFQJ0sGfAt635m3SMYQEWaYgzS3x8CLSUXMjBb0Gc3y2Gj9bbiE1MyQqR
	 GkeYzvFTGQV1Y7W7I/s6hsaK2vLqhZZjNHy36nnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgCHJxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 05:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgCHJxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 05:53:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A95020828;
        Sun,  8 Mar 2020 09:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583661193;
        bh=7z5w5Mo9GoOfooKxpQz035prhFQReuF5ube04Cvb6hQ=;
        h=Date:From:To:Cc:Subject:From;
        b=HJ+pqAVdDvlRtdCrERpwZaCxbdXeG5ID1Kq2h3Spb0Jpc6ElCTyFpzOn6XRw4qdxp
         D2CnTb0W/sWOQGKE5QAJ2i9XpWicvqbI/tVtOJniV/lrfz2pcGGoQryxyKtPSb+Etk
         5DhO2XUN5yeRUH8rj6MXPRluzI4ihNvAjq4y4+X0=
Date:   Sun, 8 Mar 2020 10:53:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.6-rc5
Message-ID: <20200308095310.GA4027283@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.6-rc5

for you to fetch changes up to f0fe2c0f050d31babcad7d65f1d550d462a40064:

  binder: prevent UAF for binderfs devices II (2020-03-03 19:58:37 +0100)

----------------------------------------------------------------
Char/Misc fixes for 5.6-rc5

Here are 4 small char/misc driver fixes for reported issues for 5.6-rc5.

These fixes are:
	- binder fix for a potential use-after-free problem found (took
	  2 tries to get it right)
	- interconnect core fix
	- altera-stapl driver fix

All 4 of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Christian Brauner (2):
      binder: prevent UAF for binderfs devices
      binder: prevent UAF for binderfs devices II

Daniel Axtens (1):
      altera-stapl: altera_get_note: prevent write beyond end of 'key'

Georgi Djakov (1):
      interconnect: Handle memory allocation errors

 drivers/android/binder.c           |  9 +++++++++
 drivers/android/binder_internal.h  |  2 ++
 drivers/android/binderfs.c         |  7 +++++--
 drivers/interconnect/core.c        |  9 +++++++++
 drivers/misc/altera-stapl/altera.c | 12 ++++++------
 5 files changed, 31 insertions(+), 8 deletions(-)
