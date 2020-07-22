Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84E5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932B520658
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaHrNGo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgGVPFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgGVPFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:05:46 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9832BC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:05:46 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x69so2284393qkb.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGlEkhcsZo3yhQXvjN0G+bmOOv4WJUp5U029tMuuyYg=;
        b=TaHrNGo0vX9p8V/a8lm0ySt7CsVnoSD6VsPJ+ZHw5/3XzTaHXum+uEEJNhhxBUw7xz
         mmpy3MgxQTOlnS7qSticTtoJFnxrKcB0v4bgF67rRG8ALv6V3prPwY4UQ61ULQEPiW7d
         fGVddSAaLcvTOnFIVytrgfb2Lt2Q5rc7KLuHKsci8sv6h/Uty2++ObGjwpo9CXCnQXkj
         6/jeCkZRq0KSMWZSxST07kWW6fGXdrKm2suORrbRZ7mtSduUSplay6gSECXy8YghAUPV
         ZrHwJZB2skAayNjFeyvDGFRe8MG6NryWipDSceAbDEIogR/7GtyW02yZsFGfUXhvRJtk
         77mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGlEkhcsZo3yhQXvjN0G+bmOOv4WJUp5U029tMuuyYg=;
        b=GrfoJEHOktXAZCSOO7PyOe2yCIoX6oRYx45NSLfQ4VVPgTDpuCSBDdJ+5EdKSKDKOA
         77lXqTyJKscfN9HjamfDy/jyvieaglwukfMK5wMY2462jxtO6mpXLElbyOY4iXjyx3YG
         bXM3DE6L4OfeZcK3E6Sis5Ur3k6yrepdie2r9wPc8oMW/EWzLXVweOZr5VntmlpoZ2Qy
         0qTxvklrcFGd2itPkQhZgdZC43RZ2kzXIH7UPxG/MsOnbDru6Ljk0l5LnmB78/h+OhNs
         yygVNwbltwz78D6R+CUduaBQFlkY0YfQwD8jPdf4VFJedQy8+o4R6N6MHhtbl6sBe9TY
         bm9A==
X-Gm-Message-State: AOAM533k/WhL9Ojnc8d7BXyJZckzEX2UUpsU35i0hyeI6KZ9HlR5Obqd
        Kic2dtcmg3PcRFbnD1i8driuHPy7
X-Google-Smtp-Source: ABdhPJzRsmgH3Px+IPWc4TcbZqEZMPxH3SvuXFB8gTd2g8L+mtmOcHk8Y5NSCDY+QN4v5i4pTgfeoQ==
X-Received: by 2002:a37:73c3:: with SMTP id o186mr322974qkc.465.1595430344773;
        Wed, 22 Jul 2020 08:05:44 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id o37sm18982614qte.9.2020.07.22.08.05.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 08:05:43 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 2so1158088ybr.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:05:43 -0700 (PDT)
X-Received: by 2002:a25:df81:: with SMTP id w123mr51454810ybg.428.1595430342800;
 Wed, 22 Jul 2020 08:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <87wo2vwxq6.fsf@cloudflare.com> <20200722144212.27106-1-kuniyu@amazon.co.jp>
 <87v9ifwq2p.fsf@cloudflare.com>
In-Reply-To: <87v9ifwq2p.fsf@cloudflare.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 22 Jul 2020 11:05:06 -0400
X-Gmail-Original-Message-ID: <CA+FuTScto+Z_qgFxJBzhPUNEruAvKLSTL7-0AnyP-M6Gon_e5Q@mail.gmail.com>
Message-ID: <CA+FuTScto+Z_qgFxJBzhPUNEruAvKLSTL7-0AnyP-M6Gon_e5Q@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the net tree
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 11:02 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> On Wed, Jul 22, 2020 at 04:42 PM CEST, Kuniyuki Iwashima wrote:
> > Can I submit a patch to net tree that rewrites udp[46]_lib_lookup2() to
> > use only 'result' ?
>
> Feel free. That should make the conflict resolution even easier later
> on.

Thanks for the detailed analysis, Jakub.

Would it be easier to fix this wholly in bpf-next, by introducing
reuseport_result there?
