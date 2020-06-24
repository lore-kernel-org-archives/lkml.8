Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD12C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358F720E65
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ssqhSLNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387959AbgFXAVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbgFXAVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 20:21:19 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0AFC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 17:21:19 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e15so160936edr.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 17:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YjofI1mwRo44tuHI1N5pBCiCgd6VCF1mc9VUJRDcqIs=;
        b=ssqhSLNFQwECvtfaqEByEmRnEvWZatoj9uZz/B5DwW54j2FQkD+Mz8lf986nWsFj/O
         1VC/kYFfNJO2rSdKjYE0GZCOUe5M5hJ5dg2KoN+JnjPhFOOrYlBmMlFRDatO0eEcxkR0
         ksGOcOp+yRJistWUEvSGzHGi0hWfgHApW536ZGxkx/ImlMQKKXTcRuHSTIeBt7JQ81Yh
         HPEW+6hx5rs1StxvLyah0FQP6QKXp7MUU5rjy9rgkp9osi1jCGckkybB+xUVoa19Tskt
         VcALBCPvxE2v4E3Do0asAE3bqTsJ2fs0G4MkURwA7zCpig8K7hrKmGW86vThgpxSuA/t
         QChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YjofI1mwRo44tuHI1N5pBCiCgd6VCF1mc9VUJRDcqIs=;
        b=FLGDMhYy1jIBJcj24YV5o0BA1B0JkzvRAxW26HGRB4a53ZA//9WITeSB2qKNRLM7Zm
         SmPVqH11BL3jYR8GlUREQBa+wNnDsgLspdTHA1KZtW1Jv3l6KYfZuix/0lgAUmX9MSCQ
         nVompBSfP5pys/fKKKXEQYvE4ixvtBjNAXR7l6w0hnIMhrlfcb5NYTv/ioKE1i9DAURV
         dQXLqqNLuWyN2ge1MmBrtXxwkoFubvCAPVvnBH6zaUyF4s19EiTcDJj8Irti8nrLYcY6
         FtgjVZreFIVs3L7X3Mo2VYkkvesnLT5sGZn1pDrn9NXWm7NT6+ZsdtZSxAY/vvFTz9Ut
         cJEg==
X-Gm-Message-State: AOAM532Xtcs2Eg9FCxeIrUGCIBwmIOA0FqWZxi+y0FXOT5Jn9XTnfqr+
        Grbc4LhQiTDG9cR6Nm8yWxkPbhXGbvm+dGJMJjzTEzd3
X-Google-Smtp-Source: ABdhPJw83ckqM7XvH578t3C1pW3kyuRas4cnGlU5TxmWEVYr+CfscQ2B8N8wRKhF8WgJl+y1psSndTTLHtMHgYWVAto=
X-Received: by 2002:a05:6402:21c2:: with SMTP id bi2mr24132581edb.296.1592958078019;
 Tue, 23 Jun 2020 17:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
In-Reply-To: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Jun 2020 17:21:06 -0700
Message-ID: <CAPcyv4ipnZ2jXd-obBk4KMGPNz4DMu0jGXFEEPCnST+A2zR+Uw@mail.gmail.com>
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 2:43 AM Wei Yang
<richard.weiyang@linux.alibaba.com> wrote:
>
> For early sections, we assumes its memmap will never be partially
> removed. But current behavior breaks this.

Where do we assume that?

The primary use case for this was mapping pmem that collides with
System-RAM in the same 128MB section. That collision will certainly be
depopulated on-demand depending on the state of the pmem device. So,
I'm not understanding the problem or the benefit of this change.
