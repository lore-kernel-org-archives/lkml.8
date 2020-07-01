Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EC7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19A12078A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VTM6A29f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbgGARYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731729AbgGARYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:24:30 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861E7C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 10:24:30 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id j202so12338093ybg.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbQ2TwlK1ou1Ma/Xntr4lOXZG1PyrbxTETwL1Zwcz+A=;
        b=VTM6A29fMksR+jLIk4hzEITA6mEAe8z0nVSebp5yTOPRqWvnoF9TgfYYEVpaPilR9r
         kBSNimBDp0aVh6H/aZgFnPoxdga96mR9YwVlkNxDBH779WFaipWno5QhbzIjjU5jLZZK
         v9HaQVZI3c0Hkhud+e+Vnrw6iC7KGBzc2IkTeioMLlnaRWy4vp3Y39cU0BTNXH9lypGp
         xef7EM/Cr9D32ved1AtnJA4tZyxUzpUj1kGmH9SQF09gG6BW3GcWgw7VpLQ1PTaUI/EX
         nA87r3j1mInKEIPyCwyZxcRCpcu7LjzyZ7C45xKahATrMjqaXtxBvg0bBr+M/hZo3LSh
         z/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbQ2TwlK1ou1Ma/Xntr4lOXZG1PyrbxTETwL1Zwcz+A=;
        b=lZL6GP6xMS5gkL75uMwYikuQp3fROZfj9sieaj4qbME6PkFzElb9O93vNubymWpmba
         4laRf6rvoSmRwqYneyIi3uWOkRHt7eZfGsoVlIFuqL4K9UhQ7Qeot22DvW/R9OYZ9Nq5
         1Ggw7i0wMC+whFGkAlq11b8N8DLT3ur4ZWitgKIuAZgwmNoahdj6onHLyUynhhf6yfE9
         B7QVow6hsFu4c3BtGlmdbmAyNOBEe3einoL26UfK6gSehsj8EaW63vlVr9yeBaqOVst5
         D4fJJ/roPMOLrqa46Q0+nI2xmdxOI2V1wLVT5MZxARN1lbaUISEw/647ewuxlaI+q5hX
         re9g==
X-Gm-Message-State: AOAM5315xdvHQKzIO4M8+nNVIoju0PZ/vCLh3DmjXwGfP1iM5+EF/LSl
        sfDQFc2igiaUY+LAGHOxpSibi7TbRHT2wxLiu4Ix1g==
X-Google-Smtp-Source: ABdhPJwgMw7io6kgtoOi1LbwpSmAzkR4pT1XuoEH6U4zwyHIZzjTT4UeD1AZHIePd0j8W2OavnRqH/5Y5mA4io3g8ME=
X-Received: by 2002:a25:b7cc:: with SMTP id u12mr28668328ybj.173.1593624269359;
 Wed, 01 Jul 2020 10:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjEghg5_pX_GhNP+BfcUK6CRZ+4mh3bciitm9JwXvR7aQ@mail.gmail.com>
 <312079189.17903.1593549293094.JavaMail.zimbra@efficios.com>
 <CANn89iJ+rkMrLrHrKXO-57frXNb32epB93LYLRuHX00uWc-0Uw@mail.gmail.com>
 <20200630.134429.1590957032456466647.davem@davemloft.net> <CANn89i+b-LeaPvaaHvj0yc0mJ2qwZ0981fQHVp0+sqXYp=kdkA@mail.gmail.com>
 <474095696.17969.1593551866537.JavaMail.zimbra@efficios.com>
 <CANn89iKK2+pznYZoKZzdCu4qkA7BjJZFqc6ABof4iaS-T-9_aw@mail.gmail.com>
 <CANn89i+_DUrKROb1Zkk_nmngkD=oy9UjbxwnkgyzGB=z+SKg3g@mail.gmail.com> <CANn89iJJ_WR-jGQogU3-arjD6=xcU9VWzJYSOLbyD94JQo-zAQ@mail.gmail.com>
In-Reply-To: <CANn89iJJ_WR-jGQogU3-arjD6=xcU9VWzJYSOLbyD94JQo-zAQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 1 Jul 2020 10:24:17 -0700
Message-ID: <CANn89i+bomkxUcUMghsS9wA5MfTwbVL9vNCzKCidAG8nxNZQ0Q@mail.gmail.com>
Subject: Re: [regression] TCP_MD5SIG on established sockets
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Jonathan Rajotte-Julien <joraj@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 3:07 PM Eric Dumazet <edumazet@google.com> wrote:

> Oh well, tcp_syn_options() is supposed to have the same logic.
>
> Maybe we have an issue with SYNCOOKIES (with MD5 + TS + SACK)
>
> Nice can of worms.


Yes, MD5 does not like SYNCOOKIES in some cases.

In this trace, S is a linux host, the SYNACK is a syncookie.

C host is attempting a SYN with MD5+TS+SACK, which a standard linux
host would not attempt.
But we could expect another stack to attempt this combination.

TCP stack believes it can encode selected TCP options (in the TSVAL value),
but since MD5 option is set, TS option is not sent in the SYNACK.
However we still send other options that MUST not be sent if TS option
could not fit the TCP option space.

10:12:15.464591 IP C > S: Flags [S], seq 4202415601, win 65535,
options [nop,nop,md5 valid,mss 65495,sackOK,TS val 456965269 ecr
0,nop,wscale 8], length 0
10:12:15.464602 IP S > C: Flags [S.], seq 253516766, ack 4202415602,
win 65535, options [nop,nop,md5 valid,mss
65495,nop,nop,sackOK,nop,wscale 8], length 0

<When ACK packets comes back from client, the server has no state and
no TS ecr value, so must assume no option was negotiated>

10:12:15.464611 IP C > S: Flags [.], ack 1, win 256, options
[nop,nop,md5 valid], length 0
10:12:15.464678 IP C > S: Flags [P.], seq 1:13, ack 1, win 256,
options [nop,nop,md5 valid], length 12
10:12:15.464685 IP S > C: Flags [.], ack 13, win 65535, options
[nop,nop,md5 valid], length 0

We can see for instance the windows are wrong by a 256 factor (wscale 8)
