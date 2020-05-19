Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846F3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F25206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589914809;
	bh=hRDF9ROmVyEtfEU8Se3HhHY/uY70VdjI0yxiSh7iEUo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GiWxQw3QJzkG+yFRyX76SFzGKEH/uSLbwdQ1lZR50V/ByAZbCWMOWFb0jlD+umfkH
	 3ZviES7YBBTyY4LhsBqA2jY9NswBjfto+gFQ8qCPkPwHAs/oAOC4QkxPleH+FHAQkp
	 SIIBpCEPGTFbt5ZT5Dwb6mPgYR+tJV4U3cqEmjcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgESTAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgESTAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:00:05 -0400
Subject: Re: [GIT PULL] Hyper-V fixes for v5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589914805;
        bh=hRDF9ROmVyEtfEU8Se3HhHY/uY70VdjI0yxiSh7iEUo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=doJpxtFvSj//xgaJggMU13Ba05vRpzIMMaAU2WIGgBDFyYdxF+OBaomj4gjZjjXV0
         thMw3uWrVuth62T9pKQY5ursWHeGUzpza8DfVlAQgwXHe3uNtciMdPou4W3pJhOmmv
         d7on0fTR09zawVPlcJYMY28OkdDxf6ytZ0ED9YFQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200519095744.kxco5eoo6462tto2@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
References: <20200519095744.kxco5eoo6462tto2@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200519095744.kxco5eoo6462tto2@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 tags/hyperv-fixes-signed
X-PR-Tracked-Commit-Id: 38dce4195f0daefb566279fd9fd51e1fbd62ae1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97076ea41a093e67db20d0e40f728a054b799630
Message-Id: <158991480493.4218.16579358079496397150.pr-tracker-bot@kernel.org>
Date:   Tue, 19 May 2020 19:00:04 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 19 May 2020 09:57:44 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97076ea41a093e67db20d0e40f728a054b799630

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
