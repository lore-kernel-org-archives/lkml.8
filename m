Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2977C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A803620842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="pzPqUCaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgAJNpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:45:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35110 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgAJNpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:45:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id j1so2211696lja.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 05:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sMdYXYMVS7cRrddfmjCZFkKAH1VKFwTqwzh9JCAXz3M=;
        b=pzPqUCaJLWaz/7wBdutwYJL0ZPJ655iIRXGBeBg0KwUzzokEOMPJ3KQL+uP4NRwhp4
         t1EpK+CONNUtkFcnfQegpyQrffFuztUfxm8D45KcA5siHagGjRFE74tYh3V1MHszpfbo
         EKndhwn6cHW7xPn5mIsBZLOXZoOhVzilJWsmnQhLE+XoJHL+jol55SAdC7UnrU9OhiyT
         hSaoinZiRU/l6gFTPCO+wbMWkSMO/Iq5teLULZ0hqegzOyH5NDE33e+k3ETCAG669F2x
         +xD6WvLhxyfrqboug0IzGKUyZ94PMq2lh3l73eICULfHX+rlnjwB8k/WfjFUKp89aFfi
         WyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sMdYXYMVS7cRrddfmjCZFkKAH1VKFwTqwzh9JCAXz3M=;
        b=X+PEkLBJR5l4e9ZXqq2TyIaOHjoUbDTiW8FOnTf0/thirtEGikfPR8vo5/ZyPq3cMx
         8Qvyi7EHc2mWrjFR7+SQ8CkYbasv+L1fzKkNBHF87XedNF2rG5GESe7YGPdm6pzyJGRJ
         hdxE+f3PBJARnV1k83XOo763+qd2PIBCF7cj59p192+hHnI8B3AaQ134Hw0AKLPnEp1q
         Dlx7VqieKrSw+n/3eUjWUuZ/pYkQArkEKJmXTgbymqfEGQ2Shenq1jIWi8jP/Yq0xvvB
         EE3SVXuSUGPeO1Tqc+t6NLyw3VB+FbAjLcjUwdwsPU2u5/Hj4CNJsJH6rFmxjs5FkxDu
         xl/w==
X-Gm-Message-State: APjAAAV9D9LzjFNDehkWMetiwkYiW5enwFL3b9stI4JoNrlwo7rn9RzJ
        9L4G15X+eFdTt5LlgrNyXrPp+w==
X-Google-Smtp-Source: APXvYqyqXd+YM/fERFV0tcUWKo1oDvb7oiPTlSCZnH/zmqCgGxZz2UoXgHoX94/CGmanCodSgLYSHA==
X-Received: by 2002:a2e:9c04:: with SMTP id s4mr2779471lji.147.1578663947404;
        Fri, 10 Jan 2020 05:45:47 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c189sm1062491lfg.75.2020.01.10.05.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 05:45:46 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 189891010D7; Fri, 10 Jan 2020 16:45:47 +0300 (+03)
Date:   Fri, 10 Jan 2020 16:45:47 +0300
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
Message-ID: <20200110134547.v6ju5dxazknfjdj3@box>
References: <20191230093828.24613-1-kirill.shutemov@linux.intel.com>
 <20200108144044.GB30379@dhcp22.suse.cz>
 <73437651-822f-fcec-3b96-281fb1064cf8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73437651-822f-fcec-3b96-281fb1064cf8@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 02:15:26PM +0100, David Hildenbrand wrote:
> On 08.01.20 15:40, Michal Hocko wrote:
> > On Mon 30-12-19 12:38:28, Kirill A. Shutemov wrote:
> >> memmap_init_zone() can be called on the ranges with holes during the
> >> boot. It will skip any non-valid PFNs one-by-one. It works fine as long
> >> as holes are not too big.
> >>
> >> But huge holes in the memory map causes a problem. It takes over 20
> >> seconds to walk 32TiB hole. x86-64 with 5-level paging allows for much
> >> larger holes in the memory map which would practically hang the system.
> >>
> >> Deferred struct page init doesn't help here. It only works on the
> >> present ranges.
> >>
> >> Skipping non-present sections would fix the issue.
> > 
> > Makes sense to me.
> > 
> >> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > 
> > That pfn inc back and forth is quite ugly TBH but whatever.
> 
> Indeed, can we please rewrite the loop to fix that?

Any suggestions?

I don't see an obvious way to not break readablity in another place.

-- 
 Kirill A. Shutemov
