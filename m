Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182F7C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C5120663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="E+os28dR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgCLNHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:07:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:47022 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCLNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:07:21 -0400
Received: by mail-io1-f68.google.com with SMTP id v3so5544721iom.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mUPVwLwbl+qGOG5kVPBNHG9adxeUh8JOP6RdVyzLB/I=;
        b=E+os28dRCW2/v1ohMkOsikz/8hYa7mpints86TuEemrPaYqU6XFgB2aiT2cRuJY/fb
         nWSpMZV5DwN1EbY83N0wRV2dr4MAFwDe3mDlmZpLuL3F1aEClDztKuAC8FExEsIW2QB2
         bTWsm3Zev9Fi9+yVqLGy6MqlDPxW8PksROSMyEp7FAj6gDltIaD9ndaQE+X805buhieW
         n57qicJpBwPBLvI8tHA7wVnhwRY8RfTWtsSIZgRa28eYts4CKOHUhgesF0EyDskOIXls
         benlZXj9g43xMpir3r2H0EHiCmH7U+NlkRhcYsmy8/hNWwdkY/z2/yp6k+ORpIkBiuVo
         eQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mUPVwLwbl+qGOG5kVPBNHG9adxeUh8JOP6RdVyzLB/I=;
        b=W8mMrxrwuMO9NNNmh21h7094vd5pAx2VF4PrVllm7HHCHQSzYAE6o8wBtOShuAptad
         2qJ2t09YxmCuzFINp9BQjCVq0COooLKlBD/ZS82ekx0d4W2xZx9CdmIe7DeqdZBYFqT6
         w7v3/b5O5PjjvxlGszM51ubcCd6raHGUrPanmcVx5YxibLi5tpXK0bjDfqNzfgY8Kne7
         dNgPDMdscpEwzG1x2s3z31Jqa+j9focD0De8gebofCprvPd329/IB++3MDZBAkxz0Hh/
         Y1ZfBzsv8lWEVmBC0z6r5OnakUobVvP/RErbu6C8fnVVPw+33ay5YZABblzEXQLvd+LN
         W05Q==
X-Gm-Message-State: ANhLgQ3gJCfjH69LdRuGY609oUUxvgc0IEgQN2F6gVNZppUR0nMGOZqv
        2xIXJV/MVGM4Fadg5qtnurr1uQ==
X-Google-Smtp-Source: ADFU+vt+fR4+B0ZCsiefMYIUrjnUtYF3XYvh9X83QTCCEfHOKk7fQk2p9JzHbDUoxsiC7hW/VvgQLA==
X-Received: by 2002:a5d:984e:: with SMTP id p14mr7593477ios.115.1584018439543;
        Thu, 12 Mar 2020 06:07:19 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n18sm5383585ilq.38.2020.03.12.06.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:07:19 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Matteo Croce <mcroce@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Coly Li <colyli@suse.de>
References: <20200312135457.6891749e@canb.auug.org.au>
 <CAGnkfhztbmpP0=KT-iNbkUGKerhX04ENFsexA4_2cP_RUs0Png@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <baefdc44-d7cb-4e9e-c46c-b37012cfc40d@kernel.dk>
Date:   Thu, 12 Mar 2020 07:07:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAGnkfhztbmpP0=KT-iNbkUGKerhX04ENFsexA4_2cP_RUs0Png@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/20 4:12 AM, Matteo Croce wrote:
> On Thu, Mar 12, 2020 at 3:55 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> After merging the block tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> In file included from fs/erofs/xattr.h:10,
>>                  from fs/erofs/inode.c:7:
>> fs/erofs/inode.c: In function 'erofs_read_inode':
>> fs/erofs/internal.h:197:31: error: 'PAGE_SECTORS_SHIFT' undeclared (first use in this function); did you mean 'PA_SECTION_SHIFT'?
>>   197 | #define LOG_SECTORS_PER_BLOCK PAGE_SECTORS_SHIFT
>>       |                               ^~~~~~~~~~~~~~~~~~
>> fs/erofs/inode.c:122:30: note: in expansion of macro 'LOG_SECTORS_PER_BLOCK'
>>   122 |   inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK;
>>       |                              ^~~~~~~~~~~~~~~~~~~~~
>> fs/erofs/internal.h:197:31: note: each undeclared identifier is reported only once for each function it appears in
>>   197 | #define LOG_SECTORS_PER_BLOCK PAGE_SECTORS_SHIFT
>>       |                               ^~~~~~~~~~~~~~~~~~
>> fs/erofs/inode.c:122:30: note: in expansion of macro 'LOG_SECTORS_PER_BLOCK'
>>   122 |   inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK;
>>       |                              ^~~~~~~~~~~~~~~~~~~~~
>> In file included from fs/erofs/data.c:7:
>> fs/erofs/data.c: In function 'erofs_read_raw_page':
>> fs/erofs/internal.h:197:31: error: 'PAGE_SECTORS_SHIFT' undeclared (first use in this function); did you mean 'PA_SECTION_SHIFT'?
>>   197 | #define LOG_SECTORS_PER_BLOCK PAGE_SECTORS_SHIFT
>>       |                               ^~~~~~~~~~~~~~~~~~
>> fs/erofs/data.c:226:4: note: in expansion of macro 'LOG_SECTORS_PER_BLOCK'
>>   226 |    LOG_SECTORS_PER_BLOCK;
>>       |    ^~~~~~~~~~~~~~~~~~~~~
>> fs/erofs/internal.h:197:31: note: each undeclared identifier is reported only once for each function it appears in
>>   197 | #define LOG_SECTORS_PER_BLOCK PAGE_SECTORS_SHIFT
>>       |                               ^~~~~~~~~~~~~~~~~~
>> fs/erofs/data.c:226:4: note: in expansion of macro 'LOG_SECTORS_PER_BLOCK'
>>   226 |    LOG_SECTORS_PER_BLOCK;
>>       |    ^~~~~~~~~~~~~~~~~~~~~
>> fs/erofs/data.c: In function 'erofs_bmap':
>> fs/erofs/internal.h:197:31: error: 'PAGE_SECTORS_SHIFT' undeclared (first use in this function); did you mean 'PA_SECTION_SHIFT'?
>>   197 | #define LOG_SECTORS_PER_BLOCK PAGE_SECTORS_SHIFT
>>       |                               ^~~~~~~~~~~~~~~~~~
>> fs/erofs/data.c:351:16: note: in expansion of macro 'LOG_SECTORS_PER_BLOCK'
>>   351 |   if (block >> LOG_SECTORS_PER_BLOCK >= blks)
>>       |                ^~~~~~~~~~~~~~~~~~~~~
>>
>> Caused by commit
>>
>>   61c7d3d5e015 ("block: refactor duplicated macros")
>>
>> I have used the block tree from next-20200311 for today.
>>
>> --
>> Cheers,
>> Stephen Rothwell
> 
> Hi,
> 
> I was building a kernel without erofs. Just including
> include/linux/blkdev.h will fix it, should I amend the
> patch or send a fix?

I'll drop the patch. I was worried about the patch to begin with,
something like this really should be done through cocinelle so there's
less concern of a stupid mistake.

On top of that, somewhat miffed that you'd have a v3 of a patch, yet
haven't bothered to even _compile_ the parts you touch. That's
inexcusable.

-- 
Jens Axboe

