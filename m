Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF954C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C2B21D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599773319;
	bh=r5CcSmnxz9R5t91tIgmwzv7faYaArtgahnyKSQWc5hw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=kUDDtFNktJhmiFreIGyF8WWCIURh99fMXSKxgnP5zzgSg4L8lzCPnBupNGd48riyC
	 lQUSs/jFaPjbiyUCtMeIZYuOcQvHcZEhrjFxj9d0GOj9ApG7uPUmsZHtQgrlfdvG00
	 3odRXZYchFNMEgDcEXwwo1vFvLsqRKiUlj6liKxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgIJV2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:28:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731048AbgIJODs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:03:48 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8378221F1;
        Thu, 10 Sep 2020 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599746561;
        bh=r5CcSmnxz9R5t91tIgmwzv7faYaArtgahnyKSQWc5hw=;
        h=Date:From:To:Cc:Subject:From;
        b=Y40bQZ401rDeUT0ggae3yuJXfwdjFn/QCdxjv+EnvnjeP2wMMjvCocV9gEsiqx8Li
         7jiGyjdw4POeDoNJhWtPSQCGLhWaG4irLqegmi+yfJ14VUWxlc+1n4iBQAGUpharLl
         +yH8d+nJPaDo+jvvva5htc2M+C+7YXx1WnD3gEAg=
Date:   Thu, 10 Sep 2020 07:02:41 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] small bug fixes for 5.9
Message-ID: <20200910140241.GA487602@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull reqeuest having some critical bug fixes?

Thanks,

The following changes since commit 34d4ddd359dbcdf6c5fb3f85a179243d7a1cb7f8:

  Merge tag 'linux-kselftest-5.9-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2020-09-08 11:56:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.9-rc5

for you to fetch changes up to 20d0a107fb35f37578b919f62bd474d6d358d579:

  f2fs: Return EOF on unaligned end of file DIO read (2020-09-08 20:31:33 -0700)

----------------------------------------------------------------
f2fs-for-5.9-rc5

This introduces some bug fixes including 1) SMR drive fix, 2) infinite loop
when building free node ids, 3) EOF at DIO read.

----------------------------------------------------------------
Gabriel Krisman Bertazi (1):
      f2fs: Return EOF on unaligned end of file DIO read

Sahitya Tummala (1):
      f2fs: fix indefinite loop scanning for free nid

Shin'ichiro Kawasaki (1):
      f2fs: Fix type of section block count variables

 fs/f2fs/data.c    | 3 +++
 fs/f2fs/node.c    | 3 +++
 fs/f2fs/segment.c | 8 ++++----
 3 files changed, 10 insertions(+), 4 deletions(-)
