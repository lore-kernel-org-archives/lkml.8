Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9464C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3AD82063A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="onJFTihw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgFHTWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:22:10 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5813 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgFHTWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:22:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ede8f840000>; Mon, 08 Jun 2020 12:20:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 08 Jun 2020 12:22:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 08 Jun 2020 12:22:06 -0700
Received: from [10.2.58.199] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Jun
 2020 19:22:06 +0000
Subject: Re: [PATCH] staging: kpc2000: kpc_dma: Convert get_user_pages() -->
 pin_user_pages()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        <harshjain32@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Simon_Sandstr=c3=b6m?= <simon@nikanor.nu>,
        <jane.pnx9@gmail.com>
References: <1590947491-11194-1-git-send-email-jrdr.linux@gmail.com>
 <7e725dd0-7423-b85b-ff56-9705419d13b9@nvidia.com>
 <CAFqt6zbsNcHWF-0Na2xMKdJQs2kVkLHTCw=cytvdo+z-axx97Q@mail.gmail.com>
 <5f0c68a0-2cc4-5724-d778-7e9d5fd7dfde@nvidia.com>
 <20200608191635.GA30374@kadam>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a71c2b68-fc70-a7bf-1d1c-500459639dae@nvidia.com>
Date:   Mon, 8 Jun 2020 12:22:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200608191635.GA30374@kadam>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591644036; bh=M9jnObSRB68t6gXIHyWay4/z8p+apr/yOzEEUHbukOk=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=onJFTihwkiDmWn0fwNOz6NHHGEtz06ewdg9TMRI3wvCU4/QHbSvASc0Mb6jADycOC
         iyTPNU9tvDPIOJekaVGHbaNd929BZ9naGWsgTAAbsNPNhDZlSGm0IYBS0rdBRVFfFF
         TUEnJ3Nf6FZwSjBb1V3UjFYBilTVmauZqCQBkwckfQge/0snTCUCxATNplKaPQ5+on
         5WFO9WGGw939GfIa2coMNDismPpCbs3YmB+aB6213561VHYnSf3ENzTv1oaCtaBiGR
         SVGOqHyAI1ECQdpBIr+Js5aGRyYqiSzf4Gg/C70/t9m3Ij0I8sbpY1C8sz72vXPSGg
         4zl3Y1W7pr5NA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-08 12:16, Dan Carpenter wrote:
> On Mon, Jun 08, 2020 at 12:05:57PM -0700, John Hubbard wrote:
>> On 2020-06-08 12:01, Souptick Joarder wrote:
>>> On Mon, Jun 1, 2020 at 7:15 AM John Hubbard <jhubbard@nvidia.com> wrote:
>>>>
>>>> On 2020-05-31 10:51, Souptick Joarder wrote:
>>>>> In 2019, we introduced pin_user_pages*() and now we are converting
>>>>> get_user_pages*() to the new API as appropriate. [1] & [2] could
>>>>> be referred for more information.
>>>>>
>>>>> When pin_user_pages() returns numbers of partially mapped pages,
>>>>> those pages were not unpinned as part of error handling. Fixed
>>>>> it as part of this patch.
>>>>>
>>>>
>>>> Hi Souptick,
>>>>
>>>> btw, Bharath (+cc) attempted to do the "put" side of this, last year.
>>>> That got as far as a v4 patch [1], and then I asked him to let me put
>>>> it into my tree. But then it didn't directly apply anymore after the
>>>> whole design moved to pin+unpin, and so here we are now.
>>>>
>>>>
>>>> If Bharath is still doing kernel work, you might offer him a Co-Developed-by:
>>>> tag (see https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html).
>>>
>>> Sure, will add him as *Co-Developed-by*
>>>>
>>
>>
>> Yes, but it's best to wait and see if he responds, before adding that tag, because
>> it also required a Signed-off-by from him.
> 
> Souptick is porting patches from your tree?  It's not clear to me how
> Bharath actually helped author this patch.


What happened is that Bharath wrote patches very similar to these, last year.
And we spent some time on review and figuring out pre-existing issues in the code.

Anyway, I suspect that he's not actually involved anymore, so I probably shouldn't
have done any more than to just put him on Cc. Sorry for any confusion I created
here.

thanks,
-- 
John Hubbard
NVIDIA
