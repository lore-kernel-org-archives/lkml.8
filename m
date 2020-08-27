Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D069DC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A701920872
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CdW/Xrj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgH0WC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgH0WC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:02:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37173C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:02:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g6so8144767ljn.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIteJ0nAuEK7c0jrgV/TY1J0yNIYT1Aa4FeQ/EkIGNk=;
        b=CdW/Xrj6rL6bkuN/g50aFJGI6xoJ+5T49vg1wH+aQYG5ODhBGVczIbk++rbvyrDGYR
         zXgdKvxaprEO4CLFluIBYv2y5NaeHOL1Eacm//imWbUs6873VwtRMAnIfHL26juyLg17
         qPiN62Oq+Eo0JAmULNBvMD9zvjsnhjUd+sLnJS0ypKOdb3vdvON1ClkSg/es/aj9txbM
         SuU5Xb6OOrjF7hd4m8389kqNE50hw/xI9JurBZFe066RBsnP3Oy6b4qIZPkpMjmSoUW8
         AB60oL9F+J3vyBy51nrVCkj5az5PocK+MV6gAZ4HR1xzF+yAtr2PihQl1lgr8fOLfUjW
         q7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIteJ0nAuEK7c0jrgV/TY1J0yNIYT1Aa4FeQ/EkIGNk=;
        b=J9+5OjQ2/FeLcBUs7USmltSOcGmDaU+OtUhRnqEu82VoNSh0t9JM1BAn1n9VLs3eAJ
         AMTQ9i0c2zgi4+st3oT7mAA1VgWGFUn60Foogl0ItyezoJwDWeRd+wK2sWGaooJ+DcfF
         GTgW+8jFcO6GsDgBUAmK5WiXZ7OgldXuCTF4CODA3WtoX8PdUHrb+DG+8erUcBP4m+Hw
         csNYaoJCc4rsyFA1rA20d+jrTCp7ZCB3/52+Oo+GFPVdQ1A+cAiwfj5fTBVJ/xT5oiFY
         l4MEB27nmA6vswrcI0zBzrGYW1d8i1yL7+haBCrw55rKW8yI1AomWMvJR7AN+F2olgIC
         nxSg==
X-Gm-Message-State: AOAM533nxB70XAiiGXWQC7NPwyY+VItd9TlSOLP/zlp12lTo+4TA53K+
        FRNpLlWYlCdUjAvBYyDmE1GCkad4KAEACDqick2qUg==
X-Google-Smtp-Source: ABdhPJz/5eAda68Aw3Kbkm+VrYPMRlunF17/JtlXd79RvIfiphEtJwwmiqJCRK30ZKlQW2dhhF1hEdaT2WgqHZVd/ic=
X-Received: by 2002:a05:651c:233:: with SMTP id z19mr11044590ljn.347.1598565775121;
 Thu, 27 Aug 2020 15:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200827175215.319780-1-guro@fb.com> <20200827175215.319780-5-guro@fb.com>
In-Reply-To: <20200827175215.319780-5-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 27 Aug 2020 15:02:43 -0700
Message-ID: <CALvZod4RrNBnr3+sWZybUoovYJcGe0TS8i_G+ymgAoV9KojU_A@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] mm: kmem: enable kernel memcg accounting from
 interrupt contexts
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:52 AM Roman Gushchin <guro@fb.com> wrote:
>
> If a memcg to charge can be determined (using remote charging API),
> there are no reasons to exclude allocations made from an interrupt
> context from the accounting.
>
> Such allocations will pass even if the resulting memcg size will
> exceed the hard limit, but it will affect the application of the
> memory pressure and an inability to put the workload under the limit
> will eventually trigger the OOM.
>
> To use active_memcg() helper, memcg_kmem_bypass() is moved back
> to memcontrol.c.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
