Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1692C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7848D21481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca/oRwxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgIGJGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgIGJGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:06:13 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910BDC061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 02:06:13 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id l1so3967394uai.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 02:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3oRTx/EEw7OvkP6TqTj990KKl+YkLOb6ElATdVMgf+c=;
        b=ca/oRwxvnOIcH5J4vfm1v0v+QoBEOoIldZVZh7YMa3WP1dtN77B3B+K7IlXxmTHeMQ
         qxbxI6EGosDBjKPZXRvSeZDDQwptN8R3Gbxf7e5ReVyVIfzXB2BO95B+cr94ZG0Qh/1P
         bufJ3LftknpuZXaBuflAmHJZHdD4DNUIF53MIdqR+rDExN5l7h/CXX2m6jTJ/dJtd75v
         5xSQOdXdoPCEUbZpbzaNA74ow4J0rtRf9gqde/k9H1NzfV9PHmQWsEKtFFZU9GAVEdk/
         z4/IOTWFLfv0kmLVLl3bX4P2zuUYQMCZ7M6kBXQJu/BMR8qSylkIxhKNlBVtdG8+mfZc
         zrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3oRTx/EEw7OvkP6TqTj990KKl+YkLOb6ElATdVMgf+c=;
        b=Wgug8Sj1tqxtr7Hd/YF8Ir+SN6ZKgSbVSYQjgrwkjp2tnPiRSErPyDUZp6RMLr1TGZ
         yOEmVMARmWx4F55Gj+kj+LyWwTViXErAVHb3yPJSz3gDa5pQgWU3fsSNBCdTTCWerO7m
         qHqrFMBaVBvyWbFprdHcPXz2WCP852+z265zYWAwLF5o1IL2npYiCOoAi9q7FVVJYw4E
         O21bXIC8r0pT66tdMUF34X+HAS225fJZsjL/RTGjt1l6EQe6VK02sGkbqjGszK79o/9A
         ucQMYXWJu7AY9jXLSlfZAtPiaxnteXXq81+VNwlQ+C7OrRXwDnbo/EPoC0Al5TgSPK47
         vHKA==
X-Gm-Message-State: AOAM531dALal2BCZYjg7n5dhBe0hSemNseKSiPhCGE1alKKgFnJMnkEl
        LKwA2nlFGw+7LU3oqqvV5haSvSx7p2TMMw==
X-Google-Smtp-Source: ABdhPJxPb4rM23jiw6o2S0YmHBFCNOr1qPbZ66qsYZZBQF3KZ/T131R1zpweXjOyj97Bd0Sj2NgjbA==
X-Received: by 2002:ab0:1d99:: with SMTP id l25mr3415401uak.56.1599469571280;
        Mon, 07 Sep 2020 02:06:11 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id y13sm539085vsm.15.2020.09.07.02.06.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 02:06:10 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id u48so3975363uau.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 02:06:10 -0700 (PDT)
X-Received: by 2002:ab0:24cd:: with SMTP id k13mr10181505uan.92.1599469569684;
 Mon, 07 Sep 2020 02:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAJht_EOu8GKvdTAeF_rHsaKu7iYOmW8C64bQA21bgKuiANE5Zw@mail.gmail.com>
 <CAJht_EP=g02o2ygihNo=EWd1OuL3HSjmhqgGiwUGrMde=urSUA@mail.gmail.com>
In-Reply-To: <CAJht_EP=g02o2ygihNo=EWd1OuL3HSjmhqgGiwUGrMde=urSUA@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 7 Sep 2020 11:05:31 +0200
X-Gmail-Original-Message-ID: <CA+FuTSdm35x9nA259JgOWcCWJto9MVMHGGgamPPsgnpsTmPO8g@mail.gmail.com>
Message-ID: <CA+FuTSdm35x9nA259JgOWcCWJto9MVMHGGgamPPsgnpsTmPO8g@mail.gmail.com>
Subject: Re: Question about dev_validate_header used in af_packet.c
To:     Xie He <xie.he.0141@gmail.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 6, 2020 at 1:21 AM Xie He <xie.he.0141@gmail.com> wrote:
>
> On Sat, Sep 5, 2020 at 3:24 PM Xie He <xie.he.0141@gmail.com> wrote:
> >
> > Hi Willem,
> >
> > I have a question about the function dev_validate_header used in
> > af_packet.c. Can you help me? Thanks!
> >
> > I see when the length of the data is smaller than hard_header_len, and
> > when the user is "capable" enough, the function will accept it and pad
> > it with 0s, without validating the header with header_ops->validate.
> >
> > But I think if the driver is able to accept variable-length LL
> > headers, shouldn't we just pass the data to header_ops->validate and
> > let it check the header's validity, and then just pass the validated
> > data to the driver for transmission?
> >
> > Why when the user is "capable" enough, can it bypass the
> > header_ops->validate check? And why do we need to pad the data with
> > 0s? Won't this make the driver confused about the real length of the
> > data?
>
> Oh. I just realized that the padding of zeros won't actually make the
> data longer. The padded zeros are not part of the data so the length
> of the data is kept unchanged. The padding is probably because some
> weird drivers are expecting this. (What drivers are them? Can we fix
> them?)
>
> I can also understand now the ability of a "capable" user to bypass
> the header_ops->validate check. It is probably for testing purposes.
> (Does this mean the root user will always bypass this check?)

Apologies for the delay.

The commit that introduced the code probably summarizes state better
than I would write off the cuff:

"
commit 2793a23aacbd754dbbb5cb75093deb7e4103bace
Author: Willem de Bruijn <willemb@google.com>
Date:   Wed Mar 9 21:58:32 2016 -0500

    net: validate variable length ll headers

    Netdevice parameter hard_header_len is variously interpreted both as
    an upper and lower bound on link layer header length. The field is
    used as upper bound when reserving room at allocation, as lower bound
    when validating user input in PF_PACKET.

    Clarify the definition to be maximum header length. For validation
    of untrusted headers, add an optional validate member to header_ops.

    Allow bypassing of validation by passing CAP_SYS_RAWIO, for instance
    for deliberate testing of corrupt input. In this case, pad trailing
    bytes, as some device drivers expect completely initialized headers.

    See also http://comments.gmane.org/gmane.linux.network/401064

    Signed-off-by: Willem de Bruijn <willemb@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>
"

The CAP_SYS_RAWIO exception indeed was requested to be able to
purposely test devices against bad inputs. The gmane link
unfortunately no longer works, but this was the discussion thread:
https://www.mail-archive.com/netdev@vger.kernel.org/msg99920.html

It zeroes the packet up max_header_len to ensure that an unintentional
short packet will at least not result in reading undefined data. Now
that the dust has settled around the min_header_len/max_header_len
changes, maybe now is a good time to revisit removing that
CAP_SYS_RAWIO loophole.
