Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D8DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 318C92078C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGPBEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:04:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7755 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726479AbgGPBEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:04:21 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 00D367C0197A199A374A;
        Thu, 16 Jul 2020 09:04:20 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 16 Jul
 2020 09:04:16 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: change the way of handling range.len
 in F2FS_IOC_SEC_TRIM_FILE
To:     Eric Biggers <ebiggers@kernel.org>, Daeho Jeong <daeho43@gmail.com>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <kernel-team@android.com>, "Daeho Jeong" <daehojeong@google.com>,
        <linux-kernel@vger.kernel.org>
References: <20200713031252.3873546-1-daeho43@gmail.com>
 <20200713181152.GC2910046@google.com>
 <3b02263d-a5e1-136c-40ed-514d34e4c895@huawei.com>
 <CACOAw_wBD_ourGJSdRTDM-wzeH97aGE966QDB6bpjiyXRrh47A@mail.gmail.com>
 <f4a594a1-464f-3a74-90cb-fd536bed9962@huawei.com>
 <CACOAw_w3OWDVXSYHuTEEVv1HaBZir1CWcRAmxOt00MB4vXBKVg@mail.gmail.com>
 <1d84bc01-fece-df55-6e33-07a705cfb432@huawei.com>
 <CACOAw_xaS7qB22EPsZvHoC=uPiPtqGMAK5cP4Vk20xO21GQ-Kg@mail.gmail.com>
 <20200715164220.GC1167@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <78df7d19-2744-34df-73b3-3c4650db8771@huawei.com>
Date:   Thu, 16 Jul 2020 09:04:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200715164220.GC1167@sol.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/16 0:42, Eric Biggers wrote:
> On Wed, Jul 15, 2020 at 07:25:13PM +0900, Daeho Jeong wrote:
>> Chao,
>>
>> I can't find fscrypt_zeroout_range_inline_crypt() function. Do you
>> mean we need to implement this one for inline encryption?
>>
>> 2020년 7월 15일 (수) 오후 4:17, Chao Yu <yuchao0@huawei.com>님이 작성:
>>>
>>> On 2020/7/15 14:54, Daeho Jeong wrote:
>>>> You mean we can support ZEROOUT option only for encrypted files of
>>>> non-multidevice f2fs,
>>>> and return -EOPNOTSUPP in the multidevice case, right now?
>>>
>>> Yes, something like:
>>>
>>> f2fs_sec_trim_file()
>>>
>>> if ((range.flags & F2FS_TRIM_FILE_ZEROOUT) &&
>>>         f2fs_encrypted_file() && f2fs_is_multi_device())
>>>         return -EOPNOTSUPP;
>>>
>>>
>>> f2fs_secure_erase()
>>>
>>> if (!ret && (flags & F2FS_TRIM_FILE_ZEROOUT)) {
>>>         if (f2fs_encrypted_file()) {
>>>                 if (fscrypt_inode_uses_fs_layer_crypto)
>>>                         ret = fscrypt_zeroout_range();
>>>                 else
>>>                         ret = fscrypt_zeroout_range_inline_crypt();
>>>         } else {
>>>                 ret = blkdev_issue_zeroout();
>>>         }
>>> }
> 
> fscrypt_zeroout_range_inline_crypt() is being added by
> "fscrypt: add inline encryption support", which is queued in the fscrypt tree
> (the master branch of https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git).
> 
> But that's not actually relevant here because fscrypt_zeroout_range() calls
> fscrypt_zeroout_range_inline_crypt() when needed.

Oh, correct, thanks for pointing out.

Thanks,

> 
> Just use fscrypt_zeroout_range().
> 
> - Eric
> .
> 
