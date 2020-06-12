Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7258C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E09620723
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hVqkG6ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgFLTs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:48:56 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19284 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFLTsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:48:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ee3dc1a0000>; Fri, 12 Jun 2020 12:48:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Jun 2020 12:48:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Jun 2020 12:48:55 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Jun
 2020 19:48:55 +0000
Subject: Re: [PATCH] mm/hmm: remove redundant check non_swap_entry()
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200612192618.32579-1-rcampbell@nvidia.com>
 <20200612193327.GZ6578@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <e14980e3-7c6e-fbc2-2b1f-f673ddb0c4e1@nvidia.com>
Date:   Fri, 12 Jun 2020 12:48:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200612193327.GZ6578@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591991322; bh=LvO/tbarhm9/wvspG2Tgwz0qRkaR+TLilKC17WqN+qM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hVqkG6adE2iCOkY8Vfc+COtUcn0g7we07vi87EJ4J9ru5iivLdtpqy8NbJeiAyFju
         0K1e0kSVVNdfHeBsAw3hngl3Ed7vRDdS7rUQaUkGsdes/d0V5b4jPhCkLO5psqqobk
         aOgeZFARHkXseCE97ZiwnLj2TCoADadFP/rBnBt3xA3QMYebw6e8gnJJyLl60HD4Q5
         WGmSiPeReDQHwJhW9ekA7ptnMNK4vDWGBLAcwyT0U7KnH0gMCqSHoee9P814ISFJRU
         M8qXay0xWASWSI3kJl2FAuqnIMGdl41qumKudFLcEwOLn6JWOw1k7xMPUfr7lfKeKA
         3Qtbawr5DooqQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/12/20 12:33 PM, Jason Gunthorpe wrote:
> On Fri, Jun 12, 2020 at 12:26:18PM -0700, Ralph Campbell wrote:
>> In zap_pte_range(), the check for non_swap_entry() and
>> is_device_private_entry() is redundant since the latter is a subset of the
>> former. Remove the redundant check to simplify the code and for clarity.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>>
>> This is based on the current linux tree and is intended for Andrew's mm
>> tree. There is no rush so it could go into 5.9 but I think it is safe
>> enough to go into an rc after the patch is reviewed.
> 
> Probably shouldn't mark it as mm/hmm if Andrew is going to pick it

OK, I'll mark it as just mm: if I need to repost.

> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> 
> Jason
> 

Thanks!
