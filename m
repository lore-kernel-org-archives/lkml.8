Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6942C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 00:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9599A20738
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 00:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDFC28TN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgHBA6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 20:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHBA6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 20:58:41 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB65DC06174A;
        Sat,  1 Aug 2020 17:58:41 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id f9so9523128pju.4;
        Sat, 01 Aug 2020 17:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wtd1dTqkIQZNG0/L93HORXN7DmmIz2UILlkYQcDT6aM=;
        b=cDFC28TNCnBL9i2dwpdgSVKxiqUVFYdv7Is61GyKTALJ4OkNnKxhn7wQw0NdfUPgNT
         h659nPgUZhPC5HqFoFN+Hw250ELXr6du7JHOpzb4B5Oz+bC/xDfRUTqcV+9twoL4SDf0
         4mpXQpLJDoGZt1MG6A1bsyi8jIRbqmeUoau0G3Hq8XM9JHLtMsYGNOCaDsWyoCZk/ePd
         ukBM4BcNquw1FBowrXsJIJX+0Y2O7kpuq/1WdnKLyN/R/c4poi8YCRt4Cy+h4C9QNT8C
         /J9GROMbyEeZjsySqm4LoZe2owKJ0gLpoVRYOmwN2ittIlmtobeKMWi5AYTSNFb3owkd
         sEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wtd1dTqkIQZNG0/L93HORXN7DmmIz2UILlkYQcDT6aM=;
        b=k3rLcVBRPpruqowVoObdEAs+qdXbBKSOnlxm/vBofk3NbuenSIEg1j+bAgIILGsko5
         x5K9R8h3Ik8pC9z+UdhdUJdckXzBwQYGrUgGSc9FjePZr5u9awDHsCfzGOoiNpMFzZFy
         hcyAdYYDnercKpEcEUxPLH3rW1sXdBuTSRO0Y4ygBUZi4Cyj3HfVjrG87udy2AaD+mwS
         O5uKbtDc3zzyL/Nin8NZGwv3lu3hqsAvxEJwRhi+1pfo5MQzFyq2vSx/0f5x2mCabeEH
         uoXMWCUoAEdFX4vqVBIXWJcUHwxxSeDWQUQEKUZ7yAHtkGjADgt1rbBUSBjlpPt/ZdXm
         5Hvw==
X-Gm-Message-State: AOAM530nYxOEDnDKWI8CklejcXN0sJd7rhQsdNdgEQcMnqiHeyxnjVKY
        5IPCOGYSR10TEhP+7hnTxDvCTVYWjI62oAaOq7E=
X-Google-Smtp-Source: ABdhPJzPBLsWF2rZygMeBjB8RfVFHbGp7efQqNHqgIP4lm9QeoY43S6Ay+IW2SbZNYx1HkPMGzhRhuvBpvLvZzvBdz8=
X-Received: by 2002:a17:90b:128e:: with SMTP id fw14mr10858638pjb.66.1596329921179;
 Sat, 01 Aug 2020 17:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200730073702.16887-1-xie.he.0141@gmail.com> <CAJht_ENjHRExBEHx--xmqnOy1MXY_6F5XZ_exinSfa6xU_XDJg@mail.gmail.com>
 <CA+FuTSf_nuiah6rFy-KC1Taw+Wc4z0G7LzkAm-+Ms4FzYmTPEw@mail.gmail.com>
 <CAJht_ENYxy4pseOO9gY=0R0bvPPvs4GKrGJOUMx6=LPwBa2+Bg@mail.gmail.com>
 <CA+FuTSeusqdfkqZihFhTE9vhcL5or6DEh8UffaKM2Px82z6BZQ@mail.gmail.com>
 <CAJht_EO4b=jC8KarwZyF1M3T57MrFCDvo-+Agnm9qD4pSCmODQ@mail.gmail.com> <CA+FuTSdJ1c0R2qmKtm9vWpKnMv=-B0yAaronGkqg=jYZBfqceA@mail.gmail.com>
In-Reply-To: <CA+FuTSdJ1c0R2qmKtm9vWpKnMv=-B0yAaronGkqg=jYZBfqceA@mail.gmail.com>
From:   Xie He <xie.he.0141@gmail.com>
Date:   Sat, 1 Aug 2020 17:58:30 -0700
Message-ID: <CAJht_EOdrnuYn0COTW-6kEivbq+1FqzNnWgs8E_xsdyD_pwomA@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux X25 <linux-x25@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 1, 2020 at 6:31 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> The kernel interface cannot be changed. If packet sockets used to pass
> the first byte up to userspace, they have to continue to do so.
>
> So I think you can limit the header_ops to only dev_hard_header.

Actually if we want to keep the kernel interface unchanged, we
shouldn't implement header_ops for dev_hard_header either, because
this changes the way the user space program sends DGRAM packets, too.
Before the change the userspace program needs to add the 1-byte header
before sending, and after the change the userspace program will let
the kernel add the header via dev_hard_header.

> Fixes should be small and targeted. Any larger refactoring is
> best addressed in a separate net-next patch.

I guess the best way for this fix patch would be just add a 0-byte
packet check before the driver reads skb->data[0].

Thanks! I'll add the check and re-send the patch.
