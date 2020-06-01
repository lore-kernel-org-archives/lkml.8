Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A95C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACFD20772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgFANp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:45:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47866 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbgFANpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:45:55 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C65D430C51C257326BBE;
        Mon,  1 Jun 2020 21:45:52 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.18) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 1 Jun 2020
 21:45:45 +0800
Subject: Re: [PATCH 1/2] ubifs: Fix potential memory leaks while iterating
 entries
To:     Markus Elfring <Markus.Elfring@web.de>,
        <linux-mtd@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Richard Weinberger" <richard@nod.at>,
        Yi Zhang <yi.zhang@huawei.com>
References: <2bec05b7-78d3-fa36-134a-efbe977933e3@web.de>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <45e2cd69-93ec-a0b9-b2a6-d170eee44055@huawei.com>
Date:   Mon, 1 Jun 2020 21:45:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2bec05b7-78d3-fa36-134a-efbe977933e3@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.18]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/6/1 20:00, Markus Elfring 写道:
>> Fix some potential memory leaks in error handling branches while
>> iterating xattr entries.
> Such information is useful.
>
>
>> For example, function ubifs_tnc_remove_ino()
>> forgets to free pxent if it exists. Similar problems also exist in
>> ubifs_purge_xattrs(), ubifs_add_orphan() and ubifs_jnl_write_inode().
> Can an other wording variant be a bit nicer?
Thanks for reminding, I will improve this description.
>
> I suggest to avoid the specification of duplicate function calls
> (also for the desired exception handling).
> Will it be helpful to add a few jump targets?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162#n455
I've thought about using "goto err_tag_2" in kill_xattrs code block to 
release prev xent, but later it needs to jump to 'out_release tag‘ for 
releasing previously requested memory, which can clutter the code. It 
seems that two consecutive 'goto tags' will make the code less readable.
> Regards,
> Markus
>
> .



