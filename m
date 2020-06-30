Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B227C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D102076C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dmd8aV0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgF3CIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgF3CIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:08:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4A3C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 19:08:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f18so10454820wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 19:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=87SnUl50AwdYnWwZFe3OCGjdVn1OLaMK1lMsKVOtucs=;
        b=Dmd8aV0i+sqLH1H+h8cmUQq+zkXKmGHHBrXY8J26j4MuYDH4WvyDGG39BHI+RsyS5X
         rTkxyLNRET6S17XP9X9q9qHAjWoucIyE36RLYVyeEdrxOfT9fHtIvVDY2Wsu0ja8q234
         ZQXr/ZkwAJOvh5ffdV7BhsOlkbPXfHo8cdimkPnIHK//px66AOI+rPFDfC4HNdcGKI/b
         ymRkQ+ZHfhY0xTtN5t5/iny/OsSppDbfME8dj5PuA+ySRQ2Htq7/WUmQ9Cy3K0mJ0dLj
         wzVqEsh7BvlQADcFYIwBd7Lc9xp/WAJsWpc59HLGJuzfA4GHB3GGfGGypY/YCj6L3U8a
         l9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=87SnUl50AwdYnWwZFe3OCGjdVn1OLaMK1lMsKVOtucs=;
        b=SWSXZBCK2vF2KCx43n9f4Vp9+x5DmUBuoKProHvfSIV1sUR9iduczxAkeyK+3mQUO5
         lHIZV998vcAkONuYsJro0Zwz7jduGmM5xgYMstF7a+QYI7QKvURYwfrVrpknEELRoBnd
         gmNXJemh7OEKUdwIckVPrbo80VYeQ4o7lITim4rreUHXedB3djFjgsG8o60dlRsPBYh6
         cdfDfj+I0BYn8fd5YJ1MQ5BRG+/7F9NUSFF05rv90ClXFj7d9EUqdeFNZEzNzENsmtJw
         S7zb7qLCV7t+IGArhlOzqPFvNom1zuYGutfEFy6E4vLl2Fpg1lFZOYXcY7VXcQUCqlVl
         thkg==
X-Gm-Message-State: AOAM532dkB4Hyi3TNkEx7spXMPHS2VU5j/13WkDla2WyR8+8tBgCCkGX
        1YcbWGgSUiNiEFgqZG3qdDAYW1w/
X-Google-Smtp-Source: ABdhPJxvkJA2vwoIyMEAk5rAJmf45l142ljIaPRL0QRlLQr42/b0WvemaHD5ZcmtdVVS5rukop78tw==
X-Received: by 2002:adf:ef01:: with SMTP id e1mr20831527wro.116.1593482919564;
        Mon, 29 Jun 2020 19:08:39 -0700 (PDT)
Received: from localhost (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id u20sm1741035wmm.15.2020.06.29.19.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 19:08:38 -0700 (PDT)
Date:   Tue, 30 Jun 2020 12:08:32 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss
 wakeup?
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200624161142.GA12184@redhat.com>
        <20200624162042.GA12238@redhat.com>
        <CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com>
        <20200626154313.GI4817@hirez.programming.kicks-ass.net>
        <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
        <1593396958.ydiznwsuu8.astroid@bobo.none>
        <20200629140245.GB20323@redhat.com>
In-Reply-To: <20200629140245.GB20323@redhat.com>
MIME-Version: 1.0
Message-Id: <1593482844.k3rh7s05o8.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Oleg Nesterov's message of June 30, 2020 12:02 am:
> On 06/29, Nicholas Piggin wrote:
>>
>> prepare_to_wait_event() has a pretty good pattern (and comment), I would
>> favour using that (test the signal when inserting on the waitqueue).
>>
>> @@ -1133,6 +1133,15 @@ static inline int wait_on_page_bit_common(wait_qu=
eue_head_t *q,
>>         for (;;) {
>>                 spin_lock_irq(&q->lock);
>>
>> +               if (signal_pending_state(state, current)) {
>> +                       /* Must not lose an exclusive wake up, see
>> +                        * prepare_to_wait_event comment */
>> +                       list_del_init(&wait->entry);
>> +                       spin_unlock_irq(&q->lock);
>> +                       ret =3D -EINTR;
>=20
> Basically this is what my patch in the 1st email does. But note that we c=
an't
> just set "ret =3D -EINTR" here, we will need to clear "ret" if test_and_s=
et_bit()
> below succeeds. That is why I used another "int intr" variable.

You snipped off one more important line of context. No such games are=20
required AFAIKS.

Thanks,
Nick
