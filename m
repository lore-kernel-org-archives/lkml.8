Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F6FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD53206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591646724;
	bh=efWRjTOAaFr25W4sPZh6CyHKYTvH5LKPp8YZPlw6ppE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VQf1RgfyWvf+wQQs7pPYWw/dEOnUp7swCyh6u6dglUnBq5pv+30AW1MUH4lfpXe/y
	 d4eoHWTZXU8pJGRYuI9dlzPXnS6LPLNCwAT2/irshIaPEe9PesaFJZLL3VdHU+G3e+
	 wKpir0WV31VbWyPU+Yqz5gt+leb9q6v6Qa0VND7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgFHUFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgFHUFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:05:23 -0400
Subject: Re: [GIT PULL] GFS2 changes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591646722;
        bh=efWRjTOAaFr25W4sPZh6CyHKYTvH5LKPp8YZPlw6ppE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y66fX7Uj4XZmWr/pAYASwB0zqxiu3y44Ue56vPPmm4sXgpUeCqr3G9dQYyIX/R8zv
         VXgQWFYa5wS9+1/pLHg8DFlplIpHa9C+wclXXTLK5XPZmPva+n3iEuLq6oi1BHc2xD
         GVjQHU+QObH640ukROXll6P7zMnBkX/DMHmNm5hA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200608163250.550547-1-agruenba@redhat.com>
References: <20200608163250.550547-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200608163250.550547-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
 tags/gfs2-for-5.8
X-PR-Tracked-Commit-Id: 300e549b6e53025ea69550f009451f7a13bfc3eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca687877e05ad1bf5b4cefd9cdd091044626deac
Message-Id: <159164672284.26583.13414931699565927085.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jun 2020 20:05:22 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  8 Jun 2020 18:32:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca687877e05ad1bf5b4cefd9cdd091044626deac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
