Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE9DC35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7982080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="gHmsJSzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgBCOtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:49:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35309 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgBCOtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:49:16 -0500
Received: by mail-lj1-f194.google.com with SMTP id q8so14938369ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 06:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FRbzbVQzxFexQ0VgQnSAj0C15SoTBMWHxIMKIhqhh1Q=;
        b=gHmsJSzbDjTN8nBH+/BiEKa+jkSEMCXiDW+WRCp9+Ih0tCciWM2vWF2vJcGqMKkCpc
         i91TmdyPYl5a3ntBbJuu7OLRibTRm094GkhLwe0o7H6kK2+kxwoJuXczUSBhDTVw/LJ7
         ZIXh3lsSXFVfWW91Pb8uzXGw9ZgsfIupdmH7trlKo3VMuxZrn9oCcLsbEHCXQ5HjCOnW
         PsY7VOIgaXhPQGM4SFUDpc3A/Rzh2YS0IzCOkD1IjGyUHmWUIMXI0FePAeGdiAJRQxlQ
         Qeb7H2RyfPlxYmAFDts/woXlCSPZ3u3gdS3ENGEEnRkpB8RD0OUf70xKuQvUs/2mnIdw
         Q6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FRbzbVQzxFexQ0VgQnSAj0C15SoTBMWHxIMKIhqhh1Q=;
        b=VOzBkPl9IKw/nyQQ3Dj+RfbxorgefI7oa/PsD9eLYRm1XS3L14UKX7t0FEcq34yyWm
         9CdyqPgaJ/SgpLQVlU425EGkyl1v4iRFFijS0vM7ttnxGd49WgCWkvXxL3Ncdyb54wBx
         4b1bNsGHJUa6+9CbOQpYo53fIigh99bDVPI78ZFAifmsIDosy7CKLdTXoJJh/y+h4BaH
         aoAerYe4Z9IhIx3n8Z4rIVRvA4NRerH4VCkEkiEWztDKWJ3xEjlM/Sies31G/MYWz6y3
         NQTNXcdIH/aJYoWHVlzbNJKpGYfGYEH74py/ZxZACaRmpFUvqNZwuUQAPB8v1tkyx+AZ
         wFCA==
X-Gm-Message-State: APjAAAV6jalkKUFk41o/UutxXrNqaRHO3M0GPOGuTUh++GhHWvsPxI/b
        XdM8euvc+PtyHd2NVOGmp3CytA==
X-Google-Smtp-Source: APXvYqyptPBlDbZpGGw9XJFVqnTHIO8tta+ErCKvto7NcZZuUelUtexY3wdRFbyGemHtQLsyAqoq7Q==
X-Received: by 2002:a05:651c:32b:: with SMTP id b11mr14075842ljp.203.1580741353554;
        Mon, 03 Feb 2020 06:49:13 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 19sm10760094lft.81.2020.02.03.06.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 06:49:12 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2ECB1100996; Mon,  3 Feb 2020 17:49:25 +0300 (+03)
Date:   Mon, 3 Feb 2020 17:49:25 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: Re: [PATCH v1 0/2] mm/page_alloc: memmap_init_zone() cleanups
Message-ID: <20200203144925.7aqbumgytmx5na6l@box>
References: <20200113144035.10848-1-david@redhat.com>
 <20200130203059.32b48bb73bf0c8e9ee8470db@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130203059.32b48bb73bf0c8e9ee8470db@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 08:30:59PM -0800, Andrew Morton wrote:
> On Mon, 13 Jan 2020 15:40:33 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
> > Two cleanups for "[PATCH] mm/page_alloc: Skip non present sections on zone
> > initialization" [1], whereby one cleanup seems to also be a fix for a
> > (theoretial?) kernelcore=mirror case - unless I am messing something up :)
> > 
> 
> I'm not seeing any acks or reviewed-by's on these two?

You can use mine:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
