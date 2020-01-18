Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30E9C33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 14:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E1B2469C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 14:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579357410;
	bh=IBXoom0OMMO0w1v7Ioz8VMGf4GUOxXDegGjJczFC28M=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=cg8ESH+WsQS5mKkbOAr+MrgOlZiMv2YvakT782WDswQO2G5jZMSU2ppn2oeaYZMhJ
	 0QUpzwzt4BPp18tllxBsXcXELdFGx1dEsAb5OoY1o0FXZYgVNSD/sXjs/alMEFiryu
	 6+xg1kK/tU70cmvxZ2reCB1KmoVBlOl9PCrD1Ytg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgAROX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 09:23:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgAROX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 09:23:29 -0500
Received: from localhost (170.143.71.37.rev.sfr.net [37.71.143.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 888B02469A;
        Sat, 18 Jan 2020 14:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579357409;
        bh=IBXoom0OMMO0w1v7Ioz8VMGf4GUOxXDegGjJczFC28M=;
        h=Date:From:To:Cc:Subject:From;
        b=BRHq23pN0cnWvgjregQNkOSJ2K6LLKL9/jAGPS9iQ5g/T/bd2iaoYN3gfrhNYtIkG
         voaV/uHWdofLmgFkf/JxxqBCo6SlFKoj/e2i4TNUwSQp5hAuNIIkZbfaFk8mPbM2bX
         cIUhlsgJv3/EnV5/8EkeXcUxvjzZ6+eoTFH5KzGo=
Date:   Sat, 18 Jan 2020 15:23:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.5-rc7
Message-ID: <20200118142326.GA80220@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b3a987b0264d3ddbb24293ebff10eddfc472f653:

  Linux 5.5-rc6 (2020-01-12 16:55:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.5-rc7

for you to fetch changes up to fb85145c04447035c07cd609302d6996eb217a1d:

  Documentation/process: Add Amazon contact for embargoed hardware issues (2020-01-14 15:45:59 +0100)

----------------------------------------------------------------
Char/Misc fixes for 5.5-rc7

Here are some small fixes for 5.5-rc7

Included here are:
	- two lkdtm fixes
	- coresight build fix
	- Documentation update for the hw process document

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      coresight: etm4x: Fix unused function warning

Brendan Higgins (1):
      lkdtm/bugs: fix build error in lkdtm_UNSET_SMEP

David Woodhouse (1):
      Documentation/process: Add Amazon contact for embargoed hardware issues

Kees Cook (1):
      lkdtm/bugs: Make double-fault test always available

 Documentation/process/embargoed-hardware-issues.rst |  2 +-
 drivers/hwtracing/coresight/coresight-etm4x.c       | 13 ++++++-------
 drivers/misc/lkdtm/bugs.c                           | 12 +++++++-----
 3 files changed, 14 insertions(+), 13 deletions(-)
