Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22ADC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B752068D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oFLvfohf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgFHTF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:05:58 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4517 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgFHTF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:05:58 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ede8bbb0000>; Mon, 08 Jun 2020 12:04:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 08 Jun 2020 12:05:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 08 Jun 2020 12:05:57 -0700
Received: from [10.2.58.199] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Jun
 2020 19:05:57 +0000
Subject: Re: [PATCH] staging: kpc2000: kpc_dma: Convert get_user_pages() -->
 pin_user_pages()
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>, <jane.pnx9@gmail.com>,
        =?UTF-8?Q?Simon_Sandstr=c3=b6m?= <simon@nikanor.nu>,
        <harshjain32@gmail.com>, <festevam@gmail.com>, <jeremy@azazel.net>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>,
        Bharath Vedartham <linux.bhar@gmail.com>
References: <1590947491-11194-1-git-send-email-jrdr.linux@gmail.com>
 <7e725dd0-7423-b85b-ff56-9705419d13b9@nvidia.com>
 <CAFqt6zbsNcHWF-0Na2xMKdJQs2kVkLHTCw=cytvdo+z-axx97Q@mail.gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <5f0c68a0-2cc4-5724-d778-7e9d5fd7dfde@nvidia.com>
Date:   Mon, 8 Jun 2020 12:05:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zbsNcHWF-0Na2xMKdJQs2kVkLHTCw=cytvdo+z-axx97Q@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591643067; bh=y9FC9kMwMYaUWl45KqVZDyvjd+9HlOT1/8zsf7RZB5U=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=oFLvfohf3AKnS3anENkJNIC0l8M3zdb+SYF9UVO3JTgFrLfvGjf+hhnHP23BcwUms
         MuwvsLTXdzmh2OS9K0m3fHi9yKVlaDO5W4YVHp0nejCjbQK1hCtabZFZHZxdDSXU38
         rfDFZNKbb++t7poQgACm5qfWUtAIB/TqvV4lWGj8MTZE5VBC0Q/1J0MjTxhpUAssDq
         8oUVmygK7C+DxlBfNfUKpAOP/bZYWaLBNSVTCyKIdKr8Rrkf2M44LFT4J8ZOmtF3WD
         LKp0bQR89v6EehNzUnPVEw1MWt/v3JZlM0GTt8FrMg5+P1JphpQFXRizVKtQk12vwk
         5RWISd7FAjPuw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-08 12:01, Souptick Joarder wrote:
> On Mon, Jun 1, 2020 at 7:15 AM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 2020-05-31 10:51, Souptick Joarder wrote:
>>> In 2019, we introduced pin_user_pages*() and now we are converting
>>> get_user_pages*() to the new API as appropriate. [1] & [2] could
>>> be referred for more information.
>>>
>>> When pin_user_pages() returns numbers of partially mapped pages,
>>> those pages were not unpinned as part of error handling. Fixed
>>> it as part of this patch.
>>>
>>
>> Hi Souptick,
>>
>> btw, Bharath (+cc) attempted to do the "put" side of this, last year.
>> That got as far as a v4 patch [1], and then I asked him to let me put
>> it into my tree. But then it didn't directly apply anymore after the
>> whole design moved to pin+unpin, and so here we are now.
>>
>>
>> If Bharath is still doing kernel work, you might offer him a Co-Developed-by:
>> tag (see https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html).
> 
> Sure, will add him as *Co-Developed-by*
>>


Yes, but it's best to wait and see if he responds, before adding that tag, because
it also required a Signed-off-by from him.

thanks,
-- 
John Hubbard
NVIDIA

