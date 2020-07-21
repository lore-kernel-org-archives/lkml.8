Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86F5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 817ED2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="h3Yuu03b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgGUKTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgGUKTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:19:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B48C0619D9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:19:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so20613597wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=VeNDrBhjoWE2FDcc+COejQI4vRtmFQlWWQalpBKe3iw=;
        b=h3Yuu03b3a+RZR0aykxkNb/7eIfBNJUZoZW2pX1A85kBFF9CW7XRjjeF4AH1dVeZJ4
         3rsWArPRHxCbYsywDBhxyIFWIzEYzfbhbrSJoeM5PlkfFalv4FQi3zb8aCN8sYR4Xtb3
         GObl/tPMIT7qLt+unX3at5nOgs4GFIBOmVO58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=VeNDrBhjoWE2FDcc+COejQI4vRtmFQlWWQalpBKe3iw=;
        b=hRNVo6XNKUMKLy1lkwEEFQHavtu/mXY2j1kVXFrgxuH9nv5exD4dCbuBaAk5ePTc4K
         uP9WY4xpSqdgW5w/qGwvhUREJ5Ei9amMrbkTox6C3c06aVidiBqFYTPHr9c4KPkw+/i3
         JpPPnIU2Eg04oGkxou/pDvNKVKjlo9lXf27gHFc5lEHC0BVqKYp/r+ycbyAMt/xmZ+6+
         xhDK63/GIh9YUGqAOudlnYRNwwTsRiyL1ImuES2frF1pSs2cdw1tFjjUPoWy4QdLzL7I
         DVrJDMhGJubkD5zzB/zAtBneaNQnAiSQYPVQbWsLGImjuCsXCsuKtBa8S43Y8QZC7aVZ
         ed0w==
X-Gm-Message-State: AOAM533aVyNv3GSwwepZaJpkvJbqDB23r44buaQ+D3DnU/NLUMzzkZhe
        2r9bER4ASwqeUvCaa/mAxdIgQA==
X-Google-Smtp-Source: ABdhPJzlj89CEZ/64j2VOxVbnlm6i5eCK/ix8hoOBzMTwL7fXedScdH/sqvkJfL+/2XPB6GssoKIZw==
X-Received: by 2002:adf:8562:: with SMTP id 89mr28112987wrh.57.1595326779538;
        Tue, 21 Jul 2020 03:19:39 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id 33sm40552267wri.16.2020.07.21.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 03:19:39 -0700 (PDT)
References: <20200720194225.17de9962@canb.auug.org.au> <a97220b2-9864-eb49-6e27-0ec5b7e5b977@infradead.org> <20200721044902.24ebe681@canb.auug.org.au> <CAADnVQJNU+tm3WT+JuPoY8TTHWXxQ8OJ0sGCLQGq2Avf+Ri7Yw@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: linux-next: Tree for Jul 20 (kernel/bpf/net_namespace)
In-reply-to: <CAADnVQJNU+tm3WT+JuPoY8TTHWXxQ8OJ0sGCLQGq2Avf+Ri7Yw@mail.gmail.com>
Date:   Tue, 21 Jul 2020 12:19:38 +0200
Message-ID: <87365lxj9h.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 09:37 PM CEST, Alexei Starovoitov wrote:
> On Mon, Jul 20, 2020 at 11:49 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> On Mon, 20 Jul 2020 08:51:54 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
>> >
>> > on i386 or x86_64:
>> >
>> > # CONFIG_INET is not set
>> > # CONFIG_NET_NS is not set
>> >
>> > ld: kernel/bpf/net_namespace.o: in function `bpf_netns_link_release':
>> > net_namespace.c:(.text+0x32c): undefined reference to `bpf_sk_lookup_enabled'
>> > ld: kernel/bpf/net_namespace.o: in function `netns_bpf_link_create':
>> > net_namespace.c:(.text+0x8b7): undefined reference to `bpf_sk_lookup_enabled'
>> > ld: kernel/bpf/net_namespace.o: in function `netns_bpf_pernet_pre_exit':
>> > net_namespace.c:(.ref.text+0xa3): undefined reference to `bpf_sk_lookup_enabled'
>>
>> Caused by commit
>>
>>   1559b4aa1db4 ("inet: Run SK_LOOKUP BPF program on socket lookup")
>>
>> from the bpf-next tree.
>
> Jakub, please take a look.

Sorry about that. Proposed fix:

  https://lore.kernel.org/bpf/20200721100716.720477-1-jakub@cloudflare.com/  
