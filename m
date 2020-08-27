Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB778C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51F622BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U/C0BJII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgH0Ls4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 07:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbgH0Lfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:35:50 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA09C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:35:45 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q14so4579296ilm.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nk3XMsscwoEZw1pfmEYAb8eP1m4cERKtDNn3BOQ6wZo=;
        b=U/C0BJIItk4cpBQIKKHprsucVwFzLLWgqyxYVTuviqiRvJjFV00mPKgYgU/U7w4t9Q
         Y40T9K2BvdJWBQDj0tw6ewwLwDyW1ggK0A40/SxM6ZC0MKMxWAcf8PU1zP7NJ0DL7mwD
         mabdMS5DBW7DARO/TJRFwzlgPVu8S0VESQgV96hED2alyqd76GfOWzrgDjc3gWEb5N5f
         ZXoX2eU3bk3e00NNtglqOZOkh7D0oiLs7icsqPvxkUgCc0SrWpmEME3fJ2zGpsL7xeGb
         Os6qqgp8yE/vPgMSIJW3N5qhxl98XatED8SwbtCvliPqsXhjaCEIi87d3MLFeclXamQ9
         +NzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nk3XMsscwoEZw1pfmEYAb8eP1m4cERKtDNn3BOQ6wZo=;
        b=aDsLs3zq3KGllS+Urj3pEAQzcdfcDe6J5yVt6F3Fdz+DNa6jXJrNF4X3XpWQzs/9zv
         aF0g8E247NKcuOC6ahBloYhpNAisL3OkOeJDVDo/fZEIgwYq9BXJ7W4d5xHLWlUGxjvF
         dnqmTyIOmycj/fHXz8T918dJo3pttfwR3o3I1kjq5y2TFeb/hcJczM4Dw8aTb/dPnTo3
         ZhyEmNNmXSwnsj0YvrNkZzxcnP9sE93tgRx533KVm2LDfrVeiXrWSDLQu6LO1n7Yrooq
         8xdt5ZC71bFRV01XZS6KlOf8NoZ0/i06mPWOlqG3CqRV8QQ2jB6pTqFVUUSzXVU9GAtn
         zOSA==
X-Gm-Message-State: AOAM530+KC6p6LFKd5X6CH/JMsuQe6Ujig8drnbtUuNSvepAxgS9jMxt
        h+vK7p1BOmt30gMi3Ok0jYVmCuMPghosFs2ShQwNHw==
X-Google-Smtp-Source: ABdhPJwxSXQ2/aSL9AbPqwXrgVZPAyH+csHxjYXsclhJT00Mv6s7Ff00Pw0g3zQXn7UCx/ACkT8asEAMiK59f/Wo/HY=
X-Received: by 2002:a92:bb0e:: with SMTP id w14mr15038915ili.68.1598528144077;
 Thu, 27 Aug 2020 04:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200827112922.48889-1-linmiaohe@huawei.com>
In-Reply-To: <20200827112922.48889-1-linmiaohe@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 27 Aug 2020 04:35:32 -0700
Message-ID: <CANn89iK3CKrXPj5fNYys26zd8P67jz8GZEF2WjLD6Xw05SimcA@mail.gmail.com>
Subject: Re: [PATCH] net: Set trailer iff skb1 is the last one
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

On Thu, Aug 27, 2020 at 4:31 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Set trailer iff skb1 is the skbuff where the tailbits space begins.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  net/core/skbuff.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 0b24aed04060..18ed56316e56 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4488,8 +4488,9 @@ int skb_cow_data(struct sk_buff *skb, int tailbits, struct sk_buff **trailer)
>                         skb1 = skb2;
>                 }
>                 elt++;
> -               *trailer = skb1;
>                 skb_p = &skb1->next;
> +               if (!*skb_p)
> +                       *trailer = skb1;
>

Why is adding a conditional test going to help ?

cpu will have hard time predicting this one, I doubt this kind of
change is a win.
