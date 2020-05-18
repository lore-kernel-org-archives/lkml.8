Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B18C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B025F2081A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="T5KMEfAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgERTVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 15:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgERTVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:21:13 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBFEC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 12:21:11 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z5so9780321ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 12:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NCtLMQj4bd2e3c2bHF+/O8J9nt2Ds2pK8CiLeSB8n0=;
        b=T5KMEfAY6vCFd6N5Kx0NVes4X6Q7ceE8/KLOzPFTAQ+GkwYT9S/SpLB4pNPQnjowkJ
         CbCiZfwOlTyQiJB+e/DHqeaoM2w/5uknnHaHMT2nG6iUEIGoU/vj/vOD8wHOLr1H25Ks
         jre48/UL+cra9yG4+JTg6MNvAynGFFoWDDr0Ke+ETW68ZWsmO8VtHAdEufFARE/0AD6G
         1vBaZK7PKNYcMg2dLZWNq4yLlWd2TcICJpkI2HalSNiiTUXmNQQEcGUMRJr4o/S+9dq3
         55yjq0I2/mslD4FGfU8OpQTCETGlya80rexHHt7bctlq3GhikIaXE+Qtl2lLopaOmXpk
         7PJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NCtLMQj4bd2e3c2bHF+/O8J9nt2Ds2pK8CiLeSB8n0=;
        b=jzIFayUJbwO5W9mEi7i5RF1OrXqYkSp0U+PZ1RVRBW4LAlTBPAu3f1vt8hFYJX6MH0
         TGn6ywfyfY6XERf8/3njK0Wau51LHYY/ADwWbwa8n5Rbtfk9Yfilad7v2QZwH2ixQAb4
         zRMepyp67vSMRR27cOu6tYp8wwYfkyfdo6MvTTYZyuGLxt+WTFNQJF7yo5ybcfaQptMc
         93RKcC1Y0NDKGZcE5XCH66iN/+Dv3YysCgZTVXOQWWqG4QL+kwe05aEPuS3B52sBK3vj
         rX7gI3vTaPmo89Whkr4b8iS0PZfxExf0ZYoMRIKeDz2pKdBXfwwd03cCYY6i0aIaj3Oq
         yxEg==
X-Gm-Message-State: AOAM531xbxy4jS7fRKBox70NVY0olxaBjqkP8fKQnM8UMVLycU4lkxU2
        49GAjbeQMugx5wG/wdQpwA5awagahWy9KOO3E/JB/Q==
X-Google-Smtp-Source: ABdhPJzd7dkJtQhZKZrnZAYQVrril33taRNEhq4HfjmcahS4WFjiDUaOSfR6v4zAJibJEOPuxLCA5yHtrrOjAp//Bgs=
X-Received: by 2002:a17:906:528e:: with SMTP id c14mr15831151ejm.123.1589829670561;
 Mon, 18 May 2020 12:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200516150229.GB19372@zn.tnic> <8022D1E6-A8BC-4610-9F58-67A06B9A9575@intel.com>
 <CAPcxDJ50pbuTbittyvPwKq1uUT8q8jJ+dHH8rCug8a1DDZXVYw@mail.gmail.com>
 <CAPcxDJ6f3pBpwiR9nvXN_g_HBa1RAMG+aOmgfXLFT6aZ9HQn3w@mail.gmail.com>
 <20200518134813.GC25034@zn.tnic> <20200518153625.GA31444@agluck-desk2.amr.corp.intel.com>
 <20200518165500.GD25034@zn.tnic> <20200518182629.GA2957@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200518182629.GA2957@agluck-desk2.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 May 2020 12:20:59 -0700
Message-ID: <CAPcyv4iLMzGJUgjG9kxuuH65mYbqJ0+oHd4DbD1Kc6p9J14F0g@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Don't try to change poison pages to uncacheable
 in a guest
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Jue Wang <juew@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 11:26 AM Luck, Tony <tony.luck@intel.com> wrote:
[..]
> N.B. Linux wants to switch the page to uncacheable so that in the
> persistant memory case the filesytem code can continue to access
> the other "blocks" in the page, rather than lose all of them. That's
> futile in the case where the VMM took the whole 4K away. Maybe Dan
> needs to think about the guest case too.

I think increasing the blast-radius to 4K is the best we can do
without a paravirt mechanism to coordinate errors. There's also the
existing problem that set_mce_nospec() fails on pmem due to the
memtype lookup.
