Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81561C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1A42071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584032708;
	bh=U3+S7HNaphrVFoVoaeXcvW9IXmqlilgkeBTvOWa7hsA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HGyijl6Y4wknl+VSwB2s25elt+qs6Vwh2wi8tlDsrdlMWQuRlQPwsc0qHz5T76vuu
	 1CbOx/l8FTO2MuSWF+9BpOK3xkPjuCB+0VgkO0Q8S8fKygQ21swk4p4gTQXx0CWD5D
	 lLYN+aaOA1Aa56vBWsAS3WqPIXT8xi6vKi/sMBiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgCLRFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgCLRFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:05:06 -0400
Subject: Re: [GIT PULL] IPMI bug fixe for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584032706;
        bh=U3+S7HNaphrVFoVoaeXcvW9IXmqlilgkeBTvOWa7hsA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kZZPegpDjsmLIdLaPDm8q8SXhbcMFGmAkwyqD/8N2DVciD0draWEECs5uW/Z45dzs
         oKhXtYs0DVGhHsAcc1mRijiyje4lvuohLJtG9EahlpUEE53Cp3lZihwHgct/dXL+GJ
         dyxpusDaWkW3qMpZOy+kQvOFZ6b665K00SBwdp1E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200312022208.GH2822@minyard.net>
References: <20200312022208.GH2822@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200312022208.GH2822@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git
 tags/for-linus-5.6-2
X-PR-Tracked-Commit-Id: 443d372d6a96cd94ad119e5c14bb4d63a536a7f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cc6e2c599cdca573a8f347aea5da4c855ff5a78
Message-Id: <158403270637.17459.5688278772956631461.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Mar 2020 17:05:06 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        John Donnelly <john.p.donnelly@oracle.com>,
        Takashi Iwai <tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 11 Mar 2020 21:22:08 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cc6e2c599cdca573a8f347aea5da4c855ff5a78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
