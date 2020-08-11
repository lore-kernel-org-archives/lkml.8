Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7C3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAEAB2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597128179;
	bh=3xx6c4zzK7ZLJ7li1HjrAVE6Hwda24Z+sgWp9kk47x0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=R8xxIEVxvmXizz+Cpb3gFx6E892ZSfn1tbGZTsViSWGOP6w72fmzTfPw75/LKkbcn
	 Gjw4TTTlv2jEbEds5xxRsvWvq553VE5POt1IDsHSkU3pds2EwkSdtA4acnKnGs0A2y
	 q4qmrGgZ4oDp1zkbs8iwSv1sxoLmHovAysxAoMzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgHKGm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:42:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42994 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgHKGm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:42:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so10359917wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3xx6c4zzK7ZLJ7li1HjrAVE6Hwda24Z+sgWp9kk47x0=;
        b=NUEE72wRKIkEbY5qV+kHbiZSz5SRD/fAwjvevVmUouPuuxdDWACFQ9rLxqXIaLdi6t
         j50xFssZYnO5YvQ09wBpFzoGQaN4CY0Okbd4fMvhqxi9+4u/PPspOWcoc6sMufVwuhn/
         udqWv0jF11Gg9BKdD6+7IctG+0tNXyU4OKIYWo/YRsrRu9piq6aP3AlUx0dl8IBc8Dkl
         b8BuCdUy6nesX+Dgol4bXb+2iEHfIQHRKsMVQFTJeFIkQw9oByKO5GNFZa81j2wry7VO
         1QWcHXe7fvcuT2mT15sljIVzdUTjWB4Gf/60VJQ/ALnydFjTiY4SXVUq3CSAH9p2Pv8C
         qh4Q==
X-Gm-Message-State: AOAM532fEtnxJ+eowFdiKI+ddaFGbybLcVqDEvAAhDKxLDOIMzMkegnN
        GzalMYsb7VYvTWUZjlCymE6Muk6FUPdUKAxZUjovBg==
X-Google-Smtp-Source: ABdhPJweUlEBXEverqx1sPmrVb1gKIVdPSH5KdkicNFQUCAetB3sWaRS/rOAOsFVeWcw7MJnUq1r14N9MmYHY15n3ho=
X-Received: by 2002:a5d:6584:: with SMTP id q4mr27708002wru.21.1597128176461;
 Mon, 10 Aug 2020 23:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200807164844.44870-1-dsahern@kernel.org>
In-Reply-To: <20200807164844.44870-1-dsahern@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Aug 2020 15:42:45 +0900
Message-ID: <CAM9d7chu8VOWfQv0dF89U6AaTE7VvwQDJj+V39cMp12k0Q1s_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf sched: Prefer sched_waking event when it exists
To:     David Ahern <dsahern@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Sat, Aug 8, 2020 at 1:48 AM David Ahern <dsahern@kernel.org> wrote:
>
> Commit fbd705a0c618 ("sched: Introduce the 'trace_sched_waking' tracepoint")
> added sched_waking tracepoint which should be preferred over sched_wakeup
> when analyzing scheduling delays.
>
> Update 'perf sched record' to collect sched_waking events if it exists
> and fallback to sched_wakeup if it does not. Similarly, update timehist
> command to skip sched_wakeup events if the session includes
> sched_waking (ie., sched_waking is preferred over sched_wakeup).
>
> Signed-off-by: David Ahern <dsahern@kernel.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks

Namhyung
