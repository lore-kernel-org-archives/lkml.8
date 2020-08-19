Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C01C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3222206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSIpNlfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgHSNSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbgHSNNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:13:15 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692EAC061343
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:12:52 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 93so19010485otx.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6oWupOTxMkZT/KhS528vX3zYkNGL3N/FEeWSRmmOn0=;
        b=iSIpNlfuXZbrlw6rncA1oe7w/qv2xYw/6l2S4tSOFY//wPo6/BByC0wlD9SOKMk1TZ
         YFxokN4ECfm6Olm/zuRvKR7R98nq1jR5iDMPcG+bTKKjfYj5RLD55mfc1fI2VzwcDxOL
         juDlmE7EDJx9Q/ZAM9pznkKQ4Du/VNEzucXWMtd2QujvnqCPV5zPr8D1NYlpmf8EDuwW
         3nRoY3hvWVbIYILVYzumEF6U8bZwiXbpeFxnA1v4YcqhXD8OsvWITY5I+DYszTJZj8bw
         FA65AR3M1rZRln2t4wnYwdkp8jOjck9CaG59dshT+x6ts1wBo3HRZzwoinUSCc2FTcBf
         lQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6oWupOTxMkZT/KhS528vX3zYkNGL3N/FEeWSRmmOn0=;
        b=CtzqJmyhQPrroxBZmx4SQuzYwZ4Q/fkUFdZQi9JjbeVHZfWKSCbinOkjcyT6xhJVEK
         5jFmQxscZWNSnr4731siO/bTPLI78Tqu8qe3X2iyjmeYMC0edAee8Ip0oHiucH07ms2f
         us9xQR/bjQas5eUuESGDdmR7vQvT6R0i8TfxBPFgTePjDJDPSLPKmw+OsELhkV3p6VGl
         Ben3UYZeRO+CBKy8DNnJGSQ6g/pnVlG7VauFEJIZH/7Qz0nEI8odwzsOqv12Q8YXtFBG
         ms+yVzkZkvaq8xx5zlZRU37YecULFPpo7AC65TPIJSscEBVC77ymQrFIXyjq7dJed1lr
         dSbg==
X-Gm-Message-State: AOAM531Ytk0U+qrXXTN2Ib1ceCGWHzKekiELwSjNvrCpI1YdYo7jtkBt
        Lyi8/Ue9A6JK+s25e2F7v5mbTgeFjO2Avnwgba4=
X-Google-Smtp-Source: ABdhPJxH0XzNQzl9TcQjuTfwZ7PhmoiQBIe37e4xF+yjRvEbkbD9HcxSYFa/hyG/k8wZRs8/H8Fk8X+j5HWnfA2rOuk=
X-Received: by 2002:a05:6830:20d6:: with SMTP id z22mr18863076otq.94.1597842771741;
 Wed, 19 Aug 2020 06:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561@epcas2p2.samsung.com>
 <1596435031-41837-1-git-send-email-pullip.cho@samsung.com>
 <5f41af0f-4593-3441-12f4-5b0f7e6999ac@redhat.com> <CAOJsxLHTL__N3KE_HUhQrVR=rkri80=kU1e64-6nBgMKHZRi4g@mail.gmail.com>
 <c0e87116-2633-c408-455b-c00c86607491@redhat.com> <20200818085444.GA72202@KEI>
In-Reply-To: <20200818085444.GA72202@KEI>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Wed, 19 Aug 2020 16:12:32 +0300
Message-ID: <CAOJsxLGP3MVhfehfs5pYsAUmc7CnHCmgBFN7E-1u8spfD3MymA@mail.gmail.com>
Subject: Re: [PATCH] mm: sort freelist by rank number
To:     Cho KyongHo <pullip.cho@samsung.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, hyesoo.yu@samsung.com,
        janghyuck.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi KyongHo and David,

On 07.08.20 09:08, Pekka Enberg wrote:
> > > I think having more knowledge of DRAM controller details in the OS
> > > would be potentially beneficial for better page allocation policy, so
> > > maybe try come up with something more generic, even if the fallback to
> > > providing this information is a kernel command line option.

On Tue, Aug 18, 2020 at 12:02 PM Cho KyongHo <pullip.cho@samsung.com> wrote:
> I don't find if there is a way to deliver detailed DRAM information
> through ACPI, ATAG or something similar. But I didn't find.

Perhaps that's still the case today then.

In the context of this patch, what I am hoping is that we'd turn the
"dram_rank_granule" parameter -- even if it's still a manually
configured thing -- into an abstraction that we can later extend. IOW,
something similar to what the "energy model"
(kernel/power/energy_model.c) today is.

On Mon, Aug 10, 2020 at 09:32:18AM +0200, David Hildenbrand wrote:
> I guess one universal approach is by measuring access times ... not what
> we might be looking for :)

I don't think it's an unreasonable approach, but measurement accuracy
and speed will determine if it's actually practical. There are
examples of this kind of approach elsewhere too. For example, MCTOP
[1] which aims to provide topology-aware OS abstractions, uses cache
latency measurements to infer the topology.

1. https://timharris.uk/papers/2017-eurosys-mctop.pdf

Regards,

- Pekka
