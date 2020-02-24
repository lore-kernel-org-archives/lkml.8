Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872F7C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF422080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgBXKHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:07:55 -0500
Received: from foss.arm.com ([217.140.110.172]:34802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgBXKHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:07:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70FB930E;
        Mon, 24 Feb 2020 02:07:54 -0800 (PST)
Received: from [192.168.1.161] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8F7C3F703;
        Mon, 24 Feb 2020 02:07:53 -0800 (PST)
Subject: Re: [PATCH 5/5] arm64/vdso: Restrict splitting VVAR VMA
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
References: <20200204175913.74901-1-avagin@gmail.com>
 <20200204175913.74901-6-avagin@gmail.com>
 <df8fa53c-5c21-b620-0254-ffefdd3a8834@arm.com>
 <20200223233013.GB349924@gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <248ddd41-d3b3-05f2-4e49-177236726209@arm.com>
Date:   Mon, 24 Feb 2020 10:08:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200223233013.GB349924@gmail.com>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrei,

On 2/23/20 11:30 PM, Andrei Vagin wrote:
[...]

> 
> Hmmm. I have read the code of special_mapping_mremap() and I don't see where
> it restricts splitting the vvar mapping.
> 
> Here is the code what I see in the source:
> 
> static int special_mapping_mremap(struct vm_area_struct *new_vma)
> {
>         struct vm_special_mapping *sm = new_vma->vm_private_data;
> 
>         if (WARN_ON_ONCE(current->mm != new_vma->vm_mm))
>                 return -EFAULT;
> 
>         if (sm->mremap)
>                 return sm->mremap(sm, new_vma);
> 
>         return 0;
> }
> 
> And I have checked that without this patch, I can remap only one page of
> the vvar mapping.
>

I checked it a second time and I agree. The check on new_size is required in
this case.

> Thanks,
> Andrei
> 

-- 
Regards,
Vincenzo
