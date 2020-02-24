Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA03C38BE6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43C120656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582575915;
	bh=cD3+eVOA7MJZ0//ykzYh3GurDr6lwAZgxlMoEqLiI5A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DZy+QyIZuwIOZItZ3cmhr+g9yc1P6l3cJciwx9SCcGU2D+TqGTQrWCPIRrnqRc3vM
	 A/RRsWmvMzlncyHxq6kZ2/D4G+8SmZWdST0pc/q434NRR2tvI+K0iuajVcAnkY8AUC
	 ZtfntnHQT2dJW2EdIiGQ1TIGqXKrO7N0CxPCh0nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgBXUZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:25:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbgBXUZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:25:12 -0500
Subject: Re: [GIT PULL] KVM changes for Linux 5.6-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582575912;
        bh=cD3+eVOA7MJZ0//ykzYh3GurDr6lwAZgxlMoEqLiI5A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ulJlm82Pz1UoH/EJ8M7e3UIHTyVgufEP5l/iuXFRaA8JdGhN127wuE0da1VU/HGBd
         QPLcuSIMLPT+qaGfLgpQrIcJk2k5qIElKa6iOJxgNcjmI2SArHsQNZxCXCUSRG+ZtA
         BH43ZOp9sRNMZ0hmc6yS1QHq+X2Xnel5D32U3hqQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1582570669-45822-1-git-send-email-pbonzini@redhat.com>
References: <1582570669-45822-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1582570669-45822-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: a93236fcbe1d0248461b29c0f87cb0b510c94e6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63623fd44972d1ed2bfb6e0fb631dfcf547fd1e7
Message-Id: <158257591213.9578.15457579917063740271.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Feb 2020 20:25:12 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Feb 2020 19:57:49 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63623fd44972d1ed2bfb6e0fb631dfcf547fd1e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
