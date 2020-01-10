Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594DEC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2911220678
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="XzwJrBkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgAJSW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:22:29 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41743 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgAJSW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 13:22:29 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so2175674lfp.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 10:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zRzWHHWUjd8GGli20zAKpRHocJhLO6+h0fMpMMJ1Kdg=;
        b=XzwJrBkxl3yW13eTy/hl5tjp9vze6F192dwkrS1OPoiXlgcelkgVD+rXULocIf+rz/
         cKGmxzyIHKxZtqfV5RqH1TATbiAyhbN+bFm2xsu8b24Mpf+iYizu8kgSPn0NA9gjYkNn
         h9sj/TpGMbzgPR9lNV0jzUexa6lsUiRIXR+OmzRuKzj/EszyzXULGRU/y8Sp/tw+MBzB
         6w/adFC9cokbgjFh7jbLjVqGRVWm3/ea1IPxMpMiEQvvHwI+VHh75YO3nXafuP80lHVO
         OBRtoCEaFvo4EjUSUcxI1DN2YAPIsWxkGbI0xOgg2NphvzPbceqZojORaSXRccvuqtM+
         8EEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zRzWHHWUjd8GGli20zAKpRHocJhLO6+h0fMpMMJ1Kdg=;
        b=iktC6ZKVMv1qblMCC+59kJpD4HjYYFo60Yn5PxSdeRomzoVe8hS+DkxYIzMG0xynju
         IZ3+7n3QGwiV2Z7YZtRpZ6g4Zfl0Zjn08Rd7Ayg/fvXAs0QW7YyKJVSTE+vbnDefa9ef
         Ve+J5gGnRdPRWQi94Qix/qCf8HiL5t2G0aD7b3v/fCDAZtnGqFNcboz2nLYbDPZhzUdJ
         uNbxqjQ9fglK49PsHE0g1+Pri7usi63ebCEl1e3/mk8GKjM9j5HfhFny5wbDjTMxpVA9
         P67SPWskFm5CJgsvnKZOZXS7Ns72nt1v6/tuzVywSrsieRwJgFXmCFU7ayub1sMXjVWo
         SRhA==
X-Gm-Message-State: APjAAAWSULn3BQ0jaxjwrIX4OzRQG4TputCKR7i3UZA9M4iGz9umHQIe
        0SNVoHbzL+6/iYQ3E2sDWKqJRA==
X-Google-Smtp-Source: APXvYqxgLj386+NhihEkXDIpdXUve8mncnv4kKCJPtW//8AJeMuDL7yNLQ3rvwuzU8jzbvijFE8+Ww==
X-Received: by 2002:ac2:5f59:: with SMTP id 25mr1185447lfz.195.1578680547459;
        Fri, 10 Jan 2020 10:22:27 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w19sm1409068lfl.55.2020.01.10.10.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 10:22:26 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2A7A410144E; Fri, 10 Jan 2020 21:22:27 +0300 (+03)
Date:   Fri, 10 Jan 2020 21:22:27 +0300
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
Message-ID: <20200110182227.3gp7zgyd3fu7jzw6@box>
References: <20200108144044.GB30379@dhcp22.suse.cz>
 <73437651-822f-fcec-3b96-281fb1064cf8@redhat.com>
 <20200110134547.v6ju5dxazknfjdj3@box>
 <de70ec09-492d-292b-0738-db1ce1f05673@redhat.com>
 <20200110144717.xufpf4yjkjlngymy@box>
 <6cf49e65-ee02-7cbd-596f-ebbc057717c2@redhat.com>
 <20200110145454.mmgmtcy2zsrr63vh@box>
 <2f075639-c378-4bba-abe1-60d3c2420800@redhat.com>
 <20200110175519.myahx3tnxajt4eam@box>
 <1dfd6a03-c444-720a-17c4-049f5953acb9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dfd6a03-c444-720a-17c4-049f5953acb9@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 07:05:19PM +0100, David Hildenbrand wrote:
> On 10.01.20 18:55, Kirill A. Shutemov wrote:
> > On Fri, Jan 10, 2020 at 03:56:14PM +0100, David Hildenbrand wrote:
> >> On 10.01.20 15:54, Kirill A. Shutemov wrote:
> >>> On Fri, Jan 10, 2020 at 03:48:39PM +0100, David Hildenbrand wrote:
> >>>>>> +       if (!present_section_nr(section_nr))
> >>>>>> +               return section_nr_to_pfn(next_present_section_nr(section_nr));
> >>>>>
> >>>>> This won't compile. next_present_section_nr() is static to mm/sparse.c.
> >>>>
> >>>> We should then move that to the header IMHO.
> >>>
> >>> It looks like too much for a trivial cleanup.
> >>>
> >>
> >> Cleanup? This is a performance improvement ("fix the issue."). We should
> >> avoid duplicating code where it can be avoided.
> > 
> > My original patch is in -mm tree and fixes the issue. The thread is about
> > tiding it up.
> 
> Just send a v2? This thread is review of this patch.
> 
> If you don't want to clean it up, I can send patches ...

Please send cleanups on top. My patch is less intrusive and easier to
backport if needed.

-- 
 Kirill A. Shutemov
