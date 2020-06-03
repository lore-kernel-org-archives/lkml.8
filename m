Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF79C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 21:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84EBB20734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 21:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591218320;
	bh=iC7xMIm/zmdOxk4WTfTegn/gUkuroR955zHSrymnLO0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2dTRK1bdqkSu2iZ2X/nVeRDMUZ7RwIftvA1jsUcdnM+5GqH0mB/003ePr1VBmfm4t
	 jzLVQVxdKCEz/uK4PkCITysX/gRhG71UQMiv0H9mOI2lqUDeMTyH6X2yAKYs77kLQj
	 YyAsnowzdiY4bVshZAkTFzBk+pSBr8MZumg0p4T4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgFCVFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 17:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbgFCVFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 17:05:09 -0400
Subject: Re: [PULL 0/5] xtensa updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591218309;
        bh=iC7xMIm/zmdOxk4WTfTegn/gUkuroR955zHSrymnLO0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vV1uhI4SgJ811h2Kkp+ysSeRlL/N4pK1GISb2nw4X/57WazKzchtgO7nEHB1CULp9
         3l2ErYERoc47gh8uv7GeMo8chbGiqfT/i0T7kreBbQyjFyChRtek019JBj2AsQHvWw
         qw7wsRPJcTeMrngxLNNE7NLde7/fFOSHNWS9CosQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200603092329.10427-1-jcmvbkbc@gmail.com>
References: <20200603092329.10427-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200603092329.10427-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20200603
X-PR-Tracked-Commit-Id: 3ead2f97bd44a9a106572d306cb04a878c569cb2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38696e33e2bdf91cbbc7a2291dc6db862d9dfd42
Message-Id: <159121830936.19900.9068582461894666271.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 21:05:09 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  3 Jun 2020 02:23:29 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20200603

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38696e33e2bdf91cbbc7a2291dc6db862d9dfd42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
