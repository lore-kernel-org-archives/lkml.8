Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D58CC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D795220730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oy8h6k+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgDGPzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:55:53 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:33956 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgDGPzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:55:52 -0400
Received: by mail-vk1-f196.google.com with SMTP id p123so953081vkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eg1oxRZLpZlWPD6oCz4X837FCVZ7vE34GRCOngbw0dI=;
        b=Oy8h6k+A1m2vhmgCO9Yf8eRDlImSINQUAr6JNlcUL2Jj02KIOgiNYfBa2eG24S2abg
         ZTKz/Iu3ufFwtsr6qinyCHEsRcWTiW9qkNH9iyUZQZ4lfDbkn9SV6J0RN/nxnms8/A9v
         AuoS8dpT2jZ+VvaPQVs5o17efsM6f0vBHliUN1+pm1Iej/xYC4hsQoookAwG5sIoU+3g
         UkdbJ079IPW35og5+0SAyplkhpI4WEtvFqH72laE+Vz9IxNaN5RUXCOom/04zRGuNSFI
         Cj5LeXVaeQdeMgkZAYLNjtXuSqFJIpMJ0h0av7BLIoIWWdJWwMh+vfIJNjWmuk65zwvz
         D3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eg1oxRZLpZlWPD6oCz4X837FCVZ7vE34GRCOngbw0dI=;
        b=FuiF5Plt6rjaV5cl9zyNdzdG9bTwlpQIq30YVPYpcGPo7vn/NRHBi1jsS0FSxIOcZk
         2xjFs/YtAezJerJ34Up3UrmpKB4s16NvBmtpgMHsoCG4Y0I9CvhPgRbB6PDBaPZ1ur8U
         pBrAnKsoU8U7Utv/EmhQGeVGgMoJkORiudXY1kT3W7ly2JR/fkmHpPo6nbeFHZYDXNJq
         xPGl0nT6ghXOU21tvKHV83viNCIvQXJos7IRmvGXGAn7tReLeBBXn5879cWhJlZ/lNN8
         FwsMQuwQb8Dfl+1KQz87wfW6bZe/Tlibu6P5Q8UH4uGxm1Kk1gTe22QzCzno2r8O1Csa
         nblw==
X-Gm-Message-State: AGi0PuZPDH4Myr8ZLAe31uO1MRb6yERLjEH9cQ3ih1e2MzrNPuHrD4B8
        2v5bktkJ6uI1Smyo9frk8v3O0+V3taI+ccMyH8JiFg==
X-Google-Smtp-Source: APiQypKH+9UUCOpR6lr3lTe5bFEuhXdjiFsvZ1RD0SdxgH1Lkoi+J8EUw9FluJiLwN7u75DMXQQF1nqanfUpe8WgUyw=
X-Received: by 2002:a1f:5003:: with SMTP id e3mr1933649vkb.59.1586274950469;
 Tue, 07 Apr 2020 08:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200407065340epcas1p13e6e5ad6131f0a94d3ed1e8360353a82@epcas1p1.samsung.com>
 <317e0073-a6f7-4232-3b95-a4bc3ddbcdec@samsung.com>
In-Reply-To: <317e0073-a6f7-4232-3b95-a4bc3ddbcdec@samsung.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 7 Apr 2020 08:55:39 -0700
Message-ID: <CABCJKudWRmdyJAxjnTs+NiRJVnhDUQfzGO3sVKZNJoQ5Qi-aew@mail.gmail.com>
Subject: Re: [PATCH] dm verity fec: Don't add data_blocks to block
To:     Sunwook Eom <speed.eom@samsung.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sunwook5492@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 11:54 PM Sunwook Eom <speed.eom@samsung.com> wrote:
>
> Even if block type is metadata,
> block in verity_fec_decode() has already the right block number.
> So there is no need to add data_blocks to block.

Is this also true if the hashes are on a separate block device?

The idea here is that the error correction data was computed over both
data and hash blocks, as if they were concatenated, and we want to
calculate the logical block number based on that. I agree that the
code doesn't look quite right though. Should we use something like
this instead?

    if (type == DM_VERITY_BLOCK_TYPE_METADATA)
            block = block - v->hash_start + v->data_blocks;

Sami
