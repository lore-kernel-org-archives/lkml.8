Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB32C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528FA206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597714533;
	bh=xSesG9kMfYTAGuYMl84cd1m9uNqRh9UxieSYNnRG11c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Y8R9IM+8CAZm/09k1gS8Sip8WYdX83ih+l44TlyI6fpKgtBTyyUsE8AMoieUKHQVF
	 BNcKGdjUIcRGUwqSD6kvvHbK+1zsCj1S4GlewK+BwRntY5kITrMW5CDivf7CdpD0JP
	 Pq7KTygfIR0K6YjRcf0O0HyPt83Vey5CNXuUP8XQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgHRBfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 21:35:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbgHRBfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:35:31 -0400
Subject: Re: [GIT PULL] mailmap update for v5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597714531;
        bh=xSesG9kMfYTAGuYMl84cd1m9uNqRh9UxieSYNnRG11c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LG4wUTfTXoWMkMz6ZHNzFGCOK+4w5j/sfUtmtogKqkEMFQw0pgSr7pnBjEkEMPRI2
         CIj7Gap5IQenlPy+csGU1LXzyFsmk+VjfAr6YZVGIJt0DASJDvOvLvYvBNmnS4djES
         Rdlbt5F+Ld2ip9XpshAMUEfI9wmRw1vajYrrJa1Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202008171624.8E3C303@keescook>
References: <202008171624.8E3C303@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202008171624.8E3C303@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.9-rc2
X-PR-Tracked-Commit-Id: 5a4fe0624687e62919a5913dc7c937fbfcf61fdc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06a4ec1d9dc652e17ee3ac2ceb6c7cf6c2b75cdd
Message-Id: <159771453126.4714.14725607549922860119.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Aug 2020 01:35:31 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, WeiXiong Liao <gmpy.liaowx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 17 Aug 2020 16:27:03 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06a4ec1d9dc652e17ee3ac2ceb6c7cf6c2b75cdd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
