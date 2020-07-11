Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A140C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 04:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 619F7207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 04:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594441510;
	bh=NGQZ1kTuBiTUB4JUrvKttB3qSookfrNHgOO2Sc16454=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wrUuyY2Caj5IIfGJUx5bccVSYLkW464WlLUzyGjrS3reEDwbESI74+0UbEU5N3pz8
	 0ZhYXN8VVkuXwXQh2K0Fm5neQzaaOVMTjsSpwql90Ay/34aEOfvka3moCLtRjgpuVO
	 9N40LNE8HxeuPUnkoXTCy8ts2ED7j0QsmeeFLByo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgGKEZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 00:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgGKEZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 00:25:04 -0400
Subject: Re: [GIT PULL] libnvdimm fix for v5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594441503;
        bh=NGQZ1kTuBiTUB4JUrvKttB3qSookfrNHgOO2Sc16454=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PhwfpIqL7IwfvjEibmQjviwXMivdIXD8o5aQQbXLBogJIZ7leaXZWHivJI2vBb5KC
         ULRFLKvgc0ciaMwotreHgzkW6D4zrEC+JT5fD/uCemiNPo8VKnhsoJmxJuoqZe5mkk
         vhe3kcoAs8JdlDkW/3fLsAwQ6G47dsGtsukv8MbE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4jSHxx-dscb7PAadNVBWhVWgT_iczah_6TQ=JSprw9ZNg@mail.gmail.com>
References: <CAPcyv4jSHxx-dscb7PAadNVBWhVWgT_iczah_6TQ=JSprw9ZNg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4jSHxx-dscb7PAadNVBWhVWgT_iczah_6TQ=JSprw9ZNg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-fix-v5.8-rc5
X-PR-Tracked-Commit-Id: 813357fead4adee73f7eca6bbe0e69dfcf514dc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1df0d8960499e58963fd6c8ac75e544f2b417b29
Message-Id: <159444150388.19180.2542503483544403679.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jul 2020 04:25:03 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 18:26:27 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fix-v5.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1df0d8960499e58963fd6c8ac75e544f2b417b29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
