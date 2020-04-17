Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD067C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B85EF20857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="RB07JlK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgDQO7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgDQO7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:59:12 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EA8C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:59:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q19so2324487ljp.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KrVdbgNLnOAtz/b4GEh6fjWuVR6UiAa01u62/hDkw0Y=;
        b=RB07JlK2pmb0+M6v4xQGBUIWbw21AfEXpRSFiwNcWlOdmO0l5W1HXEmc/ezpr5MT8j
         uG3oSBY9B4HQ/MUcBWsabTKQo+VufRJQA1NNT7pQstrOlNI98is9x+bnMG6D7L9bKMN5
         RLcWV12Kn1B0Zms7J+8cCm/Mj21gE/UFVUQ3Vq78degSMaW/rBxxvOAc0eVurkOUcUn9
         THmz8gRn7f3R5tZTkZFpEmYkZXtHb+J9mX++57Ab7pWTEvohleZgGGT7Wx3DK3bFBUvZ
         8orviJX8amuK9oTr50PkVazeUlYAXksZEIwZmZCkTYvBconnFwOsn7ngzQ1ZngyJpfAS
         hxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KrVdbgNLnOAtz/b4GEh6fjWuVR6UiAa01u62/hDkw0Y=;
        b=a4yGREN0F0gyqkLtdY2xqMp2gGQu05vrcaq1+DdXq23mpKrzRxd65e+M9nuL6dQ11e
         OMMpMM5R6FsoYhVY+0hJaGpH3bWPcmhBh2DE/rl+1A6knt98BbKUnUAK+Iha+Z7q7sh3
         FkiglDYr1UkJSLB1sZy10+N0Y5l5hmM0+Gszb/2TNR6xrgIy2Z0EMftXwFKG10mdiWAC
         Fi4+SpcKzbN20VC/Cz6728AYklzWyZrWTvpXLziCKa23XJnUnnIbLlpXpj3PFR9cm9Py
         e+WtNnyjYDB5p1BubRN0Be7BoUIl8qBU2xVY5lhZkJF4plj2seDG/OSywRyXpIFB4x4/
         XPoQ==
X-Gm-Message-State: AGi0PuYbqqHodhz5DJcCtuTHetjY6orq+RowzbLSI0GI1W5OHlLbo8NW
        fSP1HelkPz8ZJ1y2tKPtTfotMg==
X-Google-Smtp-Source: APiQypLchSnPlwcAmQhQnIQZDPdJndRghDikYI9DT9sG7mYhgtH7y9jwm5mgo0e/ZXbQ54IfOSRUIg==
X-Received: by 2002:a2e:3c08:: with SMTP id j8mr2448089lja.243.1587135550261;
        Fri, 17 Apr 2020 07:59:10 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v64sm7599013lfa.54.2020.04.17.07.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 07:59:09 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 74B7A100AEA; Fri, 17 Apr 2020 17:59:09 +0300 (+03)
Date:   Fri, 17 Apr 2020 17:59:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 4/8] khugepaged: Drain LRU add pagevec after swapin
Message-ID: <20200417145909.476o5ppho5p3cgyk@box>
References: <20200416160026.16538-1-kirill.shutemov@linux.intel.com>
 <20200416160026.16538-5-kirill.shutemov@linux.intel.com>
 <20200416214145.bfbb1afcc7a632e8cafdf203@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416214145.bfbb1afcc7a632e8cafdf203@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:41:45PM -0700, Andrew Morton wrote:
> On Thu, 16 Apr 2020 19:00:22 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> 
> > __collapse_huge_page_isolate() may fail due to extra pin in the LRU add
> > pagevec. It's pretty common for swapin case: we swap in pages just to
> > fail due to the extra pin.
> > 
> > Drain LRU add pagevec on successful swapin.
> 
> I don't see how this patch can do anything to prevent
> __collapse_huge_page_isolate() from failing, which is what the
> changelog implies.
> 
> Can we have a more detailed changelog, please?

What about something like this:
 
    khugepaged: Drain LRU add pagevec after swapin

    collapse_huge_page() tries to swap in pages that are part of the PMD
    range. Just swapped in page goes though LRU add cache. The cache gets
    extra reference on the page.

    The extra reference can lead to the collapse fail: the following
    __collapse_huge_page_isolate() would check refcount and abort collapse
    seeing unexpected refcount.

    The fix is to drain local LRU add cache in __collapse_huge_page_swapin()
    if we successfully swapped in any pages.

    Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    Reviewed-by: William Kucharski <william.kucharski@oracle.com>
    Reviewed-and-Tested-by: Zi Yan <ziy@nvidia.com>
    Acked-by: Yang Shi <yang.shi@linux.alibaba.com>


-- 
 Kirill A. Shutemov
