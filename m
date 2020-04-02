Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93EBC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2F9206D3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585808844;
	bh=59ql0wrVh8+/YhVHfDq4kUISDkedKi4JDAeMoVGC/iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qrvl0a7+1wwz8mo8pdIioJOugTPp6hJ4ITx6VUz373Eh+qTnzfeGTujuY46aCkqM5
	 5MtzNg0ZWiBbIyP+2feiRySqapyRbCliGUcsAIbSgRnKo0XOc7SFV6x4aC8hnls1BG
	 Ukqr3MZxj3EHTS/zEQHPYQ5kPrd7ZhZglDwztYZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbgDBG1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 02:27:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35533 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387431AbgDBG1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 02:27:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id i19so2301492wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 23:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IfLSMTLTvFoZT1dG8FvLcXK5lHsPjnFY8JvpK5zcfB4=;
        b=p1Mklz5otWxF3C6uwltY0477oqxyTQtBXqekpNj8JRCWY5eCAwiU/5+6nW2XrmyErz
         LanvAt7ReePnJiKE6rRDjvkEyh3AJYg213Q52AEcSMt87HqrGmWk96zKTeIWktHpDsZT
         yTshrRRT4oJqZXvFGgMl52pZKcXTHVBbODlT0om0mA3Xcx83Aqpgvc4Ykbg/re35baKk
         EVkQHUNqdH7i99DslxUXMAsv0xyz7e0VTovGkWT5VIQB+jOyXY2F6V8l6E7gv7BRQd1w
         V7CKk/xmrzEcGJlTP4+AoltT6a8cx6lt0tJhDPTWdEp2hh4eI09vL0XQWCPZSaVyUaSP
         7Xng==
X-Gm-Message-State: AGi0PuYOFik5Vn7QiGhTW5zWhJkH4CPXnWyvwYs+ckyvnrQrN0XJQZbA
        lrkOG/mhui/FkmB7tBGv9Gc=
X-Google-Smtp-Source: APiQypLCmObbZHMa6hacnQUpup7IVI8EkFLyfmjFSFj3sVOOoLer0cmjEyb2LuDkAo0RAWWCKogzVw==
X-Received: by 2002:a1c:7e43:: with SMTP id z64mr1714424wmc.45.1585808839220;
        Wed, 01 Apr 2020 23:27:19 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id q8sm6709154wrc.8.2020.04.01.23.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 23:27:18 -0700 (PDT)
Date:   Thu, 2 Apr 2020 08:27:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH] /proc/PID/smaps: Add PMD migration entry parsing
Message-ID: <20200402062717.GB22681@dhcp22.suse.cz>
References: <20200331085604.1260162-1-ying.huang@intel.com>
 <20200401160432.855bba5b210c7b4bbf6c56ef@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401160432.855bba5b210c7b4bbf6c56ef@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-04-20 16:04:32, Andrew Morton wrote:
> On Tue, 31 Mar 2020 16:56:04 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
> 
> > From: Huang Ying <ying.huang@intel.com>
> > 
> > Now, when read /proc/PID/smaps, the PMD migration entry in page table is simply
> > ignored.  To improve the accuracy of /proc/PID/smaps, its parsing and processing
> > is added.
> 
> It would be helpful to show the before-and-after output in the changelog.

Migration entries are ephemeral. Is this observable in practice? I
suspect this is just primarily motivated by reading the code more than
hitting the actual problem.
-- 
Michal Hocko
SUSE Labs
