Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081DAC10F29
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 20:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D082820737
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 20:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584303908;
	bh=8rSW5sanay1WwDiKMF/+kQBV3FRzHd6F/7KE/blBuCw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HGx6FE916m9/BUtkCiT7j+9j4ETcJnWylIn3XQi3hSrvA4AMs4nZ5165h9truXEOc
	 Av7o/gmqf9RVzReOJtaXNJ5/fXJ4XZ/J6ztUCX4h6xQpPmxLGBnxYwV4lFcG+6872Z
	 yzRj0Kdl9vMVYd4vyTkPmRvdjQ1/BrV7q3a+V51k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgCOUZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 16:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729159AbgCOUZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 16:25:07 -0400
Subject: Re: [GIT pull] ras/urgent for 5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584303907;
        bh=8rSW5sanay1WwDiKMF/+kQBV3FRzHd6F/7KE/blBuCw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XrP9nsvKuqwsNqo3wRC2hTGDbcwOwdXOIf3Lc3SZxfgLDOgRGZFRu9cEsF/A/Iqn+
         mPvhzZyyckGcRCnlSrQeGOkinNiJwLRKGt/Y7HjeMCl12grTOemjVoduA/lmPrjz/T
         H8KvhwcMMbCItcwTlHVotu4c+lgVNVAfMRnmOoJY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158428527863.14940.15328478809140163159.tglx@nanos.tec.linutronix.de>
References: <158428527861.14940.12920965330771600615.tglx@nanos.tec.linutronix.de>
 <158428527863.14940.15328478809140163159.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158428527863.14940.15328478809140163159.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 ras-urgent-2020-03-15
X-PR-Tracked-Commit-Id: 59b5809655bdafb0767d3fd00a3e41711aab07e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52ac3777fc4514b17c0c4c548f941207a0fc06a7
Message-Id: <158430390723.13594.2003491462250221282.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Mar 2020 20:25:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Mar 2020 15:14:38 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-urgent-2020-03-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52ac3777fc4514b17c0c4c548f941207a0fc06a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
