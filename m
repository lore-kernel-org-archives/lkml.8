Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C90DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4EC72070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595892996;
	bh=M5y5yPoRScFn0avmFx0PUv/rSZEB8kYEuJj6CoKzupk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xe0fdJ1kP2igZEFZpgOYEY8tj4xoaT/45ZR7relskGqDoGTlgw+xXQU1EcfZCSgTm
	 1xCrn+boNhxz55LsmsIETnJXFILSJHLO1T/Lo8Wd5NZuBwiaMYhHjQFzCj+6PlT8YA
	 Uky1dqQLBHQhShhsjUxtDoPhIUeAzKICPBrUU4Bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgG0Xgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG0Xgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:36:35 -0400
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88DB82070B;
        Mon, 27 Jul 2020 23:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892994;
        bh=M5y5yPoRScFn0avmFx0PUv/rSZEB8kYEuJj6CoKzupk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DOo/8RPTmJJa/mH42oF5T9p4saUNB07dfybB46oyvT1Y1Ec8gD4a8OXz3W3R57Es6
         D/w2KazS8oyIs2caDAhilHLBcBSWYc/d3Yx74wItLAwHTG4ZMAvl5wqioxP6YWe9ML
         2yzU+YVhWRg8mC7m15n+HoBVjICnsZsPRJnklhW8=
Received: by mail-lf1-f54.google.com with SMTP id s9so9974943lfs.4;
        Mon, 27 Jul 2020 16:36:34 -0700 (PDT)
X-Gm-Message-State: AOAM531Uyz6+gAkgjvEL0yTExxTAvxO8oYwJxsalig4nRtdv/bujdR+t
        x9Ej7gpm4P3GyO977dTmzaEPGKYOuuQEy2knZck=
X-Google-Smtp-Source: ABdhPJzRE+h94iOUbPOItCaPJwhQRMtNwhrn9/1Z4iqVn6hBn0yS+J6G7uo1B1X6uZYNg3cKX7ml/gk/J/jSTgfGUnc=
X-Received: by 2002:a19:ec12:: with SMTP id b18mr12909920lfa.52.1595892992967;
 Mon, 27 Jul 2020 16:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200727184506.2279656-1-guro@fb.com> <20200727184506.2279656-8-guro@fb.com>
In-Reply-To: <20200727184506.2279656-8-guro@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 27 Jul 2020 16:36:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7HkvXti0Nz2YDLX6wVuctyxMA9RDnk2XXpScMZZsCcag@mail.gmail.com>
Message-ID: <CAPhsuW7HkvXti0Nz2YDLX6wVuctyxMA9RDnk2XXpScMZZsCcag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 07/35] bpf: refine memcg-based memory
 accounting for hashtab maps
To:     Roman Gushchin <guro@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 12:20 PM Roman Gushchin <guro@fb.com> wrote:
>
> Include percpu objects and the size of map metadata into the
> accounting.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
