Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07948C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A9E20721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ua35ReYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgAJN1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:27:34 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:42620 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgAJN1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:27:32 -0500
Received: by mail-oi1-f170.google.com with SMTP id 18so1804794oin.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 05:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AUwd8glpr6kfXtb89k6x9PBA9ykDSCHrcjOXwyj5hTA=;
        b=Ua35ReYLIwp5dAjcfnRe5d717jLPnKQgnOXgwoQa55EKXMOyC62yk19zvYaYTRpOk9
         W3EkIJ8KAInm0Gi/SBabPmttucc5vhWdBkJCWmCCM2YFIRGDXIl0x1owC9dTR7zBbJaV
         WWz4MAs/RlsTY82k3bvZe1mgkRTBbDbwbYdhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUwd8glpr6kfXtb89k6x9PBA9ykDSCHrcjOXwyj5hTA=;
        b=BqVM0yob9ziHmbQbOcGnWlVrn3e6tpJtfWs2Js9FV4a9WSremtdiqkR9pE202geGs0
         UE/sdRIie9LU/pCZ2gwvsvGZVrjStXqNaoJUNIDZmfTGU/naX5X5EHg7edoLdMmeOGjQ
         QnQD6tUgIWwp7pHB/eq/15cRm2dTuw3LjnUwN8I8c28LZkpcw+F4Rne7x13ntG3LauMi
         wotoQObRe67yIIYDAw6apVLCEaQu4tRQF/hAbjUgTQQ/EQtA82wDenrJpbs8iA89ixC/
         hiIXq3z1dOS4Je4Ou/GJTlMbxXOb7WOZda4/0TQigg/ttinJ4iTamSLD6hqWkeNChoOU
         k54g==
X-Gm-Message-State: APjAAAUMX/lWxUWeuMBIsACUFquPUGGzgTVVJuIJ6YO4jUoNA9MhsBpp
        Swd5sK7XbvoGJWMgzk/lMUgJBTfSqi530BsQq3fLk2fCHHM=
X-Google-Smtp-Source: APXvYqxEQdRC03cg2f9SLLL9UIZBDwiOjLVn6ykjZjCp6YeJgL1s35yJA44vdEuwG59QZYLKKl73qp4FjS+FnaXcQI8=
X-Received: by 2002:aca:b60a:: with SMTP id g10mr2064783oif.102.1578662851371;
 Fri, 10 Jan 2020 05:27:31 -0800 (PST)
MIME-Version: 1.0
References: <20200109115749.12283-1-lmb@cloudflare.com> <20200109115749.12283-2-lmb@cloudflare.com>
 <20200109182335.um72tp73krvvubnl@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200109182335.um72tp73krvvubnl@kafai-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 10 Jan 2020 13:27:19 +0000
Message-ID: <CACAyw98A_Y1r0S9jDQds332whureyxRRZCDhFbXV6Bo9NsG4NQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/1] net: bpf: don't leak time wait and request sockets
To:     Martin Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Joe Stringer <joe@isovalent.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>,
        "edumazet@google.com" <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020 at 18:23, Martin Lau <kafai@fb.com> wrote:
>
> Would this work too?
>         if (!sk_fullsock(sk) || !sock_flag(sk, SOCK_RCU_FREE))

Thank you for the suggestion, this makes the patch much nicer.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
