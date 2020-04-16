Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACB0C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C615920725
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ/+6uUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbgDPBam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbgDPBaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:30:17 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B983C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:30:17 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r24so6025700ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8xFtf2O/rL/WIr7oyJJuxQp2aXJgl2Dd99kFiXV1KM=;
        b=iQ/+6uUCtwZyZ//JZbSuMrVBoG/GZ+Ft7Oh2SIRBGKS5hDeftNDSiNz7IpIBW6QS9D
         vn3TCpvcsHORaxFOWrL3OqWKA1eMM50ueicfcEgsESuml6duhm3MmYPGLsoWG3qzRXkT
         y+wvTrZqfTXqeEPT+pOGEmJDwCU1sdIJT6Hz92lEZu5oPNbESXZJjp1MpHfsTbZfdakc
         HHVj2UMQi1sPAsGK/t/crNDl38nfWZ7cWoOi7UveAnPKioPit4TvDe8FqKCxxHrvGHjM
         FhU4/kmt0i1K9E3XSp5glB64T15x+kKnz0X57HmxN9/ng2us9lyD8Bg17kwTFWMBKqVQ
         hFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8xFtf2O/rL/WIr7oyJJuxQp2aXJgl2Dd99kFiXV1KM=;
        b=Bl9ruAJeM+qQjpYGsbSPJw4aqnW8T/rDxYLUJ/KRzPD4sICMVX7M72ULYQFb0+SVHw
         JB57p9gL74emP2xNTRCUBuxlY/OD/ocHNeJ603vDyx4Y6XH8HX7zXJG4Qtw2AG8AcKDF
         S1pO6G/PehHD4A4ynV47czdYDU76i2XOMDgDx+j7lc1YPN1DpuwVMkaAzCQLw43WKEu4
         PHnRqTgSuBgWr7i04A6k3HXPEeH/3K+oW1BocyEyhybGxuIfYj3IIyEvRlh7jggwrmKP
         apn/k8NsyaVbORADGmdTAZS9eN8hyz0Nhq5ykwmHYGwtKBfk3s0DKNjxLeS98uS9b9oQ
         Rd2g==
X-Gm-Message-State: AGi0PuYTw8Z9YxQndkt2iZSyeLTAkSEjATTn4Oek7ejcChVjkjxfbdKQ
        K8rlVOPSal5rzFc0DwF9oFrwE/zfPpUu+81SRAQ=
X-Google-Smtp-Source: APiQypJCxdBT41q9hezBo1+xLbB9VsfBygbJ6hE/4CS5ylv1NnFddxHOcliaLALk9a+tsO0Yrrm8xTBV1OwgUnWU3Lo=
X-Received: by 2002:a2e:7807:: with SMTP id t7mr4918437ljc.203.1587000615751;
 Wed, 15 Apr 2020 18:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200412090919.GA19580@open-light-1.localdomain> <64985d09-d11e-5fc0-64b0-b56ef514448a@linux.intel.com>
In-Reply-To: <64985d09-d11e-5fc0-64b0-b56ef514448a@linux.intel.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Thu, 16 Apr 2020 09:30:04 +0800
Message-ID: <CA+2MQi9KHbw5fJZ4pZJYbcKU545rhM3bPddCJjupmJZCGqHqaw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] mm: add sys fs configuration for page reporting
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 11:02 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On 4/12/2020 2:09 AM, liliangleo wrote:
> > This patch add 'delay_millisecs', 'mini_order', 'batch_size',
> > in '/sys/kernel/mm/page_report/'. Usage:
> >
> > "delay_millisecs":
> > Time delay interval between page free and work start to run.
> >
> > "mini_order":
> > Only pages with order equal or greater than mini_order will be
> > reported.
> >
> > "batch_size"
> > Wake up the worker only when free pages total size are greater
> > than 'batch_size'.
> >
> > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > Cc: Mel Gorman <mgorman@techsingularity.net>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: liliangleo <liliangleo@didiglobal.com>
>
> I am not really a fan of making these configurable globally. Especially
> since the existing virtio-balloon is relying on some of this being
> configured the way it is.
>
> It would make much more sense to push these configuration options out to
> the registration interface so that the thing that is registering for
> page reporting can configure them when it is registered.
>

Agree, that's better.  Thanks!
