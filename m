Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59004C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4DC2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgGFOXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:23:01 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:38844 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgGFOXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:23:00 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id E421E1B405B;
        Mon,  6 Jul 2020 23:22:59 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-19) with ESMTPS id 066EMwFA074945
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 6 Jul 2020 23:22:59 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-19) with ESMTPS id 066EMwn8349763
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 6 Jul 2020 23:22:58 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 066EMwEw349762;
        Mon, 6 Jul 2020 23:22:58 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Anupam Aggarwal <anupam.al@samsung.com>
Cc:     AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        VIVEK TRIVEDI <t.vivek@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: fat: add check for dir size in fat_calc_dir_size
References: <87zh8gct29.fsf@mail.parknet.co.jp>
        <20200630170748epcms5p87fa9b4348c1448d2d5a5f6cdddbc021e@epcms5p8>
        <875zb8o6zh.fsf@mail.parknet.co.jp>
        <87ftacolpf.fsf@mail.parknet.co.jp>
        <1593428559-13920-1-git-send-email-anupam.al@samsung.com>
        <20200630123355epcms5p602efe0e4ceedcfe11eae2153c8466678@epcms5p6>
        <20200703142939epcms5p1440ec65f7e8a3e4741ade2496135d747@epcms5p1>
        <CGME20200629110320epcas5p34ccccc7c293f077b34b350935c328215@epcms5p2>
        <20200706115303epcms5p262a630cd1517632c48e4f72a68d98b0c@epcms5p2>
Date:   Mon, 06 Jul 2020 23:22:58 +0900
In-Reply-To: <20200706115303epcms5p262a630cd1517632c48e4f72a68d98b0c@epcms5p2>
        (Anupam Aggarwal's message of "Mon, 06 Jul 2020 17:23:03 +0530")
Message-ID: <87pn98g1tp.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anupam Aggarwal <anupam.al@samsung.com> writes:

>>Anyway, fsck would be main way. And on other hand, if we want to add
>>mitigation for corruption, we would have to see much more details of
>>this corruption.  Can you put somewhere to access the corrupted image
>>(need the only metadata) to reproduce?
>
> Sorry, uploading of any file not allowed from within.
> So, metadata image is not possible to be shared via. upload.
> Can try to arrange few more logs via. fsck.

Then, can you dump the invalid directory entries in corrupted image, and
check exactly why recursive traverse (ls -lR) never end?

We need to know the root cause to fix, e.g. this directory entry has
loop, etc.

>>What happens if you recursively traversed directories on Windows? This
>>issue happens on Windows too?
>
> After connecting USB to windows 10, when corrupted dir(\CorruptedDIR)
> is browsed, it shows 2623 number of files and directories, without
> delay.  Name and timestamps of those file/directories are garbage
> values.

Sounds like filtered the invalid names.

> Further if we browse these sub-directories and open files of corrupted
> dir(\CorruptedDIR) following popups are coming on Windows 10:
> 1. The filename, directory name, or volume label syntax is incorrect
> 2. Specified path does not exist. Check the path and try again
>
> So issue of un-ending browsing(ls -lR) of corrupted USB is not coming
> on windows 10, it lists limited number of files/directories, of
> corrupted dir(\CorruptedDIR) without delay.

It may had the luck, loop was filtered by invalid names. Well, not sure.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
