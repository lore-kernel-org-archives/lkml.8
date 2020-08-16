Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71185C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E99B20738
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597600366;
	bh=PNZLstGRrNWbC36WHlMJSZdzQ1Sw7tBWg4/gdy/ZWmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0kTjX3q7lGdadWY/TS3haoLsWI+42OaZiiRtQUPJRr7yFTE+CdtbuyyzwREE6b61S
	 ePs+DLaANx/kULzxx8nSobuW4CZjVg3B8tPAi8An7tOc7EJb/82QTCTsDTMUGzFO2S
	 P9tIOJAc285aY7u2vSBLq6XPGHi1SCaB9rRHuVUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgHPRwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 13:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729507AbgHPRwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 13:52:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3985C061385
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 10:52:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f26so14998773ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PS6YoGVPLniRRR+c8md/gMFUFC1gIYcQxqCkJrdFzyg=;
        b=atHbRpzX6ojST77P61yeW9XWzXo2nLP5AMbcUAvcz94HZSRc7IvqmssoNwyKSnrFTE
         DEQ2JrNhqTbFjWeACmgu2ERhWblD1TEhgmWMUsveOg+GQJ/iTeakIhN3FfG/sEmTox/6
         m6TfjQMw5kejjvlwOkgyOjxOWvqrG3Lh/w3H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PS6YoGVPLniRRR+c8md/gMFUFC1gIYcQxqCkJrdFzyg=;
        b=PcPZVSaZ0eF4h6P/eTuQqoa9/Jem12PVBh1h0d9Xzto0UdP3JD5utLzHtSzDNNX+2R
         c6YL7mNfvzdnFI0wW6vABji4YMEDp4AjGoCg1RIUMgs4FAqORu1B//Kg7K4hpeRAMxXb
         MpJzm7Vh5dc/nXSw8HC2WVzUwSewkM5cCcek3UA2PxuXB6R7aUPiXDRVuwzgLE16ULFQ
         Z9PK61LE9vXsBl+WFPUro4aP0+YMt+o22fSKNspNCb4vZGlwEJb+OlHE6m1IqgWGivrJ
         s1PizI3/hGYXSIX4yeBX0Zcpg9ABqHHwQdvC7bQzejC8OkPvkYDQetRoxqfHt9w+2QI+
         z1Cg==
X-Gm-Message-State: AOAM533mUY/M2WCZOck2Jw8FAt+GD5LtJunT4uoOm/iD/dMSr9YrLf1/
        NUK8+fpF3gXo8oOG2oIo1wiAgZn5EWcOjg==
X-Google-Smtp-Source: ABdhPJyt5UzCn7+DAkCXJPaZHCrUZ/Qv/zx1g865hO9wJhyLFoXm9yzfBc6B2rPoQOqpSERHx1mhZA==
X-Received: by 2002:a2e:9e8a:: with SMTP id f10mr5308279ljk.330.1597600358602;
        Sun, 16 Aug 2020 10:52:38 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id c4sm4369229lfs.27.2020.08.16.10.52.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2020 10:52:37 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id v9so15028965ljk.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 10:52:37 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr5330870ljh.70.1597600356971;
 Sun, 16 Aug 2020 10:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200816142403.15449-1-rppt@kernel.org> <20200816144209.GH17456@casper.infradead.org>
 <20200816174343.GK752365@kernel.org>
In-Reply-To: <20200816174343.GK752365@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 Aug 2020 10:52:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPUKCC490nd6Y5A1Sq=VpTpO=Li5cYb0iztp-x19nqiA@mail.gmail.com>
Message-ID: <CAHk-=wiPUKCC490nd6Y5A1Sq=VpTpO=Li5cYb0iztp-x19nqiA@mail.gmail.com>
Subject: Re: [PATCH] parisc: fix PMD pages allocation by restoring pmd_alloc_one()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Helge Deller <deller@gmx.de>,
        linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Pekka Enberg <penberg@kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 10:43 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> I presume this is going via parisc tree, do you mind fixing up
> while applying?

I'll take it directly to not miss rc1, and I'll fix up the typo too.

              Linus
