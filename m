Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7711DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD2720DD4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592684725;
	bh=nBMiu7wv3crII+RtLA98eRK4r5UhAJIvJbfA40Wdr7Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0VXlGh3KXey0VaJ1KFnWTIbhb3LT0LN4l4o760XsOhSH9Z+R1eMH9wlkDyWDNtVM+
	 I2kvOK2/tRQ47SU01TqbUEL3JFdbzwMoKiS0ZUVLyBH3ZT10X0OqxWNxyPuPubX9eI
	 7hdjJn0vi88MkBWVfpSvCnU0EdEDg43Upksz/yBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgFTUZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 16:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbgFTUZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 16:25:23 -0400
Subject: Re: [GIT PULL] libnvdimm for v5.8-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592684723;
        bh=nBMiu7wv3crII+RtLA98eRK4r5UhAJIvJbfA40Wdr7Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QSPqz6QI5pSm5rCIicfLLj1/AEtOJLRsISu/hhts51JOF66qBi2T8Dknyr1tSCZZY
         /TAQtZEe6ddaxfBSS7uFZrEOTY+HUjzW7UKijXhk7nXSdXb0qRZ/kkx3TbM9yg6IEg
         94FiL5dDbfNT5D+dpKFBc1rN22dvHD3RujEAIs04=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4jA-_Wd4S6gM2jf_VhVsgsdR5rQTeAc3AEPr6SAvhq3eA@mail.gmail.com>
References: <CAPcyv4jA-_Wd4S6gM2jf_VhVsgsdR5rQTeAc3AEPr6SAvhq3eA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4jA-_Wd4S6gM2jf_VhVsgsdR5rQTeAc3AEPr6SAvhq3eA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-for-5.8-rc2
X-PR-Tracked-Commit-Id: 9df24eaef86f5d5cb38c77eaa1cfa3eec09ebfe8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eede2b9b3fe01168940bb42ff3ab502ef5f6375c
Message-Id: <159268472295.18389.7225516964875239399.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jun 2020 20:25:22 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jun 2020 15:07:04 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eede2b9b3fe01168940bb42ff3ab502ef5f6375c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
