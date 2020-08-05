Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BEAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 262C92076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fHDQmOPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgHET4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgHEQoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:44:13 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B29C034607
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 04:56:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id m22so2988996eje.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 04:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EFzCfSOy2IvutgdDhPs5RnGz6j56czFjRkJZIjDwC5E=;
        b=fHDQmOPFaJvbXbvEliSuXqTAPHK8v552b9np6X9cWK6tTGWtQJ8LY3S0vJn2HS00rJ
         gVpdofbnaxr9+tJ+Mqj1cFGgRzfxwqq+vkUzACPs5rGvCTBqKNfOo+qeWAS+wlxzEwx6
         SKI85B2YDPDIN9J5DECiCM+0m7oOnfVCzXQdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EFzCfSOy2IvutgdDhPs5RnGz6j56czFjRkJZIjDwC5E=;
        b=H7urJGnZQu/YFa4r3vVqHqjw5NHhrssBibABXrP5FuBpHar60q/MS4Dy7NXn5zgEL1
         55yJgP6ItIKwqexcYvfxiHiUIM5iiGKnP+6FiDuTQsZ+6ryEHchplAE1cWwJE9jXnHWp
         rACq7FUvio4Pk3x4mg8IoKH51iQRYaKeoZRApr345P008kmtLkDJfSBAUM0Q6f62tmX9
         1JMhkAjeRLXBul62tr9TPoOuTy+t6HjYBgjePFabWImv4QEdhA8CBzAJlzleIpW4XQWi
         zN4H8266btq1mwsruJEYJ+r8Z9ydEMFTRoaBjTOUrmusV8Fyuq2qcr9Eh+3rVlEuQibf
         0oPQ==
X-Gm-Message-State: AOAM532s5OSyU63M9uCeliXSXQ234U0S/1ikzwow2t3FqvKXvnh0E3xA
        3ePeMQhfdzDEBzpDabNpZiWH0A4vE6h+vOnL1aRxyA==
X-Google-Smtp-Source: ABdhPJwmuCMEiB1hUFa5v+mcjhs87JwPL8sH9pgCYuW0w9XS34zg5ONW/347iIy+Lf6dRHfU4LRWES4+b7uEih/9ov0=
X-Received: by 2002:a17:906:22c1:: with SMTP id q1mr2735858eja.443.1596628572819;
 Wed, 05 Aug 2020 04:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
 <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
 <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
 <1293241.1595501326@warthog.procyon.org.uk> <CAJfpeguvLMCw1H8+DPsfZE_k0sEiRtA17pD9HjnceSsAvqqAZw@mail.gmail.com>
 <43c061d26ddef2aa3ca1ac726da7db9ab461e7be.camel@themaw.net>
 <CAJfpeguFkDDhz7+70pSUv_j=xY5L08ESpaE+jER9vE5p+ZmfFw@mail.gmail.com>
 <c558fc4af785f62a2751be3b297d1ccbbfcfa969.camel@themaw.net>
 <CAJfpegvxKTy+4Zk6banvxQ83PeFV7Xnt2Qv=kkOg57rxFKqVEg@mail.gmail.com> <013e9bb3cb1536c73a5b58c5ff000b3b00629561.camel@themaw.net>
In-Reply-To: <013e9bb3cb1536c73a5b58c5ff000b3b00629561.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 13:56:01 +0200
Message-ID: <CAJfpegvT-UznTC5CT1kjVF=Gr+DfTJXKj5CEkP67G9zFhjLMEg@mail.gmail.com>
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute
 change notifications [ver #5]
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 1:36 PM Ian Kent <raven@themaw.net> wrote:
>

> I can see in the kernel code that an error is returned if the message
> buffer is full when trying to add a message, I just can't see where
> to get it in the libmount code.
>
> That's not really a communication protocol problem.
>
> Still I need to work out how to detect it, maybe it is seen by
> the code in libmount already and I simply can't see what I need
> to do to recognise it ...
>
> So I'm stuck wanting to verify I have got everything that was
> sent and am having trouble moving on from that.

This is the commit that should add the overrun detection capability:

e7d553d69cf6 ("pipe: Add notification lossage handling")

Thanks,
Miklos
