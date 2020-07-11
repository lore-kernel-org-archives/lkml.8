Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489B8C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298B320725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594491908;
	bh=aRDoA7AMBzG3Y1+sI4J7hKyfzMcAetRpZkvTH+3d4yo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gsnaGNiqJ9F9e87m0Flz7y93hwJhLsXaqyvITZXg/ye0+TYuVY5LcLtC3/EHCEUoM
	 gOhDDSdzNNV2EABZoMFg/44o8spFptXgWvMwEgRu3YIGtE2Bf2v9DFJKHmLA40Ij/z
	 DsfoK0DwJPFK1IzKAjKPYcvDKki8Zcr+v6HRibpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgGKSZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 14:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbgGKSZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 14:25:05 -0400
Subject: Re: [GIT PULL] xen: branch for v5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594491904;
        bh=aRDoA7AMBzG3Y1+sI4J7hKyfzMcAetRpZkvTH+3d4yo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uMms6/j75GgQiY8o2tjDogC6jOYWJ/FYmW0coQHJcc1ZAqeGqt0CCuSO23Xx8oXg5
         aH+NVMDVwv0f/Mgc9HPllsQl7L43Ul0p5MmPbOiIVUWrILTc6wZgWOVm+j3+X78Jbv
         eC2h//O3sFO+MB6X6WmB26Us4X9WPFDNtejcA0/I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200711125224.14225-1-jgross@suse.com>
References: <20200711125224.14225-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200711125224.14225-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.8b-rc5-tag
X-PR-Tracked-Commit-Id: ba8c423488974f02b538e9dc1730f0334f9b85aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0aea6d5c5be33ce94c16f9ab2f64de1f481f424b
Message-Id: <159449190473.25373.7244067193903548460.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jul 2020 18:25:04 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Jul 2020 14:52:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.8b-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0aea6d5c5be33ce94c16f9ab2f64de1f481f424b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
