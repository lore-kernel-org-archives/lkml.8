Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E90BC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B6F218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="NyzKwIB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgBMNvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:51:37 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35853 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbgBMNvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:51:36 -0500
Received: by mail-lf1-f68.google.com with SMTP id f24so4330616lfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 05:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1lG9y4Y60ZGG6VZ/pe41Q4KolNDjo1CpYjwUfuOyDDQ=;
        b=NyzKwIB/nqaOMRkb9Q43JHPCN0+0LktJbc5T5aU9knSi6qgM/1tZmDQKiVzznl/UVR
         75tRahnZmakJR0nRQo32r9z+u4nZma+cH7hWKnbGvMTPxV3GDARIvoZbbZ2D3dt2xdfD
         r1shDQWIpcKOylKA+tDsQYiGEACIK9ajrKZgAljbiDQbyRi0OxVjFe4d2DG52n/+Lpmu
         id4dnWKrwqUn9Z0OJMGt14GsFlMnvt3TTLNdW7pjuRiKbeIpZbgXb8hpLpfB/aXiIeCB
         Pu+RFN9pF7jeBEORMAsEPKcWdcgR8j4cx5ed9RD1KOzg1t8aKqyhlLKHe+ebooGVkgSn
         F9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1lG9y4Y60ZGG6VZ/pe41Q4KolNDjo1CpYjwUfuOyDDQ=;
        b=d5MKWfoYH5lWh6gA/xjsm2TzjHadqkp4jyd4tVFIUyYjCYAWfOPrgzVYD3PSnq9Ujc
         spz/a6hzVtbuKCy909XsKlFsbW46wQXOmKVZubQ7VVPv+NGiC0Rh6bpPZW1ggpZuePfE
         1p/maByx+0vNdASHOOyyZ2lv1c83wyO8iUPXyg9Fck2ksYzoJyxLY7SDDJfP0lzoM9BM
         TGq5duoZhSnzoK2pKfo9Ql3VAQ58Atieb1kpBPSVOlKizgTV3+XUVdeT+ATT18H0RnJW
         VfXd56/gZazV84qM2dyTH3nYux2vdcWegoBNszUqSQstoIJHm9fdIYCkIveJ5PP0T30n
         438g==
X-Gm-Message-State: APjAAAW21ZDLyb/EEQHVZveWd7iPAwYQ0jB5JYvHqRG+cuM14tOdXdqF
        mZDRM96Q8QtDWQ0y7I9EZuVCHg==
X-Google-Smtp-Source: APXvYqzWuKQ/3f41ZkQFFOSdLEdLeEplpVEvsmF9jt0nklDHYyh1huhxdtI5NjO3NWHolQTzW8+Zkw==
X-Received: by 2002:ac2:5e7a:: with SMTP id a26mr9585633lfr.167.1581601894891;
        Thu, 13 Feb 2020 05:51:34 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r2sm1670194lff.63.2020.02.13.05.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:51:34 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6F7B0100F25; Thu, 13 Feb 2020 16:51:56 +0300 (+03)
Date:   Thu, 13 Feb 2020 16:51:56 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/25] mm: Unexport find_get_entry
Message-ID: <20200213135156.cqoqokb4bzvro3mp@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-5-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:24PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> No in-tree users (proc, madvise, memcg, mincore) can be built as a module.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
