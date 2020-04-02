Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1B7C18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6399F2078E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585815707;
	bh=qCyktk0ccXs+tfi3/6MES0x0+xzJF96PjKdqYw9cSy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a8x9e74QHnoDhXwSeYiUz80kcZbHJfvpITb6wPjdKZq6qzsr638idLE32KIcQCf5s
	 Qp4Tb2P1Yuv/ZTCoMs7RAFLXBrLHxnLGhQgtitCiVKCKHoWFzeOqGwh6A8ry3ltm5l
	 S7OmYCxFZ0D354vjzbBSiTvlMpA34Bt0DOck2bIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbgDBIVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:21:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35679 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387661AbgDBIVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:21:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id i19so2616184wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 01:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3yw/mZugffXhJm2+MbO9KEG1ll5RyPq6d+/bgOj0P7Y=;
        b=qL2mpmgJL89FXVIoIFsPbjVOV373A4m4slm69eSaeMQ8hF4YZnj7H2r9qmNnlrWE+B
         guJ17nHrE0/l1kfE4Xq75fpWyOCuNOvULyvgoomFV8enESFpc6eARQaePJFATEZsUmBk
         3CDS7VOTdF+su6vuZKhj2k4zluk9PO8EUlFAGYq9qUmrfLB7kJXh902KgvaizzCnisUB
         LdXjWzFetCiHM0Svpjg/MR5D/N1njlh5BIkaXspuqeBn0cUkpzpmqTuVshndxaMXVDDo
         I2kYCMxOASmE8hv/gwLm2ZU3QBO2c2UgdALBWzcSy3SuILWOz6LdkwCrXLxOiN17I75Y
         kxGw==
X-Gm-Message-State: AGi0PuYBgQZs7IOtmWzC9Xi/RP1QcjqVIwkOBizYfggn/ambawDU2n4G
        syN3ND1rAtZYLGIIe+gwb3k=
X-Google-Smtp-Source: APiQypIRgfJOEvtCzoD8kQfJBLr/c8mDN70xY0FqOj5l0qXDaIAfoDdbVoz3p1CjTuk7lH3y8Jq/2A==
X-Received: by 2002:a05:600c:291a:: with SMTP id i26mr2213291wmd.96.1585815704010;
        Thu, 02 Apr 2020 01:21:44 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id j11sm6086257wmi.33.2020.04.02.01.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 01:21:43 -0700 (PDT)
Date:   Thu, 2 Apr 2020 10:21:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        =?utf-8?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH -V2] /proc/PID/smaps: Add PMD migration entry parsing
Message-ID: <20200402082142.GL22681@dhcp22.suse.cz>
References: <20200402020031.1611223-1-ying.huang@intel.com>
 <20200402064437.GC22681@dhcp22.suse.cz>
 <87zhbufjyc.fsf@yhuang-dev.intel.com>
 <20200402074411.GH22681@dhcp22.suse.cz>
 <87v9mifgui.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9mifgui.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-04-20 16:10:29, Huang, Ying wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Thu 02-04-20 15:03:23, Huang, Ying wrote:
[...]
> >> > Could you explain why do we need this WARN_ON? I haven't really checked
> >> > the swap support for THP but cannot we have normal swap pmd entries?
> >> 
> >> I have some patches to add the swap pmd entry support, but they haven't
> >> been merged yet.
> >> 
> >> Similar checks are for all THP migration code paths, so I follow the
> >> same style.
> >
> > I haven't checked other migration code paths but what is the reason to
> > add the warning here? Even if this shouldn't happen, smaps is perfectly
> > fine to ignore that situation, no?
> 
> Yes. smaps itself is perfectly fine to ignore it.  I think this is used
> to find bugs in other code paths such as THP migration related.

Please do not add new warnings without a good an strong reasons. As a
matter of fact there are people running with panic_on_warn and each
warning is fatal for them. Please also note that this is a user trigable
path and that requires even more care.

-- 
Michal Hocko
SUSE Labs
