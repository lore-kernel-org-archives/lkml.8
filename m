Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FC7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 20:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972DC21D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 20:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEFtawHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgAWUFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:05:42 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37394 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgAWUFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 15:05:42 -0500
Received: by mail-oi1-f193.google.com with SMTP id z64so4164948oia.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 12:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VyznYH5jQ6Vy0xxWHMJMOnmd05+7Te8s8tuSLOem1vc=;
        b=NEFtawHLgzySPes5yhMKn043r+gEGRFGKhG2aJibWy+YdIIw0CJVynUf/h7t5SDCAn
         YCLGg0okwgHeebwoD2fSmlXxTPzE+8OqgOFxOfSXKIjZI6xLy+zqNphZwdd2Tl3HNdb9
         F+bOjMFMa/rjrcxnOi4Uv4WZy/wdxN2W8Nb0aKewvUoYFlPfCCwLGvMXURaKpP3IPhAy
         Vp7d3t7P3GCpDZy5GL/uWB/BtJVgZPiTYeU3t+OjdbL0MzYC+L/KPsM2qvjVN1iPjPEf
         Ccr0Fq0QlZZfD85rtYSLJWpgC5B4L6fMT7Gk1Ub9GJZ/JSAOlZbDhxtdfgH8LTyMuqxP
         +XHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyznYH5jQ6Vy0xxWHMJMOnmd05+7Te8s8tuSLOem1vc=;
        b=lDGLfjAnPmcz3PdabhYIbDpMiIdXSAuTtaGwmc1N2Q95ZPWpmwYZSVuDk62QijvdM1
         WfqMI4K1jo/WzgaBlPKGQKUme6B1GCUBkGxGpgZjQ679lwuURtzhTczLGoN275a5rzv/
         8AU5VzMYp2AMu/GeDWySZZYYNKL4DhSk5I2FvAEeMd0/k1pVju4+LYfumW3NnMC3+B33
         gSZJCGVr3U2n0FlLA/gENUxOpsuQR3uLeyvNeIwcITCDMxtr2J3ZoriPcoXPEGAxSbJp
         pA06Xzj/9/96nw5I43EUdit8Q/Wsn2OXXPTSU27VX4u1g/6NiQXLBbv5TDsUQefHf8F6
         HeeQ==
X-Gm-Message-State: APjAAAU/huSoYaDbb1yKfbcKZqPMvQIghckJZat5paiSUpBu0U5WpdtN
        IZdhMZkFeRKrjWWr3hI8KljfSbmEV8eFVMwUdOt7oc4A
X-Google-Smtp-Source: APXvYqwiRj0OJ5VwDvTDPamb1fxJTDNZ4OLpyrc6B4XIYJ2G1RIHK15Xy+a0L15Xtv0x5GzGRu8QZoxzo7UGUwseUng=
X-Received: by 2002:aca:b3d6:: with SMTP id c205mr12152720oif.67.1579809941388;
 Thu, 23 Jan 2020 12:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20200115012651.228058-1-almasrymina@google.com>
 <20200115012651.228058-7-almasrymina@google.com> <7ce6d59f-fd73-c529-2ad6-edda9937966d@linux.ibm.com>
In-Reply-To: <7ce6d59f-fd73-c529-2ad6-edda9937966d@linux.ibm.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 23 Jan 2020 12:05:30 -0800
Message-ID: <CAHS8izNmhxja_0+b2DudpXB+1DQfpnjUu+Qak+wnsApgYrvU=Q@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] hugetlb_cgroup: Add hugetlb_cgroup reservation tests
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, shuah <shuah@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 1:15 AM Sandipan Das <sandipan@linux.ibm.com> wrote:
>
> For powerpc64, either 16MB/16GB or 2MB/1GB huge pages are supported depending
> on the MMU type (Hash or Radix). I was just running these tests on a powerpc64
> system with Hash MMU and ran into problems because the tests assume that the
> hugepage size is always 2MB. Can you determine the huge page size at runtime?
>

Absolutely. Let me try to reproduce this failure and it should be
fixed in the next patchset version.
