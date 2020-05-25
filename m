Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9343CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB45207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590396564;
	bh=5qd4JhElAe3z091uS7e1GwYMBB8ObuPCQBDSxEgdKVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jZPhFhopEMk6BD3G9W2Fvox/T1/KKoR4SwIZmk60X+23y7nCuZQR5rJ6xwD25xpG0
	 rBguLsnGwr3w/OgRn8kCwKvpcVbyeO7+bT5PkGA2DjfuxG4SDKZm1QhM/dchXbES4Z
	 0jVkY6fm9Bvp9vSrNJXVGBbd1If6GF1W3Pjx7PBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389328AbgEYItX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:49:23 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:42965 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbgEYItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:49:22 -0400
Received: by mail-oi1-f171.google.com with SMTP id l6so15447015oic.9;
        Mon, 25 May 2020 01:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qd4JhElAe3z091uS7e1GwYMBB8ObuPCQBDSxEgdKVQ=;
        b=LXU9Fo5RGtzNk+9BrnDFd0pmWSXZRiUn6QQGQ8TVkWqbuUp5n57jdOdnG8776h3vRk
         QXeQrPWY3Q6B293ScWXnaAvWxh/nfgQ80BqOVeq2V3TuwAl0GNEahTQd7HfkTQ47JDwX
         H96xeA7BO3nj8v0j4D7YXK+5I0YC0N6mkFxlOeMrJrkTKtlzVabkwbyfhKO7ULA2evj2
         ZVp8D/M1SDXCJvFXrWnCn8pA8Lq1jtRyAs4h430hgjs74szsjLG5FyIvuhfOmJiVOtRr
         m1X9PbuCPuXMgbEOVNuUrWrDbQ0Sn8fJ7J8Rq6JyGoItG4XuI9nsxNVEvAtPk1bFg2aQ
         6mBw==
X-Gm-Message-State: AOAM5314O82UfF4Ck1ocrsGqu1CtXS93t8O1c0dHLB8LrhqM+w3j0DL1
        UfLc2asjKmxlqKS8gprQAH9kkLJFYiCbaIJ+NHESJw==
X-Google-Smtp-Source: ABdhPJw6Spt4qqKfu2lRfdhTsKwOc4XO0GKpo/Kd1MOA5Wn8wzEu38xyveRCXSUkPYZZWyOce0+T4n6Uo42MYkhp4I0=
X-Received: by 2002:aca:4254:: with SMTP id p81mr10082895oia.68.1590396561724;
 Mon, 25 May 2020 01:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <7bf4d518-5772-9615-f925-8f9af4751d10@linuxfoundation.org>
In-Reply-To: <7bf4d518-5772-9615-f925-8f9af4751d10@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 May 2020 10:49:05 +0200
Message-ID: <CAJZ5v0jDUvLuq8Zhj+Dx_=rd75Y9mg28yDyX76=mrQoC5bqAhw@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 5.8-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 1:15 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 5.8-rc1.
>
> This cpupower update for Linux 5.8-rc1 consists of a single
> patch to fix coccicheck unneeded semicolon warning.
>
> diff is attached.

Pulled, thanks!
