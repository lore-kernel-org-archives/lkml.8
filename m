Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCF1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64DE52065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597700242;
	bh=TCjzNp4qKJTaPscgXMtW9r99luBrplGHLhswQnzjIoA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0XXu6hi0yCyqmpy9nS4Qqkx3gf5dnAB4pOfD667LsvVrNjK1cpxzghL945uqfrq9l
	 /OZXfg3LstUHlkGUv9SSf4SVwO+bp5lfFIF3K6ixsffJ0vFu9w+e2U5FWR/Unxsz7l
	 zpO+Ddy8MLL1Sxci/2oAUf6jl7Hy7LlDs5YiOr6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgHQVhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHQVhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:37:20 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9815C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 14:37:19 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so19102183ljk.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 14:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jm8jZArYddhqUYv8uma7iesaEBvjq6SOsDLcRZUaQ/E=;
        b=K9ybUtGr6t0dUEotn+b5ds3wNHdUEMLBrVq/JaBumu59HnobQacNfCGqQl5mJHNbVA
         hkLWBuL6YoF8g3a1YCO+tfDSdddHQkHB/d4NFnZf0r0jOWl5e4HE9u22yd9cLQ+svWGM
         1fKT0VIsFmJ3woXTAuGbLupTo9xre9P3/nkK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jm8jZArYddhqUYv8uma7iesaEBvjq6SOsDLcRZUaQ/E=;
        b=MKP+Rd8W40B+ztpQiCxb/VtbFtRO182JjrEPzZlpE6OrYbCpNS8sjxLl/F7Z4AHc4m
         aKgpaiQwkWcqWl01hVIcgD9IjET7/7pqBIkKpcUHhcz/b/EsOXWA72Y6tYQi2OeSQW+Z
         c10gsfRfE/Vd0XZvz2QOFHx4+BoDid9Cpmr9DPQFxRt9NQL0s1QFefSwfkSeaC55LMpZ
         m7XW58OcSDttUWLUOJYwbTng+lSiob2kphqW+tNpT10ag8FdzweDXD+F5hHbtWg8Uuu5
         VmTPaY3Dy+8uc+gLedCBKnUxEx3PLHMcyZ6yGVaEMX9Sv9DunxGjdsx/F90gnnf4Cmpw
         1JVA==
X-Gm-Message-State: AOAM532oDiPopHYqhJcOFMCfuom0HLYpjYcjcAqAF98XyI+Ic8NTrJXZ
        QyfzvLDreEL2ZDp7Y8nvuSWAmTJzAC1NJw==
X-Google-Smtp-Source: ABdhPJyuW5Q8YqfLJLXW56QmPE6u6p7BaE/i4CS8iaoP+0+TH9RSAVVg6wJYdU/OIs6+sCuie4bavQ==
X-Received: by 2002:a05:651c:1343:: with SMTP id j3mr7653130ljb.112.1597700237985;
        Mon, 17 Aug 2020 14:37:17 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id l24sm5308332ljb.43.2020.08.17.14.37.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 14:37:17 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id m22so19102617ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 14:37:17 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr8282877lfp.10.1597699793904;
 Mon, 17 Aug 2020 14:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <c6fda26e8d134264b04fadc3386d6c32@gmail.com> <20200816175303.GB1236603@ZenIV.linux.org.uk>
 <20200817204223.GB12414@amd> <87lfid6kpi.fsf@x220.int.ebiederm.org>
In-Reply-To: <87lfid6kpi.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 14:29:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj04wKCjHz6b6d7N58xoS4AftnwTUBaXsEekQ5RhfWVnw@mail.gmail.com>
Message-ID: <CAHk-=wj04wKCjHz6b6d7N58xoS4AftnwTUBaXsEekQ5RhfWVnw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Yes. Finally remove '-Wdeclaration-after-statement'
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Michael Witten <mfwitten@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        John Levon <john.levon@joyent.com>,
        John Levon <levon@movementarian.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 2:15 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Does anyone remember why we added this warning?  I had always thought
> it's purpose was to ensure we stayed within our chosen dialect of C.

As far as I'm concerned, that's the primary motivation.

I'm not seeing why we'd suddenly allow the "put variable declarations
anywhere" when we've been able to keep from doing it until now.

We're still building primarily good old K&R ANSI C, just with
extensions. Wild variable placement doesn't seem like a useful
extension.

(Other variable placement improvements are: block-scope variable
declarations inside the "for()" statement is very syntactically
useful, for example. THAT would be useful if we can finally enable it
without gcc going all wonky on us)

                Linus
