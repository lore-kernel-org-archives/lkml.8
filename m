Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9E9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067EE20872
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591295113;
	bh=AS64PIh/JcgttoqwoxFWkGj3zM69UeRToDpTxHU36jI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oLhWKs4ysoXwGNA9Cot5l5THISwxmMTsZr0Ym2kFwg8dYMzLmYMrCVe9JB/7HNeUn
	 vUuySNGPQl3ABDGd3vH88/vqei+9BLoHPmM+6nP4KTB0CHSGqm0VGB+VK7cmIVfXJu
	 1iFP1FYXi8iUS8I2s66fy2bg+wMfvKmyz4b1JKKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgFDSZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730791AbgFDSZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:25:10 -0400
Subject: Re: [GIT PULL] MFD for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591295110;
        bh=AS64PIh/JcgttoqwoxFWkGj3zM69UeRToDpTxHU36jI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kxZ/UEl99o5VWK3UrxZhMNuNjxQakOfWNVhycWszEuRK+I5Ghe8RHaTTOSWF0D79Y
         YxHDXAie4PFRlVqorcB/xDO2z7xQd/xtoqb97iOFhyq8LKl1d1C3it5hhHYrR8SH8y
         ORrdDl63TkTWAqFo22MfRhRMLVlXWXTK/Ju24wNQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200603090303.GM3714@dell>
References: <20200603090303.GM3714@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200603090303.GM3714@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.8
X-PR-Tracked-Commit-Id: 098c4adf249c198519a4abebe482b1e6b8c50e47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 512b7d37ee0a9b4e2b5fafcd0b7c65a3f6e430ca
Message-Id: <159129511001.18772.17298443977651713147.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 18:25:10 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Jun 2020 10:03:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/512b7d37ee0a9b4e2b5fafcd0b7c65a3f6e430ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
