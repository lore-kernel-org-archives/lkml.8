Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A15FC2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B1820659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586115942;
	bh=e44hDYLZOYgsYqnXJ4aIm3FbFOGtihWFg62GvfSUyZA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2Swl0Scq5JauDpu28FgEHtxjigJHf3fN72K+wc+1zHA0MIWMKI4rqbYflKjhF4D1a
	 xw9rLz8I96LFfU0SK/sWBX7Sqg6YMYEnQalyg/drsLnOxsw1lq1iMohRPIcwqR5EP/
	 2EAIfDY85n8UuHKDmgG7vOFCczvuvGkQF5qzFokQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgDETp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 15:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbgDETp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:45:26 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.7-1 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586115925;
        bh=e44hDYLZOYgsYqnXJ4aIm3FbFOGtihWFg62GvfSUyZA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ml+3NwIU0cSTYMXhnP+28/Kg4Bk2Meytx4uu+oez04Qk2V3TCPG4HY84Q/ipljPXP
         w3xWP65Ufrl4Yh+LYjQEpIJHti+PbAYYgXnnRo2NPAh1D/s8X7wqZajJ0lepyrmzWO
         eA9BOYHqcgjgzgDXnMt8GDhWeJm8LxfxIDj82c1c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87h7xyrt5d.fsf@mpe.ellerman.id.au>
References: <87h7xyrt5d.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87h7xyrt5d.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.7-1
X-PR-Tracked-Commit-Id: c17eb4dca5a353a9dbbb8ad6934fe57af7165e91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d38c07afc356ddebaa3ed8ecb3f553340e05c969
Message-Id: <158611592587.11305.6103996892992065943.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Apr 2020 19:45:25 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        afzal.mohd.ma@gmail.com, agust@denx.de, aik@ozlabs.ru,
        alistair@popple.id.au, aneesh.kumar@linux.ibm.com, arnd@arndb.de,
        bala24@linux.ibm.com, bhelgaas@google.com, chenzhou10@huawei.com,
        christophe.jaillet@wanadoo.fr, christophe.leroy@c-s.fr,
        clg@kaod.org, courbet@google.com, dja@axtens.net,
        dougmill@linux.vnet.ibm.com, farosas@linux.ibm.com,
        ganeshgr@linux.ibm.com, grant.likely@arm.com,
        gregkh@linuxfoundation.org, gustavold@linux.ibm.com,
        ilie.halip@gmail.com, joe.lawrence@redhat.com, joe@perches.com,
        kjain@linux.ibm.com, laurentiu.tudor@nxp.com,
        leonardo@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, lpechacek@suse.cz,
        maddy@linux.ibm.com, maskray@google.com, natechancellor@gmail.com,
        nathanl@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        ndesaulniers@google.com, npiggin@gmail.com, olof@lixom.net,
        oohall@gmail.com, oss@buserror.net, po-hsu.lin@canonical.com,
        psampat@linux.ibm.com, rppt@linux.ibm.com, sfr@canb.auug.org.au,
        shilpa.bhat@linux.vnet.ibm.com, sourabhjain@linux.ibm.com,
        srikar@linux.vnet.ibm.com, tyreld@linux.ibm.com,
        vaibhav@linux.ibm.com, yuehaibing@huawei.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 05 Apr 2020 22:53:02 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d38c07afc356ddebaa3ed8ecb3f553340e05c969

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
