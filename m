Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282CAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BECE206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387672AbgF3Q0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:26:14 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:37558 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387434AbgF3Q0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:26:13 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 28AB31B405B;
        Wed,  1 Jul 2020 01:26:12 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-19) with ESMTPS id 05UGQAln118956
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 1 Jul 2020 01:26:11 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-19) with ESMTPS id 05UGQALf1315261
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 1 Jul 2020 01:26:10 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 05UGQAAM1315260;
        Wed, 1 Jul 2020 01:26:10 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     AMIT SAHRAWAT <a.sahrawat@samsung.com>
Cc:     Anupam Aggarwal <anupam.al@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: (2) [PATCH] fs: fat: add check for dir size in fat_calc_dir_size
References: <87ftacolpf.fsf@mail.parknet.co.jp>
        <1593428559-13920-1-git-send-email-anupam.al@samsung.com>
        <CGME20200629110320epcas5p34ccccc7c293f077b34b350935c328215@epcms5p6>
        <20200630123355epcms5p602efe0e4ceedcfe11eae2153c8466678@epcms5p6>
Date:   Wed, 01 Jul 2020 01:26:10 +0900
In-Reply-To: <20200630123355epcms5p602efe0e4ceedcfe11eae2153c8466678@epcms5p6>
        (AMIT SAHRAWAT's message of "Tue, 30 Jun 2020 18:03:55 +0530")
Message-ID: <875zb8o6zh.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMIT SAHRAWAT <a.sahrawat@samsung.com> writes:

> There are many implementation that doesn't follow the spec strictly. And
> when I tested in past, Windows also allowed to read the directory beyond
> that limit. I can't recall though if there is in real case or just test
> case though.
>>> Thanks Ogawa, yes there are many implementations, preferably going around with different variants.
> But, using standard linux version on the systems and having such USB connected on such systems is introducing issues(importantly because these being used on Windows also by users).
> I am not sure, if this is something which is new from Windows part.
> But, surely extending the directory beyond limit is causing regression with FAT usage on linux.

regression from what?

> It is making FAT filesystem related storage virtually unresponsive for minutes in these cases,
> and importantly keep on putting pressure on memory due to increasing buffer heads (already a known one with FAT fs).

I'm confused. What happen actually? Now looks like you are saying the
issue is extending size beyond limit. But previously it said the corruption.

Are you saying "beyond that limit" is the fs corruption?

I.e. did you met real directory corruption? or you are trying to limit
because slowness on big directory?

> So if there is no strong reason to apply the limit, I don't think it is
> good to limit it. 
>>> The reason for us to share this is because of the unresponsive behaviour observed with FAT fs on our systems.
> This is not a new issue, we have been observing this for quite sometime (may be around 1year+).
> Finally, we got hold of disk which is making this 100% reproducible.
> We thought of applying this to the mainline, as our FAT is aligned with main kernel.

So what was the root cause of slowness on big directory?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
