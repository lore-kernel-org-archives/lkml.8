Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A074C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6942B2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJ9kmuxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgHTBY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 21:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51335 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726603AbgHTBY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 21:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597886666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WjUMl2kvI2SWf67XAmHmBJUIFFn0OB41n2Xt50LZy2w=;
        b=XJ9kmuxvrAiYRspLUKsdqdjJAKmYavTFG/EKoQjNXvohuJRyOTmKk0ktZ+gefTKC5BQcFn
        YfDCJ4+nmYWrmjb9WLUETxJHGt1uOxr2O4WQIHOIpVwt9s8KbSlIldKQ3QrKPevh/jAkP3
        HPKG3Jwd44M9Bu8jXqviWXjW+wKn08E=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-fl3nxi5LPfOoyTuJ_KcpVw-1; Wed, 19 Aug 2020 21:24:22 -0400
X-MC-Unique: fl3nxi5LPfOoyTuJ_KcpVw-1
Received: by mail-pj1-f72.google.com with SMTP id oc8so266758pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 18:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WjUMl2kvI2SWf67XAmHmBJUIFFn0OB41n2Xt50LZy2w=;
        b=B2Lu77OXSJeqeokyYQRyTLGbdgGa+LeTQ8JkrmJmRZg6pjJ9SoKeQVDRRAk7LtX0xA
         F1oYF7Yts1FKdm0lRbDGI/YXis1ZMdZS/uyyQaAiSS0aADMvgdfWE0gH0tt71u+9/u9P
         58I2WDtsVoAlxFrAUE7VskicYtjqa8gaeAwgWrIypTbS2JKuEuYQWRlUPfCiK9pkzRwL
         vpsvdxWKipNN5ul4j6ZUXz4BzDfLm8aljFhG1yGUOnL3MPqwOoqpI96D6qDV91C3BBk/
         rSM1ut2fv1BCGR+3ixeQ4sjl+2YTnpjBg9TE+Kf5Lzko1W2K52LgfMImOC3QrDtMPMMa
         tlYg==
X-Gm-Message-State: AOAM533uKzbCdJom9o9sAo90iTrTh1IGcFCmyVNjmG/Lgji3JKbruhAO
        CydONtmvqmTWRIgoXiU8nUyRmmBJw+TnQi7y8PZYKdfc6UD0SY5mBR3JHPRfHVz5IRMZ+dqx9Wq
        z9+92mjCWHZU8drsksf/odlDD
X-Received: by 2002:a17:90a:6d96:: with SMTP id a22mr464526pjk.165.1597886661324;
        Wed, 19 Aug 2020 18:24:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznZQrOjFKArbT3Fe5xmkGGfKX9NSSvbVErYE0AQ15q2c+Bsrk3JIzM5qQom2dXOfnnMQ6c1g==
X-Received: by 2002:a17:90a:6d96:: with SMTP id a22mr464511pjk.165.1597886661025;
        Wed, 19 Aug 2020 18:24:21 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b185sm491513pfg.71.2020.08.19.18.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 18:24:20 -0700 (PDT)
Date:   Thu, 20 Aug 2020 09:24:09 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] mm, THP, swap: fix allocating cluster for swapfile by
 mistake
Message-ID: <20200820012409.GB5846@xiangao.remote.csb>
References: <20200819195613.24269-1-hsiangkao@redhat.com>
 <20200819130506.eea076dd618644cd7ff875b6@linux-foundation.org>
 <20200819201509.GA26216@xiangao.remote.csb>
 <CAHbLzkqr3Z0OuzjqrGjNX6kajr9J533FpqQd8zJYD4pjd+CGMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkqr3Z0OuzjqrGjNX6kajr9J533FpqQd8zJYD4pjd+CGMg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

On Wed, Aug 19, 2020 at 02:41:08PM -0700, Yang Shi wrote:
> On Wed, Aug 19, 2020 at 1:15 PM Gao Xiang <hsiangkao@redhat.com> wrote:
> >
> > Hi Andrew,
> >
> > On Wed, Aug 19, 2020 at 01:05:06PM -0700, Andrew Morton wrote:
> > > On Thu, 20 Aug 2020 03:56:13 +0800 Gao Xiang <hsiangkao@redhat.com> wrote:
> > >
> > > > SWP_FS doesn't mean the device is file-backed swap device,
> > > > which just means each writeback request should go through fs
> > > > by DIO. Or it'll just use extents added by .swap_activate(),
> > > > but it also works as file-backed swap device.
> > >
> > > This is very hard to understand :(
> >
> > Thanks for your reply...
> >
> > The related logic is in __swap_writepage() and setup_swap_extents(),
> > and also see e.g generic_swapfile_activate() or iomap_swapfile_activate()...
> 
> I think just NFS falls into this case, so you may rephrase it to:
> 
> SWP_FS is only used for swap files over NFS. So, !SWP_FS means non NFS
> swap, it could be either file backed or device backed.

Thanks for your suggestion...

That looks reasonable, and after I looked
bc4ae27d817a ("mm: split SWP_FILE into SWP_ACTIVATED and SWP_FS")

I think it could be rephrased into

"
The SWP_FS flag is used to make swap_{read,write}page() go
through the filesystem, and it's only used for swap files
over NFS. So, !SWP_FS means non NFS for now, it could be
either file backed or device backed. Something similar goes
with legacy SWP_FILE.
"

Does it look sane? And I will wait for further suggestion
about this for a while.

And IMO, SWP_FS flag might be useful for other uses later
(e.g. laterly for some CoW swapfile use, but I don't think
 carefully if it's practical or not...)

Thanks,
Gao Xiang

