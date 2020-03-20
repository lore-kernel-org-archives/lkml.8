Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24847C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE93C20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNh+7ws2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgCTHkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 03:40:55 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:44202 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgCTHkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 03:40:55 -0400
Received: by mail-qk1-f176.google.com with SMTP id j4so5876585qkc.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 00:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ku7qwHiv4AZSPNdmRrr8awe0lsh/dLBWtOgrxpXV/hU=;
        b=qNh+7ws2t++iS2hHk3cdNGcZPPGDY08PDxqnE3KcRQITjB+5iOC9lnRWwrFj7gLWKT
         rIvccmkA/Yr/4J1zI8riwhgz76iftHQtg5kdNIcS5AtWT8YEjPhlRtwtLZ4ksRUpHzA7
         fZoW3ZTq+Y54sr7zZuiIcsxPBACy1IIla7nBH7nCCWqOksrJRq5th8SuXO+GXPADHpfY
         ajnCXGQR3oWr35u2FfImbAr9Twfske2do5U28N8WeHD/cxZ8qGH6sv60/mTZrg0X3e4G
         2VUm8ltaZsPAgI1zAo15vXiWFfha4bqB1vE8vsCuVTHdQszMLQOzYXlKbccFuriujJCT
         ddBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ku7qwHiv4AZSPNdmRrr8awe0lsh/dLBWtOgrxpXV/hU=;
        b=kY8IGJ3H8YkiAjDjAyZYmMadoeZbbOVtNFhFokPuwr1nHqV64pkZoYmKUkCiZ48Du4
         WC0F5/IXCIPThB2A6tBJwoyIjiWWbb2j5d04irVLbCyDDqd18VXdPes43KHzCc0PsRwd
         5wfpBLaEvTcwuM7jx70WdAz20OrSUDgUYTDev1LA+sddFXIpgeYoKToSBM8/GIBZUtTS
         y/zD+XRfO5A4DJisxj+M33aXL7XYHKPS28yk9JKfqiOLeoRAozDsL5dEChRbEC5PF7/D
         DZGVYRjvln1K75YEPNbY4hEZaLSrasCdLegjjxc5rYlJWPViMtPVkSqQcEaWHaTf6ybp
         x2KQ==
X-Gm-Message-State: ANhLgQ1usK/C3sJus8/wG4yvCyIjdFgozKEeq/28Bj86xpZeP1QjvoAs
        Qfa0pcRPVR+pb5H9KFCsqedxWKD+wvwLwzvjSZI=
X-Google-Smtp-Source: ADFU+vunQpu+yReUVHUdAGT0ff+bFISOLphFku642HYW07MbagUtE2hcI52/EtAB0hFXwQFKScUM/eI4/Gda2TFlbRI=
X-Received: by 2002:a37:546:: with SMTP id 67mr6436299qkf.272.1584690053832;
 Fri, 20 Mar 2020 00:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <1584502378-12609-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584502378-12609-3-git-send-email-iamjoonsoo.kim@lge.com> <99196b17-24fb-8990-2d21-c459d2321747@suse.cz>
In-Reply-To: <99196b17-24fb-8990-2d21-c459d2321747@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 20 Mar 2020 16:40:42 +0900
Message-ID: <CAAmzW4NJd2kh8-81sYLjRR8gcsmLpndhS4s5Jh6kB-FLM-wNKg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/page_alloc: integrate classzone_idx and high_zoneidx
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 3=EC=9B=94 19=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:32, V=
lastimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 3/18/20 4:32 AM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > classzone_idx is just different name for high_zoneidx now.
> > So, integrate them and add some comment to struct alloc_context
> > in order to reduce future confusion about the meaning of this variable.
> >
> > In addition to integration, this patch also renames high_zoneidx
> > to highest_zoneidx since it represents more precise meaning.
>
> 2 years ago I suggested max_zone_idx.
> Not insisting, but perhaps max_zoneidx would simply be shorter than
> highest_zoneidx, while saying the same thing?

I think that highest_zoneidx looks more familiar than max_zoneidx since
it is previously high_zoneidx. It would cause less confusion.

> Also I wonder if we still need the accessor ac_classzone_idx() (before re=
name),
> or just replace it with ac->highest_zoneidx (or whatever the final name i=
s)
> instead of renaming it?

Okay. Looks like we don't need the accessor. I will use open-code.

Thanks.
