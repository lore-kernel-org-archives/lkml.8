Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA34C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D53F20792
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgHDF4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 01:56:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:48446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgHDF4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 01:56:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4CC0DAC7D;
        Tue,  4 Aug 2020 05:56:52 +0000 (UTC)
Subject: Re: [PATCH v3 00/11] fix swiotlb-xen for RPi4
To:     Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        tamas@tklengyel.com, roman@zededa.com, hch@infradead.org
References: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <8413f3e2-0bbf-efa3-1a8a-2ae05b1d07c8@suse.com>
Date:   Tue, 4 Aug 2020 07:56:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.20 00:34, Stefano Stabellini wrote:
> Hi all,
> 
> This series is a collection of fixes to get Linux running on the RPi4 as
> dom0. Conceptually there are only two significant changes:
> 
> - make sure not to call virt_to_page on vmalloc virt addresses (patch
>    #1)
> - use phys_to_dma and dma_to_phys to translate phys to/from dma
>    addresses (all other patches)
> 
> 
> I addressed all comments by Christoph to v2 of the series except from
> the one about merging the precursor "add struct device *" patches. I can
> always merge them together at any time as needed.
> 
> 
> Boris gave his Reviewed-by to the whole series v2. I added his
> Reviewed-by to all patches, including the ones with small cosmetic
> fixes, except for patch #8 #9 #10 because they are either new or changed
> significantly in this version of the series.
> 
> I retained Roman and Corey's Tested-by.

Series pushed to: xen/tip.git for-linus-5.9


Juergen
