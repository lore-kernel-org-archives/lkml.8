Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80818C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3D620884
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGCTLa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:11:30 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:38302 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGCTLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:11:30 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 9F5921B3FD4;
        Sat,  4 Jul 2020 04:11:28 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-19) with ESMTPS id 063JBR70022643
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 4 Jul 2020 04:11:28 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-19) with ESMTPS id 063JBRMS091362
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 4 Jul 2020 04:11:27 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 063JBQgh091361;
        Sat, 4 Jul 2020 04:11:26 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Anupam Aggarwal <anupam.al@samsung.com>
Cc:     AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: fat: add check for dir size in fat_calc_dir_size
References: <20200630170748epcms5p87fa9b4348c1448d2d5a5f6cdddbc021e@epcms5p8>
        <875zb8o6zh.fsf@mail.parknet.co.jp>
        <87ftacolpf.fsf@mail.parknet.co.jp>
        <1593428559-13920-1-git-send-email-anupam.al@samsung.com>
        <20200630123355epcms5p602efe0e4ceedcfe11eae2153c8466678@epcms5p6>
        <CGME20200629110320epcas5p34ccccc7c293f077b34b350935c328215@epcms5p1>
        <20200703142939epcms5p1440ec65f7e8a3e4741ade2496135d747@epcms5p1>
Date:   Sat, 04 Jul 2020 04:11:26 +0900
In-Reply-To: <20200703142939epcms5p1440ec65f7e8a3e4741ade2496135d747@epcms5p1>
        (Anupam Aggarwal's message of "Fri, 03 Jul 2020 19:59:39 +0530")
Message-ID: <87zh8gct29.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anupam Aggarwal <anupam.al@samsung.com> writes:

>>So what was the root cause of slowness on big directory?
>
> Problem happened on FAT32 formatted 32GB USB 3.0 pendrive, which has
> 20GB of data, cluster size is 16KB It has one corrupted directory
> whose size calculated by fat_calc_dir_size() is 1146896384 bytes
> i.e. 1.06 GB.
>
> When directory traversal of corrupted directory starts, directory
> entries looks to be corrupted and lookup fails for these directory
> entries.  Some directory entries name are having format abc/xyz,
> following are the few observed directory entry names:

[...]

> During search for single name in fat_search_long() function, whole
> corrupted directory of size 1.06GB is traversed, which takes around
> 230 to 240 secs, which finally ends up with returning ENOENT.
> 
> Now multiple lookups in corrupted directory makes “ls -lR”
> never-ending e.g. in overnite test of running “ls –lR” on USB having
> corrupted directory, around 200 such lookups in corrupted directory
> took 14hrs and still ”ls –lR” is running.

Sounds like totally corrupted FAT image, and the directory may have the
non-simple loop (e.g. there is hardlink of directory).

If so, I'm not sure if we can detect without heavyweight check.  Well,
although user should run fsck before mount. However, if fs can detect
and stop early, it would be better.

BTW, if you run fsck, the corrupted directories and issue are gone at
least?

Anyway, fsck would be main way. And on other hand, if we want to add
mitigation for corruption, we would have to see much more details of
this corruption.  Can you put somewhere to access the corrupted image
(need the only metadata) to reproduce?

> Total number of directory entries in corrupted directory of size
> 1146896384 bytes = 1146896384/32 = 35840512, so lookup for 35840512
> looks very exhaustive, therefore we have put size check of directory
> in fat_calc_dir_size() and prevented the directory traversal by
> returning -EIO.
> 
> While browsing corrupted directory(\CorruptedDIR) on Windows 10 PC,
> 2623 directory entries were listed and timestamps were wrong

What happens if you recursively traversed directories on Windows? This
issue happens on Windows too?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
