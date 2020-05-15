Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C3CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D49206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589533486;
	bh=UyzUCdDrt5R2RkXVxXBajSJEoj87ZemtdIH/0a2QAKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SpDaIphCYKBA4Kc5YS8JZit/AO0g/bCKV58cabMWP8ShofZPuMM1iAOfvPOa5q/Vj
	 8oBlwcqEK9w5yNR3R707xgyqjgSbf5NffZEAFWq9h6rtslGHmj7M0d4aVA+D5tl1j+
	 yTKhjSJP5T23Gqxfd1nLhmD//OB3jWhfM3EPwc2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgEOJEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:04:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35742 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgEOJEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:04:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5so2644586wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 02:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9QDVZDXZoqSloGv08GEy2MAxiYOaCzJPvgAYS9OutzI=;
        b=RPKej9ipQyAOWjB+MJh5te19VycKFWmhJ1tftvjBczoSNPVZFW60Bm3pJ3VlfFiD3f
         Z6gd0z75HnUdGpcSHM8oYkjHLXKCVreLG84SDWz5sGwo/4NZymNliKel0k6sZbW8qh3t
         vQ0tbFuvXnNP56b+dfbWRXr6V2ZQAI/cfa8CZBxe4Cl0wxJNs/1qxJeJxeiCEtvUuDlN
         v0h8/A+PNDsyRFaNxY7sOn6JxW0iQAr4KU1mjK9aRNlTieR+mfEK4RlYkGTpmZhLiZOs
         /L8LmpwldpVqEMPMEBr59+An5M1GQH1Bf1fstUNTaW25+ye/IrLJmtSAUeclS0b2ZvIU
         HV2Q==
X-Gm-Message-State: AOAM533kNr7zXWeQgBcbxL+2NTpft740xpAyuNHmi8cCHANN3zNbDdGq
        hMBLBdhV1SwSuDvgzlR6sz4=
X-Google-Smtp-Source: ABdhPJy6OuUYUgPiVAlIah3CMGMVQCvfBn1TKTEVWtRuHvhUaoWQqy0w+nQkgDhq3DgMc1Ml/o1Vjg==
X-Received: by 2002:a5d:530c:: with SMTP id e12mr3313165wrv.271.1589533482726;
        Fri, 15 May 2020 02:04:42 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id m3sm2547773wrn.96.2020.05.15.02.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 02:04:41 -0700 (PDT)
Date:   Fri, 15 May 2020 11:04:40 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm/util.c: make vm_memory_committed() more accurate
Message-ID: <20200515090440.GN29153@dhcp22.suse.cz>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <1588922717-63697-3-git-send-email-feng.tang@intel.com>
 <20200515072307.GG29153@dhcp22.suse.cz>
 <20200515081109.GD69177@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515081109.GD69177@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-05-20 16:11:09, Feng Tang wrote:
> On Fri, May 15, 2020 at 03:23:07PM +0800, Michal Hocko wrote:
> > On Fri 08-05-20 15:25:16, Feng Tang wrote:
> > > percpu_counter_sum_positive() will provide more accurate info.
> > 
> > Why do we need that?
> 
> This is a preparation for patch 3/3, which will enlarge the batch size
> of percpu-counter 'vm_committed_as'. Andi Kleen concerned that may
> hurt the accuracy for those readers (currently only /proc/meminfo
> and hyperV balloon drivers for status check)
> 
> As in worst case, the deviation could be 'batch * nr_cpus', and
> with patch 3/3, that could be totalram_pages/16.

This information belongs to the changelog.
-- 
Michal Hocko
SUSE Labs
