Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8ECC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47671206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgGGL5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:57:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7819 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726745AbgGGL53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:57:29 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D659616BD5B4F6A04B78;
        Tue,  7 Jul 2020 19:57:27 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.214) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Tue, 7 Jul 2020
 19:57:21 +0800
Subject: Re: [PATCH] ubifs: Fix wrong orphan node deletion in
 ubifs_jnl_update()
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <20200702152048.1819867-1-chengzhihao1@huawei.com>
 <CAFLxGvybobVbhS4zQSxSmq3xR40QP=pkyDG8j7jA8a6eOOKfHg@mail.gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <37d3628a-1904-bb94-e225-348dfeafe6b1@huawei.com>
Date:   Tue, 7 Jul 2020 19:57:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvybobVbhS4zQSxSmq3xR40QP=pkyDG8j7jA8a6eOOKfHg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.214]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/7/7 19:52, Richard Weinberger 写道:
> On Thu, Jul 2, 2020 at 5:21 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>> There a wrong orphan node deleting in error handling path in
>> ubifs_jnl_update(), which may cause following error msg:
>>
>>    UBIFS error (ubi0:0 pid 1522): ubifs_delete_orphan [ubifs]:
>>    missing orphan ino 65
>>
>> Fix this by checking whether the node has been operated for
>> adding to orphan list before being deleted,
>>
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> ---
>>   fs/ubifs/journal.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
>> index e5ec1afe1c66..db0a80dd9d52 100644
>> --- a/fs/ubifs/journal.c
>> +++ b/fs/ubifs/journal.c
>> @@ -539,7 +539,7 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
>>                       const struct fscrypt_name *nm, const struct inode *inode,
>>                       int deletion, int xent)
>>   {
>> -       int err, dlen, ilen, len, lnum, ino_offs, dent_offs;
>> +       int err, dlen, ilen, len, lnum, ino_offs, dent_offs, orphan_added = 0;
>>          int aligned_dlen, aligned_ilen, sync = IS_DIRSYNC(dir);
>>          int last_reference = !!(deletion && inode->i_nlink == 0);
>>          struct ubifs_inode *ui = ubifs_inode(inode);
>> @@ -630,6 +630,7 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
>>                          goto out_finish;
>>                  }
>>                  ui->del_cmtno = c->cmt_no;
>> +               orphan_added = 1;
>>          }
>>
>>          err = write_head(c, BASEHD, dent, len, &lnum, &dent_offs, sync);
>> @@ -702,7 +703,7 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
>>          kfree(dent);
>>   out_ro:
>>          ubifs_ro_mode(c, err);
>> -       if (last_reference)
>> +       if (last_reference && orphan_added)
> I think you can just check for orphan_added here.
> Looks good otherwise, thanks for fixing! :-)
Sounds reasonable. I will send v2.

