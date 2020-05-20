Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E02FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003B420708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zededa.com header.i=@zededa.com header.b="VKLJf4RM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgETXvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgETXvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:51:35 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FD0C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:51:35 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id t25so4169701qtc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zededa.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOijWyKqJLxNwQeBpPWMP+0S3cV6uReedydSlpIjzL4=;
        b=VKLJf4RMzZ8GKwYeh9OqRDk2QVWEm43naydQATItag3YW/jJ5eONuUaMTKh0s95LEh
         8rgDtmyH+0qrLmnklWxl1XWFSu7uIlM30DG0fONhO/30xcMrA6IMw8Zp6a7iaB3GIqn2
         S7IELd0Jg+esKrNB0DzDvAW/KK7ppEp87NWuSKApP6O63Xls3m8QUJAMgaygYnYm93JH
         sKzRJByGxKC1qNzWU2XCfC5b2NoVQARZfqn0YAbJsqUIM8KzV+mGq5Cgw0NRP8JV1Gnv
         Pe07AyDl+Q9k1ZW888U5f6HrlwhBFRIzybMwFGkFQVHj4NGMi0CcWVFYiQP29KvhkdNb
         S3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOijWyKqJLxNwQeBpPWMP+0S3cV6uReedydSlpIjzL4=;
        b=f2Lw1INJkjZZkb6RU0tTEyxUnGwoBbwSQcnh/EljMQ2usJL1BmtGzhtSVvTdOYKbzq
         a7AQ7VeHHoReJfsSLK7G9TPLDsM3JXDb6lBndhZbU1Zv3My0l2/ryZRzkffQKbxr6ZgA
         lb0uaj4+GCGyn7izTi9H0pxbm/ROuvSbEe8I38FQ+3ClVIT6f5c7tnRC/wIyYtr/V5UH
         Givt5AOgGrtJO58PHDvsD0s4voLkIqt/ajWX/CQmmM6o9GS4N+iJ22+6ahnbcsIVaZr2
         zFFlMKF6+PyGe109QKDxQ2GROXe5DazmcZlUwe9Lzubz93Y8gChxJHf9khCq4HWOPAbj
         Bqqg==
X-Gm-Message-State: AOAM5314Sgz/4uw8UMRDxZ5tefpnl+xZ2ClCutV5MptBAtessv1deSPS
        sPVy581gGSCPniWBx35UeG05TO4gJ9Rn++fBYcqKUg==
X-Google-Smtp-Source: ABdhPJxt2EESLU8nhk5tsHgnFk3RvF6RDw6Vldmiq55JHPOjOD9uPQTlMBvIBmWRF0NacS8L88rfoIbWTF1pRYQwj0s=
X-Received: by 2002:ac8:670b:: with SMTP id e11mr8166734qtp.365.1590018694922;
 Wed, 20 May 2020 16:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
From:   Roman Shaposhnik <roman@zededa.com>
Date:   Wed, 20 May 2020 16:51:23 -0700
Message-ID: <CAMmSBy9VBxjSCRcfyiZ-RY8eyYOooeNfCqrvirhWzfpSbAQyuw@mail.gmail.com>
Subject: Re: [PATCH 00/10] fix swiotlb-xen for RPi4
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Xen-devel <xen-devel@lists.xenproject.org>,
        linux-kernel@vger.kernel.org, tamas@tklengyel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 4:45 PM Stefano Stabellini
<sstabellini@kernel.org> wrote:
>
> Hi all,
>
> This series is a collection of fixes to get Linux running on the RPi4 as
> dom0.
>
> Conceptually there are only two significant changes:
>
> - make sure not to call virt_to_page on vmalloc virt addresses (patch
>   #1)
> - use phys_to_dma and dma_to_phys to translate phys to/from dma
>   addresses (all other patches)
>
> In particular in regards to the second part, the RPi4 is the first
> board where Xen can run that has the property that dma addresses are
> different from physical addresses, and swiotlb-xen was written with the
> assumption that phys addr == dma addr.
>
> This series adds the phys_to_dma and dma_to_phys calls to make it work.

Great to see this! Stefano, any chance you can put it in a branch some place
so I can test the final version?

Thanks,
Roman.
