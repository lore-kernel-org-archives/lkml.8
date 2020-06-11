Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DAEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50502073E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591905028;
	bh=ycRWFcfPZWkCuruOMA8U5Rj2A8LLaNpfTbIAsFi7BNk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=R3uxBgYRf7SjRRBlV2+Gr9ZOCQIQn+lfQ1izb8bLiEjin2nPnOlaGbST893hsuqkH
	 fZfUxwvGEroru6bWiHw3Rbmal9G0DHsF8q6ANvzty4/QeO+9xaBwwc9b/FMPp72Brj
	 QwhOp3x80+iTEX2xhVRqLS+9DkJP3MC/HvLSkBGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgFKTu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgFKTuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:50:25 -0400
Subject: Re: [GIT PULL] Mailbox changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591905024;
        bh=ycRWFcfPZWkCuruOMA8U5Rj2A8LLaNpfTbIAsFi7BNk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OTyh5GnzHSJ+5Ieuh3AZu7DFhrMgeMMWU0jplIcBRNjDBoVjTJfynwzqX4ZMQYof+
         Oy4bJDq2dvn2p1fVtKLaECetTBxiV6LuDqcoQSyQCbOCdoqj//d6uh0b/S/neHB8+y
         7C87tzOWP7LA+hOcVWOZ6asaFt4w+P67cKJdy8ns=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY1q3fTJkF0zOBJ6y8u-707-tVax9Vn_TR=vgq35=7j83Q@mail.gmail.com>
References: <CABb+yY1q3fTJkF0zOBJ6y8u-707-tVax9Vn_TR=vgq35=7j83Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY1q3fTJkF0zOBJ6y8u-707-tVax9Vn_TR=vgq35=7j83Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git
 tags/mailbox-v5.8
X-PR-Tracked-Commit-Id: e9f901dc05c09c4f89183cadcb2d93177f3100cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2dca74a40e1e7ff45079d85fc507769383039b9d
Message-Id: <159190502460.20905.8006768909883247389.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 19:50:24 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Jun 2020 23:10:56 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2dca74a40e1e7ff45079d85fc507769383039b9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
