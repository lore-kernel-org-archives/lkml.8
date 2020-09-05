Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1177AC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7C320797
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599345373;
	bh=21fic43Yu+L8AQOtTCjlWRDPcmsuiQghE1oSbvXWM2I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yaRDBZCjvfdk2GuqrAE5hIMI0EAl+t8gZ5cV5McbX99X0rqyt7POcF+bg3WQBH9vS
	 vHW1GMGqaSzKDaiWOHxd4BnIE3TkTAr9pPdFkYGtGSuAexgJ5w3iTuPzuDNvI10nAm
	 IBiLY8sp/I8puADKGVcUomESZwH620SPlwkh6oXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgIEWgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 18:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgIEWgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 18:36:12 -0400
Subject: Re: [GIT PULL] ARC updates for 5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599345371;
        bh=21fic43Yu+L8AQOtTCjlWRDPcmsuiQghE1oSbvXWM2I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hXdUbjV/cRGpyt6YSSg1yFCWa3OFJW0EZKaJg8xK2QC9MqHNm1s1nVTlbVjRYzhjI
         vIEw4ZPq0rlj0a6kJp8Z7QTT1rU9YD6GbemNgdZraOQ7vIpfkl9kf8NkXRUQw/ug8J
         0TPQw9onbyuvJaWAOVWzbrC8ae/dnD1mRhTCz55g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0724a4d3-7f69-040e-2a76-67ceefe9e745@synopsys.com>
References: <0724a4d3-7f69-040e-2a76-67ceefe9e745@synopsys.com>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <0724a4d3-7f69-040e-2a76-67ceefe9e745@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.9-rc4
X-PR-Tracked-Commit-Id: 26907eb605fbc3ba9dbf888f21d9d8d04471271d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70187f7727d4ddd8282b576ece93ca233e88b19e
Message-Id: <159934537164.12925.17333595083875187697.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Sep 2020 22:36:11 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Sep 2020 01:08:56 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70187f7727d4ddd8282b576ece93ca233e88b19e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
