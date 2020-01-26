Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5556C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 22:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DA820716
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 22:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="vd7wN7va"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgAZWGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 17:06:48 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36095 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgAZWGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 17:06:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id f24so4911677lfh.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 14:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bIjpqXTvBSR6objHCm0IzTR/hQ3TPrKkme7EJy7SinQ=;
        b=vd7wN7vaZJfsftvGGeIdYEwGAd4ISoPUjH4z/airo4c26P52SSKuDuY4RS0FCTd3jk
         KGJuozw/CRaeDQ8RBJpp+oWUfc2eDnUbiMFkXFrBXbs5ojteYSba/dGN1A/1KxD1aEzs
         kwJfOZOp2vtTZ1sI5xIYQJlNEmUxEGX6JXv4Xurm4zHypuUTquU8mvoaBx/394qcnVUj
         RzzbO3aM80carMr02Nqzb6oeiw1Uu4+S5GWqP8R0NK6qJX9IlkQ0sONrEey8uSOh9ukr
         a/5FajX0UzsqgSnvcxbbzkeC25sud1T/2dcmQXy0fbovFOy/mw4wm/rc/xExEVA6kt85
         nmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bIjpqXTvBSR6objHCm0IzTR/hQ3TPrKkme7EJy7SinQ=;
        b=PiNO+8of4s0sa8zxGPJYbCOPS79pteVw420dqZWKfIh5xiJMYfRCwsxsgeBZTGQ3Lk
         5PGCaItof5UFo88FJGRwKtDx32Fveu9gOgGPXQbwH0p613sPIRDHu6IEIhEwAAcdwDZZ
         mQjrRFLJWnOuLHJgSorqIux/v1UlQSn+wnw/4uWpH282xeORr4VsSe6vdx4cZD/NoUls
         gabv1z6nO2T/JplKCTpcFBSDscwhI9b2aT0eObK0dJYbildds51Ix0sWzBD1FWB0XhCE
         ZcP/o55JSSvapKZepJGg5UL2yOeYM3B2ZpPJxTWZsVOrXnivS+yznpnKvuIz6hyOYaDA
         Dwww==
X-Gm-Message-State: APjAAAXaIWA/yw5dEQjgb7GSz2YUYGAbtUC8uYdLSk1VxQ9WNKNhOJ0Q
        6zfITu5P+miN0ZvaeUVMBuFbug==
X-Google-Smtp-Source: APXvYqzcewzG3j/TNt2F5XioQ+wUekZmF3eUnjfjLtEYPRrWC1YWX5O7aKsWt9YIO7SAizSUaGlpNQ==
X-Received: by 2002:a19:4855:: with SMTP id v82mr6199593lfa.197.1580076405722;
        Sun, 26 Jan 2020 14:06:45 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w20sm7129060ljo.33.2020.01.26.14.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 14:06:44 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0082B100301; Mon, 27 Jan 2020 01:06:50 +0300 (+03)
Date:   Mon, 27 Jan 2020 01:06:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Subject: Re: [PATCH v2] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200126220650.i4lwljpvohpgvsi2@box>
References: <20200123014627.71720-1-bgeffon@google.com>
 <20200124190625.257659-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124190625.257659-1-bgeffon@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 11:06:25AM -0800, Brian Geffon wrote:
> When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> set, the source mapping will not be removed. Instead it will be
> cleared as if a brand new anonymous, private mapping had been created
> atomically as part of the mremap() call.  If a userfaultfd was watching
> the source, it will continue to watch the new mapping.  For a mapping
> that is shared or not anonymous, MREMAP_DONTUNMAP will cause the
> mremap() call to fail. MREMAP_DONTUNMAP implies that MREMAP_FIXED is
> also used.

Implies? From code it looks like it requires MREMAP_FIXED. And
MREMAP_FIXED requires MREMAP_MAYMOVE. That's strange flag chaining.
I don't really see need in such dependencies. It maybe indeed implied, not
requied.

> The final result is two equally sized VMAs where the
> destination contains the PTEs of the source.

Could you clarify rmap situation here? How the rmap hierarchy will look
like before and after the operation. Can the new VMA merge with the old
one? Sounds fishy to me.

> We hope to use this in Chrome OS where with userfaultfd we could write
> an anonymous mapping to disk without having to STOP the process or worry
> about VMA permission changes.
> 
> This feature also has a use case in Android, Lokesh Gidra has said
> that "As part of using userfaultfd for GC, We'll have to move the physical
> pages of the java heap to a separate location. For this purpose mremap
> will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
> heap, its virtual mapping will be removed as well. Therefore, we'll
> require performing mmap immediately after. This is not only time consuming
> but also opens a time window where a native thread may call mmap and
> reserve the java heap's address range for its own usage. This flag
> solves the problem."

-- 
 Kirill A. Shutemov
