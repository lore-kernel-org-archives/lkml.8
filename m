Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFC9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C1E206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580324430;
	bh=NojsvvfSlAbqmtV9iKY4aDpuda6Ex13CjD055Dor5k8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dn6Y3rfVUKMHW/ok9kmqIt4O5Gh4i74nOOmXeuT7IoPqyf3ZqvO2dAz9EiyazBS6Y
	 nlC+zIMiFeR+8r0YbzuZImEft92KjZUxhoIU3xXdNafiCGaVhSPHGXwsG0rlg93ZbR
	 tfNeXlyUI5lb8lA9biKj65a2Rzwr5Rxh0r6sozdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgA2TAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:00:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbgA2TAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:00:09 -0500
Subject: Re: [GIT PULL] Staging and IIO driver patches for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580324408;
        bh=NojsvvfSlAbqmtV9iKY4aDpuda6Ex13CjD055Dor5k8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Pj1CZzNbJ4jYM+E9esgllPBAElLV3M7EXztDl8QW2w0Nd+d914LzWdrVoHmiOCamR
         Uzs1effcl//WqkYqMMUv2/tw7Zfcq++Y+iDxtMweUPrY52xnIurzrIZhc9xxKRKguj
         250u5lCeKABjEcBp7bbILpmBXhS0aDSKpPI6jGPo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129101441.GA3858429@kroah.com>
References: <20200129101441.GA3858429@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129101441.GA3858429@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.6-rc1
X-PR-Tracked-Commit-Id: fc157998b8257fb9cfe753e7f4af1411da995c9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ba31c3f2f1ee095d8126f4d3757fc3b2bc3c838
Message-Id: <158032440891.15518.7902918717751453269.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 19:00:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 11:14:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ba31c3f2f1ee095d8126f4d3757fc3b2bc3c838

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
