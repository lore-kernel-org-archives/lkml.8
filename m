Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC15C2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4043420716
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLtvWnDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgC3MdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:33:02 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39599 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbgC3MdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:33:02 -0400
Received: by mail-il1-f193.google.com with SMTP id r5so15554324ilq.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 05:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxbhURdqeY4tQY1TIF/XtnZiMO5t6ORH3FDOf86VjrM=;
        b=kLtvWnDD+PVnqLf0EKVUTgodcUI/vDh/Jr9+BGujcM8e+jZxRSMy2g+Q+oOo8we85/
         faAgDxecXONAnLA6Ka7bpVUj9jKMMbBKt0CxHAsP2EzGOKPMpwz0YBw1BtHQM6+51XQO
         DvkhyuQdRiAabUh0ceErLSExDebMPp9a/y6KKVIBd4Ke2cQOZhittXjIinY8ACFptFyC
         eLVSlQg6kgdbLJZOCwOw91AnfcKc024yttEA9aK550aXHuxcHaQp5S1fAWoDvzj6lxqr
         qBr/OVUYV+wRjL7gWfyZOAJrzg10eT6XSFhooYj79PvcEGanu0Ncv/klW6dDPiewaCoo
         fwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxbhURdqeY4tQY1TIF/XtnZiMO5t6ORH3FDOf86VjrM=;
        b=Q2GfI7ejONVnvQ6w4ruPnx3zR48M1yxTR/QmtHewKT81Md8wx+06dcKSYu+MSidTyR
         0VNwk8OMqq3r8aLK7F383hSo3sOOaTYuFRgg4T5xMB2K5HRwnfqYLCOmy8KrWkQHvgRr
         I7nyyaWyFjdK10YU4W4FjzPs0KL7Mp1BqNZf/luYckJQB4VXwMpgu9O2uMDmSzJDgNQb
         FUAL8pxW8dlXSnLyhXviZA/kwoTPNQikoxW35TkQyjxznPYAoN7vqsOSnCXr0u54+vRz
         X9AWzRKQ0nN0fZEXlElxQedqa9h6rI/6GdXZtF92ZMaHwsXQw4AGiFF/BGILs3chSUMd
         wTAw==
X-Gm-Message-State: ANhLgQ15tSmYNMdywI1fotbulje0ay9DOrHfkPY1Z2pcNQwk+gE9pyJ+
        RLZutls93a7QSVGyjfW9Jk6DZGpmj8XE3fRlb3PxYCC/nK0=
X-Google-Smtp-Source: ADFU+vvVDdO6PE5/W/xY8RMb/+IIw3P2f/dN4OSoiJyI34MLt27MsmlTiBxW0aYiFCCJMEmGWrNdhhnBZHIdY4tgANw=
X-Received: by 2002:a92:9e99:: with SMTP id s25mr10656271ilk.306.1585571580232;
 Mon, 30 Mar 2020 05:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200325090741.21957-2-bigbeeshane@gmail.com> <CGME20200327075458eucas1p2f1011560c5d2d2a754d2394f56367ebb@eucas1p2.samsung.com>
 <4aef60ff-d9e4-d3d0-1a28-8c2dc3b94271@samsung.com> <82df6735-1cf0-e31f-29cc-f7d07bdaf346@amd.com>
 <cd773011-969b-28df-7488-9fddae420d81@samsung.com> <bba81019-d585-d950-ecd0-c0bf36a2f58d@samsung.com>
In-Reply-To: <bba81019-d585-d950-ecd0-c0bf36a2f58d@samsung.com>
From:   Shane Francis <bigbeeshane@gmail.com>
Date:   Mon, 30 Mar 2020 13:32:49 +0100
Message-ID: <CABnpCuDuvrJYQKSbdci=N-pqH5V11R3-Kwi_d2cDSrWSASxCsw@mail.gmail.com>
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
