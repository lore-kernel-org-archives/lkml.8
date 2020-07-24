Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AE3C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A3B2206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnFXeLiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgGXFf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 01:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgGXFf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 01:35:29 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6523CC0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 22:35:29 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c25so6132032otf.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 22:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EpP1x6fpBcJRRTFRXnW5L0tvhqkIz94dWPm8oCXCSGg=;
        b=TnFXeLiZoPhmCJGn8MBfTPcOm2/alOEcWuJYiXGsR74hLyq8npnNYkfGYGbkbfwgqU
         NysP9hCDCaYUcSwSda/DO1KqMRNq0vB/6jFQI/OqnqT/ZOuMxKkiAYUBC5WOBddI9m5v
         Cz8hML9K27X9jN9kBfbzNpvYMuWvCxYRnsZkPUxEBlBvgunagLSs0G/7CVEyzcmYABBC
         JU/8JzAYYydFd+IQMbV8ews2kyd0hdKCEQFnEsU2qpBALoRmiFzgDNYEJ7fEJ2GiRRuM
         aYWTJUu4e8sRyFhycyURKVNuYmp9QAVdG5HPmniDK7mZLZNJZ4RpFc+g7ajDULqsyBSs
         N9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EpP1x6fpBcJRRTFRXnW5L0tvhqkIz94dWPm8oCXCSGg=;
        b=ZW8tjx19LAzqzk/ZKL/w7niILDINQqoVRUh5mFI8LSvQtYfewOrgwqr3t3i7KlUE4D
         2w2G/OyoxwdHwzvuDveHHjqV8SqH4KXctKWcRdkm1S7mMuGeWg0SamOnSA+bSuyUYunY
         O5XrkozxYA0MzGvtU5KDU+mOdzpLXzPqyujWY+B4qJ2dfLg2uy2I+2kbvrQU91uhgAlU
         AvLQxx4JB8G2jAh6/mK+ZafHFNRR++gG+jEi5o3Z1e9RyDTGJQLKE3LiqbFbIK75TF2U
         C7WTU/hu8QQ3DSrIiRmpKYQuahoDPZxxs/yJLJPpAiZQD/aAckn/40CEPWnJ8XCvx7r6
         fQaQ==
X-Gm-Message-State: AOAM530jBee9Stt3ffwXcW+v/W/290VNvc4GEnhx2iKKRmxGdxV/Gs6e
        C0abiVpTbRWIZjUH3OOtHZwuza9RWXrlomVW/EQ=
X-Google-Smtp-Source: ABdhPJzjCd7itzkyErUCs/NOiWvltk4xor8hQjXMvSPqF7YlI5nbOEyQtDEcNxAy7VvN5QmVjlbgIzvF6r9XDe4t7Yg=
X-Received: by 2002:a05:6830:1ad7:: with SMTP id r23mr6902936otc.96.1595568928812;
 Thu, 23 Jul 2020 22:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200723091715.GL19262@shao2-debian> <87v9iexztl.fsf@nanos.tec.linutronix.de>
 <CAKc596KA2moT7fgO+Ount5trEbtrYsuLbde5S5Ou-c4EQbHb3g@mail.gmail.com> <874kpyxpro.fsf@nanos.tec.linutronix.de>
In-Reply-To: <874kpyxpro.fsf@nanos.tec.linutronix.de>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Fri, 24 Jul 2020 13:35:17 +0800
Message-ID: <CAKc596Lp3m3Ny9joOckYPsR5Lmok978bceMYNBrzsk6ozFjqhw@mail.gmail.com>
Subject: Re: [Softirq] a76eadba0d: WARNING:at_net/mac80211/rx.c:#ieee80211_rx_napi[mac80211]
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel test robot <lkp@intel.com>, peterz@infradead.org,
        will@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:35 PM Thomas Gleixner <tglx@linutronix.de> wrote=
:
>
> jun qian <qianjun.kernel@gmail.com> writes:
> > On Thu, Jul 23, 2020 at 6:58 PM Thomas Gleixner <tglx@linutronix.de> wr=
ote:
> >> That drops everything which has not yet been processed and the above
> >> warning is due to this.
> >>
> > wow, I made a mistake, thank you for finding the cause of the problem
> > so quickly.
> >
> > How about the following code.   we need to clear the corresponding
> > pending bit at the
> > right time Instead of all the pending bits cleared in the start.
> >
> > pending =3D softirq_pending();
> >
> > while ((softirq_bit =3D ffs(pending))) {
> >
> >         pending >>=3D softirq_bit;
> >
> >         set_softirq_pending(pending);  //Only clear the corresponding
> > bit which will be processed.
>
> How is that supposed to be correct. pending has been shifted
> right. Something like this should work:
>
>                 h++;
>                 pending >>=3D softirq_bit;
>
>                 if (timeout()) {
>                         /*
>                          * Ensure that the remaining pending bits
>                          * are handled.
>                          */
>                         or_softirq_pending(pending << (vec_nr + 1));
>                         break;
>                 }
>         }
>
> Thanks,
>
>         tglx
>

I have two questions that need to be discussed.

1. If the __do_sofrirq() is executed in the ksoftirqd, we may not need
to check the timeout in the loop.
2. Both the invoke_softirq() and run_ksoftirqd()  will execute
__do_sofirq, they all execute the same code=EF=BC=8C
    when it is in the ksoftirqd, Do we need to wake up ksoftirqd in
the process context according to
    max_restart and MAX_SOFTIRQ_TIME. In my opinion, If we  use a flag
to distinguish where
    __do_softirq() is called from,  we can do what is most suitable
for __do_softirq based on this flag.
