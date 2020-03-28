Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA027C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCED1206F2
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="krBxnjhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgC1AT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:19:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44949 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgC1AT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 20:19:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so12021051lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 17:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/27FgRjA8d032GtY7HE3lQ/cMxK1Gx032Jbtg6BA4Lw=;
        b=krBxnjhLC4IxLHtvfiBB/MAx5jXsWZWo19W02YfJ99zFKEcpCWKMMvPlHGDu8tbQ0M
         RwYviRx72BPRZJofn53BR5kjbou5+VtC/RmobQhCAgmyWtbNaGU35yYrsi0pF/c3kVPQ
         WSTHmyIlmJ4YxIqy7WiosJXu0qyDGv+nD9oNGJ4hTDjvz1Dt4cP1cIPsXHxfPBcEF6IX
         lED74wmdxBYdqmpm+cEXA0wgdZfnfTWD5lsQV1chWo/t2CXn1iqWEXxzU75rovCsQVZE
         0gbD/iFoNRs9GXuvkAu7i9ek2/EtH9rDXBmqjm7/YJJM3LrtMHGy7kxCKNwQW3j+KQo8
         QURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/27FgRjA8d032GtY7HE3lQ/cMxK1Gx032Jbtg6BA4Lw=;
        b=Jz3Cnqza2CK85vp8eduwSBceIe39BgL5Z1QBq/tSabicQ4ejgcYcdeeZ6HFS3HqquU
         /tOD0y2U6ghIfBsYGCCXdO1q3U8bnb8/I1mEqbeVtSXMdKpMKm7Jk2+aSW8fVqW8QNfj
         6C3ObL6upipvrqYJqPRMazLL64VeMmUkhTXUvOsKsIrRrMZpG0FqV8eeOdJ0fld4JiDo
         7YbJ0ckveXDf/JactdkHIRR3B6M9Nl1jxSovIG2k8xuoUd8fRXEmeaEW/Y4GKVfhyXv3
         uRKfubjWq+IVqTfMKaKqZQEDztl8RhHviqIJ1hVMYoSfcLf9jSIiPMUHPmeajENRV0Gq
         iNjw==
X-Gm-Message-State: AGi0PuaiYIAnZYxs2D6eUvaNiN8h+8qKgZgBTKzno8X611E1iDoxdyW4
        bYwC5kPTAfzIU6iemAbWSiTSCNCRHqY=
X-Google-Smtp-Source: APiQypKQgaTKxolHVLHUW/w20cfNSovlvtiHv+kLPb6uIoyPq8z2v8ya7yFzs5391TlI3xY22kgeXw==
X-Received: by 2002:a05:651c:1061:: with SMTP id y1mr765888ljm.285.1585354796426;
        Fri, 27 Mar 2020 17:19:56 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e14sm3247401ljb.97.2020.03.27.17.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 17:19:55 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id F2CFB100D24; Sat, 28 Mar 2020 03:19:59 +0300 (+03)
Date:   Sat, 28 Mar 2020 03:19:59 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <ziy@nvidia.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] thp: Simplify splitting PMD mapping huge zero page
Message-ID: <20200328001959.ggi74gch42soulus@box>
References: <20200327170353.17734-1-kirill.shutemov@linux.intel.com>
 <1437F525-1510-45CD-A67F-13DF525083B4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1437F525-1510-45CD-A67F-13DF525083B4@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 01:23:07PM -0400, Zi Yan wrote:
> On 27 Mar 2020, at 13:03, Kirill A. Shutemov wrote:
> 
> > Splitting PMD mapping huge zero page can be simplified a lot: we can
> > just unmap it and fallback to PTE handling.
> 
> So we will have an extra page fault for the first read to each subpage,
> but nothing changes if the first access to a subpage is a write, right?
> BTW, what is the motivation for this code simplification?

Match what we do for file-THP.

I found a problem with the patch. Ignore it for now.

-- 
 Kirill A. Shutemov
