Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB7AC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33DF1206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bpuZ7YTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgEENs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:48:29 -0400
Received: from m12-17.163.com ([220.181.12.17]:46070 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728898AbgEENs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:48:29 -0400
X-Greylist: delayed 955 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 May 2020 09:48:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=vtE9L
        BKKqPY2QgOdCyMuZW9mjYDyjGtNVqWc4Ka9luo=; b=bpuZ7YTYNZo8qjLCX6F9U
        ay8iGfhemsjWMvllBx3GKhJ2anA8/6VNjQXiQqR11jgKHjYSFM0cd3YiXkgkIwSS
        BOsWXdIVUF8umu3yxdlGCG4kJFMgFqbc8uK+/7XmSmdNqdLvpKojArPHjk2jz/Q5
        1tIjBv3mehZ4LaEbnKmgbY=
Received: from [192.168.1.7] (unknown [120.244.110.63])
        by smtp13 (Coremail) with SMTP id EcCowAB37v3carFejW99BA--.112S2;
        Tue, 05 May 2020 21:32:12 +0800 (CST)
Subject: Re: fs: jfs: fix a possible data race in txBegin()
To:     Dave Kleikamp <dave.kleikamp@oracle.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        jfs-discussion@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <5ef374a5-0e2e-5c74-a827-0148c384f6e3@web.de>
 <abbb03ec-7ce3-08b6-7d08-420743067f19@gmail.com>
 <fa6fabec-8cc5-fc62-657f-3794e9405fac@web.de>
 <df165b9f-7a51-a632-b1a0-a2cf1efa1915@oracle.com>
From:   Jia-Ju Bai <baijiaju1990@163.com>
Message-ID: <565e317a-396e-9221-11bb-bc8c76cc9f7a@163.com>
Date:   Tue, 5 May 2020 21:32:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <df165b9f-7a51-a632-b1a0-a2cf1efa1915@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: EcCowAB37v3carFejW99BA--.112S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWkWFy8ZFyUuF1UKw45Jrb_yoWDCFc_uF
        s5CFyUGwn8uF1rXFZ7Jw4fZry3Zw47ZF1Yywn5JrW7J3s3tFs5CFZ7KFyYy3W5tF9akrsr
        Ca1Sqw4Dt3W2qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5M5l5UUUUU==
X-Originating-IP: [120.244.110.63]
X-CM-SenderInfo: xedlyx5dmximizq6il2tof0z/1tbiVhwbelqzk2jEvAAAsB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/5/5 21:23, Dave Kleikamp wrote:
> On 5/5/20 12:12 AM, Markus Elfring wrote:
>>> I am not sure how to add the tag "Fixes"...
>> How helpful do you find the available software documentation?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=47cf1b422e6093aee2a3e55d5e162112a2c69870#n183
>>
>>
>>> I need to find which previous commit add the code about txBegin()?
>> I suggest to take another look at corresponding source code places
>> by a command like “git blame”.
>> https://git-scm.com/book/en/v2/Git-Tools-Debugging-with-Gits
> I suspect that the problem was in the code much longer than it has been
> under git source control.

I agree, because "git blame" shows the last change to txBegin() is 
commit 1da177e4c3f4, which was submitted in 2005...
And this commit just added or merged the filesystem to the Linux kernel.
Thus, adding the tag "Fixes" of this commit should be useless...


Best wishes,
Jia-Ju Bai

