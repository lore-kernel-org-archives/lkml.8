Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4509C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D9621532
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593756615;
	bh=2vTj+W18Sohyh8VTtxWMMIYHjiQzKmvq/8qt8MjNAGg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DYnuIo8lgwbqa/WQyJHQOtTTSTe2j8PFd/xaj19yC4jGkCgJYK9hARiw7aA6M/Hn+
	 Vy2y62OzI186+HMLhnFXNd/v+nenKlni7kLMwtf/YxNcPFJ/lZij0RNfQIuuxCCAdT
	 I6cNQVrAo9OWNeediSoBLQ0WdkUHj6jzk02UgqV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgGCGKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgGCGKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:10:08 -0400
Subject: Re: [git pull] m68knommu changes for v5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593756608;
        bh=2vTj+W18Sohyh8VTtxWMMIYHjiQzKmvq/8qt8MjNAGg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kFZyTbFa6uZQPIDAbSz/FAil0b0MUVLAdN9HcnBMd2T60sOdb5lvMasbU30HaSNZQ
         QM8Mp5V6qxPt+ErjmCh0701ttySIiwUo9WlINesoZ/8difpgtuWLswOnq7R4j8Qofb
         Z5L/H1OVoO2mRWb85LAsyAkH9/p917RmLNiDw8rc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <85548a92-b917-08e2-e89c-833bf5cb97b4@linux-m68k.org>
References: <85548a92-b917-08e2-e89c-833bf5cb97b4@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <85548a92-b917-08e2-e89c-833bf5cb97b4@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git
 tags/m68knommu-for-v5.8-rc4
X-PR-Tracked-Commit-Id: c43e55796dd4d13f4855971a4d7970ce2cd94db4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cdd3bb54332f82295ed90cd0c09c78cd0c0ee822
Message-Id: <159375660825.4799.9904334631995485906.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jul 2020 06:10:08 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jul 2020 08:21:59 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cdd3bb54332f82295ed90cd0c09c78cd0c0ee822

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
