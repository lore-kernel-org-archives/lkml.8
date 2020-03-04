Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E12C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5BD20870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FrMlwWsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387667AbgCDIpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:45:13 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33690 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgCDIpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:45:12 -0500
Received: by mail-ot1-f65.google.com with SMTP id a20so1260302otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 00:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ma8ZuzcCeVEH6377/YAf0HxDb+sbrr8YMMlgCfFH6Lk=;
        b=FrMlwWsM6VLOsyh8IR/l2AzoOl3oFGBHNGhVWnWt1/tr3WhRWPJ0BMj3yX6YGBMea/
         TQXGkaFBa4jar3k26oX5MaEcapBB2a9JrNsHVM3OA9DUIQ5UDooYIFTp46eOZKBkaMDc
         08Zcri9aN5WHeb0oDzOIOw4JngUyWipsbPvd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ma8ZuzcCeVEH6377/YAf0HxDb+sbrr8YMMlgCfFH6Lk=;
        b=o2HxduhwweDgqnJ6zJWz19GQrUIW5p5rmFdAlsgjbF8tPOTxCO51riKdNT3KO+yiqL
         7RgLMpI9kb9ceJ8HFzYTMHAO7IY3CAqD8jE9k7DVId9VU+GXD0Yqr23qyHm6Ias2dx6M
         1OKZcWDgVQc7Kzgspl8ye29cxbmDpePHrIfn9HQ6safS7BoNsxMHVPTqCgTENR3vTWDg
         pfdZEzQhtR62Uqbrhz0Vepj03qz9M+GrdXQHhNrHCyKHGo+JIEEgvOcBd46nCXNUFw3x
         84wD7k3KWHqh3ukWuwhGVp/mxD6ET7AJNOV15GwQ/CnKBV5slOe2NEypqpgIsveLy7ef
         azrg==
X-Gm-Message-State: ANhLgQ3JFlxEWkAaRDAbXFujWB/bKub5IJO9SAbxk/FUutriQbS4BMYN
        lXBFJDPR688wof50YYxaJMwKK5AGuwxbMTP8ukH6hKOTdivyYA==
X-Google-Smtp-Source: ADFU+vszsCH0gAioTE/0Oo9bJUmXm+Eq3B6gwTKHp5hf/N0BfkJM6SCshdG+Ifs/jv7uE2DSKKOkCsuTMscyII1dFjw=
X-Received: by 2002:a9d:10d:: with SMTP id 13mr1579216otu.334.1583311509322;
 Wed, 04 Mar 2020 00:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20200228115344.17742-1-lmb@cloudflare.com> <20200228115344.17742-4-lmb@cloudflare.com>
 <20200303175051.zcxmo3c257pfpj7f@kafai-mbp>
In-Reply-To: <20200303175051.zcxmo3c257pfpj7f@kafai-mbp>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 4 Mar 2020 09:44:57 +0100
Message-ID: <CACAyw9_Ewe86YYgdffhz3dVaPPMnXeckMYhoPn+umvhAShtnBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/9] bpf: sockmap: move generic sockmap hooks
 from BPF TCP
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 at 18:51, Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Feb 28, 2020 at 11:53:38AM +0000, Lorenz Bauer wrote:
> > The close, unhash and clone handlers from TCP sockmap are actually generic,
> > and can be reused by UDP sockmap. Move the helpers into the sockmap code
> Is clone reused in UDP?

No, my bad. I'll update the commit message.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
