Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF0BC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 04:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D022072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 04:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsZjBy+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgCSENx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 00:13:53 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39077 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgCSENx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 00:13:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id t17so1184571qkm.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 21:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FR3/VUTQEwbV3Equ08fX7Xd6LvL5oS+tn1Zktb/fbUM=;
        b=dsZjBy+yV/MHGyz5H4PXiu2ITsQozof48sMccRt03te8oW+/WZdYJE2okHubS7KJIY
         LTUJ4itx6koLcFyNFyC910MaxSCCzqRpvQlj4AkYPh2mvLpst/DjrNAHmjHDcXJ++LJ+
         f6b5rU3X6IRNW/gnIe214uP371XyrYeu5srAsz0LUq0VYY6Pd+WJjNBPlDF+bvi9wYGe
         1d5p3rPRr9pQuvzC2DY+TKjY0SgomF2uc8u2C54xj+ZBINdCaHPzyiU5LkzRr+Os7MRN
         nxOCARkUZYFo1Iz7ksDQfNC2bTlwXEnMlHY7XydfnXzkzM4rO1ExvEJowN2DuZrb32FT
         zepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FR3/VUTQEwbV3Equ08fX7Xd6LvL5oS+tn1Zktb/fbUM=;
        b=bChHaAgb8rxyyPz/aKPVH5LRjGPzkKDDN9jZ5nu34frq9FJ1QmBsKNtcgLeqdoKD+F
         bAPV4jEQnTQExqr3OOGaepL9AT7ZrtFrlqNg99m9RL+WO1Q8owu+3F9ENvqylcsJ0Mnv
         hgiPWM5lRXEKPRxnvcWf/AoqF4qqelrq4aIeViOqw/tLX8MSN1sW2JyRg32+l1nsLuG0
         lk+RsQP8MpxE0AYTU1L955D9GQ7Zfom+pg+FbKNhQEKkSGQ6p8yQb/AYtzA4fv5T0qvi
         HVJ9Wcjf8I5nTuAZNajPqUVl9v6a2uJDIt57V0Su4IW/HOLhb+a0Kg7h7DmPCOzDgcrr
         M7Cg==
X-Gm-Message-State: ANhLgQ2Fsnf1hhO92mKhyt86ezz4o9p5jlN4EuiEf8bsrTpzOEV1rnqs
        aPKJLxW2JDkTuX3FZAGAlhGTgc3c2DiYk2ShuE8=
X-Google-Smtp-Source: ADFU+vsM5/749PP9gpl4I9DsMBvFPjATXrkV93kwzjUUmBi7jv9rppEgiNKx0AvqXBQmLRhWkSOx1cZCtntSY54pU8Q=
X-Received: by 2002:a37:546:: with SMTP id 67mr1136238qkf.272.1584591232221;
 Wed, 18 Mar 2020 21:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584423717-3440-4-git-send-email-iamjoonsoo.kim@lge.com> <20200318180638.GC154135@cmpxchg.org>
In-Reply-To: <20200318180638.GC154135@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 19 Mar 2020 13:13:41 +0900
Message-ID: <CAAmzW4NHqKfWcx3BKBthLeiKmx8f1R7sTzza3+O+6sjivBxh6A@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] mm/workingset: extend the workingset detection for
 anon LRU
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 3=EC=9B=94 19=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 3:06, J=
ohannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Mar 17, 2020 at 02:41:51PM +0900, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > In the following patch, workingset detection will be applied to
> > anonymous LRU. To prepare it, this patch adds some code to
> > distinguish/handle the both LRUs.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> This looks all correct to me, but I would ask for some style
> fixes. With those applied, please feel free to add
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks! I will apply all you commented at v4.

Thanks.
