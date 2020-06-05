Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE48C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 23:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C092075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591401022;
	bh=kkT+Uj6d0cWiFuMlRRXhKPM3P6HNsDoNZeqP5uY9k7Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AbM3Dk1bG/X0tHfl5TqEB5P+xsbCS3f8lKrrhK/7HZrSBxDdMcVoMpOUsFU09KFWK
	 Byx7WN8e8sG02xxJCW+iN8iF+qCZHr5IvP1/EaNmpd5n/i+GytqPLBb/hm8VuQWJ+O
	 GuOiAFagSHCy3bUbeDRapp+Y3hJ6rnc8A5HXfy+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgFEXuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 19:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728532AbgFEXuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 19:50:17 -0400
Subject: Re: [GIT PULL] dlm updates for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591401017;
        bh=kkT+Uj6d0cWiFuMlRRXhKPM3P6HNsDoNZeqP5uY9k7Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MAi48KXxYe6b6nm+b2T5PP5H/QKt6/Z+wTnnx9vaZxmSOMdhHfoQ2jQuvTf7tIxmU
         iBUwyJuYLA+9ALI8Vt17puZbVOAQYGplonHXcFCK3EmP5PIcUGdi+34FU8twXFwwEA
         ZgDk2p91JvipTwI4khgmdgOdE7yDkU+xbbDFIwKg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200605181803.GA4820@redhat.com>
References: <20200605181803.GA4820@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200605181803.GA4820@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.8
X-PR-Tracked-Commit-Id: fe204591cc9480347af7d2d6029b24a62e449486
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3cea0cad147a9ab4f0e74a2fbdf15d18df1f820
Message-Id: <159140101723.11239.4757678543363038809.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jun 2020 23:50:17 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Jun 2020 13:18:03 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3cea0cad147a9ab4f0e74a2fbdf15d18df1f820

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
