Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D714EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17922078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591722650;
	bh=mUhfWNznLxmCWMFhxxdUHx438NavV98MJxuKPN+4wQM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tiqzmWlT4vUscXW/Of21OZTisrHiHEx1DgXfPJZIU5jSlC9B5Pp9rRf9+AoTLqi6M
	 awIB/y0RXihy82/zjqfjCCJXhHGwo5zhXysfiN8OlgQ9i2Hggn8I0Kn6wOaiMXL1CJ
	 1XP7KXTQVcZFaOFRtkQPWinZaCKwTsakpbMewpZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbgFIRKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgFIRKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:10:23 -0400
Subject: Re: [GIT PULL] Kunit update for Linux 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591722623;
        bh=mUhfWNznLxmCWMFhxxdUHx438NavV98MJxuKPN+4wQM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1V/HIUeYSC9aTuWb8mRowJI7O7kSWkQLypqsEEgFvXABk6YIgyjsoedk51UiGlsuR
         uwAnbwyA9zSumU2GZSEMyTJBNfYYtvGbzIOpypqyY68MIxfm1jza1q0FABKFzOK5d1
         w3AtdHVGpA/ceDQqroK+alWBaC1VT8faUsiPoHe4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a975bc3c-a101-fe24-a2e3-1ae70ad7b181@linuxfoundation.org>
References: <a975bc3c-a101-fe24-a2e3-1ae70ad7b181@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a975bc3c-a101-fe24-a2e3-1ae70ad7b181@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-kunit-5.8-rc1
X-PR-Tracked-Commit-Id: 6d6861d45e38d42a7df9db244c871ee3856acf57
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 595a56ac1b0d5f0a16a89589ef55ffd35c1967a2
Message-Id: <159172262303.7211.17730688109818843743.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jun 2020 17:10:23 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jun 2020 16:23:52 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/595a56ac1b0d5f0a16a89589ef55ffd35c1967a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
