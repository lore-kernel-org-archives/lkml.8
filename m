Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58921C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC722084D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596655853;
	bh=RNKlLDsxzIi6tmaPwQpT2046A1v3ABwRrprGAFgNa+k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nbu9swtyovObgaQqmws28kkUjDdwQjbRKhS6rWs0EUlwcOvxPKO0vvgg3NR3UyofW
	 fyKeYGUSg4ZBr5QtkqUCb2Pbyfvf/pc87v8kUIeIeGo+VAaHY8MYMycSHZQn4TraoH
	 eZBf78NmtODZLfyUFGLqFM9D4EkO8mvwSmau7NMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgHETav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:30:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgHETa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:30:27 -0400
Subject: Re: [GIT PULL] USB/Thunderbolt patches for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596655824;
        bh=RNKlLDsxzIi6tmaPwQpT2046A1v3ABwRrprGAFgNa+k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=s84tR+BDnrjuXgLKYaIgsIcoe+KqQGc91Tflj8sily9QT+V7jywG9Ooq1wPe0d+ij
         v9aWRgU9z5iM/mGy1nBVKIL+gK/dNVdN/cqcp6ymiV3NM7M0If2Qsi/VOBBi/kQt6S
         /V6R6a9ZhkikkmaT3XxY0KhWdSGkJpOdBHf0TNKg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200804173811.GA513846@kroah.com>
References: <20200804173811.GA513846@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200804173811.GA513846@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc1
X-PR-Tracked-Commit-Id: e3ee0e740c3887d2293e8d54a8707218d70d86ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecfd7940b8641da6e41ca94eba36876dc2ba827b
Message-Id: <159665582422.8842.6896986572629697703.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 19:30:24 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Aug 2020 19:38:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecfd7940b8641da6e41ca94eba36876dc2ba827b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
