Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40777C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 03:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003EF206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 03:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="N1XmCwAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgIHDS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 23:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgIHDSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 23:18:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5C2C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 20:18:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q4so1345583pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 20:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=akExiIzhW0wDPoReoqSiRO2xBb1xAPq4gk30XCoDFSs=;
        b=N1XmCwAxSdI2vF3IpdeTaspa2yvas8w+Wb4qm405CKhUGkPLP2jDILx/UjulUXR4/m
         e+XdRAPDmQGDN25FwrlnYYiv/KMQump/pLq63xguv0RP4HflY0+aS+4yDEhO4zNAp3ta
         14iklFrQgIkUY3HpNC1uici/UxMceAVnpTlrNZTucYwZkamUo9huoeeYs+kYWWCmH7Y9
         jMCQqxYap6bKiXM1cXZmg0YXA9uLelHaj1wG6eDFaSJyhGG3FcZlQJl32hJz1yM5lA3O
         smtl/x6+7ExFbVn3MWYR/ea73RMEog1QqYTVQuhu0B2CCArPXqzTUSLmrezQFqtJD7DG
         vQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=akExiIzhW0wDPoReoqSiRO2xBb1xAPq4gk30XCoDFSs=;
        b=kJdfklypaVVMa5HoN+40kn08F3gfIOxaIA0SsnjZGlGtfbuhm76P7Q+nTJaair+5MP
         tUIOjB4jy+CsxNpGhFwiLKZIO2e1+/wBUDX2NM0q0zdRcNkU3iWXWlcT0hWYxntMjRVB
         UNAJNLQUJaxta9XYRGoKNmfgy/gT1fqmwArJEhD+nXqKCkD+aL+OPbxPZx3Oy/hJ9nIP
         1yx97ClyxMfo/f21qgc7iE9MWV01DosxBloYT5mVJt4005mo22gepbwZXX6BK5yVlRDI
         59MYDxwLCZCQ/QXq28moUer2nspKi/42D8+BKhlAHKgfISkukjne2HLidxosmx1NbYEz
         xF8Q==
X-Gm-Message-State: AOAM530+/WTUDx+NyAyoFb5TESAvcOxpD+7Sj5A+e60nPtOxsogixq14
        Xb14n0OjmN2EHAGSGAyJ9l4wb870SVa30KQB
X-Google-Smtp-Source: ABdhPJywDyWQuf57fsN6+ZnZ0aQNEAN/Tz5ApBF1LJNJhY6L5UU4xE0xo6Qsd2Hz1dnKClD2Sb2ouA==
X-Received: by 2002:a17:90b:b0b:: with SMTP id bf11mr2051952pjb.227.1599535132068;
        Mon, 07 Sep 2020 20:18:52 -0700 (PDT)
Received: from [192.168.10.94] (124-171-83-152.dyn.iinet.net.au. [124.171.83.152])
        by smtp.gmail.com with ESMTPSA id j14sm11252447pjz.21.2020.09.07.20.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 20:18:51 -0700 (PDT)
Subject: Re: [PATCH v1 02/10] powerpc/kernel/iommu: Align size for
 IOMMU_PAGE_SIZE on iommu_*_coherent()
To:     Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joel Stanley <joel@jms.id.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200817234033.442511-1-leobras.c@gmail.com>
 <20200817234033.442511-3-leobras.c@gmail.com>
 <7b9640e0-568f-1470-40f4-a3ccec8abcf2@ozlabs.ru>
 <c67c66e466ad27d15aa2b970c48d2336d95b2971.camel@gmail.com>
 <da473389-f921-075a-ec8e-ea516de4f177@ozlabs.ru>
 <2aacd45f047489642da1731c92d3555ad101e3c7.camel@gmail.com>
 <81f106bd-8962-22f2-f14a-378d3486f57e@ozlabs.ru>
 <39ad3a9c103faf9c5fc2fd5700d8606eb4a2b67e.camel@gmail.com>
 <8f569f68-5145-676e-50a1-b13f3fbd69cc@ozlabs.ru>
 <ef7e80b0a7399bad607324301a604bfb46c2de05.camel@gmail.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <bafc94fe-85e8-88be-a75d-45293b56fa09@ozlabs.ru>
Date:   Tue, 8 Sep 2020 13:18:44 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <ef7e80b0a7399bad607324301a604bfb46c2de05.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/09/2020 16:04, Leonardo Bras wrote:
> On Thu, 2020-09-03 at 14:41 +1000, Alexey Kardashevskiy wrote:
>> I am new to this, so I am trying to understand how a memory page mapped
>>> as DMA, and used for something else could be a problem.
>>
>>   From the device prospective, there is PCI space and everything from 0
>> till 1<<64 is accessible and what is that mapped to - the device does
>> not know. PHB's IOMMU is the thing to notice invalid access and raise
>> EEH but PHB only knows about PCI->physical memory mapping (with IOMMU
>> pages) but nothing about the host kernel pages. Does this help? Thanks,
> 
> According to our conversation on Slack:
> 1- There is a problem if a hypervisor gives to it's VMs contiguous
> memory blocks that are not aligned to IOMMU pages, because then an
> iommu_map_page() could map some memory in this VM and some memory in
> other VM / process.
> 2- To guarantee this, we should have system pagesize >= iommu_pagesize
> 
> One way to get (2) is by doing this in enable_ddw():
> 	if ((query.page_size & 4) && PAGE_SHIFT >= 24) {

You won't ever (well, soon) see PAGE_SHIFT==24, it is either 4K or 64K. 
However 16MB IOMMU pages is fine - if hypervisor uses huge pages for VMs 
RAM, it also then advertises huge IOMMU pages in ddw-query. So for the 
1:1 case there must be no "PAGE_SHIFT >= 24".


> 		page_shift = 24; /* 16MB */
> 	} else if ((query.page_size & 2) &&  PAGE_SHIFT >= 16 ) {
> 		page_shift = 16; /* 64kB */
> 	} else if (query.page_size & 1 &&  PAGE_SHIFT >= 12) {
> 		page_shift = 12; /* 4kB */
> 	[...]
> 
> Another way of solving this, would be adding in LoPAR documentation
> that the blocksize of contiguous memory the hypervisor gives a VM
> should always be aligned to IOMMU pagesize offered.

I think this is assumed already by the design of the DDW API.

> 
> I think the best approach would be first sending the above patch, which
> is faster, and then get working into adding that to documentation, so
> hypervisors guarantee this.
> 
> If this gets into the docs, we can revert the patch.
> 
> What do you think?
I think we diverted from the original patch :) I am not quite sure what 
you were fixing there. Thanks,


-- 
Alexey
