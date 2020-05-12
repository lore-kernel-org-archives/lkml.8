Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF133C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA012206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EcH7WTMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgELR33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELR32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:29:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F66C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 10:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=hV4BDdW+iFVPmUkxPoN7ZR0971mJPrSTzPY2RD+WQVs=; b=EcH7WTMK6MGNVVbLI8orxTjYLd
        bOPL4TbPTU+kuyf05NAc+x0XosCEPquLD9Pb7P7srgyyZpAJXVkIgcrFtZUkMEPvqato+AiZwgTci
        yhuynginxhTo9OhW18ZWGkkF2kYr/BZATQLN0fk6mIl3qW3s7hYf0yXHJdlJpCzjAqp11pwlLYXQf
        SAuPzEocMTp4F93kOSGbmglOAya4nrq+uzNkwJMpQ8M1BEUlTIRzXTOk7lC2u5DX7ji/jb5C0GoNA
        r6ONsm5c4eoLsa4zKirmpcGjvfmtxFIaOB/8LFPkin4PcGglJFjtLZjJFfHnlPzi5xN7YSKHz0c7C
        ThRBaqXg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYYiZ-0001PE-OP; Tue, 12 May 2020 17:29:23 +0000
Subject: Re: [PATCH] drm: vmwgfx: include linux/highmem.h
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Chris Zankel <chris@zankel.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Huang Rui <ray.huang@amd.com>, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200508220150.649044-1-arnd@arndb.de>
 <20200509131434.27ddccb9@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9c694077-1a65-3883-d082-017586098aaf@infradead.org>
Date:   Tue, 12 May 2020 10:29:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200509131434.27ddccb9@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/20 8:14 PM, Stephen Rothwell wrote:
> Hi Arnd,
> 
> On Sat,  9 May 2020 00:01:31 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> In order to call kmap_atomic() etc, we need to include linux/highmem.h:
>>
>> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c: In function 'vmw_bo_cpu_blit_line':
>> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:377:4: error: implicit declaration of function 'kunmap_atomic'; did you mean 'in_atomic'? [-Werror=implicit-function-declaration]
>>   377 |    kunmap_atomic(d->src_addr);
>>       |    ^~~~~~~~~~~~~
>>       |    in_atomic
>> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:391:5: error: implicit declaration of function 'kmap_atomic_prot' [-Werror=implicit-function-declaration]
>>   391 |     kmap_atomic_prot(d->dst_pages[dst_page],
>>       |     ^~~~~~~~~~~~~~~~
>> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:390:16: warning: assignment to 'u8 *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
>>   390 |    d->dst_addr =
>>       |                ^
>> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:403:16: warning: assignment to 'u8 *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
>>   403 |    d->src_addr =
>>       |                ^
>>
>> Fixes: 46385a895322 ("drm: remove drm specific kmap_atomic code")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/gpu/drm/vmwgfx/vmwgfx_blit.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
>> index 94d456a1d1a9..1629427d5734 100644
>> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
>> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
>> @@ -27,6 +27,7 @@
>>   **************************************************************************/
>>  
>>  #include "vmwgfx_drv.h"
>> +#include <linux/highmem.h>
>>  
>>  /*
>>   * Template that implements find_first_diff() for a generic
>> -- 
>> 2.26.0
>>
> 
> Added to linux-next for Monday (in case Andrew doesn't get around to it).
> 

Hi,

What happened with this patch?
I am seeing the same build problems in linux-next of 20200512.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


thanks.
-- 
~Randy

