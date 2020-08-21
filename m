Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339CCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC31207C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598047513;
	bh=ueuGh5NpCxyHbiYv/aA9SOo5J6EI+bDQFiXPnwhaBnc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZGSSfuZ03ipBQ0J7fEt4f7WfD2umiCBcb9eJ2DACsNWIiAP+aTFrmIWsdDyNRcYM0
	 MZX91rae7H9/DF4wSL4AZ/1Vo3E5JAKkPQSArQqAj7Sc7AUapM+oRfyHVmqjQ6nicu
	 kwSIJdByaSfQcMIWDpw9xMzmA1oQX99lTuKkjdbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgHUWFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgHUWFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 18:05:08 -0400
Subject: Re: [GIT PULL] xen: branch for v5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598047508;
        bh=ueuGh5NpCxyHbiYv/aA9SOo5J6EI+bDQFiXPnwhaBnc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TSHxXoAr1TfPNCm2itTUzvUXiHhT0OiOkIeEYb2uRuBj7OKwJVZnKzjIfTiuYedl/
         t0M7fe6A+txbUJP0xfzY2qglpMPchTMjPQ8gQ5fsKbzKj4jc7j3zDe8k1yTbhNGqgf
         /9g/Q4mQCcDEDMHHv3Ob21f9CqDcdrX0Q9qapF8Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200821180217.14469-1-jgross@suse.com>
References: <20200821180217.14469-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20200821180217.14469-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9-rc2-tag
X-PR-Tracked-Commit-Id: ee87e1557c42dc9c2da11c38e11b87c311569853
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0a4f5b354dc26573cfaa541064fd35a794eb166
Message-Id: <159804750841.4316.16518368579794539100.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Aug 2020 22:05:08 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Aug 2020 20:02:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0a4f5b354dc26573cfaa541064fd35a794eb166

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
