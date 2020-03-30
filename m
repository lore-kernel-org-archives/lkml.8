Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6290C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E54E20774
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585597815;
	bh=ZUeKlp3lY/9lYFVDDRCSh9tLpLH0ku1/JEunZ53b11A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GVFvpGQwkh4nmPkU6767Rrflp2hbgzZO9ZXwo5FpYd3yWk57qDOzTEJoCVrKzBc+R
	 IXX1hoRUDAtDLjcvxWlIJdOQO4YozYPY9usAqB/hc6K2jJTpopZ3LQ7sF1tEn3P7GS
	 i5ndGl+87GRO5mi084SkYguixT2HASqP9J8iRHfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgC3TuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbgC3TuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:50:11 -0400
Subject: Re: [GIT PULL] Documentation for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585597810;
        bh=ZUeKlp3lY/9lYFVDDRCSh9tLpLH0ku1/JEunZ53b11A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IuppsRpcJYBNpowt8yTLRmodF7sifWRBfNyM3oySWr5MVB+hFHcC+HrgKK38655yE
         FFwfa8muWKivgQpYIJkFOYL+vohg358SHFT0u5PTUn5tiJMDJrBNp44GBemvOioRg1
         x2SRLcIlmdBHgz3JmYFL4TwrH61DsDHyrqugOPu8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200329172713.206afe79@lwn.net>
References: <20200329172713.206afe79@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200329172713.206afe79@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.7
X-PR-Tracked-Commit-Id: abcb1e021ae5a36374c635eeaba5cec733169b78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 481ed297d900af0ce395f6ca8975903b76a5a59e
Message-Id: <158559781063.12131.10548411530782596213.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 19:50:10 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Mar 2020 17:27:13 -0600:

> git://git.lwn.net/linux.git tags/docs-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/481ed297d900af0ce395f6ca8975903b76a5a59e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
