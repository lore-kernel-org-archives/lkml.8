Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5BEC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026C120721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="blJrJGu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404219AbgDCQVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:21:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34953 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgDCQVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:21:40 -0400
Received: by mail-io1-f65.google.com with SMTP id o3so8159973ioh.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 09:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+BUx9P8Dak6JAoSbhCIj2JgZxaWNKR419JDcA+r5N2E=;
        b=blJrJGu2n92ny5HCpgtVJezllSUUoHhcmmaH5ZG1A2toOdilEGQgLBba9C32/i7LOy
         aiqldYQw7hPOt1P8jK2GvzFoZ+BSGzi5nWPwOOwrvECXGJMGyng6Y8tcdRNPv+5IlwvY
         RekoHCvy+insQITkFqJgTP8AHqEBmU7FJ4t0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BUx9P8Dak6JAoSbhCIj2JgZxaWNKR419JDcA+r5N2E=;
        b=QQn15VLhIFVZt9sAylZU6GoidEaHVtOzQR701Y9fimj/iDUz4u+IVSWAkRZADjwjUg
         9ThxpseuliEKY4bLD+QRcvsqgV21E2k73EenkftL3ve8RrrURYQY4rI9c5VmvfFabc1i
         hp9ezZnmr0Th0f2gXq6f22q1Gby++/0Uo7Mlg6VVw27U3UpXzChyZfe9dJ1shtQeMx2S
         xZ+JvbM1Iz5fzDClZSRSONPHWlAI+1Km5HwJUfVQRGs74sEezxpKXcv9uMUreRYpwHJD
         eXRP/iyuuyzD8KMVKGgcsujtA3k6Ci845GnNonPHzTI8+p9fv3OSFP0pL0ACSF/yDKPw
         yldQ==
X-Gm-Message-State: AGi0PuZWhwUlfYcMiQwbBMc2M5fkf94MsnfgkASF7z1t8Q3mlzNsaLjn
        IIqq7OKQhAdhFKnBBt+qy5oj3QVHO5KjT072pLb59g==
X-Google-Smtp-Source: APiQypK7NzI44FJCtAySNWwx5BVe9e3FMHTpJtekyTDtBq6XoLkx0MSuSLWOp03WX1QwfpZFZKVpTD7gC4ylbac2Rd4=
X-Received: by 2002:a5d:8d0e:: with SMTP id p14mr8593874ioj.0.1585930899525;
 Fri, 03 Apr 2020 09:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200402033640.12465-1-f.fainelli@gmail.com> <20200402081346.GA2548@willie-the-truck>
 <c380729c-9cba-6639-de9b-64d3d0896110@gmail.com>
In-Reply-To: <c380729c-9cba-6639-de9b-64d3d0896110@gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Sat, 4 Apr 2020 00:21:13 +0800
Message-ID: <CAJMQK-i06+zG30tzPMgKGrrC4gcrUOcnecaBLP+uMTzfaFZu7A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: dt-bindings: Document 'rng-seed' for /chosen
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Will Deacon <will@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        geert+renesas@glider.be, Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 2:07 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > Are you sure about this being limited to a u32 value? I thought you could
> > pass an arbitrary-length value here.
>
> Humm indeed, we can pass an arbitrary value, I completely conflated the
> type of "l" here:
>
>         int l;
>         ...
>         rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
>
> with how much we would be reading from the property, which is complete
> nonsense. Out of curiosity, what property length do platforms typically
> populate?
> --
> Florian

64 bytes should be able to init crng. (pass CRNG_INIT_CNT_THRESH)
