Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A005C2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41CF20787
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="M/TGYKy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388398AbgDBMxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:53:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36681 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388312AbgDBMxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:53:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id b1so3121751ljp.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VNWrHdXg3Yy9QNYyWfmhuoGwbW2EjORHJrKP3nYvVkI=;
        b=M/TGYKy160b2KdmNMklbl4hrVhVHNqk0kvQK+9tThJ1rU1a2MQk3iD/AlhWwsEuaXw
         Nd+jOxHYJrb3iSPKOQ8MK3YxO6YYAmzz2ty+XbNVahOvoPzLI18RfaxBUegH+8Jx1cBB
         WnacijaPfsK07Y46soJkrbDlin9Dk06zHBT192xpRFuG8SKfxtOl+kvabxwD/ePoBbzy
         lotjQsXtUWMDDINKn/r8Y04hhj58thTR0wRqF6p5i/jM2VORtlr5f+yLpzUd9405OgQs
         +KbVqLR0dncjQfOE7z+l1HFwQsD3vtMy2s7FfBn39hASuu/kfjkdtA/LMackkd+53gGr
         88Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VNWrHdXg3Yy9QNYyWfmhuoGwbW2EjORHJrKP3nYvVkI=;
        b=OxM69KM6Zbb6sm2pQQlrHfotZ5NjnHv13O9pfuj+uwBIVXwpHec8xAAq3HzcM7D8G/
         ioQpQP9cayDTl3Bxn0KnQqqgzb1K0R1X1JN4qyHwkqVNQNYKNdTkm/6Pt89UljSi5CkK
         7omExCCmMl+WQVBxGIQBLTKQxo6O4TRK/1MIj4QzCPeEpMbpRA+JCdCcxbZ6lJb6RQev
         LOpPIEbcsRs4QoqwrcKdm1/fJ5zPHegJCo8eRGo+GrljMnF40KiwRcpaGS3qEDCNuPqD
         J4+YdLcqcE4UPT1vZJS/m8TJjrkyXyHULBmtKnODjPadx2HqcsXQkQ62sOqn4KTRLR4U
         wheQ==
X-Gm-Message-State: AGi0PuZHsn3Hd/fpJuIwYZ+ek9AOqVdqCShaH9ZRmK1vFTu2malbNWEc
        cnC6hCQ9Dt9PX/Ph7pF0YwtuTM7pLR4=
X-Google-Smtp-Source: APiQypKsnSMgPI+27x38wzO/S/ewac5zFRYA1l+vLUf8WoLmfmNvYKaBWkcP4JmWzGkuRlP5504YhQ==
X-Received: by 2002:a05:651c:28a:: with SMTP id b10mr1968584ljo.223.1585831982476;
        Thu, 02 Apr 2020 05:53:02 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j2sm3799760lfm.44.2020.04.02.05.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:53:01 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 334071020A6; Thu,  2 Apr 2020 15:53:01 +0300 (+03)
Date:   Thu, 2 Apr 2020 15:53:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH -V2] /proc/PID/smaps: Add PMD migration entry parsing
Message-ID: <20200402125301.mtngw2toytiohkee@box>
References: <20200402020031.1611223-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402020031.1611223-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 10:00:31AM +0800, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> Now, when read /proc/PID/smaps, the PMD migration entry in page table is simply
> ignored.  To improve the accuracy of /proc/PID/smaps, its parsing and processing
> is added.
> 
> Before the patch, for a fully populated 400 MB anonymous VMA, sometimes some THP
> pages under migration may be lost as follows.
> 
> 7f3f6a7e5000-7f3f837e5000 rw-p 00000000 00:00 0
> Size:             409600 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:              407552 kB
> Pss:              407552 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:    407552 kB
> Referenced:       301056 kB
> Anonymous:        407552 kB
> LazyFree:              0 kB
> AnonHugePages:    405504 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:        0 kB

The alignment makes me triggered.

Andrew, could you please apply this patch:

http://lore.kernel.org/r/20191230084125.267040-1-samuel.williams@oriontransfer.co.nz

-- 
 Kirill A. Shutemov
