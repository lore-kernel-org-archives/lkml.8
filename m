Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5311FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298B32087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SgvKEzvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgH0PPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgH0Lia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:38:30 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1FCC0611E0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:37:20 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d18so5394694iop.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rcg4TIxpS2XrDTWj8mS51Tf2vGitjPKgU895pVtnQkw=;
        b=SgvKEzvYUaEchSKyXnlDf9/rSQtJ8+7m+0GJkn97LKTQl5LEu9FPK9m43svxpmEfgt
         iH/oN1s764d2JTNj/xWEXaVNL2GB4vqgkruQ1yKEpPqo0ll0EXg+VvWLG5Tl53EbjGJw
         +OGgWYITwpB0yMLuSqdCB89dDAVwtP1BY+5CjKOb93e42M+8JUnLQcusWy6fNs59V4aj
         fd7LomJjV6nuXESt9E5JoDX4+oTnHpvJgRWMGzbDO0efG3Xp49x3kgCDbQ4mLt/wG/gf
         OWHDOiNvcZ2LxXvkoqrEFfIUTur/0rz60hcbbp+NYII6e87FUy2OcA34+YMh5WAjVxKN
         N/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcg4TIxpS2XrDTWj8mS51Tf2vGitjPKgU895pVtnQkw=;
        b=QJIL+CSooimhX9RpitNHUe+NF2obozOOMRcBaBdDG1D2uO0mHTUlKdxIwZup/CNbun
         HErywq/BB4nXQcWADVRhi4E3pHglNO4kReNW3kDtGwqj4JSPPrctugxnFBLtMt/3YJ5S
         mzIF+LqNwjHQYsFmCCRWcqCU6ol4HtFvXtVyWKdya34N+PmThUUVxT0sMhcrNsOhp0+7
         Yq/k/SUgifZMBIIlQ4gcR+9PtLQcpFTp16ovlHJeef9hAgAj8HoLMw2/ImLA3sqZ1+/e
         BRZLXspeBJXkwqVEkYHTlxPeslGOyGj+3insRR9V8wEOuQxMieXfZYZBYHvtRHvlLzYN
         lpdA==
X-Gm-Message-State: AOAM531E2y+Epa8pdP4bsEmOXaxnfsXPoZPgKPqWPgnPS4w/WDdAjAzf
        PjS1rbgyAj9WCTXG0xxle9visuvJwMVx6TAsSMCGtw==
X-Google-Smtp-Source: ABdhPJw1N6sVjHVtii/hCb0grxGUljPwAXeuCDgAlkjVrpPoJ2ImTSGfKfLHTqtDw39I1tiyLzx6dfrl5d7CtzSMMnU=
X-Received: by 2002:a6b:7846:: with SMTP id h6mr16736497iop.145.1598528239275;
 Thu, 27 Aug 2020 04:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200827112342.44526-1-linmiaohe@huawei.com>
In-Reply-To: <20200827112342.44526-1-linmiaohe@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 27 Aug 2020 04:37:08 -0700
Message-ID: <CANn89iJ7orDEWxdBJVYqhk+1WF2ZuRpzN_XOaPoGRrn2hWjGNQ@mail.gmail.com>
Subject: Re: [PATCH] net: exit immediately when off = 0 in skb_headers_offset_update()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Pravin B Shelar <pshelar@ovn.org>,
        Florian Westphal <fw@strlen.de>, martin.varghese@nokia.com,
        Davide Caratti <dcaratti@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Paolo Abeni <pabeni@redhat.com>, shmulik@metanetworks.com,
        kyk.segfault@gmail.com, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 4:25 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> In the case of off = 0, skb_headers_offset_update() do nothing indeed.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  net/core/skbuff.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 18ed56316e56..f67f0da20a5b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1459,6 +1459,8 @@ EXPORT_SYMBOL(skb_clone);
>
>  void skb_headers_offset_update(struct sk_buff *skb, int off)
>  {
> +       if (unlikely(off == 0))
> +               return;

If this is unlikely, I doubt adding a test is going to save anything.

This will instead add a conditional test for the 'likely' cases.
