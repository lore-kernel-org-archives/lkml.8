Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A1BC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BA720838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="R+l3zA+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgBCPSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:18:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41392 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgBCPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:18:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so15046108ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 07:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J9cgaeMLTaJECRcYqxABSftFV/5KWVEItmdNxoAd1kk=;
        b=R+l3zA+jNPp4j3NEVCD/WguynL5ltM98xpOCFsqcdd6u3ePAmhIrTzIzlNZK58nZb/
         6N+De1oZJUAwAPmzSiNSFeF+9oQ34uemRwKeyHwM/QRdIWzIsqNz/IGlTHexGVQb2cRx
         eKYV78sRevdg4SczLQ/iGOayOH9g3hTDCPePwEpiJapkvwbbLxTuWa8FUo0G7W1ViF5j
         At/LijsaN8RkI4qFEWITlT0Hs3OTPRevQtb/J6XFlU9gwSyVNybe925U1Hu7pcFcG2WY
         H1hN5LS9tCqu7Qhx2u2F+kCaO0lwJmYUalMbr+55plBjXahEbE4PbbTPHht4peZQZifz
         z14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J9cgaeMLTaJECRcYqxABSftFV/5KWVEItmdNxoAd1kk=;
        b=t3GfWMcmkj8QWpckiHy++iiI1ojdUnWmz2Zj/oUY8NSUIiNdDO7q1gyiiTh0MmoYX4
         yr3dOaBLwviwECjiRFklMNn1F41to7tJUCBEwvfXbh+OSD6jlbeR8kDfAspsw5FrUDPP
         4w2ubUsUTP51BIN56VGSqQ00pueF/dHrZNehmmaHaSYbI0LPxUgvF5GpcZaE6VWlov2k
         aZIYoFDu0uPzu+oD5QFGFVDzpszzBvuG72bHYdatMzvfbg5CSDLJhUCXPuqcVDQ8qfgW
         VUXmZQUgpbVxBbk9Huf/I4tJx/A3n1AULtV7RKqD+/FAN3ubmNBN01X8fbc55F0NYfRD
         cMXg==
X-Gm-Message-State: APjAAAXMuRAYn696WLHaviTz5DAxrraonb4X/GqTNt+kMbne//VtsJMC
        NsUNtGmpNlCrLGkCECChhcuKUg==
X-Google-Smtp-Source: APXvYqyuTiS50TSLyZys9pI8tQ8C0R0qyODfDKnunffnlEE0uashYDmDCPJl8rsojWctlbaz2SykJQ==
X-Received: by 2002:a2e:9b90:: with SMTP id z16mr13423303lji.254.1580743112406;
        Mon, 03 Feb 2020 07:18:32 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h10sm9835670ljc.39.2020.02.03.07.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 07:18:31 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6D693100996; Mon,  3 Feb 2020 18:18:44 +0300 (+03)
Date:   Mon, 3 Feb 2020 18:18:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@gentwo.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Steve Capper <steve.capper@linaro.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 09/16] page-flags: define PG_reserved behavior on
 compound pages
Message-ID: <20200203151844.mmgcwzz3igo7h6wj@box>
References: <1426784902-125149-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1426784902-125149-10-git-send-email-kirill.shutemov@linux.intel.com>
 <158048425224.2430.4905670949721797624@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158048425224.2430.4905670949721797624@skylake-alporthouse-com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 03:24:12PM +0000, Chris Wilson wrote:
> Quoting Kirill A. Shutemov (2015-03-19 17:08:15)
> > As far as I can see there's no users of PG_reserved on compound pages.
> > Let's use NO_COMPOUND here.
> 
> Much later than you would ever expect, but we just had a user update an
> ancient device and trip over this.
> https://gitlab.freedesktop.org/drm/intel/issues/1027
> 
> In drm_pci_alloc() we allocate a high-order page (for it to be physically
> contiguous) and mark each page as Reserved.
> 
>         dmah->vaddr = dma_alloc_coherent(&dev->pdev->dev, size,
>                                          &dmah->busaddr,
>                                          GFP_KERNEL | __GFP_COMP);
> 
>         /* XXX - Is virt_to_page() legal for consistent mem? */
>         /* Reserve */
>         for (addr = (unsigned long)dmah->vaddr, sz = size;
>              sz > 0; addr += PAGE_SIZE, sz -= PAGE_SIZE) {
>                 SetPageReserved(virt_to_page((void *)addr));
>         }
> 
> It's been doing that since
> 
> commit ddf19b973be5a96d77c8467f657fe5bd7d126e0f
> Author: Dave Airlie <airlied@linux.ie>
> Date:   Sun Mar 19 18:56:12 2006 +1100
> 
>     drm: fixup PCI DMA support
> 
> I haven't found anything to say if we are meant to be reserving the
> pages or not. So I bring it to your attention, asking for help.

I don't see a real reason for these pages to be reserved. But I might be
wrong here.

I tried to look around: other users (infiniband/ethernet) of
dma_alloc_coherent(__GFP_COMP) don't mess with PG_reserved.

Could you try to drop it from DRM?

-- 
 Kirill A. Shutemov
