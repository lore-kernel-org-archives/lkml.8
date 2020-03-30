Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2004C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996392082F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585600808;
	bh=cHzfQoKbVQUqHdX+/LrYyMnzkUBykPIX2ElSc3E/KmM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Gl54DzE3JPpdYy2NQet7lWfTlF/Szhk2RN4HUuLB3FuxfY+LNJoGf0CLsxCGVeWMX
	 lEglP2sw6tnwlDeNJV//ktQJ73Eo6BPvZzBQVv5RA+va6YFBAK4c2NN9zLex7ACg68
	 yElGBa08au46vFjhQ8fS8kFsSxZOhD+NZMEZwYDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgC3UkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbgC3UkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:40:07 -0400
Subject: Re: [GIT PULL] erofs updates for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585600806;
        bh=cHzfQoKbVQUqHdX+/LrYyMnzkUBykPIX2ElSc3E/KmM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YcDeCn9GSXm1aCDZN566cLL2fkG7pRnwvJO7+wq5xigfGK9CBKRiPp0a653slMD+1
         LK2AnFWxUXh+4luqOikeyBMBoUQnvPPuUQq9xIMFUpYWevdR3ou27OmS6yZfPuz3vl
         sHnPFWcJhcuXhS6D4444uQdXnTcM2SJnJB10lFyc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330023830.GA5112@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200330023830.GA5112.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200330023830.GA5112@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330023830.GA5112@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.7-rc1
X-PR-Tracked-Commit-Id: 20741a6e146cab59745c7f25abf49d891a83f8e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 377ad0c28c1df7b0634e697f34bdea8325f39a66
Message-Id: <158560080684.3259.12757063213872171906.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 20:40:06 +0000
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 10:38:40 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/377ad0c28c1df7b0634e697f34bdea8325f39a66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
