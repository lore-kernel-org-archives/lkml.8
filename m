Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45998C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 19:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABA52068D
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 19:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LJmZyCG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgEaT4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 15:56:24 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13495 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgEaT4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 15:56:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed40b890000>; Sun, 31 May 2020 12:54:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 31 May 2020 12:56:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 31 May 2020 12:56:23 -0700
Received: from [10.2.56.10] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 31 May
 2020 19:56:23 +0000
Subject: Re: [PATCH 1/2] mm/gup: introduce pin_user_pages_locked()
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20200527223243.884385-1-jhubbard@nvidia.com>
 <20200527223243.884385-2-jhubbard@nvidia.com>
 <CAFqt6zZr9rUZaXEpjwmtmicdNP9KhJ8UrjPPjk4bMHJ20VsVsg@mail.gmail.com>
 <CAFqt6zaz21GQZYSGZ5Md0hCrPv8UFQ7gQMiV_oBzX0zSTZ16-A@mail.gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <0674f8b7-a5eb-6d5c-792d-573f85871a72@nvidia.com>
Date:   Sun, 31 May 2020 12:56:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zaz21GQZYSGZ5Md0hCrPv8UFQ7gQMiV_oBzX0zSTZ16-A@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590954890; bh=Th/cRGXuH5TQAsB59fJhQbQWOy6yVIziuBSyzMG0XRw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LJmZyCG3IH0g2a0d4Ax6nEFatLTVb1w2HMjjjElXPV7cUVsnZIqIoaH3C647Wd2Ua
         IHP/OndOMCopjWvsPRz1sUUvGkqOiYqRw4d5kRcSGYbpcL/PyuaaHJDHopIBH4pVUG
         NHluLPeoAOMveuTSKhHZJ6eGjHCu9YB6XbFsp06F1FLSMahpVlwgW3G9dbkNR/vpVn
         hIMu2mv1hzuPNXaCwAUwqF0NBnVftbEHcZCvpYvVTs7NXO5ZZlFkEEAiIq12R+d7hK
         xjh6zzOzUB1aCRiiBWOf1ehwn2yViW4U2lh9OcqonhvXHttv8qtCmlNqNhgBvkP/8g
         ltz+cBQGZFcBA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-31 00:13, Souptick Joarder wrote:
> On Sun, May 31, 2020 at 12:34 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>
>> On Thu, May 28, 2020 at 4:02 AM John Hubbard <jhubbard@nvidia.com> wrote:
>>>
>>> Introduce pin_user_pages_locked(), which is nearly identical to
>>> get_user_pages_locked() except that it sets FOLL_PIN and rejects
>>> FOLL_GET.
> 
> Forget to ask, is it fine to add this new pin_user_pages_locked() in
> Documentation/core-api/pin_user_pages.rst ?
> 
I wasn't planning on maintaining a rigorous list of all of the pin_user_page*()
API calls, in pin_user_pages.rst. Each call is documented in gup.c, for  that.
The .rst is there to help explain things at a slighly higher abstraction level.

thanks,
-- 
John Hubbard
NVIDIA
