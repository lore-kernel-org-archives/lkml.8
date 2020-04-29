Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ACDC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D102073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GJ8Rr26H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgD2OwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726484AbgD2OwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:52:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513B2C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=tJbIYTsv5ydRIeAGA1IAN4ifc0SDWuh5ts8+JIK7AgI=; b=GJ8Rr26H0QFQAfm6VPf7syyx3x
        uqo1UkUd7+VFvFJNrrQM3UiJfUpMUPMzl8uBoTrLfo4Mwq0nBBhRgf9W48wZ1N98qizS6246R0rOf
        ZOrcqJ+Dp5tY8eQQToHUVRGVJf4LF9EBMnS/F169EN6h94/LP/ZfjZZ+Vl3AG9xNS6udlAPxjtGrk
        x7Rqi/Xn1TOnmTIBz6MIyWQCulkndHnUJH49rBGkGehwdOFD9brWmiwisEiaiwuuuSolD6gV7G2fT
        20DjXShTOdeSUmXnyqr35rZPqwU0MIrCQs0tK8mucbOSUOCqpwZYTnHuWjZ51VeFpQeqksCOhageJ
        NLsmoVGg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTo4A-0006Ji-PV; Wed, 29 Apr 2020 14:52:02 +0000
Subject: Re: [dm-devel] [PATCH -next] md: dm-ebs-target: fix build errors &
 Kconfig entry
To:     Heinz Mauelshagen <heinzm@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, dm-devel@redhat.com
Cc:     Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>
References: <d33b3bfb-c38d-9770-e6a6-929519dc21d4@infradead.org>
 <980b6b95-6e18-40ff-f71c-058917c5b6ee@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f78d654d-3f98-151d-bc16-bf31a6547a66@infradead.org>
Date:   Wed, 29 Apr 2020 07:52:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <980b6b95-6e18-40ff-f71c-058917c5b6ee@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/20 5:23 AM, Heinz Mauelshagen wrote:
> On 4/28/20 5:03 PM, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix build errors by selecting DM_BUFIO.
>>
>> Fix Kconfig entry formatting by using tabs instead of spaces,
>> using "help" instead of "---help---", and
>> indenting help text with one additional space.
>>
>> Fixes these build errors:
>>
>> ld: drivers/md/dm-ebs-target.o: in function `__ebs_forget_bio':
>> dm-ebs-target.c:(.text+0x1bc): undefined reference to `dm_bufio_forget'
>> ld: drivers/md/dm-ebs-target.o: in function `ebs_dtr':
>> dm-ebs-target.c:(.text+0x2fe): undefined reference to `dm_bufio_client_destroy'
>> ld: drivers/md/dm-ebs-target.o: in function `__ebs_rw_bio':
>> dm-ebs-target.c:(.text+0x4c4): undefined reference to `dm_bufio_get_block_size'
>> ld: dm-ebs-target.c:(.text+0x4f1): undefined reference to `dm_bufio_read'
>> ld: dm-ebs-target.c:(.text+0x504): undefined reference to `dm_bufio_get_block_size'
>> ld: dm-ebs-target.c:(.text+0x519): undefined reference to `dm_bufio_new'
>> ld: dm-ebs-target.c:(.text+0x567): undefined reference to `dm_bufio_mark_partial_buffer_dirty'
>> ld: dm-ebs-target.c:(.text+0x56f): undefined reference to `dm_bufio_release'
>> ld: drivers/md/dm-ebs-target.o: in function `__ebs_process_bios':
>> dm-ebs-target.c:(.text+0x6bf): undefined reference to `dm_bufio_prefetch'
>> ld: dm-ebs-target.c:(.text+0x72d): undefined reference to `dm_bufio_prefetch'
>> ld: dm-ebs-target.c:(.text+0x783): undefined reference to `dm_bufio_prefetch'
>> ld: dm-ebs-target.c:(.text+0x7fe): undefined reference to `dm_bufio_write_dirty_buffers'
>> ld: drivers/md/dm-ebs-target.o: in function `ebs_ctr':
>> dm-ebs-target.c:(.text+0xa82): undefined reference to `dm_bufio_client_create'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Heinz Mauelshagen <dm-devel@redhat.com>
>> Cc: Alasdair Kergon <agk@redhat.com>
>> Cc: Mike Snitzer <snitzer@redhat.com>
>> Cc: dm-devel@redhat.com
>> ---
>>   drivers/md/Kconfig |   12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> --- linux-next-20200428.orig/drivers/md/Kconfig
>> +++ linux-next-20200428/drivers/md/Kconfig
>> @@ -338,12 +338,12 @@ config DM_WRITECACHE
>>          to be cached in standard RAM.
>>     config DM_EBS
>> -       tristate "Emulated block size target (EXPERIMENTAL)"
>> -       depends on BLK_DEV_DM
>> -       default n
>> -       ---help---
>> -     dm-ebs emulates smaller logical block size on backing devices
>> -     with larger ones (e.g. 512 byte sectors on 4K native disks).
>> +    tristate "Emulated block size target (EXPERIMENTAL)"
>> +    depends on BLK_DEV_DM
>> +    select DM_BUFIO
>> +    help
>> +      dm-ebs emulates smaller logical block size on backing devices
>> +      with larger ones (e.g. 512 byte sectors on 4K native disks).
>>     config DM_ERA
>>          tristate "Era target (EXPERIMENTAL)"
> 
> 
> Thanks, fine with me for the most part.
> 
> We mainly use '---help---' for dm/md though, so lets's keep it. Mike?
> 
> Heinz

Sure, you can keep it for now, but it is being phased out.

thanks.
-- 
~Randy

