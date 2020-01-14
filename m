Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4071C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B80222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Wm2t8cPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgANPw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:52:57 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33804 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgANPw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:52:57 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so10217496lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 07:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zmI+7fCvDJ8jUI/s1LWzV0ABXbMh8NW+HrTxQxtxW+c=;
        b=Wm2t8cPhYynnALTqITb4PRgUN3xAdtIL/l7NillCbGBQKs9d29OyBpMDhPLuc15IGf
         Mrkog0biOqCEaTd77ua6TqgU2efNPzr7diD4mLhIaEAlNKTUf70asBLacWTFPtMxcoxN
         eMS0MmaA5epHFn/XxW+Q4I/ZKoUxE8I1NMoaCo8m/4Do9dOn5ph7E4+xIATrfx66x+hI
         9XYQDCGrx3yaP3P4rQhyt/IgawT3rlwBiPrJHHm/SPj7tOXx/Qk3ch9gCT3Yt4sJ68n0
         4gwAKa/hwpG3oHP+rCxWWHYpouueIJI5yLV5rhVfs/PEQMqoiGm+OuXyD/3yauzIqK3u
         Laeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zmI+7fCvDJ8jUI/s1LWzV0ABXbMh8NW+HrTxQxtxW+c=;
        b=cOG9MRe7oYfxMzwXeHDDUm9pNsQCAcf3TXjrcCXPxgTvQck62Y3tZ8MDSSeZ/VXzDu
         gBHNypQBZmSrkKG60CkcaGLVbjbucV8Q9y5SoI7Bz4fxwOpmpUM1pKOfDsdQSRI319h1
         DKKyOjl2UJo22MvEeKXmOpAYKNslDy8QrGLEAZ1YYSWze0HSL8IIiJAtkqQ1PrWLBQk0
         Rw14dBcfSozkckz9kVM2vaLHrP6dPxs/sx2LB0cJoStmRyERqDNqSPLZMQIxuS586WZZ
         Mt9iOqMG5KzCQtR9Wjudev1F96mXcODDjHLQXOheXVqg7KFSIr7ze+SdgVe/OH41ByV5
         1I1w==
X-Gm-Message-State: APjAAAVbTmub4tnraPu029oyRKVbe53UdjbJM3FhzwLJInUQle9Sj4Zf
        w9Eglrqok5Njh+IsCirlPIhjo143/6Y=
X-Google-Smtp-Source: APXvYqw+3PJvfNkdFH3y9F3CIp1R5dqPceP7RzJP7ftqvhfxkDa2mvUtfpC+UzToTb1sJ6fKFFCIeQ==
X-Received: by 2002:a05:6512:cf:: with SMTP id c15mr2106258lfp.57.1579017175586;
        Tue, 14 Jan 2020 07:52:55 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p15sm7379134lfo.88.2020.01.14.07.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:52:54 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id E23471012B2; Tue, 14 Jan 2020 18:52:58 +0300 (+03)
Date:   Tue, 14 Jan 2020 18:52:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 2/2] mm: factor out next_present_section_nr()
Message-ID: <20200114155258.kww5ve7agifxxtoy@box>
References: <0B77E39C-BD38-4A61-AB28-3578B519952F@redhat.com>
 <C40ACB72-F8C7-4F9B-B3F3-00FBC0C44406@redhat.com>
 <20200114104119.pybggnb4b2mq45wr@box>
 <4de17591-e2c4-daff-e4b2-d03dd8792d0f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4de17591-e2c4-daff-e4b2-d03dd8792d0f@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 11:49:19AM +0100, David Hildenbrand wrote:
> memmap_init_zone() is called for a physical memory region: pfn + size
> (nr_pages)
> 
> The highest possible PFN you can have is "-1(unsigned long) >>
> PFN_SHIFT". So even if you would want to add the very last section, the
> PFN would still be smaller than -1UL << PFN_SECTION_SHIFT.

PFN_SHIFT? I guess you mean PAGE_SHIFT.

Of course PFN can be more than -1UL >> PAGE_SHIFT. Like on 32-bit x86 with
PAE it is ((1ULL << 36) - 1) >> PAGE_SHIFT. That's the whole reason for
PAE.

The highest possible PFN must fit into phys_addr_t when shifted left by
PAGE_SHIFT and must fit into unsigned long. It's can be -1UL if
phys_addr_t is 64-bit.

Any other limitation I miss?

-- 
 Kirill A. Shutemov
