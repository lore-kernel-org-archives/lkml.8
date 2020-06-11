Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D2AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA51207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591840229;
	bh=1bMTDHYNilN0wsjDD9VsVH+mfJI/tyVAqLliu2VoAQo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tOqqwWP2UKnjn7Vimjj8+UFZ5UO215wS+vc3U1gx4q/v04BxCGGYis2O26k64zX02
	 tkBIpW7VeOZnAGfWJlOSuOFo7zM3hZIVUIc7uBVSpUFDA92a6X1pzwC74Lah8cHZOt
	 oGhbyWj08Y3MOl1tTXPr43lCtYP//bDHuVGaMr8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgFKBu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFKBu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:50:26 -0400
Subject: Re: [git pull] uaccess i915
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591840226;
        bh=1bMTDHYNilN0wsjDD9VsVH+mfJI/tyVAqLliu2VoAQo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Dwv3FcMRmPE4jHrpL4qrfrL20CPPK1WYdp7V+XX5Nm48vu9Jd4VEq0v7nl3qQ3i+v
         d+5vJdtNuWJR7cDaMdHdNAzict9tkNg7NHN0mGU3aY0deXjQ8wJifzik5mTHTb2YEH
         fnO5zWn6HwVlOfi4HkcVSiy3xSokPaw46X78fjb0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200610202837.GV23230@ZenIV.linux.org.uk>
References: <20200610202837.GV23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200610202837.GV23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.i915
X-PR-Tracked-Commit-Id: 7b3f0c4c56b08a86f890cad3599242c78c683aa9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a8557e1aed0043d526f304a1f500108c8976b78
Message-Id: <159184022602.24802.16565146152387751985.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 01:50:26 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Jun 2020 21:28:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.i915

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a8557e1aed0043d526f304a1f500108c8976b78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
