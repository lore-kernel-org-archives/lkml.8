Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CD8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5AC62076C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="J2Zg0lkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407931AbgDOCmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:42:54 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12129 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391714AbgDOCml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:42:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9674320000>; Tue, 14 Apr 2020 19:40:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Apr 2020 19:42:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Apr 2020 19:42:39 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 02:42:39 +0000
Received: from [10.2.85.126] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 02:42:38 +0000
Subject: Re: [PATCHv3, RESEND 5/8] khugepaged: Allow to collapse a page shared
 across fork
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
 <20200413125220.663-6-kirill.shutemov@linux.intel.com>
 <0efcc512-6f12-1ff0-9885-871172fac766@nvidia.com>
 <20200414213526.ecn3zcgnqxoveddq@box>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <ca114751-1a19-5b8a-5187-a0150716d3fa@nvidia.com>
Date:   Tue, 14 Apr 2020 19:42:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414213526.ecn3zcgnqxoveddq@box>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586918450; bh=qTZY0os6at1npMB2sob6j3xFufXnjCkxklf/oSH4Ng4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=J2Zg0lkjZUPsttHoKMtn9tpNoDDxi1U92V00cmqjG/PpxSoMtE8eYf5XO9sNHBsIH
         6vglRMiJNVizuNVNNZL0AtGHFIcJFipXPZUBBZwi4LRD3eKXA9N2yWohAOvv9UHJuU
         QkwyRj9HHf5/iqlqbeHn5+DqAcE4CfpiQ7ojVy/uqe6JK1SqCdozN+XF0LWEFKfflW
         QYUyE4JNZOM70r5B+RJ6/zX/pn+8XHydqN6N79BrwBljvsYKWrkJ1YXnckWE57evIT
         mtQiI0DdUGUJ38Ftrf1dM/iMTNd8FjvOwTkRJdu+Jei7quFJl9cW7iJGsjTM0B7xoj
         RyByOosLIt8sQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-14 14:35, Kirill A. Shutemov wrote:
> On Mon, Apr 13, 2020 at 01:48:22PM -0700, John Hubbard wrote:
> 
> [Thanks for all your suggestions and corrections]
> 
>>> +	if (IS_ENABLED(CONFIG_DEBUG_VM) && expected_refcount > refcount) {
>>> +		pr_err("expected_refcount: %d, refcount: %d\n",
>>> +				expected_refcount, refcount);
>>> +		dump_page(page, "Unexpected refcount");
>>
>>
>> I see two issues with the pr_err() and the dump_page() call:
>>
>> 1. You probably want to rate limit this, otherwise you'll have a big
>> problem if lots of pages are pinned!
> 
> Nope. Only if kernel is buggy. See below.
> 
>> 2. Actually, I don't think you'd want to print anything at all here, even with
>> rate limiting, because doing so presumes that "unexpected" means "wrong". And I
>> think this patch doesn't expect to have GUP pins (or pin_user_pages() pins, ha),
>> but that doesn't mean that they're wrong to have.
> 
> See condition. We only do it if refcount is *below* expected refcount. It
> should never happen. Pinned page would have refcount above expected.
> 

Yes, you are right. I misread the condition. This actually is just right. :)

thanks,
-- 
John Hubbard
NVIDIA
