Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B1AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 14:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5FD20720
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 14:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TE6agYmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgAZOsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 09:48:08 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39978 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgAZOsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 09:48:08 -0500
Received: by mail-lf1-f67.google.com with SMTP id c23so4399597lfi.7;
        Sun, 26 Jan 2020 06:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=suFPTFq/Jnh/uA1mB3Xjj1yJvj/WmXz4zUasdh/U3Lw=;
        b=TE6agYmJp5GFdw08Vzg+NV/vbjFAQN87TqO+KUwG+SSpOn/QXw2O5iYkI4V5wBFOd7
         MskcQuJgz9OYUgTc3wCtEzUgVduImNspswoMR5iF6Aeljkj9x8+Ij6OYsZMeJPtuBt0q
         dusBuy9L/4jdf/rIl4Ugr8l3im2nUCt42fx1+bieysOkOovSmCUZ9hhChAnDUD5Wl47C
         A7zbiIfv6LDY6pcR+3eNEpeqzKBmMVG/i4T8YB8k6ehvMx6mruuC75qtvzU6oRRJ0u9s
         FcptOHkL02y1q8s1Tw0K95zwucg+aW2S+pCCrs0TgJmPCWAif56/0YZyDJm7kR6nU8Ot
         eREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=suFPTFq/Jnh/uA1mB3Xjj1yJvj/WmXz4zUasdh/U3Lw=;
        b=Gnv8h4mubjMtEXQQUY/GKkMCNKHPaq87xzfDRC2DhpyIhmmGs4oJ4QJPLjGsJqO6Nr
         mSUlP8cJnXZS8SbQDhdlOL/hTjA6JYneq1JaG9RBsDIbrrpYbBMWOOKiEzTGFqwyGFce
         qhKprE8X+yUj41K8DsAGHGRuC22d55Yi6BtIQ94M4VlHK12mBQFUiR00cnDD80eRDyn1
         dXrz0kNZwhe8cfnUT5yPGJ7KenlLCVr/Q8jdwxs//p2U3/W3yTdevPfWLxpUA2yVQa7h
         kjjyIOgEuBluWV7Moqo+zc8jWYK1y8oTsL7TsHyUOFsXTji4fC4hlUyke5AQjxLXY1Ez
         KYSQ==
X-Gm-Message-State: APjAAAUGNtZvILcMdwCenrqTyQ8QNfkiemSfhUoUAiOSaHLx+VU50eq5
        Jd94U0Zi4iDKcxUrCbmOZ7g=
X-Google-Smtp-Source: APXvYqzrBzQVrNMbr4ufPq5EvI4AI6Akr2T5dAKUbDntDgoBL0+AcsUC3mGSp5/wQzvANInr+4cgcQ==
X-Received: by 2002:ac2:4839:: with SMTP id 25mr5664498lft.192.1580050086365;
        Sun, 26 Jan 2020 06:48:06 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id z14sm6594934ljm.86.2020.01.26.06.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2020 06:48:05 -0800 (PST)
Subject: Re: [PATCH 3/5] mm/mremap: use pmd_addr_end to calculate next in
 move_page_tables()
To:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        aneesh.kumar@linux.ibm.com, kirill@shutemov.name,
        yang.shi@linux.alibaba.com, thellstrom@vmware.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20200117232254.2792-1-richardw.yang@linux.intel.com>
 <20200117232254.2792-4-richardw.yang@linux.intel.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7147774a-14e9-4ff3-1548-4565f0d214d5@gmail.com>
Date:   Sun, 26 Jan 2020 17:47:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200117232254.2792-4-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.01.2020 02:22, Wei Yang пишет:
> Use the general helper instead of do it by hand.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  mm/mremap.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index c2af8ba4ba43..a258914f3ee1 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -253,11 +253,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  
>  	for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
>  		cond_resched();
> -		next = (old_addr + PMD_SIZE) & PMD_MASK;
> -		/* even if next overflowed, extent below will be ok */
> +		next = pmd_addr_end(old_addr, old_end);
>  		extent = next - old_addr;
> -		if (extent > old_end - old_addr)
> -			extent = old_end - old_addr;
>  		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
>  		if (!old_pmd)
>  			continue;
> @@ -301,7 +298,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  
>  		if (pte_alloc(new_vma->vm_mm, new_pmd))
>  			break;
> -		next = (new_addr + PMD_SIZE) & PMD_MASK;
> +		next = pmd_addr_end(new_addr, new_addr + len);
>  		if (extent > next - new_addr)
>  			extent = next - new_addr;
>  		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
> 

Hello Wei,

Starting with next-20200122, I'm seeing the following in KMSG on NVIDIA
Tegra (ARM32):

  BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:190

and eventually kernel hangs.

Git's bisection points to this patch and reverting it helps. Please fix,
thanks in advance.
