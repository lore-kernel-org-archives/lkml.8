Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F08EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B502054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589396839;
	bh=6ic+6n1wGdR4/pvLTH/MP65+OfXLiPfd9XYBKnzj5LE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kuyxA1bzti1MD1R8ff5oe2MW/iUiBxBwC7X+TYNUD8NCkGA7sPp49RPyeGhQvQ8V9
	 0wN/sBji5seLiVJuV09nOsWQMGiJ1TyAJjLnKpx+VDyDrMD+FrmVs9VNNyTyk04f/K
	 vJp6KgdrOSj8mfpQPEPLg6OrV3dmnlFO33+xv6Yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390277AbgEMTHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732218AbgEMTHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:07:17 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20DB12054F;
        Wed, 13 May 2020 19:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589396837;
        bh=6ic+6n1wGdR4/pvLTH/MP65+OfXLiPfd9XYBKnzj5LE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EBccvFjgyFZKOaGw8K7zRaf94Y0GYjmBm3DVxnG/mr99sytI1GEXGGKNw4h1testq
         YAXlpbUlELnBw+zbEXKgNTYCv0DWPQ++h5wrBnqJCFQZKmFrf1MHkGFqn6URrD1VCb
         X8sLenn4g31EV+qEfTegBWcSzb8rseKCo48bNsoc=
Received: by mail-lj1-f172.google.com with SMTP id g4so830654ljl.2;
        Wed, 13 May 2020 12:07:16 -0700 (PDT)
X-Gm-Message-State: AOAM530Q2aiSgi1JMAXi6o0n/3IsLjfLZE3GLQigXM2lVMT2Ana1ItaB
        EocEJMtZ+cY7uZqvcBo+I07hPc7Y/MMRWL2TmXE=
X-Google-Smtp-Source: ABdhPJwhjKXZi/3px+fkVHMw+xlVjv1OBZRwcd2CD1ekChseDXAGim42sSfrsnEAiUSt7Io9FYoYMR4DfNKC8IhTYnw=
X-Received: by 2002:a05:651c:1025:: with SMTP id w5mr331990ljm.113.1589396834316;
 Wed, 13 May 2020 12:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200507192209.GA16290@embeddedor>
In-Reply-To: <20200507192209.GA16290@embeddedor>
From:   Song Liu <song@kernel.org>
Date:   Wed, 13 May 2020 12:07:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5auRH2K5YyxGL6P4sy7hugF1N2s3AVj7GYOj_9EWKmFA@mail.gmail.com>
Message-ID: <CAPhsuW5auRH2K5YyxGL6P4sy7hugF1N2s3AVj7GYOj_9EWKmFA@mail.gmail.com>
Subject: Re: [PATCH] md/raid1: Replace zero-length array with flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 12:17 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>

[...]

>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to md-next. Thanks!
