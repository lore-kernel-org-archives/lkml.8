Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A184C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D4A2067B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TNx4pfV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgE2U2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:28:43 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19292 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgE2U2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:28:42 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed170250000>; Fri, 29 May 2020 13:27:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 29 May 2020 13:28:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 29 May 2020 13:28:42 -0700
Received: from [10.2.87.173] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 May
 2020 20:28:41 +0000
Subject: Re: [PATCH] staging: gasket: Convert get_user_pages*() -->
 pin_user_pages*()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Souptick Joarder <jrdr.linux@gmail.com>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <rspringer@google.com>,
        <toddpoynor@google.com>
References: <1590613362-27495-1-git-send-email-jrdr.linux@gmail.com>
 <20200528110408.GJ30374@kadam> <20200529115330.GO30374@kadam>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <bd1064bf-65ae-2c5f-0dad-b52ae12c2ece@nvidia.com>
Date:   Fri, 29 May 2020 13:28:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529115330.GO30374@kadam>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590784037; bh=/zEeOofiTZp0ZN4TMVdNueb74rWQtstcMaq8AqpNAXo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TNx4pfV1Oa5Gt92dyvF6CRTaALmkT1IqZLtRev4uhQqtIZ+IAVkhIXy4c/Ktu6Wjk
         3RnO4Goto2RAnvTjfqV+DXrgpiTlBVU6LqoH9louFwwgn/Y72hijNJeeC4Yg6cV7+c
         2WiBK1iZmAjABwfMmFeM5FbeOItOax32HVaTLJvlfxH38v3QjK8pzMDVHK3BzhNdht
         gEPGLsWkNT/2jmvGUFQqlC+KPm/3uVvgbdzWlykBAiRiI+r4/S9wZAUnmm/Pxv7svm
         5ISgugk4zGmuDa8pt3c9viPzCcKg3JPaEPkG3CRoV1ftf6P2vdv9ryHTgf6sVY5nI6
         +1uHGUPhExX6Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-29 04:53, Dan Carpenter wrote:
...
> What are the runtime implications of this patch?  I'm still not clear on
> that honestly.

Instead of incrementing each page's refcount by 1 (with get_user_pages()),
pin_user_pages*() will increment by GUP_PIN_COUNTING_BIAS, which is 1024.
That by itself should not have any performance impact, of course, but
there's a couple more things:

For compound pages of more than 2 page size, it will also increment
a separate struct page's field, via hpage_pincount_add().

And finally, it will update /proc/vmstat counters on pin and unpin, via
the optimized mod_node_page_state() call.

So it's expected to be very light. And, for DMA (as opposed to DIO)
situations, the DMA setup time is inevitably much greater than any of
the above overheads, so I expect that this patch will be completely
invisible from a performance point of view.

It would be a "nice to have", though, if anyone were able to do a
performance comparison on the gasket driver for this patch, and/or
basic runtime verification, since I'm sure it's a specialized setup.


thanks,
-- 
John Hubbard
NVIDIA
