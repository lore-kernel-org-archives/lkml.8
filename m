Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95BAC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A1320721
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dwTJpY8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgAKAXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 19:23:33 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44240 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbgAKAXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 19:23:33 -0500
Received: by mail-oi1-f195.google.com with SMTP id d62so3459063oia.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 16:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7WnWXCuaXczv3MiKg1HktA0VJdofgPWH6v/BLugYfyY=;
        b=dwTJpY8W88ILCg4RZPT1PHuOLNHodSeC86S2F1AcOTylKcPfXVEM3xEG7uGPmlsicp
         TbUupKQDLgoA1CzAY8pKnHxJ1UUlrsPa6zVDc3gsxOsJAf33c/qEBfRT5e1g33O2kiPK
         235Loh6sjOsv35abGw+qwvLy4jnEa78SokGTGi32ioPyGN9bTyCML2yz8V9jdplcuxUY
         YA6u6z6/3+z0Y49EZETjrg7+maM8TvtTDglvwHHW8rjyKJomhnDavsieYa6D8imca9cN
         eXjKqtTxotMKuOE+KEuu0CzIpcSl/qojIMZXM4RAk4h1LPGF9s5M/278XusbCkEC28uG
         r6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7WnWXCuaXczv3MiKg1HktA0VJdofgPWH6v/BLugYfyY=;
        b=LAtRG7xX6Zg8l/KwtzvImyUJ8MpPmgtvo/nQjK+7kEAIhqcpOPog1CYPcAYvOqJpDl
         LsxNln8k9HzQSkcMKcYOxhQwlW0bARdr5qVyffv0r0xJsFO1kV2R3z3JlO/VqxFUnqp7
         QLIuKhcIjVvMfcNd+/XqPNlFGIuXjR62n/Bz/g+lEuTnI0hlADzWsXPHelZopS4zzMBy
         RkI/qdXZEMv4NMpSvWSx+gkD/XQe2lxvx6/l6qBtIH8hCMTTHkwitlwvs388IgRPV1Dt
         8Ica6EW/f1GLqJR1LLpFu4uzv3TTFuY+dGqFh4sIYz3XydwMVtNHz0oJWKQpF8BiOSzi
         i4xg==
X-Gm-Message-State: APjAAAWS/7eAhp82BQHsAX9/itNUBjcfTvyvCUTsZ8CutPejJbTo1tmd
        DVbf+DEWvgezaE/p+M0R8SILxh6BPeMtYZwzNs0fFg==
X-Google-Smtp-Source: APXvYqzOZL/Fh/KXvLkiAsFK7v15sek1ylGb0cch0sE9occd0VS7wYKT4fOAMaqbxxxvFlELF4JWfSHK063aP/+SDFA=
X-Received: by 2002:a05:6808:30d:: with SMTP id i13mr4240155oie.144.1578702212099;
 Fri, 10 Jan 2020 16:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20200109202659.752357-1-guro@fb.com> <20200109202659.752357-2-guro@fb.com>
In-Reply-To: <20200109202659.752357-2-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 Jan 2020 16:23:21 -0800
Message-ID: <CALvZod6ecqAKd_ZDgEbHJh6w_s3p5742QYVrBwZGPr4EUsR43w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] mm: kmem: cleanup (__)memcg_kmem_charge_memcg() arguments
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 12:27 PM Roman Gushchin <guro@fb.com> wrote:
>
> The first argument of memcg_kmem_charge_memcg() and
> __memcg_kmem_charge_memcg() is the page pointer and it's not used.
> Let's drop it.
>
> Memcg pointer is passed as the last argument. Move it to
> the first place for consistency with other memcg functions,
> e.g. __memcg_kmem_uncharge_memcg() or try_charge().
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
