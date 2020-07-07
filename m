Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6F3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FC2206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgGGLnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:43:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:46920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgGGLnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:43:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53655AE35;
        Tue,  7 Jul 2020 11:43:15 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] xen/privcmd: Mark pages as dirty
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
References: <1594059372-15563-1-git-send-email-jrdr.linux@gmail.com>
 <1594059372-15563-3-git-send-email-jrdr.linux@gmail.com>
 <8fdd8c77-27dd-2847-7929-b5d3098b1b45@suse.com>
 <CAFqt6zZRx3oDO+p2e6EiDig9fzKirME-t6fanzDRh6e7gWx+nA@mail.gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <4abc0dd2-655c-16fa-dfc3-95904196c81f@suse.com>
Date:   Tue, 7 Jul 2020 13:43:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zZRx3oDO+p2e6EiDig9fzKirME-t6fanzDRh6e7gWx+nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.20 13:30, Souptick Joarder wrote:
> On Tue, Jul 7, 2020 at 3:08 PM Jürgen Groß <jgross@suse.com> wrote:
>>
>> On 06.07.20 20:16, Souptick Joarder wrote:
>>> pages need to be marked as dirty before unpinned it in
>>> unlock_pages() which was oversight. This is fixed now.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> Suggested-by: John Hubbard <jhubbard@nvidia.com>
>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>> Cc: Paul Durrant <xadimgnik@gmail.com>
>>> ---
>>>    drivers/xen/privcmd.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
>>> index 33677ea..f6c1543 100644
>>> --- a/drivers/xen/privcmd.c
>>> +++ b/drivers/xen/privcmd.c
>>> @@ -612,8 +612,11 @@ static void unlock_pages(struct page *pages[], unsigned int nr_pages)
>>>    {
>>>        unsigned int i;
>>>
>>> -     for (i = 0; i < nr_pages; i++)
>>> +     for (i = 0; i < nr_pages; i++) {
>>> +             if (!PageDirty(pages[i]))
>>> +                     set_page_dirty_lock(pages[i]);
>>
>> With put_page() directly following I think you should be able to use
>> set_page_dirty() instead, as there is obviously a reference to the page
>> existing.
> 
> Patch [3/3] will convert above codes to use unpin_user_pages_dirty_lock()
> which internally do the same check. So I thought to keep linux-stable and
> linux-next code in sync. John had a similar concern [1] and later agreed to keep
> this check.
> 
> Shall I keep this check ?  No ?
> 
> [1] https://lore.kernel.org/xen-devel/a750e5e5-fd5d-663b-c5fd-261d7c939ba7@nvidia.com/

I wasn't referring to checking PageDirty(), but to the use of
set_page_dirty_lock().

Looking at the comment just before the implementation of
set_page_dirty_lock() suggests that it is fine to use set_page_dirty()
instead (so not calling lock_page()).

Only the transition from get_user_pages_fast() to pin_user_pages_fast()
requires to use the locked version IMO.


Juergen
