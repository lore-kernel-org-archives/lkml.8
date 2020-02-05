Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74D5C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8709E2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580884816;
	bh=/6/204LznVKEKmIO54WGYihW+G8/eo1p8Sjxlh3ReZA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Av16At1Vo6tsCJbmwtmuOOFeN2aWGJdiIUPu/oamrEkAciExf2qbLQcK7+Wx0lajt
	 dDtLW+uirbyTDdibp2KFHntJX9Zc8suzjkypKZrqR45yFH0HS43zUE0AyhBHjQpNLX
	 Dy1LBBztSKZiUHir+sii1SSMKdgvpwiwfD66Ro1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgBEGkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 01:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgBEGkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 01:40:15 -0500
Subject: Re: [GIT PULL] jfs update for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580884814;
        bh=/6/204LznVKEKmIO54WGYihW+G8/eo1p8Sjxlh3ReZA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=10sjv+IRNBGGpA80IaKq6iYOEB6kTSOK7nRDtbKEqO1DkiK0EeD4AOBhEtfkdIkVe
         vFG+AcxzVmAiKSBv1cC2ggqMKYLDaSAND6eiwtiGJn03KylmeqIadh/TketXYWyJ8X
         EylL2IeK+Hoy6p3GH9fDLMyXKbcbPHd5fTpgQjRw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ce930730-248c-7e5c-dbf6-7ba5a2db07b0@oracle.com>
References: <ce930730-248c-7e5c-dbf6-7ba5a2db07b0@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ce930730-248c-7e5c-dbf6-7ba5a2db07b0@oracle.com>
X-PR-Tracked-Remote: git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.6
X-PR-Tracked-Commit-Id: 802a5017ffb27ade616d0fe605f699a3c6303aa3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51a198e89a96c34b3944034b2ebda9002ff57827
Message-Id: <158088481481.15873.16070944296633751179.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Feb 2020 06:40:14 +0000
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Feb 2020 09:31:35 -0600:

> git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51a198e89a96c34b3944034b2ebda9002ff57827

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
