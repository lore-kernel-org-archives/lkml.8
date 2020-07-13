Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40208C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC55A206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="PlIuW+Kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgGMB5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 21:57:25 -0400
Received: from mail.synology.com ([211.23.38.101]:33456 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbgGMB5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 21:57:25 -0400
Subject: Re: [PATCH] mm : fix pte _PAGE_DIRTY bit when fallback migrate page
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1594605443; bh=dMt+4j48OGNWxlYU555z1xu2wQ1GhECOEHBMhx3gXYc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PlIuW+KcQCXbqf+KNuT0az7wI1UjNfW25kD3FT1JxChhMBgqDffloSHQ8PGVw/iKS
         nF8wf6FNSEVt/U6Mq8eNHkttyvN9i/ySllUUdH8WXHrOS+S/QedOAfybYCdXZ9hhLV
         ZbpTyC4D0r6dYOqwjOYhtYtkESYfK/CcsDlzzDBM=
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
References: <20200709024808.18466-1-robbieko@synology.com>
 <859c810e-376e-5e8b-e8a5-0da3f83315d1@suse.cz>
From:   Robbie Ko <robbieko@synology.com>
Message-ID: <80b55fcf-def1-8a83-8f53-a22f2be56244@synology.com>
Date:   Mon, 13 Jul 2020 09:57:23 +0800
MIME-Version: 1.0
In-Reply-To: <859c810e-376e-5e8b-e8a5-0da3f83315d1@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Vlastimil Babka 於 2020/7/10 下午11:31 寫道:
> On 7/9/20 4:48 AM, robbieko wrote:
>> From: Robbie Ko <robbieko@synology.com>
>>
>> When a migrate page occurs, we first create a migration entry
>> to replace the original pte, and then go to fallback_migrate_page
>> to execute a writeout if the migratepage is not supported.
>>
>> In the writeout, we will clear the dirty bit of the page and use
>> page_mkclean to clear the dirty bit along with the corresponding pte,
>> but page_mkclean does not support migration entry.
>>
>> The page ditry bit is cleared, but the dirty bit of the pte still exists,
>> so if mmap continues to write, it will result in data loss.
> Curious, did you observe this data loss? What filesystem? If yes, it seems
> serious enough to
> CC stable and determine a Fixes: tag?

Yes, there is data loss.
I'm using a btrfs environment, but not the following patch
btrfs: implement migratepage callback for data pages
https://git.kernel.org/pub/scm/linux/kernel 
/git/torvalds/linux.git/commit/?h=v5.8-rc5& 
id=f8e6608180a31cc72a23b74969da428da236dbd1


>> We fix the by first remove the migration entry and then clearing
>> the dirty bits of the page, which also clears the pte's dirty bits.
>>
>> Signed-off-by: Robbie Ko <robbieko@synology.com>
>> ---
>>   mm/migrate.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index f37729673558..5c407434b9ba 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -875,10 +875,6 @@ static int writeout(struct address_space *mapping, struct page *page)
>>   		/* No write method for the address space */
>>   		return -EINVAL;
>>   
>> -	if (!clear_page_dirty_for_io(page))
>> -		/* Someone else already triggered a write */
>> -		return -EAGAIN;
>> -
>>   	/*
>>   	 * A dirty page may imply that the underlying filesystem has
>>   	 * the page on some queue. So the page must be clean for
>> @@ -889,6 +885,10 @@ static int writeout(struct address_space *mapping, struct page *page)
>>   	 */
>>   	remove_migration_ptes(page, page, false);
>>   
>> +	if (!clear_page_dirty_for_io(page))
>> +		/* Someone else already triggered a write */
>> +		return -EAGAIN;
>> +
>>   	rc = mapping->a_ops->writepage(page, &wbc);
>>   
>>   	if (rc != AOP_WRITEPAGE_ACTIVATE)
>>
>
