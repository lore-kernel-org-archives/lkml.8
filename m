Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311C3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FDB8206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591989947;
	bh=DcjK10GvDFeAl9mARoMVV4tuAvpVpKVU/efnkMi2GfM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=y+hCsi++HIWKzfftwSIwqAriNxlcCyftHNxG7BairXDyBs6B6L0aRYdb84FRPz+d1
	 FrEvNc0ncRWK+/8B3uMaeOap5kOdxp0VrnH1xR4CALMvEk1GbIgXU4uNSYUw1aJ33Y
	 +FyDopD9iGU5l3O1MyNForBbkQfufNXYdb10aVVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgFLTZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgFLTZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:25:35 -0400
Subject: Re: [GIT PULL] Devicetree fixes for v5.8-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591989935;
        bh=DcjK10GvDFeAl9mARoMVV4tuAvpVpKVU/efnkMi2GfM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Gq0jNa65zyKidBw9g5liYqzdlMvMwg+E1yD6e48slKnfeJQ6mZ8mTpmWDYId8wbfD
         BvqhnIG7uYIzSstb5iTLuv31QIyAce1vEuNA7fR4LUyyIBWI7tlPrdeINuW1FFg//L
         yYRm4j2Xk2zIqe4KscEhPXHmh/OmbGYuoW4/N5DU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200612174800.GA3459802@bogus>
References: <20200612174800.GA3459802@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200612174800.GA3459802@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.8-1
X-PR-Tracked-Commit-Id: 8440d4a75d90556cfb8fb3e244443f67381aafd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4071b856afc8a49ec41e98ff45151bb0800bc46d
Message-Id: <159198993544.4050.9158713986979540025.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jun 2020 19:25:35 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jun 2020 11:48:00 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4071b856afc8a49ec41e98ff45151bb0800bc46d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
