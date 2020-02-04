Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E58C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63588217BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580822720;
	bh=N0Wnx6hjJLstyz1lA+v+EjrgLErGA6F36ngCuwLl8wg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OIOfa5EraXGtGW6gQ7BxhsJxXyiyI6Zp1fdowquNEPVqPQ6QvNJBbkbXZWRPidOn+
	 wD5UxhYm4DX7JddsnwsEOTrjWfOxrcBNK1TytR88ODfqubX+moGnQIqhzls1hmovGM
	 Ably012SW+Siv5E1xVEorn9JCNdOV62mFXUnO02g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgBDNZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:25:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbgBDNZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:25:18 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.6-1 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580822717;
        bh=N0Wnx6hjJLstyz1lA+v+EjrgLErGA6F36ngCuwLl8wg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Rk/bwZCApMOUODsemV9dwILJUa0CpCajVoc2O7YHpAVczTqCmoqFX+pPRlM7uCUEw
         gcnU1sDkVkEg3ZkZLWBUFx+F0H5zMjviRNSjZv9oH2jiKIrp6bcYVp4QBvgkeQqu1s
         dxIr4uKls431Qjj82E/h+2dP1vi0YB5E6j+Cf4pU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <878sli3640.fsf@mpe.ellerman.id.au>
References: <878sli3640.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <878sli3640.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.6-1
X-PR-Tracked-Commit-Id: 4c25df5640ae6e4491ee2c50d3f70c1559ef037d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71c3a888cbcaf453aecf8d2f8fb003271d28073f
Message-Id: <158082271757.19118.3664369841819660996.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Feb 2020 13:25:17 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Julia.Lawall@inria.fr, aik@ozlabs.ru, ajd@linux.ibm.com,
        alex@ghiti.fr, aneesh.kumar@linux.ibm.com, anju@linux.vnet.ibm.com,
        bigeasy@linutronix.de, byj.tea@gmail.com, chenzhou10@huawei.com,
        christophe.leroy@c-s.fr, fbarrat@linux.ibm.com, groug@kaod.org,
        jniethe5@gmail.com, joel@jms.id.au, kernelfans@gmail.com,
        krzk@kernel.org, laurentiu.tudor@nxp.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linuxram@us.ibm.com, mwb@linux.ibm.com, natechancellor@gmail.com,
        npiggin@gmail.com, oohall@gmail.com, oss@buserror.net,
        paulus@ozlabs.org, peter.ujfalusi@ti.com, rdunlap@infradead.org,
        ruscur@russell.cc, shawn@anastas.io, sukadev@linux.ibm.com,
        sukadev@linux.vnet.ibm.com, timur@kernel.org,
        tyreld@linux.vnet.ibm.com, vaibhav@linux.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 04 Feb 2020 23:10:55 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71c3a888cbcaf453aecf8d2f8fb003271d28073f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
