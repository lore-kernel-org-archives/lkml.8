Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AA0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E341C20872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHayFTVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgH1Qom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgH1Qod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:44:33 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D33C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 09:44:33 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w25so2004484ljo.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UzpPi8yXbLMuzZSSY1LpudtamO507TJJwiMVPeY80DE=;
        b=hHayFTVAP6eh4eo+w96Oa1ZAIXRFKK+O8XvGFl7M7dsA/Sfgl+TIdTnwip76YxquFb
         MUgTLABcXm228lJFA+6PfABognH5JhCINUZ4/AV1oFyEVllbBqx6bZUMFpPQMbMG854O
         uBbhuWVF8lM4SKRAu8D54grAOXevhjo09f77L+QDqC+9f4UGc/pT8JdJMAcS6b9Uft6i
         UBi00xHyjclUtNjsHg83xovHNctWTuceI4QpQKcnCuX0neMqc7kVyRpy99rQ1W8kw5kC
         YrpihI9fczOPvfkaWFuOpvsw1esRu4o8kmdQSn/QJo1TOO9BYzegeWQ5dDCpmFHqFrBH
         478w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzpPi8yXbLMuzZSSY1LpudtamO507TJJwiMVPeY80DE=;
        b=k9HFLLpLwAeXnwr1337oaNk0Q5WxnJpw2toGbBTJsm0/Dgp6K+mLp5IcAwiP4VpCzR
         EBR5riQS2yZQj6R6DWQFO0R+ncHYSxPnBUZML0xyQDddmAeJWTgZQxv+32TcXdmIogXD
         wT1o3Ab8BXNBg+3tWJf88/efOSRqP4j9HX1UhKwUYgcsGpLdWkF3zG0JJbZcFCtqvGoH
         /vzadKWOOGYUxpFlbxsbWP+nNOh27+rjMuVWfN9vXJk63hTPBH54XCBuYq8PoYCSBG6v
         XAyqXxL2baJaA0xKghYWSTK5TP/uBxqmI98XRM+jHnv4h+94Lz8YTZrUeq+jAAB82dJ2
         1IrQ==
X-Gm-Message-State: AOAM530jOKYRKG52yj2fMj8UrWHcoMQtH17CW/seX6UZgirt8uMxCPLJ
        j0v38MDDaZRoVMN5xuSHw9koJPsknXKx7INVOatZ4w==
X-Google-Smtp-Source: ABdhPJzWm18EUoriLV8GpLXZeBfpnJJ0335T25V0TWtCl4zXTizNjuHaws4CrJw0LNy//Kma1xGNubrLqXxkoP4jWBk=
X-Received: by 2002:a2e:9d8e:: with SMTP id c14mr1334390ljj.332.1598633070579;
 Fri, 28 Aug 2020 09:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200821150134.2581465-1-guro@fb.com> <20200821150134.2581465-9-guro@fb.com>
In-Reply-To: <20200821150134.2581465-9-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 28 Aug 2020 09:44:19 -0700
Message-ID: <CALvZod75xBLmf6FigcdNsruyWjMhZ3eaZWggWYuzS5jwFVgW6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 08/30] bpf: refine memcg-based memory
 accounting for hashtab maps
To:     Roman Gushchin <guro@fb.com>
Cc:     bpf@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 8:23 AM Roman Gushchin <guro@fb.com> wrote:
>
> Include percpu objects and the size of map metadata into the
> accounting.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Song Liu <songliubraving@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
