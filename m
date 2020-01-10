Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC731C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842F52080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="aBroZhD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgAJRzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:55:22 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42623 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgAJRzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:55:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id y19so2110239lfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zz+quxNQ9A7Nw9iS38o6f8U+FhTKrAPp7iIrBkPDhng=;
        b=aBroZhD7Y0T9JZ9Me+bhFExvvN2ek+hxX9sraWp+HU38gxMBkZRHRP4drMgDP5TZym
         K//IAs2EZ0YnkdMMsZcQ0rguk8FnsxOQUO0u6vwDRNXsvPgmuKzQimYEJyEwuth9HMib
         R4a8mXioF0Hh1kwl1g0mQCRZnDFz3noAPZZSVuvs7NY7cwS+WftKEoLH6rW1LJcX+4nc
         oihLd6XtHzkis179G5ZolevpXvOTYgjtcGySrC9NdMcXWxPbx6nymac5HvqJ23fyou7t
         BvRio8Hu6F1GlPWLXFdtlMemJecHHXEAPcFfL8GZ7avwQq6RPMXjmxSgsT7Wm5yvcXxe
         EtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zz+quxNQ9A7Nw9iS38o6f8U+FhTKrAPp7iIrBkPDhng=;
        b=BGkKkk96kFMxBuSxm+eogMgoa4URCbwyOQnT4E++qAeIwSESI6x5+jp7x6nmHvxWWk
         IZuh0PR9f64UGwz+I90FavCuaNIWyHZUvaQcLMu0NAX+WFCYjqfh37j/Fa/434uwMCvs
         P5OlnBt7SvQ1Xuj8KTK/DumdkwPClfLsNimSTR4SKhSbrsB+MjBBZSlqt3EYVBwVk9V9
         aL4iJrWtz1MBjFpGLuQfKv+7sT50JFJ5/Ysd0FBBeV2dtFSlx3K+A7yu4kGu5tV3Gm5r
         oDNhcV4qsfUr0F+O9Dfw5sjnWpPkWENJtD+j/Ep3CQ7AcGHOajhgCHrGbHB9CnLyqBAJ
         fmqg==
X-Gm-Message-State: APjAAAXzuYGsSvcgc621DTHEn4ceV2xJ/fAZZlUppTUXHd5hEt5ebPWy
        ZNy14XZv1Hlmwrk36Ulq/Je64A==
X-Google-Smtp-Source: APXvYqy8FVQJWam23cUJsbg5L2XIhB4e80Fm51ijXV/BqTf4T7GX8aBwJOGS+3R1JLeZ/gpUYCvctw==
X-Received: by 2002:a05:6512:244:: with SMTP id b4mr3034448lfo.85.1578678919579;
        Fri, 10 Jan 2020 09:55:19 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i4sm1308379ljg.102.2020.01.10.09.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 09:55:18 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8C02C1010D6; Fri, 10 Jan 2020 20:55:19 +0300 (+03)
Date:   Fri, 10 Jan 2020 20:55:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        "Jin, Zhi" <zhi.jin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm/page_alloc: Skip non present sections on zone
 initialization
Message-ID: <20200110175519.myahx3tnxajt4eam@box>
References: <20191230093828.24613-1-kirill.shutemov@linux.intel.com>
 <20200108144044.GB30379@dhcp22.suse.cz>
 <73437651-822f-fcec-3b96-281fb1064cf8@redhat.com>
 <20200110134547.v6ju5dxazknfjdj3@box>
 <de70ec09-492d-292b-0738-db1ce1f05673@redhat.com>
 <20200110144717.xufpf4yjkjlngymy@box>
 <6cf49e65-ee02-7cbd-596f-ebbc057717c2@redhat.com>
 <20200110145454.mmgmtcy2zsrr63vh@box>
 <2f075639-c378-4bba-abe1-60d3c2420800@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f075639-c378-4bba-abe1-60d3c2420800@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 03:56:14PM +0100, David Hildenbrand wrote:
> On 10.01.20 15:54, Kirill A. Shutemov wrote:
> > On Fri, Jan 10, 2020 at 03:48:39PM +0100, David Hildenbrand wrote:
> >>>> +       if (!present_section_nr(section_nr))
> >>>> +               return section_nr_to_pfn(next_present_section_nr(section_nr));
> >>>
> >>> This won't compile. next_present_section_nr() is static to mm/sparse.c.
> >>
> >> We should then move that to the header IMHO.
> > 
> > It looks like too much for a trivial cleanup.
> > 
> 
> Cleanup? This is a performance improvement ("fix the issue."). We should
> avoid duplicating code where it can be avoided.

My original patch is in -mm tree and fixes the issue. The thread is about
tiding it up.

-- 
 Kirill A. Shutemov
