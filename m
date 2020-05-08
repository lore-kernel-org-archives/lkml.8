Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F6BC35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34571208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588898870;
	bh=o+XMYnph7WnUvtJzgSjnkfel0bcIVqkZCQcAyXf7X8w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jm+uorg9IusbLX1r4dznzT0t0NRcQOr5A6u/Ux4i9C44qLLoK7+6fB/DpHGGKdBL6
	 7kbfXZjbxSSMPmskA/W2Hr7jdLYEatFvsIqyvIfKSC9nIHrxnOBROJahOjFBTE1hW1
	 4rp8gyPtUXn5dKYpl9II8yAXKeq4pOHU2UErIbS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgEHArt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 20:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgEHArs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 20:47:48 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 392C4208DB;
        Fri,  8 May 2020 00:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588898868;
        bh=o+XMYnph7WnUvtJzgSjnkfel0bcIVqkZCQcAyXf7X8w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MRyKEnLCgDOEJAbR2QHtq5uH5cC3ds7OS0vSSpGdIWKUrlY5Up1fCDhounYXrbKZM
         tSbeRvZdsK8RK8bdNji3Tcot8wOcPydqqeK+1Q7BQ9K35Ms/Q6wK9XilKGISQYwXuI
         6nrfNCi2g5rpI2hbjM63pxfYtU39Po7ggeLiUH5Y=
Received: by mail-lj1-f180.google.com with SMTP id u15so8386393ljd.3;
        Thu, 07 May 2020 17:47:48 -0700 (PDT)
X-Gm-Message-State: AGi0PuZXPFNKqvbf4TQQAVzxBuKMTWvVbxxGL9O8I5rPeoFERwBA/IK9
        X5m6mxmNs1ZCTxPqxPjUNgebaq6SMuTehMwcj/w=
X-Google-Smtp-Source: APiQypKWc38MeNE3gf0ZtBnSHyBQT4+vbhnwvgfpeWBVwKm33L2xKJsqjFGnv2W4jRlbv5ZUQNg7CbdahZ2nkror/Fw=
X-Received: by 2002:a2e:a552:: with SMTP id e18mr10194682ljn.113.1588898866412;
 Thu, 07 May 2020 17:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com> <20200507214400.15785-3-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20200507214400.15785-3-guoqing.jiang@cloud.ionos.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 May 2020 17:47:35 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Z9MfS_yFbPaC7Mc8+rMkL3e_m5N_P=6bq28TLXYQpuw@mail.gmail.com>
Message-ID: <CAPhsuW5Z9MfS_yFbPaC7Mc8+rMkL3e_m5N_P=6bq28TLXYQpuw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 02/10] md: remove __clear_page_buffers and use attach/detach_page_private
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, david@fromorbit.com,
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 2:44 PM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> After introduce attach/detach_page_private in pagemap.h, we can remove
> the duplicat code and call the new functions.
>
> Cc: Song Liu <song@kernel.org>
> Cc: linux-raid@vger.kernel.org
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Acked-by: Song Liu <song@kernel.org>
