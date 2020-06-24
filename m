Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF493C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4B92137B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gq7KSZM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbgFXBgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388228AbgFXBgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:36:06 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6144EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:36:05 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n24so707655lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7pIjJ2I8CWHvSXRl5P0nw8Gdno7bPM7de/tvxRqaCFg=;
        b=Gq7KSZM381qbz0Jl+qP97fH800pxovHxWOnBpx1iufZGWbLoRKOjcozMUvJtqM+su/
         W2721W4kzQuK5yyfLxMtbvTi/uPJU39TMmSiqYJWbPmdZyeXBaPjxDSnZF6QrPYn4UqS
         YYBSmjmnZU0pambP/0j27dtj3ivrt2l6jNoApO/6mxarXJ56iV4Cxu+dFQucHzlDWw3k
         /Y/OsKJJZC8c0A3sqKAneGqGwV4Z3qxgV72+4XLPZXuDr3Y9N8IrfX5V+yB/E1tnV0DD
         U9R9/7/ckT/5oa0aLN+AO6APOmPbQVus8sgCjIijuyu2pM74TAT8Y8WFSlO3j9txsFF1
         TRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7pIjJ2I8CWHvSXRl5P0nw8Gdno7bPM7de/tvxRqaCFg=;
        b=RjJSy4Tip65FvtzUeGFPs/Rbw8HNADLsZqd9mWBnRRLRl34wYrGyjUNOjarvloLcHP
         sv9R2WLaJHgDvglPNOCoPf2Hxkk+/FChwnbz6SgbNREtt9Tfouc/qIT6S3W03ZemsX48
         4U+5KcA7b7cAi+LwHAaDvBtEZKD0C0q37Yo37SgDQz41rfk9htnF5kXLwozRX/1TfXo+
         0xseJn55f2k9lPUcO5zcZBGRCgWiurlvaYoRKll960UzXD0i9BfMsSei887ozZ2aEnJk
         ivKWnB2dafk/0LdAhbfMG59Wl4VIHy9nD0irUr1ngjOIke/onlXKe9e91OcNvaPVi6qJ
         AoQA==
X-Gm-Message-State: AOAM5330DvQLUgzHj5txzUuhpPKz2DUNRZF2S9btl/yVCxwqWAE60/zP
        mwb0936J4rk1YJIhpNGC5KnUsAIDWMddyRAi+LepCQ==
X-Google-Smtp-Source: ABdhPJyX/XZZ07bjXY9YxEuQSJag1qcS/Wpx/76xl21f5ldw4T6ZWTcEtT5g+hMU8xIso2qD2sPVP4AO57c3Qyr347k=
X-Received: by 2002:a2e:9395:: with SMTP id g21mr11389976ljh.58.1592962563653;
 Tue, 23 Jun 2020 18:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200623184515.4132564-1-guro@fb.com> <20200623184515.4132564-4-guro@fb.com>
In-Reply-To: <20200623184515.4132564-4-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 23 Jun 2020 18:35:52 -0700
Message-ID: <CALvZod5NWqfdCq07mPBVUG1ZVzjaDDEnCzz3+sH2O3nMf0Zrzg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm: memcg/percpu: per-memcg percpu memory statistics
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:47 AM Roman Gushchin <guro@fb.com> wrote:
>
> Percpu memory can represent a noticeable chunk of the total memory
> consumption, especially on big machines with many CPUs.  Let's track
> percpu memory usage for each memcg and display it in memory.stat.
>
> A percpu allocation is usually scattered over multiple pages (and nodes),
> and can be significantly smaller than a page.  So let's add a byte-sized
> counter on the memcg level: MEMCG_PERCPU_B.  Byte-sized vmstat infra
> created for slabs can be perfectly reused for percpu case.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
