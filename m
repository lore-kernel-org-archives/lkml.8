Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E3CC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA43420721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="H02JMG8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgAJOy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:54:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33087 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgAJOy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:54:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so2462790lji.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 06:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SIr8YjUlHXwroCw7JSyezNjS+8rrWXmTvnkdQl1GRZY=;
        b=H02JMG8k/CsF40jcBWeJH8di2gQR3VJUngbt04jtkSXT33aLg7YIwhtE7GSR1girlo
         7jj2BlN3aM2B/M7rnWO8SMEBsfpb5int6DVFpWyaagSh09+dpLLuhfXWg+BHZZaj+fDi
         GTPL84VPhu4Pc1M8XCpW7L+6hnCGKiQZzzeS2Ry3F+tr2Te5ppFT8jTJcPu+yksk46mT
         mIXtL5L29NINfDBevNH8uUXC2sE8MzUBTrLCGy/132gDocs/d/EVdKVcELDpGNQvycip
         z9hKV5W6J1DDffrFHv336ZPyc6Kc9bLqYfIwHTVDjZITPoTqzXAeP0zCAp01fKMXquf0
         b+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SIr8YjUlHXwroCw7JSyezNjS+8rrWXmTvnkdQl1GRZY=;
        b=GdOsMyMNyQ+RIzYwoHgLsqMD4VKZbNBwb2vhAl+dFfzbs9ckcV3/glSy9JBnn5GAio
         48wkdfqv19mmo7gF2V4O1gM5Oo8Z5RHo4otWrWC4E5Pr20OhSmV/JZa9Z2skJOAIM0wM
         6iRvRV8a6h9XpsgW/AsQJ+cD4cfBzWtVK1SVyFW/ibTm/bkAI30h+es4DrGbzxs4oSve
         /boi3l7rJDMI9ItU6iIVVMGr1lYEGFWaA3cOVib9BblbJXN8N6gJrP8VnLefUuwLEv44
         opzHfndd1v5EQDm5vz5tbCRRgVtcxk2a0pWlKtzGCtHPX1qxDZx9WgtIlHQ8xWWebefa
         IwVQ==
X-Gm-Message-State: APjAAAWtj4+4+wDd+KRXdTFwRAQIKdlfVZGeQSx50+et0D6+tSqfXtMz
        hRIGJYDQxK7mPsHwq05T90Cc7A==
X-Google-Smtp-Source: APXvYqwFUfr/JO3laFVMUUcUEgIU7jfdmhle2+BHKv9pbpNkcc1QHW/uK0hL4xi6f6FfjnhxM9NtpQ==
X-Received: by 2002:a2e:914d:: with SMTP id q13mr3034950ljg.198.1578668094480;
        Fri, 10 Jan 2020 06:54:54 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b17sm1098592ljd.5.2020.01.10.06.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 06:54:53 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4D4B9100C65; Fri, 10 Jan 2020 17:54:54 +0300 (+03)
Date:   Fri, 10 Jan 2020 17:54:54 +0300
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
Message-ID: <20200110145454.mmgmtcy2zsrr63vh@box>
References: <20191230093828.24613-1-kirill.shutemov@linux.intel.com>
 <20200108144044.GB30379@dhcp22.suse.cz>
 <73437651-822f-fcec-3b96-281fb1064cf8@redhat.com>
 <20200110134547.v6ju5dxazknfjdj3@box>
 <de70ec09-492d-292b-0738-db1ce1f05673@redhat.com>
 <20200110144717.xufpf4yjkjlngymy@box>
 <6cf49e65-ee02-7cbd-596f-ebbc057717c2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cf49e65-ee02-7cbd-596f-ebbc057717c2@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 03:48:39PM +0100, David Hildenbrand wrote:
> >> +       if (!present_section_nr(section_nr))
> >> +               return section_nr_to_pfn(next_present_section_nr(section_nr));
> > 
> > This won't compile. next_present_section_nr() is static to mm/sparse.c.
> 
> We should then move that to the header IMHO.

It looks like too much for a trivial cleanup.

-- 
 Kirill A. Shutemov
