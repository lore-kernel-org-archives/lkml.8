Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D68C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B2AD21924
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588358112;
	bh=5ZOFxY1l89hJ+h4heApKnaHEWKqMZcqZ0twj5qMIxYk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sLN31XzhjkwcIMBBloVXQc6d6uLjjbi+wafPX08TFl3x8JWNZypo+iOSDXxt4Onxm
	 ur/kyyhsH+KSIvphMldkEgbvTPzi9OY8Li+4tsr4NqytK2jiJr+0ZWo0ZiqCf91CrD
	 IpBgPDKcvLX2xdYOk/7BOUBaVsCueN7D2951qDZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgEASfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729671AbgEASfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:35:11 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588358110;
        bh=5ZOFxY1l89hJ+h4heApKnaHEWKqMZcqZ0twj5qMIxYk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XPqwk1Ws4yxa/RECnS32gTIV5O4yTqzP+AntbCNiikKUlVnfPx6er6FRYIkCUDpsj
         3YA5XlQ+LsEObPhrp0dqTaSvmP2q0ihuhWNDq+ynBJqZzTZMDx82qQBjwddXME+Z2V
         RsxEZVJH5ovTE8Zlsxh1tNQeW/Hdr8K5SbPrOKpE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1588299335.6654.7.camel@HansenPartnership.com>
References: <1588299335.6654.7.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1588299335.6654.7.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 1d2ff149b263c9325875726a7804a0c75ef7112e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cebcff3a1c42d9ddd29175ad3669245f4573938b
Message-Id: <158835811072.18489.3871559340832068878.pr-tracker-bot@kernel.org>
Date:   Fri, 01 May 2020 18:35:10 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Apr 2020 19:15:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cebcff3a1c42d9ddd29175ad3669245f4573938b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
