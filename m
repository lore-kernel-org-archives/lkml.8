Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DF8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E229320775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KztnXTTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgFZGya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:54:30 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12299 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgFZGya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 02:54:30 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef59b470000>; Thu, 25 Jun 2020 23:52:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 25 Jun 2020 23:54:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 25 Jun 2020 23:54:29 -0700
Received: from [10.2.63.78] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jun
 2020 06:54:29 +0000
Subject: Re: [PATCH 2/2] xen/privcmd: Convert get_user_pages*() to
 pin_user_pages*()
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, <sstabellini@kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        Paul Durrant <xadimgnik@gmail.com>
References: <1593054160-12628-1-git-send-email-jrdr.linux@gmail.com>
 <1593054160-12628-2-git-send-email-jrdr.linux@gmail.com>
 <59afe2fe-3718-85aa-f3b5-83ca0b9df577@nvidia.com>
 <CAFqt6zZdq_OMZ3EBDGC+Bn4uPBEhDGOYF=jB4B16z7rY6hpZ7g@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a750e5e5-fd5d-663b-c5fd-261d7c939ba7@nvidia.com>
Date:   Thu, 25 Jun 2020 23:54:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zZdq_OMZ3EBDGC+Bn4uPBEhDGOYF=jB4B16z7rY6hpZ7g@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593154375; bh=Q41CWEP5r3Ufe0JNWhziz/qb4o51XvJxncTjiFALTd8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=KztnXTTdUvCLh7PVjhgdEdJjQLzOZ+aiFMqOIGgtqGoF0ODBvP087ugRo3NmzGeBU
         spIKPTrXPydpzoSH1PEByxRFPLmch6g1j9Ts6UuzwLBNdRsplAxU00Upc7Fn73AN1A
         jAyupSo+0x5EY6DMJiyuNm2cl96pczadN10iObrRoix9yShwNmNk3XQt6Iv/81P+LG
         mk3cyuVI9pY9kgOqNBpI6MQ+1VJ6WXJc//TcPdFrEQzi1gNw4aT0k/nJFwrpuKvCVH
         727IJiaCE++NmKS8Na8++JuQCfdG9BKYQb2yCQ5DMKW+xnzb9QSzraquFoe866bI1i
         xyboQkZZz52hA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-25 22:26, Souptick Joarder wrote:
> On Thu, Jun 25, 2020 at 11:19 AM John Hubbard <jhubbard@nvidia.com> wrote:
>> On 2020-06-24 20:02, Souptick Joarder wrote:
...
>>> @@ -612,13 +612,7 @@ static int lock_pages(
>>>
>>>    static void unlock_pages(struct page *pages[], unsigned int nr_pages)
>>>    {
>>> -     unsigned int i;
>>> -
>>> -     for (i = 0; i < nr_pages; i++) {
>>> -             if (!PageDirty(page))
>>> -                     set_page_dirty_lock(page);
>>> -             put_page(pages[i]);
>>> -     }
>>> +     unpin_user_pages_dirty_lock(pages, nr_pages, 1);
>>
>> "true", not "1", is the correct way to call that function.
> 
> Ok.
> 
>>
>> Also, this approach changes the behavior slightly, but I think it's

Correction, I forgot that I put that same if(!PageDirty(page)) check into
unpin_user_pages_dirty_lock(). So it doesn't change behavior. That's good.

>> reasonable to just set_page_dirty_lock() on the whole range--hard to
>> see much benefit in checking PageDirty first.
> 
> unpin_user_pages_dirty_lock() internally will do the same check after
> patch [2/2]
> So I thought to keep old and new code in sync. Shall we avoid this check ?
> 
Just leave it as you have it, but of course use "true" instead of 1, please.


thanks,
-- 
John Hubbard
NVIDIA
