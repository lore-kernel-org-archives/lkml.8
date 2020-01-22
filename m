Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ABCC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4012467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579727105;
	bh=wmFNqsvcvqhGUmM0lVT/YB9hRrRPQNs7ulV0NOy2ZCM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TCJU7Wcbyu1BY8E7RrChpEcEdfoPXHi0mFwh1LVK4lxp8MJ5EGZsixiLXs9yIV8NY
	 mn+SS6QFOt0tH61R0b9Q5rBRcgQ8Cfmi1hUN/8qPMFFbgrlAgUMNekbyQslYNzTVQ2
	 /AyZE1JcPKlVtUaP0J9AMwIrsDafTIP+4NaeOU90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgAVVFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 16:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgAVVFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 16:05:03 -0500
Subject: Re: [GIT PULL] hwmon fixes for v5.5-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579727103;
        bh=wmFNqsvcvqhGUmM0lVT/YB9hRrRPQNs7ulV0NOy2ZCM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CU4t4LpIn/qMw1BmoUE1ut5pyhvuzc4SlBwi42HyqvywNfO09tv+Gxl/OupOCg0zS
         CIjHq7Tk4oQGDdHUEpO3n0eFVPcSBiuVSoa85XFjhJm/80agJ/h8JVLvQM3gFQVei+
         poaCAitciTYr+Z1wQq02O55Uuk2TQZFFWWqhWGk8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200122181937.18953-1-linux@roeck-us.net>
References: <20200122181937.18953-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200122181937.18953-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.5-rc8
X-PR-Tracked-Commit-Id: 3bf8bdcf3bada771eb12b57f2a30caee69e8ab8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b4e677f86c7f730999223053534973bd0818c3c
Message-Id: <157972710315.17393.17475365828781547151.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Jan 2020 21:05:03 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Jan 2020 10:19:37 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.5-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b4e677f86c7f730999223053534973bd0818c3c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
