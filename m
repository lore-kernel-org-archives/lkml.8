Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68843C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432D0206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgGGMrh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:47:37 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:41490 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGMrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:47:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8BC25625BBD0;
        Tue,  7 Jul 2020 14:47:34 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eijkKERwVYDA; Tue,  7 Jul 2020 14:47:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2D10D625BBD2;
        Tue,  7 Jul 2020 14:47:34 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xLztF4_PzNUd; Tue,  7 Jul 2020 14:47:34 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 053E3625BBD0;
        Tue,  7 Jul 2020 14:47:34 +0200 (CEST)
Date:   Tue, 7 Jul 2020 14:47:33 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yi zhang <yi.zhang@huawei.com>
Message-ID: <1480699627.103583.1594126053947.JavaMail.zimbra@nod.at>
In-Reply-To: <963fa5c8-414f-783f-871e-47e751b54d87@huawei.com>
References: <20200701112643.726986-1-chengzhihao1@huawei.com> <CAFLxGvyO_aXGfgoO0mrNsoGP4Bfh3n6CUQxDx=ecH6o2ZDNYDg@mail.gmail.com> <082f18e0-d6f0-6389-43af-3159edb244cb@huawei.com> <1463101229.103384.1594123741187.JavaMail.zimbra@nod.at> <963fa5c8-414f-783f-871e-47e751b54d87@huawei.com>
Subject: Re: [PATCH] ubifs: Fix a potential space leak problem while linking
 tmpfile
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Fix a potential space leak problem while linking tmpfile
Thread-Index: z3Bxr4A9F54hqlSABBHN3RwegnQ+tw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
>>> Perhaps I misunderstood what commit 32fe905c17f001 ("ubifs: Fix
>>> O_TMPFILE corner case in ubifs_link()") wanted to fix.
>>> I think orphan area is used to remind filesystem don't forget to delete
>>> inodes (whose nlink is 0) in next unclean rebooting. Generally, the file
>>> system is not corrupted caused by replaying orphan nodes.
>>> Ralph reported a filesystem corruption in combination with overlayfs.
>>> Can you tell me the details about that problem? Thanks.
>> On my test bed I didn't see a fs corruption, what I saw was a failing orphan
>> self test while playing with O_TMPFILE and linkat().
> Do we have a reproducer, or can I get the fail testcase? Is it a xfstest
> case?

I think xfstests triggered it, yes.
Later today I can check. :)

Thanks,
//richard
