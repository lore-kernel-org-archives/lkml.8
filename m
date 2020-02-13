Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC019C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767AE20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="NftAHAky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbgBMPjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:39:53 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34100 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbgBMPju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:39:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id x7so7129516ljc.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 07:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NHktFnZlX6uKMwJC+qraMNZiHbiScODIMZ6tmW6mHl4=;
        b=NftAHAky8nG3HwoLsfo/A8XP/u8putXbTgMDGVG58zTqt/ANXlRTYfcUpPXIjIulCW
         F3frpsniYt6j0+nbWgw7d9lx35BuGxO/FG96mRE8mhOsVGxY+XQjoPIrnqIMuOrN1/sT
         E7/82AQpay1JLLCwW1jOIPaRMJa4OX3nkjmTI4lbVG1YQPVm1h54D4/xbiKtRvEweF0T
         48Vwo0nYCFVEAsONA2QnyFuiJknvu7JV84/cePCypvp5ncTwBb82VdR5tASR8Om68/Xx
         IVLOFu/1sRo6fR4cGOO5EzsJQn35BxU+zKuSxG+WjrfJHZfuceELhp+8PnpUHRqeb8ZM
         UHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NHktFnZlX6uKMwJC+qraMNZiHbiScODIMZ6tmW6mHl4=;
        b=pxm79AfOxCotkEBUrMaDxQiaGWwS3etp2LB/O84FRukVtjpZlqxMgJwx3uFMXh4/Ad
         1AT5Sywjh+JwC2cxJrsHUkBDO0D7iB3O0xTnnVAevbAjcd2yaRmZHNmNSqhWqOxI8TB3
         wbvceWwocQdo7qGbrRvmNmnRXG+f1mF9ubqklr/TStFjHG8iSpaWM2pXE+iBnHlhToas
         BI6escwDDnfB3MSIifVWtsdA0IqqWti6+HlOTDvuZQNL17/FHRgF2IdVo6OWGbc69y5t
         WAqjAfPTmJPU2MVg2uRyyK6AYPrys6j9Hw7hHc+SgWZ7NoN/+ekVxXxd694dHiImszUT
         axlg==
X-Gm-Message-State: APjAAAUAf9Od+74iToH2Hel5iezx0aLhF8F0wq85ihUdIAXyBPX1smWe
        3Jb6R5OZmaxljfRDbpguLWY0wA==
X-Google-Smtp-Source: APXvYqwEQWxVztZsHujLgYXUzp80jKlSTGmzeS7kguAQ03NeSNKI0seeS7EaeHwwCRbzQupO4lEBBQ==
X-Received: by 2002:a2e:93c5:: with SMTP id p5mr10069149ljh.192.1581608389545;
        Thu, 13 Feb 2020 07:39:49 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p12sm1474818lfc.43.2020.02.13.07.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:39:48 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id F34E7100F25; Thu, 13 Feb 2020 18:40:10 +0300 (+03)
Date:   Thu, 13 Feb 2020 18:40:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/25] fs: Introduce i_blocks_per_page
Message-ID: <20200213154010.skb5ut6fixd36cxr@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-11-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:30PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This helper is useful for both large pages in the page cache and for
> supporting block size larger than page size.  Convert some example
> users (we have a few different ways of writing this idiom).

Maybe we should list what was converted and what wasn't. Like it's
important to know that fs/buffer.c is not covered.

-- 
 Kirill A. Shutemov
