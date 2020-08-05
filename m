Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484CDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28CC522BED
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596607516;
	bh=+NBrQKaxlNSGOzDNgl9/R1Ecna0DN8bALvJ0EqNCR1s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kSGD1BkYNkns+u50TyMUNoOhtMXTuqy+jj/Uz04LO1QPafOE1sd5DoThjVxjWm39v
	 lFmi7XS6Gmv1VXG3Y9r3Vmm6Xo/VrS0HLg4ARojP3qly3Y/74exczEHeqaRSOHZQNo
	 YOmu85FBTyfyA8Yo7kPucdOm9wz53G7YtJ9TPHAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgHEGFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgHEGFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:05:15 -0400
Subject: Re: [GIT PULL] Documentation for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596607514;
        bh=+NBrQKaxlNSGOzDNgl9/R1Ecna0DN8bALvJ0EqNCR1s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DXlFuhAhKbW33P+SV2jVAIF0AsLzpNtC32IZC/aL4ts7JZgXsLx6THYaZLSa9Y35M
         eO61AZhi3PwRgR/Z848IB9cLK0mv1UC6lyek0yg6c45vil3+p661hjkfFXU9Too1lf
         Y1efqRqCktkLfPvIe3U11i/nc7LZs4UmBFS1q3Lk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803122657.635aee87@lwn.net>
References: <20200803122657.635aee87@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803122657.635aee87@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.9
X-PR-Tracked-Commit-Id: 2c12c8103d8f15790cf880f1545dafa36acb004a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2324d50d051ec0f14a548e78554fb02513d6dcef
Message-Id: <159660751467.19907.5875454230420531586.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 06:05:14 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 12:26:57 -0600:

> git://git.lwn.net/linux.git tags/docs-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2324d50d051ec0f14a548e78554fb02513d6dcef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
