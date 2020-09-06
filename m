Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DE1C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F182080A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599419664;
	bh=b0sjA3RRmE3Ctkx5sSi6A7jcGmb2AJfka3zvRYsP/wU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZxdJN5fbmy6PLoacLny0Nq4viQ49p4DKymWsfgf66rwaqR0y/0xyV8cFoqz5qn8jk
	 mAnSgWgI5eg4N2Mn1nOxc5VdhVNvhYuXg+Na7FdV8NMV8kqbKp9g0gBUPR8sQ8IgXZ
	 clSiGwJUN05KFc+nyRrbZXTvgpbamPNvs7jSQiWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgIFTOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:14:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgIFTOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 15:14:18 -0400
Subject: Re: [GIT PULL] xen: branch for v5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599419657;
        bh=b0sjA3RRmE3Ctkx5sSi6A7jcGmb2AJfka3zvRYsP/wU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nXOptfINJoSA073riFbrAXutgZhaprtMwKp4gK9XY/0ojryKDSlve9udCxWIokA+z
         r7WAei5yZN5ljtu2M8s4fgezs9el9idy/Y5yjG3Ypj7Qo+KQUr6LBjnHLi0u8VzaVe
         KTF7xEm0WkYa0UjLV1BbUPHfAHrRYAFX32Se5jQ4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200906044433.24820-1-jgross@suse.com>
References: <20200906044433.24820-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20200906044433.24820-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9-rc4-tag
X-PR-Tracked-Commit-Id: 9e2369c06c8a181478039258a4598c1ddd2cadfa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68beef571071014ef34a3beac65fe2af7e8e3cf6
Message-Id: <159941965789.19439.10257590173501018968.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Sep 2020 19:14:17 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  6 Sep 2020 06:44:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68beef571071014ef34a3beac65fe2af7e8e3cf6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
