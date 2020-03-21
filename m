Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAFCC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 12:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32ACA20722
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 12:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584793025;
	bh=F+kqJs1UV3lFH0p9XsOZOQTFoUy/Hn0KUq/CmPvR7wU=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:List-ID:From;
	b=OxoSJd2K5+Y8TsrfRKfqb7Yl8VbBUg9HmkzEz3lTDhkjiKDOfVy4Uy/enVPMcMaj9
	 x0qDDfeak5toJtgkK1Gwwp2Lv+050cFX4T/JJrwwj7LkmSeKRhXFx1SWswwQTKpjS5
	 wz4pV1IM7TCQ9PEkPXrynRz7IdVLLUdHZuRs6+IQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgCUMRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 08:17:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgCUMRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 08:17:03 -0400
Received: from [192.168.0.107] (unknown [49.65.245.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8486120757;
        Sat, 21 Mar 2020 12:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584793022;
        bh=F+kqJs1UV3lFH0p9XsOZOQTFoUy/Hn0KUq/CmPvR7wU=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=SOXPr9VoGGVo6hDy+Nniv1abMx8LgRIyU9uX8lSHxeoh6JMWENZQW0MUIAgsnxCiF
         LNQj5FAWTV2DUcfpM9xkN5gfxc5+J3CPNrrBuDtqe99P9jS4O6RHWd1cjDCpI6UUBz
         drUdKH+SMIujnKKDpDsiVILV+rKn//fORVWQsPhc=
Subject: Re: [f2fs-dev] [PATCH 3/4] f2fs: fix NULL pointer dereference in
 f2fs_verity_work()
To:     Eric Biggers <ebiggers@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20200319115800.108926-1-yuchao0@huawei.com>
 <20200319115800.108926-3-yuchao0@huawei.com>
 <20200320191149.GL851@sol.localdomain>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
From:   Chao Yu <chao@kernel.org>
Message-ID: <915e56c1-3e87-ef0a-8bdf-26a3774b0a18@kernel.org>
Date:   Sat, 21 Mar 2020 20:16:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200320191149.GL851@sol.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-3-21 3:11, Eric Biggers wrote:
> On Thu, Mar 19, 2020 at 07:57:59PM +0800, Chao Yu wrote:
>> If both compression and fsverity feature is on, generic/572 will
>> report below NULL pointer dereference bug.
>>
>>  BUG: kernel NULL pointer dereference, address: 0000000000000018
>>  RIP: 0010:f2fs_verity_work+0x60/0x90 [f2fs]
>>  #PF: supervisor read access in kernel mode
>>  Workqueue: fsverity_read_queue f2fs_verity_work [f2fs]
>>  RIP: 0010:f2fs_verity_work+0x60/0x90 [f2fs]
>>  Call Trace:
>>   process_one_work+0x16c/0x3f0
>>   worker_thread+0x4c/0x440
>>   ? rescuer_thread+0x350/0x350
>>   kthread+0xf8/0x130
>>   ? kthread_unpark+0x70/0x70
>>   ret_from_fork+0x35/0x40
>>
>> There are two issue in f2fs_verity_work():
>> - it needs to traverse and verify all pages in bio.
>> - if pages in bio belong to non-compressed cluster, accessing
>> decompress IO context stored in page private will cause NULL
>> pointer dereference.
>>
>> Fix them.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/data.c | 35 ++++++++++++++++++++++++++++++-----
>>  1 file changed, 30 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 5c5db09324b7..66e49fc1056e 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -187,12 +187,37 @@ static void f2fs_verify_pages(struct page **rpages, unsigned int cluster_size)
>>
>>  static void f2fs_verify_bio(struct bio *bio)
>>  {
>> -	struct page *page = bio_first_page_all(bio);
>> -	struct decompress_io_ctx *dic =
>> -			(struct decompress_io_ctx *)page_private(page);
>> +	struct bio_vec *bv;
>> +	struct bvec_iter_all iter_all;
>> +	struct decompress_io_ctx *dic, *pdic = NULL;
>> +
>> +	bio_for_each_segment_all(bv, bio, iter_all) {
>> +		struct page *page = bv->bv_page;
>> +
>> +		dic = (struct decompress_io_ctx *)page_private(page);
>> +
>> +		if (dic) {
>> +			if (dic != pdic) {
>> +				f2fs_verify_pages(dic->rpages,
>> +							dic->cluster_size);
>> +				f2fs_free_dic(dic);
>> +				pdic = dic;
>> +			}
>> +			continue;
>> +		}
>> +		pdic = dic;
>>
>> -	f2fs_verify_pages(dic->rpages, dic->cluster_size);
>> -	f2fs_free_dic(dic);
>> +		if (bio->bi_status || PageError(page)) {
>> +			ClearPageUptodate(page);
>> +			ClearPageError(page);
>> +		} else {
>> +			if (fsverity_verify_page(page))
>> +				SetPageUptodate(page);
>> +			else
>> +				SetPageError(page);
>> +		}
>> +		unlock_page(page);
>> +	}
>
> I'm a bit confused why you added SetPageError() before unlocking the page.
> The other error paths actually clear the Error flag, not set it.  I thought
> there's a reason for that?

These codes were copy&paste from f2fs_decompress_end_io(), I guess I missed to 
check that logic, so anyway, we need another patch to fix that first.

Thanks for pointing out this.

Thanks,

>
> - Eric
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
