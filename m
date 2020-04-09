Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D08C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 04:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C2520757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 04:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586405132;
	bh=1xW8kN2yqWmv57JHAaFToSciFy2sqNwu2DUej9DniPQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jimRwVNu1YxK6y1Bi7Hj1Zh2rUOQs+/u98V9IdSaC8HqZKuIOEN1EfVVY8dttc5AL
	 sEwMlO6weigqqptHXSFZUr3STfs+DsCYkY4adaOdhI4dh8eqleACMhtpLc0VtyZz3i
	 CRJ/kjB+NTvheyV93zjpusC9bjUFpatYYPH3hDaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgDIEFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 00:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbgDIEF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 00:05:27 -0400
Subject: Re: [GIT PULL] Second batch of KVM changes for Linux 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586405127;
        bh=1xW8kN2yqWmv57JHAaFToSciFy2sqNwu2DUej9DniPQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=K4AxF5CNOiXnQqUeTdl/NyYDjLTjk/1+60dk9GLkLjds0QK0u7C3nbI7fp8LSG6fs
         akowsmy37yK2sgHYJ7f1cbPlpkJ/I17iPoRTA1GIO/+R6tWsXbxtC4Md/1g/wC0b8J
         LBShwEUJLd8q4QwwP0ZRH00STsRvVVukRdBMIiWI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200407182111.23659-1-pbonzini@redhat.com>
References: <20200407182111.23659-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200407182111.23659-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: dbef2808af6c594922fe32833b30f55f35e9da6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0339eb95403fb4664219be344a9399a3fdf1fae1
Message-Id: <158640512788.12302.996590418957242955.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Apr 2020 04:05:27 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  7 Apr 2020 14:21:11 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0339eb95403fb4664219be344a9399a3fdf1fae1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
