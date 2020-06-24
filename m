Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0D8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039C020786
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d99eV6NN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbgFXBnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387780AbgFXBnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:43:52 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B56FC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:43:51 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c21so412002lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RASqUJNJKvi6chUPf50pDvBaP0SIK/nJTpfi9HQbRPo=;
        b=d99eV6NNNCeJtLrdvMkmv6RfrH9h0RXAeaTwY+g3iMP82JyHE2TYD+IMeKjCD8petd
         Dn+gtS8mYS4ph8B0PFpoSmrCiygh1KbY/GxbIqlM8CHtPrO8iWFgZWo9qi2zCM72Tg/P
         ipPKq6Bwr0+w6jD+k1IseAToDc962FA96nOUjqVNn9nwiW0VLd0Kvwg+23HW2Pe13gro
         w9tO6YYbXpkewp8zlnLJuSZSBFU+VWFG04IrMeLJvzUgjSaw1WnAssbZUWCT8R+8gyv2
         Z0NSWD0Nzf5R4Sv/ssINpuchFrHiWtyjhWPiCdyWIU2ltsmGM59pZHxrkyAglKKMy7fl
         SQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RASqUJNJKvi6chUPf50pDvBaP0SIK/nJTpfi9HQbRPo=;
        b=ZdhScV0SfW7Wa0uXbGncp6x6yX3+m5QpKOIAM43g0LPIANmVjvgq0Itng3OxmbymoO
         kG3PaofvQR+AI5FPuLDedUYcIOhSLKAnkdzKSSwFGJS7d7PoLCWjVJF054rPg0QUI1KG
         t7yqvRFk3TBRI6asH/fEBqkwxErdyUPjs+8JvTGyJEhBP3CBnI3r13dv3AgfDE3OVoXv
         5qLW9htTqx8Z7hi9fz3d0bXVeW+IjJnfu6NmA3i/dfVBFhskA2LVzFtU0B6Cl06ZUh62
         GGH0yk/l+vtc89AHsmjNNcKIm+br7Iue+MNT/FpodcTLh16lLDOIPJ0GNZbn+o6IGLPa
         5Gdw==
X-Gm-Message-State: AOAM533Gd2Mrt+ZZW0Fr1RSDkqNVNAcizEGUX4xh9/laAv/ynzvSRtIw
        95zOqPzJbk8UIOnxZGhtvEJbMYbqc5bILsUUY44iFw==
X-Google-Smtp-Source: ABdhPJys23/+YRk8+SWODCOySRzNS6wzVDGMHd5o0Sx6XZMCYCGNhQs7SiVfRrJce26QPi4Bs7RcuMTmiR/nZOLO6yY=
X-Received: by 2002:a05:6512:482:: with SMTP id v2mr13935646lfq.3.1592963029804;
 Tue, 23 Jun 2020 18:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200623174037.3951353-1-guro@fb.com> <20200623174037.3951353-11-guro@fb.com>
In-Reply-To: <20200623174037.3951353-11-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 23 Jun 2020 18:43:38 -0700
Message-ID: <CALvZod6bShcP2X0W=UmY_oUzXuUdPhuQJviL6rgBYOqvLuf=Gw@mail.gmail.com>
Subject: Re: [PATCH v7 10/19] mm: memcg/slab: deprecate memory.kmem.slabinfo
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:40 AM Roman Gushchin <guro@fb.com> wrote:
>
> Deprecate memory.kmem.slabinfo.
>
> An empty file will be presented if corresponding config options are
> enabled.
>
> The interface is implementation dependent, isn't present in cgroup v2, and
> is generally useful only for core mm debugging purposes.  In other words,
> it doesn't provide any value for the absolute majority of users.
>
> A drgn-based replacement can be found in tools/cgroup/slabinfo.py .

tools/cgroup/memcg_slabinfo.py*
