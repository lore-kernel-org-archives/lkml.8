Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4869AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2578D21973
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585682122;
	bh=OZ6ikrpegbUpjJ4xpv0geVSoATx/Z9lW6dCWzqcPPiY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QDwYyu3+tpWgSahQ45Kg7tlZgL/8qN9LDRSjKgGBUumAWWFk1bOor02ZIJL6RDTyy
	 FsesG2T0wqynp8n1SfuPvSP2ZG3VorGU+lA/V0n4sLrj1za6kogs/YKmxAYOUiT74K
	 RDfH5Ep+qHHlLFRoa8mfKouRhrWfKCfKjAcf4+z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgCaTPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731396AbgCaTPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:15:17 -0400
Subject: Re: [GIT PULL] x86/vmware changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585682116;
        bh=OZ6ikrpegbUpjJ4xpv0geVSoATx/Z9lW6dCWzqcPPiY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sf5nUwGofgRUAs+ije07q+zRIq7MRy8ZuMy3919AX4dxbzf0wqdGD7x0wGEDZYECP
         UclOLkPIG6YHbcNhXqyTnDMX8UxNYAbFMejLqTCnm497fRmeb5WswXZOWCo6QwhuqX
         oPVdv4tFgcjfZGs/G9h4X6/HIljdWuiiLRfGnrNs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331100353.GA37509@gmail.com>
References: <20200331100353.GA37509@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331100353.GA37509@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-vmware-for-linus
X-PR-Tracked-Commit-Id: 8fefe9dacdb0a1347d3dac871bb1bba3cbc32945
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42595ce90b9d4a6b9d8c5a1ea78da4eeaf7e086a
Message-Id: <158568211674.28667.14517194972655097318.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 19:15:16 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Mar 2020 12:03:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-vmware-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42595ce90b9d4a6b9d8c5a1ea78da4eeaf7e086a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
