Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94467C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1FF2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591642836;
	bh=TADXkTSQWoa3MyExygYsuGyc5j7G9rmpLPZ8UBV7ETY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=H+JhceWK2YLGU/C9HaOdtjqYMjE1c5i7HyXnJlHPT6yD2cJ3pErFZBCoP7wr1saJg
	 /XpAFWwqfrYWOtDKaNa6wyK+TlDMemvtP80sRO93UDT57C4WOZHP1+o9wfKrqbx2E9
	 0X47udDJNMMoGSRdBAJAUy5yqG07kEgt5Xg+KqBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgFHTAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgFHTA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:00:26 -0400
Subject: Re: [git pull] IOMMU Updates for Linux v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591642826;
        bh=TADXkTSQWoa3MyExygYsuGyc5j7G9rmpLPZ8UBV7ETY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EHxoXKabiFXLcYfAz1VttN/HO1JpOj5IcuDx0szV4eVqxyEdtCJIF89kJY8MJkm5o
         uZK8nYmj7pg/W6no3p3D1wg86g2NsMq0XZx9VM/wSsdgQsvdb++tOJcRn9MeNwW5mm
         RIH64HMvsmcK7ughkqD3w75RP/bmDLYUSedgrU1Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200608160502.GA4491@8bytes.org>
References: <20200608160502.GA4491@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200608160502.GA4491@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.8
X-PR-Tracked-Commit-Id: 431275afdc7155415254aef4bd3816a1b8a2ead0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e3a16ee9148e966678bbc713579235422271a63
Message-Id: <159164282645.16000.16082571812872995168.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jun 2020 19:00:26 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jun 2020 18:05:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e3a16ee9148e966678bbc713579235422271a63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
