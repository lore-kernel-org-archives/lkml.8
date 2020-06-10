Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B76C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4C32078D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591821039;
	bh=zpv4C/TpH7T1zfhbSQa25RzU+28XvamfS6e8LuPaM30=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=otyNC8Om+s1kqwXNpd/iiqOEAE5+3NHDNVovan0sCkKHXHVR+VHzw1tsEblBCUJoP
	 AbbKOD6IwFY8liOOEQkYdprRRz6Pf9ypo5LtdAri1MfsSi5qwJ62Nd3w59dP+cjjS/
	 yPzCjY+Pcxp/h26z6RIUoKRldsBqtfBOLEMJ4KM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgFJUa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgFJUaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:30:23 -0400
Subject: Re: [GIT PULL] mtd: Changes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591821023;
        bh=zpv4C/TpH7T1zfhbSQa25RzU+28XvamfS6e8LuPaM30=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1aTGMGaiRHeT8pi6irliYHGYlsNyU2LhhL3Yh2Vqt2Gpz+b3Be3+9HAwtwWMuRZtv
         42vx9cwsHPpnt5Ys/rQztAbpDxKC819VWvXJuS7R+c5KpXKGc1d7RqgNIKUgG5hdOy
         d59KXvvWEH6BbDXRWqVVZIRKZLpy2OnHq4Ol/6lA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <996261112.163.1591735115611.JavaMail.zimbra@nod.at>
References: <996261112.163.1591735115611.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <996261112.163.1591735115611.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.8
X-PR-Tracked-Commit-Id: 5788ccf3c84f5587418a80128a3653aa35abf00b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f51ab9440d131ae424cce27e3170746219f5142
Message-Id: <159182102312.16227.8292226544758577327.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Jun 2020 20:30:23 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com,
        Tudor.Ambarus@microchip.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Jun 2020 22:38:35 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f51ab9440d131ae424cce27e3170746219f5142

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
