Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43FBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A287B206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PO9cecDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgFSHai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:30:38 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7271 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbgFSHah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:30:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eec69380000>; Fri, 19 Jun 2020 00:28:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 19 Jun 2020 00:30:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 19 Jun 2020 00:30:37 -0700
Received: from [10.2.62.75] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Jun
 2020 07:30:37 +0000
Subject: Re: [RFC PATCH] xen/privcmd: Convert get_user_pages*() to
 pin_user_pages*()
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC:     Juergen Gross <jgross@suse.com>, <sstabellini@kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <paul@xen.org>
References: <1592363698-4266-1-git-send-email-jrdr.linux@gmail.com>
 <d9e8ad0f-f2aa-eea4-5bc7-a802c626ace6@oracle.com>
 <CAFqt6zbJD+k9xkV9Se0nL2qKfnea3mRrWJ4gzPmPJBquYk4M+w@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <fe2a1d23-7abd-86a9-4aec-2c14fb11cdea@nvidia.com>
Date:   Fri, 19 Jun 2020 00:30:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zbJD+k9xkV9Se0nL2qKfnea3mRrWJ4gzPmPJBquYk4M+w@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592551736; bh=Fe6+LEcBGqkmcut7uJjH2j1++zsWFrmLLtaEG5FehVs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PO9cecDSmGNiqNB9v5SItJ0pP9uHG0j0hqx1mly0Bozfnb61r+QlkigFmHiTrjnVA
         50uX8ugVzjFrQw9jzH7jZsAMEl15fvx3mdu/9Gcq7OD00kQJskp6KzIJUGz6hc8OL4
         KMekN5uR3E7Z+Wc/XpK5k89x0TIpuvw7DQYHPhudM544WumvUaJGuay2QtZFqcmFd5
         DsfAD52xAevCZE4moN72e/Vm5ogJR7OQldT//bYwFB+jBy/UHz24CJjD2BdN3Uj6/l
         9Z/5BV/dhjoeF3QGmiYjbHENP6qry3q39uhEjU5fcIBe5nxaOlx4cz3UlErPqcrUsb
         ZWF0KVgCIk6xg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-18 20:12, Souptick Joarder wrote:
> On Wed, Jun 17, 2020 at 11:29 PM Boris Ostrovsky
> <boris.ostrovsky@oracle.com> wrote:
>>
>> On 6/16/20 11:14 PM, Souptick Joarder wrote:
>>> In 2019, we introduced pin_user_pages*() and now we are converting
>>> get_user_pages*() to the new API as appropriate. [1] & [2] could
>>> be referred for more information.


Ideally, the commit description should say which case, in
pin_user_pages.rst, that this is.


>>>
>>> [1] Documentation/core-api/pin_user_pages.rst
>>>
>>> [2] "Explicit pinning of user-space pages":
>>>          https://lwn.net/Articles/807108/
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>> ---
>>> Hi,
>>>
>>> I have compile tested this patch but unable to run-time test,
>>> so any testing help is much appriciated.
>>>
>>> Also have a question, why the existing code is not marking the
>>> pages dirty (since it did FOLL_WRITE) ?
>>
>>
>> Indeed, seems to me it should. Paul?

Definitely good to get an answer from an expert in this code, but
meanwhile, it's reasonable to just mark them dirty. Below...

>>
>>
>>>
>>>   drivers/xen/privcmd.c | 7 ++-----
>>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
>>> index a250d11..543739e 100644
>>> --- a/drivers/xen/privcmd.c
>>> +++ b/drivers/xen/privcmd.c
>>> @@ -594,7 +594,7 @@ static int lock_pages(
>>>                if (requested > nr_pages)
>>>                        return -ENOSPC;
>>>
>>> -             pinned = get_user_pages_fast(
>>> +             pinned = pin_user_pages_fast(
>>>                        (unsigned long) kbufs[i].uptr,
>>>                        requested, FOLL_WRITE, pages);
>>>                if (pinned < 0)
>>> @@ -614,10 +614,7 @@ static void unlock_pages(struct page *pages[], unsigned int nr_pages)
>>>        if (!pages)
>>>                return;
>>>
>>> -     for (i = 0; i < nr_pages; i++) {
>>> -             if (pages[i])
>>> -                     put_page(pages[i]);
>>> -     }
>>> +     unpin_user_pages(pages, nr_pages);


...so just use unpin_user_pages_dirty_lock() here, I think.


>>
>>
>> Why are you no longer checking for valid pages?
> 
> My understanding is, in case of lock_pages() end up returning partial
> mapped pages,
> we should pass no. of partial mapped pages to unlock_pages(), not nr_pages.
> This will avoid checking extra check to validate the pages[i].
> 
> and if lock_pages() returns 0 in success, anyway we have all the pages[i] valid.
> I will try to correct it in v2.
> 
> But I agree, there is no harm to check for pages[i] and I believe,


Generally, it *is* harmful to do unnecessary checks, in most code, but especially
in most kernel code. If you can convince yourself that the check for null pages
is redundant here, then please let's remove that check. The code becomes then
becomes shorter, simpler, and faster.


> unpin_user_pages()
> is the right place to do so.
> 
> John any thought ?


So far I haven't seen any cases to justify changing the implementation of
unpin_user_pages().


thanks,
-- 
John Hubbard
NVIDIA
