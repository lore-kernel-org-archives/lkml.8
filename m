Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D7FC2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1CD20A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="FGTYd9ZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgDJLrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:47:42 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:46695 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgDJLrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:47:41 -0400
Received: by mail-lj1-f181.google.com with SMTP id r7so1655719ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sIKZKvkKOfKVnvhnn37sRvniOncPpFeTUBs3cOx0KS8=;
        b=FGTYd9ZKEK/G10jkYdyhx6Ch8co8upFEhZBInbBuLHwsCb+Gv40W6obVDIRr5TcOMd
         rQUFvvHkvylwZw+kD8fGzIeWEDxt4Zy3RROcolQ7Ex2G4Bmw5pD21ExjoWnCTQyAwU0c
         blFpxTRNbFD3o1gh0nGU24kNPNt6SETZM2zC+buToQRFM8WZsT2RiSGYuLq3jJqhM/N9
         knMGY+8tzpEhfZnwV5KrxaKO4vZ9BSdOldFoU5rEi1KiC28inzKNItecFvPM/6YjL4k8
         4hWSunh+vSDlrOOWSUk4BHLyyTWYsuh+3uhQPYfx9PuU5jQh1wAZK6Ho/JRRpYr6saWE
         9GvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sIKZKvkKOfKVnvhnn37sRvniOncPpFeTUBs3cOx0KS8=;
        b=VaOigQad+2puLUL68L2WvpiU4qiZNclfcZhFNoF48P4Ak6gXmeB8rm29YkI+cKX0vd
         1y1dxHfVcmyY9sQbvsITKdrJZUoeO9cmg+ofTlM4x4vw9kGd/Hxv3AD4U+pMnrmgqcBS
         qJeUNtGtjoUOxjMIrEYmTg+R/EkYa0jfzlQXfRzSjyuthZlWkYNSieufStE9Fuv0e6JN
         3MXdGYDSafwQOnjThGJC7nutKcUH2t5hdRDBAuqozhFKQCQNMhNQA38VBTi9nLhA6CNe
         Am3vb1OulQxR6sVH+zEUqvmSx3Qo/C5xQyOFI2hcJmmPEF1l1wYtSo3It2H8t/JV6YUu
         IeFA==
X-Gm-Message-State: AGi0PuYej35LnYoEi7VvAEqNegdWBsawHld2IX5KVcRqXzrt5YG72usF
        6z4mFlUmcts3YcJggZFodpYXdQ==
X-Google-Smtp-Source: APiQypJErK4laJ0jEbX51VkYXoZ1N52Vv9Cd0MUOov966QVqD4RbKCHGUSLOyI3CGErnytpfk6Ns/g==
X-Received: by 2002:a2e:8795:: with SMTP id n21mr2883563lji.71.1586519259791;
        Fri, 10 Apr 2020 04:47:39 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c8sm956193ljd.70.2020.04.10.04.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 04:47:39 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 11813102110; Fri, 10 Apr 2020 14:47:39 +0300 (+03)
Date:   Fri, 10 Apr 2020 14:47:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <ziy@nvidia.com>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 1/8] khugepaged: Add self test
Message-ID: <20200410114739.b2ndracbyhsdmanv@box>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-2-kirill.shutemov@linux.intel.com>
 <D55D6A3A-47A1-41F5-B939-36EEA740CF72@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D55D6A3A-47A1-41F5-B939-36EEA740CF72@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 10:59:52AM -0400, Zi Yan wrote:
> I ran this test with all patches from this series applied to Linus’s tree, but still see several failures. Is it expected?
> The config file is attached. Let me know if I miss anything. BTW, I am running in a VM.
> 
> Thanks.
> 
> The output:
> 
> ➜  ~ sudo ./khugepaged
> Save THP and khugepaged settings... OK
> Adjust settings... OK
> Allocate huge page on fault... OK
> Split huge PMD on MADV_DONTNEED... OK
> Collapse fully populated PTE table.... Fail

I was able to reproduce the issue. And it's fun failure mode.

How did you get the test case inside the VM? Copy-paste source using 'cat'
or something similar inside the VM?

It screwed up CHECK_HUGE_FMT and CHECK_SWAP_FMT for me. Double back slash
was converted to single. As result check_huge() and check_swap() gave the
false-negative result all the time.

Could you check that the source of the test-case is not mangled and
re-test if it is.

-- 
 Kirill A. Shutemov
