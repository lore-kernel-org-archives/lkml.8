Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4D6C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8FA820719
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REVuEsg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgHaPt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgHaPtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:49:22 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC327C061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:49:21 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so2547392wrn.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1d2XOGj4/mQm0XIjmCNV1oewYnJg6EZTFcc9J+2cbQ=;
        b=REVuEsg2CiN/qtSP5ghWobHHXBx5sr9ZVE7C/NuSXKhV/Xd7Pgzyr4SVn563uQXjGI
         Eq5XEDoSWa0svg/5eG6tnrbMJgXXZoPwGMXyG5sbV2Km3PHMCETnnzx8qcNwyPs1khSq
         cRcnMTckV8XPo0ktVdWLdXr2ct9RSKYAiE0xufkCrESiMa4TJBNJmTLn6Fdy8dFiglUs
         O37bIvopoXLB7N36Owu79jonpk31lWDBrDWtmm+NOnUo89VmO/RngjUCO4Wc35VV9fMu
         OPBpxB5pQxZE9lYtu6VREchdX5ne11FFpN15mkX3yDP8vGmORrv8G57zWMROdPY4i9W4
         Zqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1d2XOGj4/mQm0XIjmCNV1oewYnJg6EZTFcc9J+2cbQ=;
        b=PgtjsicDTHgxe4YYHi+224eHT8F9nJywjKw72DZLf0DY9k3lBSdEx4zkg70AF7wJZx
         o1+AbRg3c+UQ/8awf7VQIZpzrwCm7+cL9Ofm2Zw3Aj4feKaXIURN7/iua3DDeEqjWnmm
         eXVsNjuoNQobSc1HdYGdS0VVFwGLIACEUwQBqTvatCgn7PriHX36qMvwqod4Rp+QQLJ0
         iX63m7wZxgLw2zkoUeTXC7XxE8NqIh2FQFtHu7EHlS21+H2CD0OjhcZPQIjGRJ3BgHl5
         Lt6CdAGOJy9ZscP0q7J3Nbnx0jqDOHsd99htV2qQmf+Rh0EysJ/5/4Vb5yera/h674yS
         m7XQ==
X-Gm-Message-State: AOAM531kbkWxX6lrdWtAoXJ8iCiTYKSdNy/cL/mPMDPHIL4yrISRmmK1
        PqUPx1EXD3MUM03zYwkINCz5UwKxHfXDrUseYduUEw==
X-Google-Smtp-Source: ABdhPJxLWPETNyPnCiyjTDBC8XYVpbEbjCWK79OLmZWLx/OGDa49T6VAmNNs0loEizDKgyAsCush7FlOkIpOBlpST30=
X-Received: by 2002:adf:f101:: with SMTP id r1mr2234529wro.314.1598888960087;
 Mon, 31 Aug 2020 08:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200828141344.2277088-1-alinde@google.com> <CAC5umyiNw7FA__Y3HZ1UEG8Y6uQDgAWHTJpOVf7okERzpCjnRg@mail.gmail.com>
In-Reply-To: <CAC5umyiNw7FA__Y3HZ1UEG8Y6uQDgAWHTJpOVf7okERzpCjnRg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 31 Aug 2020 17:49:08 +0200
Message-ID: <CAG_fn=XDTWYbxb1Hy1p0hdOtOejZPWvDXfitysK7wUOsPAE_XQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] add fault injection to user memory access
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Albert Linde <albert.linde@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Albert van der Linde <alinde@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This series looks good to me.

Great!

Which tree do fault injection patches normally go to?

> Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>

Reviewed-by: Alexander Potapenko <glider@google.com>
