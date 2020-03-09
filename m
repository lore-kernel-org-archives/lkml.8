Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72915C10F28
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469FB20727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7eCoXwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgCIJ3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:29:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37893 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCIJ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:29:10 -0400
Received: by mail-lf1-f67.google.com with SMTP id x22so7057873lff.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 02:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/x3bOS8+EQ730wvwzViwYAyxSIAy+Gqe4DlDcCBFmac=;
        b=e7eCoXwJn2Jq3avlPXDgQK9Rx/D9sv6dMMc8asjsu4JqGIdjFQ3+Tvma1SXSOhr7YI
         gQznjl6GdDgBkjgwCtHbuqrUoNwW+q1mYBZlXjqVLNH9OtaWlHwrTydkv/lBF9uMCHLo
         /2D0ERQdHCCCHUQ8MgMPH6ocbKoE0iD+vAgs4Feiu2PU4KEU/Lk8dU3I0jDfk4fnsdP7
         Cc88vNqxKVhDyZP8ACw+iid8ZvAxTgEioqBRlvDYEi633fqtmjmvJxUgjkvwm4+Maftd
         otTV8ue5JmmtIS4Es8BgpsbROdUrHq0Fe7jt2BevM2NF16Ty6aktOTSgqE+GGnH73Dt2
         Z3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/x3bOS8+EQ730wvwzViwYAyxSIAy+Gqe4DlDcCBFmac=;
        b=bx10sc+ggDF4DZAH/bMSBXAfbZj/9ZTyQPLs0T7g83Sh2E9pn6jFtUIkBNCsNRZrEs
         NWe9rt/u6ELlJ+Dpp0Xfp6ZOmuM3lF2w8mU7rU40w1zbZzpXIBMXgG4YLt/Rc6BfSD3d
         4C3STdCHBiJa8vPRWl698yuBSrI9+ciiFcjyLedPortvEN7bMVuUn0poHB9O4lfNL5Qd
         8j2UeeAq/SuYCuxoVu6sDmChMCMUgg5t2fWB/PuxkrDcR3m0+w69ch0qsliHu8gL8TSL
         y5Y6qd/BH/aYRMpLzYs8z5n8ruS0Ly3wEosFIJoPM0GrFORp1FNa16CNs3redAI7P3l7
         ek+Q==
X-Gm-Message-State: ANhLgQ1OQKsnwBi6O8fBEFm3BMoT0ur/bSvngw1gdLemBj6oZ2HEOUXr
        E4vioyXIAJRaTCg8ZF2/m7JqsgQYt7N6CNFSjhyp5Fye
X-Google-Smtp-Source: ADFU+vsM0JTR3ANUQQsabsuZJsGRykwEGIjqSJXt/IVH98XX9FTs6BBkjNP3H6lsmBa6je9qc6mHr1lZrLe8Agh2tcQ=
X-Received: by 2002:a19:f503:: with SMTP id j3mr8990215lfb.77.1583746146910;
 Mon, 09 Mar 2020 02:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200305182245.9636-1-dev@kresin.me>
In-Reply-To: <20200305182245.9636-1-dev@kresin.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Mar 2020 10:28:55 +0100
Message-ID: <CACRpkdbBao6ij4SNDJso2X0q0gbU38PQu0DUtWk+QyV7KW4njA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: falcon: fix syntax error
To:     Mathias Kresin <dev@kresin.me>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 7:22 PM Mathias Kresin <dev@kresin.me> wrote:

> Add the missing semicolon after of_node_put to get the file compiled.
>
> Fixes: f17d2f54d36d ("pinctrl: falcon: Add of_node_put() before return")
> Cc: stable@vger.kernel.org # v5.4+
> Signed-off-by: Mathias Kresin <dev@kresin.me>

Patch applied for fixes with Thomas Ack.

Yours,
Linus Walleij
