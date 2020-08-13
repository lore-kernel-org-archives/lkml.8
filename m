Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D600C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01B1207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmZ+2cVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgHMMvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgHMMvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:51:03 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7D4C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 05:51:02 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id j7so1226608vkk.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 05:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6U+MzbkuK7qE2zWXiIV5fubuG6u2ECbr/eqjOujnCU=;
        b=JmZ+2cVCvH/NJLMcB8pNKwvmqjinr9zVEEkYBcwRynp3GponnTUIozTMBlSYJeFfdu
         zD8Gr/YxyMtB/RJR/6DfEFywcsMIfSWRrl3ggZHURB/YMtF/G3hdC7TLebysrh6wtSD7
         9ftV1qKlcsrxlYfB4KeEN5mi0vMsKes6XHx72Aedcwhs4MDLGD1juvHcouOvufrxtgS3
         pMLyGwMmSw1uCWFgvjSZZ3LIZE7Q7sTiizR01fR8QcaawF6JfindNjLcZN8R9TPVNljU
         TDhHRrvmqgKXeV00svNQfAoQ+RGhYBfSep1c/wkp7oP1r+c6h5wl7cX1DJCstRJVnZKK
         z03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6U+MzbkuK7qE2zWXiIV5fubuG6u2ECbr/eqjOujnCU=;
        b=tT2doD3tDpZKuHLeM4tF1lBBwEorS5JghIEVhUTZ5sQENhQEHD3eJhKSR139M0w1bJ
         DZtOh4jh8A6XZorwUQWKr2h3bJzMc5OUjKWfcxz8D4KEg3lAZkodbPhMOkLDlig9tqJ8
         2G5AC4cX3YVuYTOYyFuvf7CUHUDz8E1DmzvxivnhlJe0Ote2Fj+j7wc1NpW1JqtnWEXn
         9+MXKbymTPOvlUXrRBTudUuck8Yj1wyEeeXBNgMIbutyoLuX8zJaqxA/M0GjG4vJy9W0
         kTYE9wcznJ8EpyPaaT4DEZPDXMYPKFKrA4efNciKK3E0U5Rww7+1SECrGwZBt9rT/PLs
         +4aQ==
X-Gm-Message-State: AOAM531lMJIjmbmenkevY8XwXu2iQ1NbSusvYQN8IpoVZISocZbAN8zE
        5FV1WPo7wgT1SulkbSoKCwyoWV8zaqY=
X-Google-Smtp-Source: ABdhPJzk3fnQMuFDYWkubTIlDS60BxrccXYBFKPO9TsP75thrg4xhIcagJ7v0IZpTnEBrdVRfCk9hA==
X-Received: by 2002:a1f:d387:: with SMTP id k129mr2995210vkg.26.1597323060929;
        Thu, 13 Aug 2020 05:51:00 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id p16sm778739vkf.40.2020.08.13.05.50.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 05:51:00 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id m12so1237682vko.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 05:50:59 -0700 (PDT)
X-Received: by 2002:ac5:c925:: with SMTP id u5mr3013838vkl.68.1597323059280;
 Thu, 13 Aug 2020 05:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200813121310.23016-1-linmiaohe@huawei.com>
In-Reply-To: <20200813121310.23016-1-linmiaohe@huawei.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 13 Aug 2020 14:50:22 +0200
X-Gmail-Original-Message-ID: <CA+FuTSeS9eE_1bsik-0i3qb-WXtQnb3q=mo6+iHOciQjLZ+sHQ@mail.gmail.com>
Message-ID: <CA+FuTSeS9eE_1bsik-0i3qb-WXtQnb3q=mo6+iHOciQjLZ+sHQ@mail.gmail.com>
Subject: Re: [PATCH] net: add missing skb_uarg refcount increment in pskb_carve_inside_header()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Westphal <fw@strlen.de>, martin.varghese@nokia.com,
        pshelar@ovn.org, dcaratti@redhat.com,
        Eric Dumazet <edumazet@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shmulik Ladkani <shmulik@metanetworks.com>,
        Yadu Kishore <kyk.segfault@gmail.com>,
        sowmini.varadhan@oracle.com,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 2:16 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> If the skb is zcopied, we should increase the skb_uarg refcount before we
> involve skb_release_data(). See pskb_expand_head() as a reference.

Did you manage to observe a bug through this datapath in practice?

pskb_carve_inside_header is called
  from pskb_carve
    from pskb_extract
      from rds_tcp_data_recv

That receive path should not see any packets with zerocopy state associated.


> Fixes: 6fa01ccd8830 ("skbuff: Add pskb_extract() helper function")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
