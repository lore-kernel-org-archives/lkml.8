Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7C5C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1E820787
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Ac3/nMj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgDHOv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:51:26 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42899 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgDHOv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:51:26 -0400
Received: by mail-ed1-f50.google.com with SMTP id cw6so8836021edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3zZRqZBT7bl6XuqCoSGBYjXfPH3OC6gG/jRKiV96AqY=;
        b=Ac3/nMj52bzfBeFiIMgWtYKLj/5FMVy+22ItcI9qsqUeD/T1Ft6NWOn3nTVsTU8Aa0
         WW7Ooxi+yy4n7kEuhw9YzxZlaMP1gzZxCCnQQsoeVpic0k3dMQUwCUlUs8Jrz/z7DY2s
         iZkEx4JRJqfIra3Es0ozbCIEkGLOBODr/LixI1vvDDVLcNIrhQWotmT1dBvrRAxpP2qr
         MhE3+0nzuRLXHtMGzawaCevFfknnkm9YFuxVGS6kpg1+r7IXysVmjPhyHMbJlvToywSB
         VV86gH0/S/zCFvnykz88u0YBi/V68L7vcP9yBr5m+t5Sh3HJvRjKpBehM+6wEA3pv1XV
         8z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3zZRqZBT7bl6XuqCoSGBYjXfPH3OC6gG/jRKiV96AqY=;
        b=KMTn/45qLSOJ9m/Vr2ZNRig+6RJoHuA2LTYP5VOM0i2977wAQpZG3n4E8Az8Zx19lD
         68yUECDJpsAFVDchDh+Z/thNR2wawn1IpLuGHj1g4SrpvayEP4xQjsz4efT0He2M1NZ7
         BtISxDgvHWjQJ47EJY+vgt0rEv8pZxo0eGVpi0BdX23yX6FfCl0aBFimu6ROxPMDuMam
         RtuWx/qhflS0DQhHGXnzyR6Pbj/KoXD7AGLU0Ut81XvVqUHUrbSaVrxBfcdVZiTLBfFA
         Zsx46qXCKrl5TXR+yI5UvkgMSwklm3WDbabCyeoVWI0a+44AhVNWjQgpwupjGG/GQ1at
         sCIQ==
X-Gm-Message-State: AGi0Puan1Oy4Lvbh7anExJUPzQcD++lfO53D0VEO1OazrsnPBxhHSQg1
        CP8dg8FgQ+3CPhxkndZBObtRd202xyA=
X-Google-Smtp-Source: APiQypK6+uQOMxoqN4nUCCUsZ6n5F+dz2DRbrE9+IZabawptpTewzjtnzQNgsWsjgGlj8uyKBxNAAQ==
X-Received: by 2002:a2e:988c:: with SMTP id b12mr5251654ljj.138.1586355703999;
        Wed, 08 Apr 2020 07:21:43 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v17sm1305530lfe.34.2020.04.08.07.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 07:21:43 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B0613101C47; Wed,  8 Apr 2020 17:21:45 +0300 (+03)
Date:   Wed, 8 Apr 2020 17:21:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <ziy@nvidia.com>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 1/8] khugepaged: Add self test
Message-ID: <20200408142145.workbzv2n3p27y2w@box>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-2-kirill.shutemov@linux.intel.com>
 <D55D6A3A-47A1-41F5-B939-36EEA740CF72@nvidia.com>
 <20200406152035.ga7hk6jfaqzvlete@box>
 <A8449566-7C9E-464E-92AC-46FDBCDC04AA@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A8449566-7C9E-464E-92AC-46FDBCDC04AA@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 02:50:32PM -0400, Zi Yan wrote:
>       khugepaged-58    [001] ....  9913.990380: mm_khugepaged_scan_pmd: mm=00000000283d31fc, scan_pfn=0x2ae4bd, writable=0, referenced=512, none_or_zero=0, status=no_writable_page, unmapped=0

Looks like all failures due to lack of writable ptes. That's very strange
because we write to the page on fill.

You've mentioned that you run it in VM. I wounder if it can be a
virtualizaiton artefact. I run tests under KVM and they are fine. What is
your virtualization setup?

-- 
 Kirill A. Shutemov
