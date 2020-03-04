Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3972C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7722820828
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHrZLvAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388094AbgCDUpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:45:30 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40623 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgCDUpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 15:45:30 -0500
Received: by mail-pj1-f65.google.com with SMTP id k36so1442657pje.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 12:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bSssoW6aFVtYbqfH2RQfHGPyl30tcb1D7T0IFzp6CiQ=;
        b=wHrZLvAte9VBOVY1o96UtBWoPp1ikUjEojHSDjOxtEbBQ7U3yONVGuEruSLMWYhwhI
         q+iSE8ArSoDUE5cxh/3eNyyBmYM8CDIjGHICFoQlFIunjSF8GlNWqHRlmwKcx8HXb631
         kJcM5NIauzZDt17vhBzDcSmQCXDDNhoaG8DqO46SmgdZvPknArsV5a7KzIm0vb1DTDWt
         /sHKASxd4Xiez8aFydm0594os17orXKGBmD3tRimTGrK7Wo5ih1RTI2Cemg4rhTFRwjq
         FbjERSDJNnJcc0FAeNiWQj9p5XYyrdZPd2+J/NK/stuQL8Cs+32C1vM65GwMv2hr6uZV
         8f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bSssoW6aFVtYbqfH2RQfHGPyl30tcb1D7T0IFzp6CiQ=;
        b=n15BDtQ0Rk3gPTOM4NcWVJFCYwUP8Y8JS+z9Vj1Gq2D2B4Cf5N9GW3hrRS7IpVCTQh
         4Qnaa2ISe7cZcM+NIg4oWR+os+ycFlIsuTjXGiLa2CFScFp7W6GQj23TcApoOprccMDS
         BV5hspgMiRzeoPpfaMY/2UgGH3tUbjHQlkZYbMAJdbn2er+XzR5nbRyiEROoufwgRI9Q
         UUfpBqef/XPhPl+UJiowVzay+j8DqAzE+UBkkrN5RRLuvAjfs2logIB2egLzg7rfXcK+
         WSIsBb7jeOXShs1MuxyU4NU48V7lR/ZSi3ck8mNCKZwlCOqlJh8RL1u79KpmFRCOXJla
         07Xg==
X-Gm-Message-State: ANhLgQ0rFaxDmiJTDGAnh/0U5ED6eYVUno7x/oS2V6Ha/XenBiMjByyt
        qwvnNkIva6T6kGtFIZ7pkCJPiA==
X-Google-Smtp-Source: ADFU+vvbCvj9+Tk7UslBowQCU89mQmq5dKR8f8wr3FcdkxVmhP+ZrVXcL8z26ro0YUT/N8AmGvg6vg==
X-Received: by 2002:a17:90b:19cf:: with SMTP id nm15mr1503230pjb.69.1583354728838;
        Wed, 04 Mar 2020 12:45:28 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id b9sm528776pgi.75.2020.03.04.12.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 12:45:28 -0800 (PST)
Date:   Wed, 4 Mar 2020 12:45:27 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     David Hildenbrand <david@redhat.com>
cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -V2] mm: Add PageLayzyFree() helper functions for
 MADV_FREE
In-Reply-To: <d7dcb472-76fa-9d8b-513a-793a7ab8580d@redhat.com>
Message-ID: <alpine.DEB.2.21.2003041243100.260792@chino.kir.corp.google.com>
References: <20200304081732.563536-1-ying.huang@intel.com> <d7dcb472-76fa-9d8b-513a-793a7ab8580d@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020, David Hildenbrand wrote:

> In general, I don't think this patch really improves the situation ...
> it's only a handful of places where this change slightly makes the code
> easier to understand. And there, only slightly ... I'd prefer better
> comments instead (e.g., in PageAnon()), documenting what it means for a
> anon page to either have PageSwapBacked() set or not.
> 

Agreed, I think any changes to clarify what PageSwapBacked means when it's 
set and when it's clear for PageAnon should be in the form of a comment, 
likely in page-flags.h.  That's currently lacking for lazy free pages.
