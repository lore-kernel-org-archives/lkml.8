Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9565AC34034
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE9721D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="DnjHaN1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgBRI0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:26:10 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36314 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgBRI0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:26:09 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so21889254ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 00:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lPpnBH/Ec+U4BS9aeM6PNHC3PGBciULDCwrtqz+a1OA=;
        b=DnjHaN1qBkLLWyLNs08YhKQSELw6EA3k0PVEYvSL4y5LiKDsAowA2Z0F9NX95BPVZP
         nAw6kvB/KytsAqAB+591hSD9VA5Fu+U7/JmvzkLXAHZ9i3/ojNPFOr446dxr16L6sEae
         lpONGATz4gijbGFl+xdBJD54Nzl5LVhnuOsDNnpabjej7SjHZ5cIz+cqTjLAnvS6P5Z1
         TaDcyDSjxobPB9rH/taGuvTjMitthUKOwZKCiYT43bJW+AgbdPEoHEiCZ5yDnQfSX7LA
         KTsS+vfofrNwBuvmWGK5MZFFFIcN2l8pm0ydbrgw6p/lZmhqirL/ot7HkQMxOzEjj8Hd
         TWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lPpnBH/Ec+U4BS9aeM6PNHC3PGBciULDCwrtqz+a1OA=;
        b=QvKATLXBzq66g1FmU9cG6L85cO7d2I5MHqCKtiMRBJs4bHPIodtmfka7VOmvAIZSmo
         5U0jgZC7G7GrAE3QvYpGZBs+u2vAnDIHTn9q00EvMcgLe0gNrMIaxeDyloUVvlLzTe19
         DTYYru+FKsXPYKH3rq7C7qCUg5XfHkH+h55SEIF+SBZNJcdv2yf7jdsqLgwxAw+teEx0
         mS68hN7ik/7P+xPMHVp4AqaSNfQkL4/ziUATWXAsfldmIERmWBB0P7FCdugzXpxJFhrl
         0A3AAaCyITSBIug5XHxJhTl51DOshEQhNgoznRJCtFbZDQpySpl7KSNx24jk10gF7+hR
         rx7g==
X-Gm-Message-State: APjAAAVzRJ3oZgKpwfAhgHHT8TY23sHcZMWkRWpwMGDoAnqL+Xbt3A3o
        x8Zg6g1XQz+teZ/Koziq92rKBg==
X-Google-Smtp-Source: APXvYqxe0fjPnzAoZSBTdwq8ivm8QoPOQWpxXLSnYk93TuBbd5ajAuJ3GNhfLzgu6lkObfJc7IdoGg==
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr12350688ljg.166.1582014367627;
        Tue, 18 Feb 2020 00:26:07 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i4sm2177411lji.0.2020.02.18.00.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 00:26:07 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 68859100E9D; Tue, 18 Feb 2020 11:26:32 +0300 (+03)
Date:   Tue, 18 Feb 2020 11:26:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jeremy Cline <jcline@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, thp: track fallbacks due to failed memcg charges
 separately
Message-ID: <20200218082632.kn5ouiditzx5h2iq@box>
References: <alpine.DEB.2.21.2002172139310.152060@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2002172139310.152060@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 09:41:40PM -0800, David Rientjes wrote:
> The thp_fault_fallback stat in either /proc/vmstat is incremented if 
> either the hugepage allocation fails through the page allocator or the 
> hugepage charge fails through mem cgroup.
> 
> This patch leaves this field untouched but adds a new field,
> thp_fault_fallback_charge, which is incremented only when the mem cgroup
> charge fails.
> 
> This distinguishes between faults that want to be backed by hugepages but
> fail due to fragmentation (or low memory conditions) and those that fail
> due to mem cgroup limits.  That can be used to determine the impact of 
> fragmentation on the system by excluding faults that failed due to memcg 
> usage.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>

The patch looks good to me, but I noticed that we miss THP_FAULT_FALLBACK
(and THP_FAULT_FALLBACK_CHARGE) accounting in shmem_getpage_gfp().

Could you fix this while you are there?
-- 
 Kirill A. Shutemov
