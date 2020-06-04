Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2125FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1AA207D5
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591231211;
	bh=4A/Y77ldlhorBhFLx/InIGAQjVNif68g4+o79CFctVI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RCBvxPVqDa8ZE/3VAuZ6uWdjSVCepp2lAhisE6Hq3X60uU3aFfgijqDm0+RBqoted
	 2Jw/1K+m7qMPzyPPrj6LTUcCtf/b0FoBrX20PUhEVDlitzl5T5XjCrmCbpHm2mwvAC
	 rzgCa4oWP2cT3hMu8DxEgqlfDDlzFbES5fItqM24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgFDAkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 20:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgFDAkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:40:07 -0400
Subject: Re: [git pull] uaccess comedi compat
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591231207;
        bh=4A/Y77ldlhorBhFLx/InIGAQjVNif68g4+o79CFctVI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YatkLY9YmLEBrDi+i0aGM0mHY2dbRc+h77Gt8qAcIWFiVYzflMeTroBBtfNKU1+yi
         oJW8jDEFBrVyfmOAFUrunOQrgLDjklEMtm7IaZgoc5uf9YZi9BiugDESuSKu8XYsZX
         D/aIKXQOFf6cXzHLtfcLHPdhtaC0i87r6BOhfGis=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200603193127.GZ23230@ZenIV.linux.org.uk>
References: <20200603193127.GZ23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200603193127.GZ23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.comedi
X-PR-Tracked-Commit-Id: bac42fb21259783cb748ae54227a5e755340a396
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e63f6ce7ed2c4ff83ba30ad9ccad422289a6c63
Message-Id: <159123120749.4554.5394403198787278653.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 00:40:07 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Ian Abbott <abbotti@mev.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Jun 2020 20:31:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.comedi

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e63f6ce7ed2c4ff83ba30ad9ccad422289a6c63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
