Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566FBC3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200E024649
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Qe5MOTcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgBMOTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:19:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41689 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbgBMOTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:19:35 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so4376351lfp.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 06:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ChUl3tHz/fw+J1QXa3SpVpFJqSXrNSqyDcmt7Jvy8A0=;
        b=Qe5MOTcV3y5UxK9Ii9p0xEZvCMj9OLw0YjFE0xBCoz1gWi9ibYASz014rUL04gpb7q
         Jh0z4VuqzLtk3mvX37TJRUZy9SweYkQMK1BNiZXULFtmiSf7XqC0kDKiTeTV2BnEn950
         QAcRxDT2FRhbApnil+gab9l+DhowDzeOFeOiHpa2fVhub7mVhBIr/LjjVhe8WBe9YEsz
         4k7GUhjbSju+l2w7Q1fbj+Ibb9rgONMoY22O91dYYGvKakYmmmCXCywGHQTkxos6LKE/
         RW2rlByGRW2QIHo+HAfVA4hPa0BnLl3f8/ihSYYBYF5CI00ccfZfMQw6yeKJCLqiol83
         NvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ChUl3tHz/fw+J1QXa3SpVpFJqSXrNSqyDcmt7Jvy8A0=;
        b=o4yvTDNTEEiZKpCZSdL1/vOEZJfaJmEAzdfNF2e6NANzhNFt14zZibwMiP8cvVXo0K
         65cnpdzzJGNGS2JHQG/tAOJuLWB+db2vJ/1fF+bQ32tYf79LLHvOvz4J8/EcrX0L8FY1
         ONEtNn9KIxH6DYowEauEcmaACCioS6VBnFrOeT6TE/20lNy2TCRBfXe1HfqgyG9lzubq
         KTnqGfTFh72J5LH/mKJSH8vQm5XYftSqFmNJMVxFB9ivh+OxJpdI//Tj5MmxupZnsp+A
         Bt4CMjz60EzG3i/pv3fNCUn+CzJ75olVtT8Qg668ivxOPm+tpLCpNnZxe5uFw9L31L7e
         d5OQ==
X-Gm-Message-State: APjAAAU1W/tz8gINjH6LcRSbtlrLgVL5OLlzO+CKyDjd4Jm9mPNjx4IM
        KLP6bYW+S+zcE4jK5jYtP3JfxBp4mKs=
X-Google-Smtp-Source: APXvYqzq/FNTpsd3Tvp2BMWqJNwdIvCHj9yXlOkhD98MAYW0DHLX50XOLa+DZ0Flj/x/O/8HCz4OZQ==
X-Received: by 2002:a19:cb95:: with SMTP id b143mr9527955lfg.158.1581603572940;
        Thu, 13 Feb 2020 06:19:32 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i5sm1591340ljj.29.2020.02.13.06.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 06:19:31 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id DF899100F25; Thu, 13 Feb 2020 17:19:53 +0300 (+03)
Date:   Thu, 13 Feb 2020 17:19:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/25] mm: Introduce thp_size
Message-ID: <20200213141953.ijmts6cs5eh5pgfx@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-8-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:27PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This is like page_size(), but compiles down to just PAGE_SIZE if THP
> are disabled.  Convert the users of hpage_nr_pages() which would prefer
> this interface.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I would prefer the new helper to be inline function rather than macro.
Otherwise looks good.

-- 
 Kirill A. Shutemov
