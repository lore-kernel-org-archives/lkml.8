Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34369C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14FA2207F9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590067771;
	bh=+Vul0RFPdVZB0vQS1vT3FMvkdRIwInL6j//NVC1qhzU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YGG/Z5vPzQKJF0pkQTh6KFwqsoeraOSAygdBAtFgf3rPSHaFioFkSHm27eMkdtH9i
	 xlTMk5K/iWmvPxSfq8TpVCarfBVQm285xeBIKunamTQS5t3T187IUqOB3jZJEndyJC
	 6IApvr7NRE2hWHk/qsaiE+l0rSJploGxeVhBg0z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgEUN3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbgEUN3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:29:30 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75B2520872;
        Thu, 21 May 2020 13:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590067769;
        bh=+Vul0RFPdVZB0vQS1vT3FMvkdRIwInL6j//NVC1qhzU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RnR7LQDq/x9Ij28pJbJmM6lvZTtP5kEYvMwF8rieOVu/rNm+FHySqrnsIpxMZWBHX
         GYOoUmXROau+GrCoaKOJ+QGWRx9oyNLmHaajGax+M/19uf94LxIcXmO61c4AKPllos
         jEwGPIwlV5CxQgeEAMFlDM2V7QSfNpK5DrC5F4To=
Received: by mail-ot1-f45.google.com with SMTP id x22so5492490otq.4;
        Thu, 21 May 2020 06:29:29 -0700 (PDT)
X-Gm-Message-State: AOAM533NNjD2DP9gkwF06u9LrLPeegbp4Vx5swO8EXYBwkjAt+VUlUrn
        bMLOcC48fuuZj6Db3HHRVQJuCBHwYTLQESm8aQ==
X-Google-Smtp-Source: ABdhPJwr4rrTCR/Idttk5JgrSALx4SScRiwigbIhOO/HiSRN+KNXysfUOLEjfhqUUsjN5MDORr7rgIYX7slyHD18ORM=
X-Received: by 2002:a9d:1441:: with SMTP id h59mr7152607oth.192.1590067768679;
 Thu, 21 May 2020 06:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200521093805.64398-1-chenzhou10@huawei.com> <20200521093805.64398-6-chenzhou10@huawei.com>
In-Reply-To: <20200521093805.64398-6-chenzhou10@huawei.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 21 May 2020 07:29:17 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+EV02YBqEGoJrsJW8Y+g_GkB_LkTwWCxNCb3F+8MSdyw@mail.gmail.com>
Message-ID: <CAL_Jsq+EV02YBqEGoJrsJW8Y+g_GkB_LkTwWCxNCb3F+8MSdyw@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] dt-bindings: chosen: Document linux,low-memory-range
 for arm64 kdump
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        John.p.donnelly@oracle.com, pkushwaha@marvell.com,
        Simon Horman <horms@verge.net.au>,
        Hanjun Guo <guohanjun@huawei.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 3:35 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>
> Add documentation for DT property used by arm64 kdump:
> linux,low-memory-range.
> "linux,low-memory-range" is an another memory region used for crash
> dump kernel devices.
>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  Documentation/devicetree/bindings/chosen.txt | 25 ++++++++++++++++++++
>  1 file changed, 25 insertions(+)

chosen is now a schema documented here[1].

> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> index 45e79172a646..bfe6fb6976e6 100644
> --- a/Documentation/devicetree/bindings/chosen.txt
> +++ b/Documentation/devicetree/bindings/chosen.txt
> @@ -103,6 +103,31 @@ While this property does not represent a real hardware, the address
>  and the size are expressed in #address-cells and #size-cells,
>  respectively, of the root node.
>
> +linux,low-memory-range
> +----------------------
> +This property (arm64 only) holds a base address and size, describing a
> +limited region below 4G. Similar to "linux,usable-memory-range", it is
> +an another memory range which may be considered available for use by the
> +kernel.

Why can't you just add a range to "linux,usable-memory-range"? It
shouldn't be hard to figure out which part is below 4G.

Rob

[1] https://github.com/devicetree-org/dt-schema/blob/master/schemas/chosen.yaml
