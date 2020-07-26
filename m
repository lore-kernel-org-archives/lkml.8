Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AA1C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 13:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E64E206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 13:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="YsdxGaTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgGZNdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 09:33:51 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:33726 "EHLO
        mail1.hostfission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgGZNdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 09:33:50 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
        by mail1.hostfission.com (Postfix) with ESMTP id 5ED0E421AE;
        Sun, 26 Jul 2020 23:33:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
        s=mail; t=1595770428;
        bh=5GI31f2PQFEE8ETcCbbiabG/rWi1p3ssraz0xzQtMXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YsdxGaTUGSITkBkADdCb+6NXyqd0mkxNwMzvSIvJ+A5HZmURJhNwzo6HjiUk8D61o
         ur54QrE0fn4OT63Pq3jiy7B8TWa1aTcY4pieX6NtWlXOyhVnQjCFjdb/PMMABEjjQ6
         PH+pb139hWFVFKgxM8NYCpIPiigV3waRbII2pUBE=
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
        by www1.hostfission.com (Postfix) with ESMTP id 5269D53932;
        Sun, 26 Jul 2020 23:33:48 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 26 Jul 2020 23:33:48 +1000
From:   Geoffrey McRae <geoff@hostfission.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     hdanton@sina.com, tj@kernel.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: Poor windows VFIO performance, GPU stalls (bisected)
In-Reply-To: <a74373a54faf78541d96c28a00ae6757@hostfission.com>
References: <30452714b2935b530b9c2bbf2d20854a@hostfission.com>
 <20200726073052.284dadb2@x1.home>
 <a74373a54faf78541d96c28a00ae6757@hostfission.com>
Message-ID: <1a23ec3c1f1b9d213ddc5fb8adcd9005@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-07-26 23:32, Geoffrey McRae wrote:
> On 2020-07-26 23:30, Alex Williamson wrote:
>> On Sun, 26 Jul 2020 17:49:07 +1000
>> Geoffrey McRae <geoff@hostfission.com> wrote:
>> 
>>> Hi All,
>>> 
>>> The commit 22540ca3d00d2990a4148a13b92209c3dc5422db causes a Windows 
>>> KVM
>>> guest running under QEMU with a VFIO passthrough GPU to randomly 
>>> stall
>>> when using the GPU leading to the guest assuming that the driver has
>>> hung. Reverting this commit resolves the problem.
>> 
>> Please double check this commit ID, I can't find it in mainline or
>> linux-next.  Thanks,
>> 
>> Alex
> 
> Confirmed:
> 
> https://github.com/torvalds/linux/commit/22540ca3d00d2990a4148a13b92209c3dc5422db

Sorry, I just noticed my error, it should be:
aa202f1f56960c60e7befaa0f49c72b8fa11b0a8

> 
>> 
>>> The host system is configured with the following kernel arguments 
>>> which
>>> may be related:
>>>    isolcpus=0-5,24-29,6-11,30-35 rcu_nocbs=0-5,24-29,6-11,30-35
>>> 
>>> The system is an AMD Threadripper 2970WX on a Gigabyte x399 AORUS 
>>> Gaming
>>> 7 board.
>>> It has two GPUs each being passed through to two separate KVM guests,
>>> one is an AMD Radeon 7 in a Linux guest, the other is a GeForce 
>>> 1080Ti
>>> in a Windows guest.
>>> The cores used for these two guests are isolated from the host for
>>> performance reasons.
>>> 
>>> Any insight as to why this is occurring would be appreciated. If you
>>> need any more information or would like to test patches please let me
>>> know.
>>> 
>>> Kind Regards,
>>> Geoffrey McRae
>>> HostFission
>>> 
>>> https://hostfission.com
>>> 
