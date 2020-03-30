Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8E9C2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C61206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AulWHQzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgC3MeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:34:17 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32815 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbgC3MeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:34:17 -0400
Received: by mail-io1-f67.google.com with SMTP id o127so17518721iof.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 05:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ugYRzz9x1UjGNKjwYYI17qia2N9XHsI1pN2vBIoW4mc=;
        b=AulWHQzIHdpUZnA2sbkDfxfUjyOfSvu6RazWKeyE6oqreSfALk5Y2vXA2kQ2/ZtBmW
         XL9QQtIGnuzHC3n2SVWQQ4RbUEYFYCWmwSiWln3Z+xTe7CRgmxmQXivx1qb5ocRvAa8c
         eqcZ25hP0Vx3sd+pgloyAKEUJ8v8t9HOVHD/jZ0z9ibyNourLGJ7/hP6QIwR02B4qWu6
         +PyGHV1rYNU2zT7NHv5h9oe2NtTF0K4zUQQYwM3zNOIfvB+2fZl4G65UhvhKBaBJPtfR
         nEjqdo7Oogn0QNgP9AJ/xa5G/SXIeOUY6ZA8pFzRy0ShUwfBK/vFlEKBOm5KKAnOyJbj
         X24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugYRzz9x1UjGNKjwYYI17qia2N9XHsI1pN2vBIoW4mc=;
        b=uDNn+rRA9lsBosor+tvqT4yNLOFSJDjPwtEXTcOUzfGSuOT31vSrsMPPZhw1XoW2ng
         HYvrha9po+4kMjEA+I2BzXIi5zJGlCPlCnS6xdC3N6pHNXGzNLCLAnt04bDXNyLmaDCk
         OK1mf/IYfPSD/YNoqYmf+kjdMBZCX90Y6m8mWomrQSU63JhwPoQY+mEin6VuUXh8RKJS
         NHYb+ufqN4EY244VKgcGNY0vBBire+7yaeK+zLihcphYDsNwGWJ6FY9rx4zvs7xazKzJ
         gw6ne8jg1KegjrwOTyJmJ8KecJzaa4y4suGcUaVQ6ybCQ1lXhUH6MrxZ0nigCMi0FIBJ
         y/yg==
X-Gm-Message-State: ANhLgQ1uAVMgd5u2sAGJ1LUhivgBIvq9sepylQsa0rSlQ/LGem+dwa2I
        fXqqbtW8QUmqVJhmFXY5Nay8F077qiPZEp36UbY=
X-Google-Smtp-Source: ADFU+vuJ2Fim0LqX//6fvtgqy0RzQBRtW5mAL/toKxx/E1bUAIyfGNfzuWQoO0GVaXic4F3UMLxIDDTCSuxXedtjGTo=
X-Received: by 2002:a02:455:: with SMTP id 82mr10525540jab.112.1585571655651;
 Mon, 30 Mar 2020 05:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200325090741.21957-2-bigbeeshane@gmail.com> <CGME20200327075458eucas1p2f1011560c5d2d2a754d2394f56367ebb@eucas1p2.samsung.com>
 <4aef60ff-d9e4-d3d0-1a28-8c2dc3b94271@samsung.com> <82df6735-1cf0-e31f-29cc-f7d07bdaf346@amd.com>
 <cd773011-969b-28df-7488-9fddae420d81@samsung.com> <bba81019-d585-d950-ecd0-c0bf36a2f58d@samsung.com>
In-Reply-To: <bba81019-d585-d950-ecd0-c0bf36a2f58d@samsung.com>
From:   Shane Francis <bigbeeshane@gmail.com>
Date:   Mon, 30 Mar 2020 13:34:05 +0100
Message-ID: <CABnpCuBGW9VeDxE9-SnS=hA=k18uPv4c=Ym8JtKUvZ-Tsd8s8g@mail.gmail.com>
Subject: Re: [v4,1/3] drm/prime: use dma length macro when mapping sg
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 9:18 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> Today I've noticed that this patch went to final v5.6 without even a day
> of testing in linux-next, so v5.6 is broken on Exynos and probably a few
> other ARM archs, which rely on the drm_prime_sg_to_page_addr_arrays
> function.
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

FYI These changes are now in the 5.5-stable queue.
