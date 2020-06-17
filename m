Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA795C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE8821475
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFQH4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:56:40 -0400
Received: from verein.lst.de ([213.95.11.211]:42288 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgFQH4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:56:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1200968B05; Wed, 17 Jun 2020 09:56:37 +0200 (CEST)
Date:   Wed, 17 Jun 2020 09:56:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     linux-kernel@vger.kernel.org, hch@lst.de,
        mm-commits@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [merged] exec-open-code-copy_string_kernel.patch removed from
 -mm tree
Message-ID: <20200617075636.GA13618@lst.de>
References: <20200605201952.V2waw9dhw%akpm@linux-foundation.org> <079d08bb-f8de-e119-a427-4ff0274f4616@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <079d08bb-f8de-e119-a427-4ff0274f4616@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 03:14:44PM +0200, Vegard Nossum wrote:
>
> On 2020-06-05 22:19, akpm@linux-foundation.org wrote:
>> The patch titled
>>       Subject: exec: open code copy_string_kernel
>> has been removed from the -mm tree.  Its filename was
>>       exec-open-code-copy_string_kernel.patch
>>
>> This patch was dropped because it was merged into mainline or a subsystem tree
>>
>> ------------------------------------------------------
>> From: Christoph Hellwig <hch@lst.de>
>> Subject: exec: open code copy_string_kernel
>>
>> Currently copy_string_kernel is just a wrapper around copy_strings that
>> simplifies the calling conventions and uses set_fs to allow passing a
>> kernel pointer.  But due to the fact the we only need to handle a single
>> kernel argument pointer, the logic can be sigificantly simplified while
>> getting rid of the set_fs.
>>
>> Link: http://lkml.kernel.org/r/20200501104105.2621149-3-hch@lst.de
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>
>>   fs/exec.c |   45 +++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 35 insertions(+), 10 deletions(-)
>>
>> --- a/fs/exec.c~exec-open-code-copy_string_kernel
>> +++ a/fs/exec.c
>> @@ -592,17 +592,42 @@ out:
>>    */
>>   int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
>>   {
>> -	int r;
>> -	mm_segment_t oldfs = get_fs();
>> -	struct user_arg_ptr argv = {
>> -		.ptr.native = (const char __user *const  __user *)&arg,
>> -	};
>> -
>> -	set_fs(KERNEL_DS);
>> -	r = copy_strings(1, argv, bprm);
>> -	set_fs(oldfs);
>> +	int len = strnlen(arg, MAX_ARG_STRLEN) + 1 /* terminating NUL */;
>> +	unsigned long pos = bprm->p;
>>   -	return r;
>> +	if (len == 0)
>> +		return -EFAULT;
>
> Just a quick question, how can len ever be 0 here when len was set to
> strnlen() + 1? Should the test be different?
>
> The old version (i.e. copy_strings()) seems to return -EFAULT when
> strnlen() returns 0.

So, the nasty part here is that strnlen_user has different semantics
from strnlen:

 - strlen excludes the terminating null byte and never returns error
   codes
 - strnlen_user includes the terminating null byte, and a 0 return
   means it could not access the user address (a condition that can't
   happen for strlen).

Now with that back to your original question:  I think then len == 0
check can just be removed without replacement.
