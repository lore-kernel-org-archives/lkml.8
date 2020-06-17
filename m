Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA577C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8224220888
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHDEFFc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFQPzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgFQPzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:55:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A86AC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:55:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x18so3518536lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+rzqdnz8r3FAqXWwD1gDVePdUHQDJi/4YgwPQMfMFA=;
        b=SHDEFFc789vRYeW1su2Gaa8bZ+QIDqGELGMbXne2rOAla35jtL8FX73T2NXQHskY3h
         6hc2UDPyaQ2YqQircog+cI4jNEOVGlVfGh6jrYWBEFkffTeAuWDll25swry/t778LTwU
         GvpxSODR6Lbwfu4Ylt8yAW11JYZ0dGlw/M6PfBvOXk44Wl/zcBwDWA9K1O+JiCHMapnc
         OexX/f6ORWFBGGXc1eZ36asCHwoMLiP0cHPsAmjirFOol94jug7hM4dixnP8T3gkNE1s
         jCGXOeV8ZNheEOSjWn6y3RPlrEVDkVuxgbHIuz8zuRhVQNWpjMeMCLYn8Tp6qj4OMnal
         8feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+rzqdnz8r3FAqXWwD1gDVePdUHQDJi/4YgwPQMfMFA=;
        b=VIKWcUb5/A61vid1SsLb9N1pB6D+mUqVnr1y/qfX54AKF0j3KyMV3wht/sX+7dbB8M
         N+ClKuGfJusIoSqYDdOWcIM74fHnKSSYoIlNjbcqt3OykS1BK9byG3kyO2Oyhh3gGlAc
         9YENF3BZW3+gGf7xiY/kFapDDEt4LDY5f5Llrc/3VPWVsJmmbocRg7t43b6/3wfyCzuv
         iFclHEsrJjFY/wq8PATQsFK3DHPXS0HJ9Hlv8T9RI09NlwIes7z6p8xuket/WgsVNyse
         /vTME7egcsZSs1NFdDSTTXWqMgy98zrdb/rAYtjgzCx1nF8NZ0ssgh7pVwD4eHP1XVMG
         nfgw==
X-Gm-Message-State: AOAM5338GD3t9LME0fjBRbHlkmZA3gIXgJ1xbYYyaQGUCZUCfuVtP3Hk
        TriAViUzJ+OJE1/UOwB4oVq2nHj9uXopdKcl3+h8/Q==
X-Google-Smtp-Source: ABdhPJyFhfn2qdOtcu73QdZkHzTrokzYqN5wBiGecH2VRaWa2n9acLfwuRxjivsjawol+3dNCv3nZCVpDFATIMu2jDA=
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr4496325ljp.347.1592409333511;
 Wed, 17 Jun 2020 08:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-3-guro@fb.com>
In-Reply-To: <20200608230654.828134-3-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 17 Jun 2020 08:55:22 -0700
Message-ID: <CALvZod61ejfKiHRGNBQHKCyWbLr_DrRRzUQh7WVXJYSUu-098w@mail.gmail.com>
Subject: Re: [PATCH v6 02/19] mm: memcg: prepare for byte-sized vmstat items
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

On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
>
> To implement per-object slab memory accounting, we need to
> convert slab vmstat counters to bytes. Actually, out of
> 4 levels of counters: global, per-node, per-memcg and per-lruvec
> only two last levels will require byte-sized counters.
> It's because global and per-node counters will be counting the
> number of slab pages, and per-memcg and per-lruvec will be
> counting the amount of memory taken by charged slab objects.
>
> Converting all vmstat counters to bytes or even all slab
> counters to bytes would introduce an additional overhead.
> So instead let's store global and per-node counters
> in pages, and memcg and lruvec counters in bytes.
>
> To make the API clean all access helpers (both on the read
> and write sides) are dealing with bytes.
>
> To avoid back-and-forth conversions a new flavor of read-side
> helpers is introduced, which always returns values in pages:
> node_page_state_pages() and global_node_page_state_pages().
>
> Actually new helpers are just reading raw values. Old helpers are
> simple wrappers, which will complain on an attempt to read
> byte value, because at the moment no one actually needs bytes.
>
> Thanks to Johannes Weiner for the idea of having the byte-sized API
> on top of the page-sized internal storage.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
