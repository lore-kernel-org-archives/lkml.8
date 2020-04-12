Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF380C2BB55
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 17:35:09 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3272206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 17:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW7ARKNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3272206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgDLRfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 13:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbgDLRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 13:35:06 -0400
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A624DC00860F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 10:25:28 -0700 (PDT)
Subject: Re: [GIT pull] x86/urgent for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586712328;
        bh=HvZSaB+A9h11LGH91Gc8lGmYplm+JR5dXSnmTOie5Z4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oW7ARKNFi9wXB8ZwkYydXTGvBmoSs1BOQckxap3R33io8SpTYoGKVku4HBPcbvBQn
         Hp5/BMOsgrszz7m8KOGs7KTQHBlfdp1EvSgWju+moWwDCPWbfut+Cc+c55vZyfXAnl
         HLs6DbFcS/3mSfTDJOKQk2cyKRlwKuS/Ph43dBME=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158670112259.20085.6131532982985666749.tglx@nanos.tec.linutronix.de>
References: <158670111777.20085.1305752188791047060.tglx@nanos.tec.linutronix.de>
 <158670112259.20085.6131532982985666749.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158670112259.20085.6131532982985666749.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-04-12
X-PR-Tracked-Commit-Id: e6f8b6c12f03818baacc5f504fe83fa5e20771d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f8a3cc1183c442daee6cc65360e3385021131e4
Message-Id: <158671232842.12917.4643415554183089318.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Apr 2020 17:25:28 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Apr 2020 14:18:42 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-04-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f8a3cc1183c442daee6cc65360e3385021131e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
