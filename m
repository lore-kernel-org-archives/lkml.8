Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D3EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5D7206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ZvrfzlZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404715AbgFXQKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404531AbgFXQKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:10:22 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D95C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:10:22 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id t21so1891404edr.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLPAvbq/jeYHfg7FTd3eSHmjKk2usdkzJKthmaiXIo8=;
        b=ZvrfzlZNgIA+onZZAlqnmU1RPQNYcGK0AJ0sANVmYurFnqexDQH84xBGPSwIkrakti
         mFQTbpuFJLke0gP1+xA5KoTwMuBxllumFrO7SqUu7X5FbglbrRJSI8HZ0yMFxhrMW6ar
         hi4cCFCRjEbaQ9fgYypDD5zHzqbcn0rHcYB2PtRsFQCaCSitzwliPwcdRylK3Z2TTrE2
         TsKVqQvMjx2bIBF1IjVF9LhxdzjilJqgWgKhWHw1G/fBrlUf8iqS8LGXH+47xrpc5/td
         cl2EnMSeaqZcjzoH+XVvN+XSUXjbBSqJZUQ16uvQv5ewo9CPxMVhN5yJPTHQAPxDLsrv
         Hgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLPAvbq/jeYHfg7FTd3eSHmjKk2usdkzJKthmaiXIo8=;
        b=er1xsQ38XRe5Ld6iNVf7PrZgzSjFTain3qlqvaJ/gvLgT7PSnT6Fas3ictVcvVSi1M
         RPb0TSDY9Mh3YgfnVI4hdFnLkGyanfRuXfS3O9AA2ZNfaLZJnVovbEX9Ui3QEvn/rolA
         xaB3I+MPe0GfxeCfM1ay32tHN+CNBiW1PgyXLczKxN3LqRcBQR66375r/amq6BOwaCEM
         vYE9D3m3ZkjSnsUlLaDXgwLZ4VgYOSz3zTjywo9eSxgUMxqOrdOGAo3rv4tG8xIiUlJ7
         GK0VOAEY+hHZqT88DQFqcDaAflIYMhAeaQiPV3hib8epZwgCXioEedusgpe7Uhr/uQEZ
         Xu+A==
X-Gm-Message-State: AOAM533rNQDlkaG7Rwy2Jssan/mUIMsDFo0b8FFB6sRn9Ux+XMlIH3yM
        8pQtR8j7SKh8PhWxWNm5uVho3lPNeNG0d6NZyOB24g==
X-Google-Smtp-Source: ABdhPJz/LyWML2A9O3eOvChFMF2pj94Hmc0Dil9jdAodBK50RG9PbNs6c/xVBLGE3keNaEpKfeXrqt1z700nztWRtPk=
X-Received: by 2002:aa7:d043:: with SMTP id n3mr3899927edo.102.1593015020879;
 Wed, 24 Jun 2020 09:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
 <20200623151828.GA31426@dhcp22.suse.cz> <20200624061340.GA11552@L-31X9LVDL-1304.local>
In-Reply-To: <20200624061340.GA11552@L-31X9LVDL-1304.local>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Jun 2020 09:10:09 -0700
Message-ID: <CAPcyv4gEUq0yyz00AbQQSyo_acj1wUCZPse5vEff_Bq7GmeksQ@mail.gmail.com>
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>, Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:14 PM Wei Yang
<richard.weiyang@linux.alibaba.com> wrote:
>
> On Tue, Jun 23, 2020 at 05:18:28PM +0200, Michal Hocko wrote:
> >On Tue 23-06-20 17:42:58, Wei Yang wrote:
> >> For early sections, we assumes its memmap will never be partially
> >> removed. But current behavior breaks this.
> >>
> >> Let's correct it.
> >>
> >> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> >> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> >
> >Can a user trigger this or is this a theoretical bug?
>
> Let me rewrite the changelog a little. Look forward any comments.
>
>    For early sections, its memmap is handled specially even sub-section is
>    enabled. The memmap could only be populated as a whole.
>
>    Quoted from the comment of section_activate():
>
>        * The early init code does not consider partially populated
>        * initial sections, it simply assumes that memory will never be
>        * referenced.  If we hot-add memory into such a section then we
>        * do not need to populate the memmap and can simply reuse what
>        * is already there.
>
>    While current section_deactivate() breaks this rule. When hot-remove a
>    sub-section, section_deactivate() would depopulate its memmap. The
>    consequence is if we hot-add this subsection again, its memmap never get
>    proper populated.

Ok, forgive the latency as re-fetched this logic into my mental cache.
So what I was remembering was the initial state of the code that
special cased early sections, and that still seems to be the case in
pfn_valid(). IIRC early_sections / bootmem are blocked from being
removed entirely. Partial / subsection removals are ok.
