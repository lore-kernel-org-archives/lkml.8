Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60323C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386392074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTeg4CPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgFJFNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 01:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgFJFNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 01:13:08 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B53C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 22:13:08 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id p15so486670qvr.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 22:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hLUoxt0yiIKouGw7/buAE5rk8hMNj3nZR/xKb2B/ppc=;
        b=jTeg4CPQ7s4h9Y4F7BOUQVHOAxnY8YXCxjC/UrDVy9eN4he3dh5AFSdg94P/oYYfeP
         dbJFi3RpFReQOhjJRvudpIken1Rzr11mWy0Hn/9l+SjQHJ3zBZ33sebrkLiwBZTfYAil
         CzTtAtWwvGi7JAkvTpsjR5RjzUeXkjkwK39HrJH89c/k3Q/ueAbt3dJtC/E+G1iauWEd
         nZaozL0GeaIOC4RyLqP2HhPMt5UZ3lHVp3SmZd51aei04H02KVo+K/Lu+t9Z11DOmIGv
         4k1xEqpoQ54wrkjzleSc9ykpZV88+iwlu567Urs0h7fdZRrGYbXygA6SDIJvqR8Xa02+
         3riA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hLUoxt0yiIKouGw7/buAE5rk8hMNj3nZR/xKb2B/ppc=;
        b=O5ZrvJpl+0g4fBBOkcbInd2U0tTEkrHfU1SexFSVuuUwar9gaHfsD2aI9STLBumUhh
         ucX55wFJe/KFHLTZe5mbVa4qVl73jiJALAG+rB8GbbTP6EY///JT9ErM3LXtVA50mv14
         roiuiJoh/zoBp/CO2knhKgSeVPehnjDCd3HAsnDBP5PH4wTEM5HgCzkVZ0g378QsN0rD
         4vbOIYNz5w9Ee2qhWouGEK3SZehNpFRSCWOOtr18REQk8msRz5MqA9nfn7bm32/sAu6k
         J4AxiBfcjdOxHxEdiWjZltHNrEjDLFsZYRLPPg9h/qR/HlNtCHNLdtGrp4KQXqGsuVQH
         5paQ==
X-Gm-Message-State: AOAM532Y74PL3kDbVO9WR5VI4qqgHuuPmxyXM/AS82GNPnJ4H8zueZ9J
        D5/7DbUfyNvl69wpnooy2VYqEhVQNip+WZ7+CJMWrQ==
X-Google-Smtp-Source: ABdhPJwueE8ZjMW1bpMs2FrKsGnGX0T6gYMQdn2T3ghIBONhrFPd8wQC8+4GwNFV8+CzuFgJdOp/zChta6l90nzMsVo=
X-Received: by 2002:ad4:4368:: with SMTP id u8mr1472220qvt.227.1591765987012;
 Tue, 09 Jun 2020 22:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1590561903-13186-8-git-send-email-iamjoonsoo.kim@lge.com> <20200609135431.GI22623@dhcp22.suse.cz>
In-Reply-To: <20200609135431.GI22623@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 10 Jun 2020 14:12:56 +0900
Message-ID: <CAAmzW4Ou-65wW2iHFDZdOYrEkb2afrSox7sVwd1zEo-VXSE30Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] mm/hugetlb: do not modify user provided gfp_mask
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 10:54, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed 27-05-20 15:44:58, Joonsoo Kim wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > It's not good practice to modify user input. Instead of using it to
> > build correct gfp_mask for APIs, this patch introduces another gfp_mask
> > field, __gfp_mask, for internal usage.
>
> Ugh, this is really ugly. It is just hugetlb to add __GFP_THISNODE as a
> special case. This is an ugly hack but I do not think we want to work
> around it by yet another hack. Moreover it seems that the __GFP_THISNODE
> might be not needed anymore as pointed out in a reply to earlier patch.

If you mean __GFP_THISNODE handling is ugly, as you pointed out,
__GFP_THISNODE handling would be removed in the next version.

If you mean introducing __gfp_mask is ugly, I will try to use a local varia=
ble
to keep modified gfp_mask rather than introducing a field in alloc_control.

Thanks.
