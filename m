Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25FFC2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCE220771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585597804;
	bh=xwUUryMp5GTbHMDazkQKlMrY8HdcqWGbe/rL7TKG80U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Izo5DvoHQC61e8k6THSNG1qUaROo2bcEUd2CY6JsgJJhjtrajGE45+AwVnU29RAob
	 2d4XENoEBdyn2x9DPhYkzhRvlbZGkvpYaWaXY5Fr/rFbpqx/QPKHOlHQOpMWA/zK59
	 Qs/SqrnOywUu2FIhxFQo4bjXx5Y4kstFt3Srx/Mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgC3TuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgC3TuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:50:02 -0400
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585597801;
        bh=xwUUryMp5GTbHMDazkQKlMrY8HdcqWGbe/rL7TKG80U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ArnWHQ2DRpuNhX9jVTZe+6vZGog2NQfNPSJObHq0xU6JmZMcfZGslCTwNwKAaKPMZ
         QhJzRYcrL7yh4TVeWMd/mzUu64BiTjupg9a729kzpyibLxHaf5xRkIgPsn4ICX5cJ9
         BggEihIf78F28os7NynZV2fwK7eBY3Bow8jRbuNM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200315225443.GA1413900@linux.intel.com>
References: <20200315225443.GA1413900@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200315225443.GA1413900@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20200316
X-PR-Tracked-Commit-Id: 2e356101e72ab1361821b3af024d64877d9a798d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f751396346f5cfb6d02abe1985af53717b23c3d
Message-Id: <158559780173.12131.1497831289468164278.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 19:50:01 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Mar 2020 00:54:43 +0200:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200316

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f751396346f5cfb6d02abe1985af53717b23c3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
