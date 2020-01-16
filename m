Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A655C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0090F2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcwQskaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgAPRUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:20:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44480 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391260AbgAPRSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579195078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q9O76iCwXxuBVXY0EPgkjSgjg+Zhx6547dbKvdv2dvA=;
        b=TcwQskazko+fX1Uy36CC8QgAFA5BEvHavfqFv+BpTEXyMQsZIBWGVM6wzGmF9SleXDdARv
        LqEJQxj69zIv9m96w59ZwI29tgzNyEznZGcTx7ZKyeE5Ni86xSAIloOZiusDAVXmVqfrzC
        3qqnAucrBWsiIQDYZDM83BlDK48SeXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-t3v8Wxs2PeWEZuznrxHoPA-1; Thu, 16 Jan 2020 12:17:27 -0500
X-MC-Unique: t3v8Wxs2PeWEZuznrxHoPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DDB9800D53;
        Thu, 16 Jan 2020 17:17:05 +0000 (UTC)
Received: from [10.18.17.160] (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E607B842BA;
        Thu, 16 Jan 2020 17:17:01 +0000 (UTC)
Subject: Re: [PATCH v4] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        Scott Cheloha <cheloha@linux.ibm.com>
References: <20191217193238-1-cheloha@linux.vnet.ibm.com>
 <20200109212516.17849-1-cheloha@linux.vnet.ibm.com>
 <181caae3-ffb8-c745-a4c9-1aef93ea6dd5@redhat.com>
 <20200116152214.GX19428@dhcp22.suse.cz>
 <765a07fe-47e9-fe3d-716a-44d9ee4a5e99@redhat.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <007f0eed-0d42-f0de-8af4-acae69db0a42@redhat.com>
Date:   Thu, 16 Jan 2020 12:17:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <765a07fe-47e9-fe3d-716a-44d9ee4a5e99@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/20 10:28 AM, David Hildenbrand wrote:
> On 16.01.20 16:22, Michal Hocko wrote:
>> On Wed 15-01-20 20:09:48, David Hildenbrand wrote:
>>> On 09.01.20 22:25, Scott Cheloha wrote:
>>>> Searching for a particular memory block by id is an O(n) operation
>>>> because each memory block's underlying device is kept in an unsorted
>>>> linked list on the subsystem bus.
>>>>
>>>> We can cut the lookup cost to O(log n) if we cache the memory blocks in
>>>> a radix tree.  With a radix tree cache in place both memory subsystem
>>>> initialization and memory hotplug run palpably faster on systems with a
>>>> large number of memory blocks.
>>>>
>>>> Signed-off-by: Scott Cheloha <cheloha@linux.ibm.com>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> Acked-by: Nathan Lynch <nathanl@linux.ibm.com>
>>>> Acked-by: Michal Hocko <mhocko@suse.com>
>>>
>>> Soooo,
>>>
>>> I just learned that radix trees are nowadays only a wrapper for xarray
>>> (for quite a while already!), and that the xarray interface shall be
>>> used in new code.
>>
>> Good point. I somehow didn't realize this would add more work for a
>> later code refactoring. The mapping should be pretty straightforward.
> 
> Yes it is. @Scott, care to send a fixup that does the mapping?
> 
>>
>> Thanks for noticing!
> 
> Don noticed it, so thanks to him :)
> 
Backporting XArray to RHEL-8, and continuing to support radix-tree api in RHEL-8 due to RHEL rulz, it wasn't stable/bug-free everyewhere, etc., was a challenge, thus my 'sensitivity' to seeing new radix-tree code upstream.

> 

