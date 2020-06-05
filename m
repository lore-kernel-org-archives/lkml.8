Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAE1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16DA8207D8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591389622;
	bh=3Mr3q/0wKvLsvO1QHM9nx2Hrpfoq4xQhK3q76mTUVok=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SiZPMndJtIaSGXIud6V8/+k5t/0zt5kZjMs58iSyfwpcihYti5kyLqXuBqW/+tLyA
	 ALneAlP7v0t6ZQIP/AV4ylx9PBGs7g3K6J4+NQ53g5KA0fPlAKt/KLjwgKT8kJwf9p
	 8TelRBv1bkocZeitiTYjbLLZu5DT3QsUIhOwMb/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgFEUkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbgFEUkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:40:16 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-1 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591389616;
        bh=3Mr3q/0wKvLsvO1QHM9nx2Hrpfoq4xQhK3q76mTUVok=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Bi8xAE5IzIiQV/FBsgxmJX+kCVJQ3J2kgNnKE5g5IOhCUFvCXiMzXDycesR++AdWb
         Yn2KelsQboGkYltrzpQwUgbDepeSEg9Jco/kU/nOQXM3GCnBb3HzIcqyUpMlw/AVDV
         qMYMYPqaqvIaycMqSiOGm+6tJOP4PmxtpUEAzajk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87eeqth3hi.fsf@mpe.ellerman.id.au>
References: <87eeqth3hi.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87eeqth3hi.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.8-1
X-PR-Tracked-Commit-Id: 1395375c592770fe5158a592944aaeed67fa94ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ae77150d94d3b535c7b85e6b3647113095e79bf
Message-Id: <159138961612.17917.10938644618812483205.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jun 2020 20:40:16 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, ajd@linux.ibm.com,
        alistair@popple.id.au, aneesh.kumar@linux.ibm.com, arnd@arndb.de,
        cai@lca.pw, chenzhou10@huawei.com, christophe.jaillet@wanadoo.fr,
        christophe.leroy@c-s.fr, christophe.leroy@csgroup.eu, clg@kaod.org,
        dmitry.torokhov@gmail.com, ego@linux.vnet.ibm.com,
        elfring@users.sourceforge.net, emmanuel.nicolet@gmail.com,
        fbarrat@linux.ibm.com, geoff@infradead.org, gustavoars@kernel.org,
        haren@linux.ibm.com, hbathini@linux.ibm.com,
        herbert@gondor.apana.org.au, huhai@tj.kylinos.cn,
        jniethe5@gmail.com, kernelfans@gmail.com, kjain@linux.ibm.com,
        leobras.c@gmail.com, leonardo@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linuxram@us.ibm.com, mahesh@linux.ibm.com, michal.simek@xilinx.com,
        mikey@neuling.org, natechancellor@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, npiggin@gmail.com,
        oohall@gmail.com, ravi.bangoria@linux.ibm.com,
        rzinsly@linux.ibm.com, sbobroff@linux.ibm.com,
        segher@kernel.crashing.org, sfr@canb.auug.org.au, st5pub@yandex.ru,
        tiwai@suse.de, wangxiongfeng2@huawei.com, wsa@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 06 Jun 2020 02:38:49 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ae77150d94d3b535c7b85e6b3647113095e79bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
