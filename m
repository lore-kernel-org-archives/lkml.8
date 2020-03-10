Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFB3C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F910222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583876701;
	bh=TSDq+N2Xq2WKyqJ3qt/mNkLFgoX8wRRyVlS3iwmICTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aNpQin/Y5k+FOayVc3p9LH8vMb4ENU1SpI9ekVgkSvG0dkQE3j79eI77CpWtDJWav
	 iPienvS+dqatHMry6u2ufM5zcVmlsd1fpIt39yoT/2l1sn/Ibm+BoPSVUXdkHzSJxO
	 S2Zk0oPkRiHAbKiYiEHxw7J3ymclNfwE+tSgzuzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgCJVpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:45:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgCJVo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:44:59 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1EB6222C4;
        Tue, 10 Mar 2020 21:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583876699;
        bh=TSDq+N2Xq2WKyqJ3qt/mNkLFgoX8wRRyVlS3iwmICTU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kTqCUIINSdaOLvEUJkpfj+zxHUv2VmENXtessPZ2QSqtxfYpAq5PyMDLChRa7IqcF
         zWCZ64h7LizTEN6hwinBZyENwh9IZK7iYBqRcrgcRP0RKjvTgQ/FST6PwoOO1O5bEI
         SvcOgw+uYfTECt4ylGFXYIPw1avWaRF9zQ/eMPqo=
Received: by mail-lf1-f45.google.com with SMTP id g4so5916467lfh.2;
        Tue, 10 Mar 2020 14:44:58 -0700 (PDT)
X-Gm-Message-State: ANhLgQ24Tqg97JtRVTaZ6bI/MIqDQKpbJFQlcIFyzA1baEnH0H2dGIOl
        WW/GiqKhgFTEzUb1UKC6ImPuWSXbA2SLAGLNjp0=
X-Google-Smtp-Source: ADFU+vu7nX+XEEO/nQ4AW+W27Xd+L1WjEIY+gqS5q+5ZjLYcsx7c8VbunkpXowlwAg3B+R3iP2amsdG/f5u9tW/5B/c=
X-Received: by 2002:ac2:4116:: with SMTP id b22mr90742lfi.172.1583876696820;
 Tue, 10 Mar 2020 14:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200226221804.GA8564@embeddedor>
In-Reply-To: <20200226221804.GA8564@embeddedor>
From:   Song Liu <song@kernel.org>
Date:   Tue, 10 Mar 2020 14:44:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7tP3qfiY_kppSBBPXtNs27uGKcTsR9mZGULtQSCaNbQg@mail.gmail.com>
Message-ID: <CAPhsuW7tP3qfiY_kppSBBPXtNs27uGKcTsR9mZGULtQSCaNbQg@mail.gmail.com>
Subject: Re: [PATCH][next] md: Replace zero-length array with flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 2:16 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
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
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

For md part: Acked-by: Song Liu <song@kernel.org>

Alasdair and Mike, would you like to route the patch via dm tree?

Thanks,
Song
