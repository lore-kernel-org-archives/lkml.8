Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EE9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116A5206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="j0Hz9qCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgENMbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726146AbgENMbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:31:15 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4E3C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:31:15 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n14so2707532qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rXUjuNQKfOwsiQsnf8kbEEKYDtZNdCEYADSwV7JyE7o=;
        b=j0Hz9qCfXTLgLzIb9XaI9TvQpOF1a6NwMMd45yEfuG2KvgPFo6tcD9kq+QTG7iYcHG
         zqtXbZxaeOLZ/XJxQYjZYhzCrqEmNUaMhi5ke4EVXIJmZs9SW71o2KOa+w6cU0UuWpWO
         GIu8Ee81QOUYF7Mgx0P4/U/JvznK9Pdd0hf+Nq3BYmiu8iXA8aO0lyGQjoyJKg8PuC5+
         UhLhLS2Q0EiHfWpeVANgZGDEifWR0YTOC4uahsyk9tB1aldhrinJBhv9aHngCgN2QICl
         eOQvGHPHsNjnVhPh6d3G+WippDrI15t/w+MzTrap5e0Lq2t+9o+F1TiSUnNlhY+2uE6S
         qA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rXUjuNQKfOwsiQsnf8kbEEKYDtZNdCEYADSwV7JyE7o=;
        b=E3jxFTAB9eiTALwGdOrUStVdo+7NsHT9neE3Fu2XOdto2hxNJcTMiuGNynCMakPD9K
         3dFZp6bAqQ6GXRcpBtwTR7c2aEiZUP/z3zZPU/3LNYn0Cgw8+Y+GwHfNC/XfGophVZp5
         OjRk7klEd18R9WRRANoPe/tgyouDKHY2yjebf85i/pApGk+5YvWINRWv6lOsPhSGPeDv
         W2hCYL4kCjFWeUHEkNgSr0NCaSsOGJV0GkXYoRUzXlumujBqzW/f7zi42NkW+6Joglrx
         KIakoP7qfBRbWodsHy6loXOmw9u+IqrsR9OWfxmNc0i+qRkm0ftpJ4Tr7knUS52WmGds
         yKEQ==
X-Gm-Message-State: AOAM533/X1HSn4JeYvMBzrrALkReaaSqxFDZpyPsHaCb4FVcigOj9OOx
        0gQCi/BRh60IIokKOUsqUXhOPQ==
X-Google-Smtp-Source: ABdhPJzsfUagLYdd1iwZS5RuppqKxjj13xRYfKcnhxCAlq+6SV9PHRT4cvrmZGXg9GEM2JjXGkHL9g==
X-Received: by 2002:a37:78c1:: with SMTP id t184mr4527270qkc.213.1589459474634;
        Thu, 14 May 2020 05:31:14 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l184sm1047116qke.115.2020.05.14.05.31.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 05:31:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Default enable RCU list lockdep debugging with PROVE_RCU
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200514222535.259cb69e@canb.auug.org.au>
Date:   Thu, 14 May 2020 08:31:13 -0400
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Amol Grover <frextrite@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ADC503BE-32C0-46BB-A65E-59FFEC30ED57@lca.pw>
References: <20200514222535.259cb69e@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 14, 2020, at 8:25 AM, Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Hi Paul,
>=20
> This patch in the rcu tree
>=20
>  d13fee049fa8 ("Default enable RCU list lockdep debugging with =
PROVE_RCU")
>=20
> is causing whack-a-mole in the syzbot testing of linux-next.  Because
> they always do a debug build of linux-next, no testing is getting =
done. :-(
>=20
> Can we find another way to find all the bugs that are being discovered
> (very slowly)?

Alternatively, could syzbot to use PROVE_RCU=3Dn temporarily because it =
can=E2=80=99t keep up with it? I personally found PROVE_RCU_LIST=3Dy is =
still useful for my linux-next testing, and don=E2=80=99t want to lose =
that coverage overnight.=
