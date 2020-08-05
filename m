Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BBAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53712075A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oenfg43n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgHEJeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgHEJdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:33:51 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A98C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 02:33:50 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id q13so15379957vsn.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 02:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zv3njctJm6+JcXZYqCty4/Sd4dBn0kL3k7iTzjdDtfw=;
        b=oenfg43n0bbPqzDbC7M2gy1BFz6L4j5HVCwHLtU/Pd/u1lL9Q8XQe9N2tV7UufJLBo
         MATyUl4G6KT941Gq5GWK1IRQAUrFB+lObmZPz6DsWSFZIk98PEkOpyS44op89AjF0Yhc
         /nCPtftT2HFYYw1+IL9n60Qm0Rse1uvZQdFsSt1qycaGxhSvOLb2GrZKd3IQdGpnbER7
         55M2mlDFMUTcf3/1WW8TpGa8ffoPYhK6NHu8G+w75fYXZQNHZYmxpY7ENGI8aJd1IqbQ
         COcN6TjLK7eeGurWWCYgSthmkkpR2GYKwx/B6sEXmj3k30YgV+xNiFNNEZmqWstxYnmp
         HSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zv3njctJm6+JcXZYqCty4/Sd4dBn0kL3k7iTzjdDtfw=;
        b=Ocn/ZC+jAHuCthm+KXQ0Q7sX9FHQ2lYiY5AciAVVgg1DmA6Vqa3dG1+CDzktBrRbS4
         EXu9HuIGUkHoMXfS9o85Vyvn/AqcQlQJeUuYtrBE4jO6D9VCKV+rQw3ktycoXZUBOWAx
         cFyCp9aWZOmsoKZYeCBWPLeQmQfFbG2ka6Fhm6G5y6kau7hT3A3CbXdjpKZ2IqhqHeTe
         y+2eUOLwhJ3WaEHlB4PZHs8s3CNV8KwNygWqWoiikGx/fM4oXVMCHJNcWeX51Z1qdxQk
         TjG6fWFB1VfAQVs5iKSIpnh3CznlgrY319Et7ceVTerrtz+gveuZlVXxT/xxOIs0ZFUN
         0STw==
X-Gm-Message-State: AOAM533gNTjiYRNQYiWhRYDaaprxKMgIgFB0ZWYLQuskt6BPmpVIpR2w
        MUK/r2cOsnSStyI/SMaSGe3HFnwjX3o=
X-Google-Smtp-Source: ABdhPJz9DetEpr+JggdbpwnCU/0O5SB8cvNYe/SawqCatmijrG/yrCcsNGtUD81fBEMCDTWgO9nAeA==
X-Received: by 2002:a67:e08d:: with SMTP id f13mr1225723vsl.84.1596620029433;
        Wed, 05 Aug 2020 02:33:49 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id m62sm232626vsd.21.2020.08.05.02.33.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 02:33:48 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id p8so14849556vsm.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 02:33:48 -0700 (PDT)
X-Received: by 2002:a05:6102:517:: with SMTP id l23mr1162285vsa.114.1596620027960;
 Wed, 05 Aug 2020 02:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200802195046.402539-1-xie.he.0141@gmail.com>
 <d02996f90f64d55d5c5e349560bfde46@dev.tdt.de> <CAJht_ENuzbyYesYtP0703xgRwRBTY9SySe3oXLEtkyL_H_yTSQ@mail.gmail.com>
 <9975370f14b8ddeafc8dec7bc6c0878a@dev.tdt.de> <CAJht_EMf5i1qykEP6sZjLBcPAN9u9oQoZ34dfJ68Z5XL6rKuDQ@mail.gmail.com>
In-Reply-To: <CAJht_EMf5i1qykEP6sZjLBcPAN9u9oQoZ34dfJ68Z5XL6rKuDQ@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 5 Aug 2020 11:33:10 +0200
X-Gmail-Original-Message-ID: <CA+FuTSf2r1eFoFHov-cGDG=5iLAUGt+Jv7Aok7EFrVo8UqkJog@mail.gmail.com>
Message-ID: <CA+FuTSf2r1eFoFHov-cGDG=5iLAUGt+Jv7Aok7EFrVo8UqkJog@mail.gmail.com>
Subject: Re: [net v3] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
To:     Xie He <xie.he.0141@gmail.com>
Cc:     Martin Schiller <ms@dev.tdt.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux X25 <linux-x25@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        netdev-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 10:57 AM Xie He <xie.he.0141@gmail.com> wrote:
>
> On Tue, Aug 4, 2020 at 10:23 PM Martin Schiller <ms@dev.tdt.de> wrote:
> >
> > > Adding skb_cow before these skb_push calls would indeed help
> > > preventing kernel panics, but that might not be the essential issue
> > > here, and it might also prevent us from discovering the real issue. (I
> > > guess this is also the reason skb_cow is not included in skb_push
> > > itself.)
> >
> > Well, you are right that the panic is "useful" to discover the real
> > problem. But on the other hand, if it is possible to prevent a panic, I
> > think we should do so. Maybe with adding a warning, when skb_cow() needs
> > to reallocate memory.
> >
> > But this is getting a little bit off topic. For this patch I can say:
> >
> > LGTM.
> >
> > Reviewed-by: Martin Schiller <ms@dev.tdt.de>
>
> Thank you so much!
>
> Yes, it might be better to use skb_cow with a warning so that we can
> prevent kernel panic while still being able to discover the problem.

Let's not add defenses to work around possibly buggy code. In the long
run that reduces code quality. Instead, fix bugs at the source.
