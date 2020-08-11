Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86CAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1C72076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597112896;
	bh=JssZeCzTVyBREhzmciTwisMb3OnkLxh5jPmyPNMBNbY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1ivtWyKK/kfpYY9PrBeuJyTxW+7gUlhEkojVGsq/G6thI1SyKmjYaBm0NA2qJSFQB
	 6Qj7VD/d4hunXb0X0xn3bJuBIKgwun5KWoU+9kpYRmz05UoLDo8F+XOoom07+YmXlZ
	 Iqp7/W3ErJcgcIcf3dd4iYnrTm/F8kAgtAq8bAso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgHKC2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgHKC2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:28:14 -0400
Subject: Re: [GIT pull] locking/urgent for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597112894;
        bh=JssZeCzTVyBREhzmciTwisMb3OnkLxh5jPmyPNMBNbY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iDa7rIRywwPemwiYsgr2GzV0NIjCiY81H2NzOGdqYAI+ys57j3IyO2+/n/A23g0BZ
         kRyuZO7WkBBog6B5AUxUfIuQ40c0UeIlXRdxcVCa+N6f48P0o6jwXNfrdf/57qfJcx
         8X7T81GAOgndGa6bWzr5+zvDOB3fpCnBj2HlRMRA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159708609435.2571.13948681727529247231.tglx@nanos>
References: <159708609435.2571.13948681727529247231.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159708609435.2571.13948681727529247231.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-08-10
X-PR-Tracked-Commit-Id: 0cd39f4600ed4de859383018eb10f0f724900e1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97d052ea3fa853b9aabcc4baca1a605cb1188611
Message-Id: <159711289432.3363.208577828566704189.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Aug 2020 02:28:14 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Aug 2020 19:01:34 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-08-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97d052ea3fa853b9aabcc4baca1a605cb1188611

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
