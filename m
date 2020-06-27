Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E70C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 22:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3922081A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 22:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="veU/BlHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgF0WOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 18:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgF0WOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 18:14:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CD9C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 15:14:18 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f9so6244476pfn.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 15:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Ea+WAVW1cojpak2BnE/W8a2xxeVZM5iKPEaLgDFR2Ys=;
        b=veU/BlHDO8EFjWqir2bTt6RPxgkjGz1OZ7pEWVjsWCI9+TVnML8nP8JkynGAe8/hO2
         hO54A/p6HvZqllq71ivU8oxeMPpeMrQTAsB6EDdyxhOdGnugGmCSd+IetNdsszMxnYMz
         OcxrmiWaDLMWuTVR+GL5RqiDB7g26Bh0pQZU+kGAbd5cz5GiqEU2qT6XtvdYJLqHlYmc
         R1uzpfPFgwjgRwVfA4+hSfnQgRo+ohIltL3AR4q0nyLMM0sAgwD1bFYAuD+870PMwzzk
         colYVIfvxel04n6FJgsW8c+fyersBKzMDANMkStZXQVc7OeA9ijzlGsQw6YJIRjgWR3n
         qIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Ea+WAVW1cojpak2BnE/W8a2xxeVZM5iKPEaLgDFR2Ys=;
        b=VH39WUgK7N5D5BWH3ejFvtT78FebYTjI+B5yZ5YN4yVc6G4Za+tySms4bWG7ttrtz/
         jFcjVS+QHOmJyEF2JU7EAKT3E0ivzZcHH97ywYMTbH6Fi9trOLoTx51vDD8pi9uL7Ydu
         Oy5ixN7Q90move+6Xbm2lwJDpnff78IMqcGAGuizK+HIO7SOArkO0k+IdoT53ranf/Yb
         A2HGHKCOIG+t7WW1tpgRXkzjwwRhoAu+/JwnPBOe9FFCjLMrePcvpyZ7eOqsqUoGxzsf
         pgmddLoMv+I7LENF0ZIMZtcsk0hT0frcN0we3nMdeiRXthsAiC+HbyON+DZfE6dBYGym
         84dQ==
X-Gm-Message-State: AOAM531w9g4aT4GQpM2QKvhbSsDOFcuofljInlUMqxOAs6oehVdJ6iT1
        OIdPL7ybmc3fitzjgS4MHtQbP9/dEFA=
X-Google-Smtp-Source: ABdhPJyBI87KNIg9X/ZXAujpVAbpYaxHPSbdLUkrdyYeZHAbnslS8fx92OnmdV/yar+2P4wiW1h9GQ==
X-Received: by 2002:a65:6884:: with SMTP id e4mr4516364pgt.283.1593296057450;
        Sat, 27 Jun 2020 15:14:17 -0700 (PDT)
Received: from ?IPv6:2600:1010:b06c:c4ce:a9fe:12c:6f82:8006? ([2600:1010:b06c:c4ce:a9fe:12c:6f82:8006])
        by smtp.gmail.com with ESMTPSA id j70sm10483828pfd.208.2020.06.27.15.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2020 15:14:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH tick-sched] Clarify "NOHZ: local_softirq_pending" warning
Date:   Sat, 27 Jun 2020 15:14:14 -0700
Message-Id: <83B12EF8-3792-4943-A548-5DB0C6FC71D1@amacapital.net>
References: <20200627214629.GH9247@paulmck-ThinkPad-P72>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <Kernel-team@fb.com>
In-Reply-To: <20200627214629.GH9247@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 27, 2020, at 2:46 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Sat, Jun 27, 2020 at 02:02:15PM -0700, Andy Lutomirski wrote:
>>> On Fri, Jun 26, 2020 at 2:05 PM Paul E. McKenney <paulmck@kernel.org> wr=
ote:
>>>=20
>>> Currently, can_stop_idle_tick() prints "NOHZ: local_softirq_pending HH"
>>> (where "HH" is the hexadecimal softirq vector number) when one or more
>>> non-RCU softirq handlers are still enablded when checking to stop the
>>> scheduler-tick interrupt.  This message is not as enlightening as one
>>> might hope, so this commit changes it to "NOHZ tick-stop error: Non-RCU
>>> local softirq work is pending, handler #HH.
>>=20
>> Thank you!  It would be even better if it would explain *why* the
>> problem happened, but I suppose this code doesn't actually know.
>=20
> Glad to help!
>=20
> To your point, is it possible to bisect the appearance of this message,
> or is it as usual non-reproducible?  (Hey, had to ask!)
>=20
>                           =20

In this particular case, I tracked it down by good old fashioned sleuthing f=
or bugs, but it=E2=80=99s still unclear to me precisely how NOHZ gets involv=
ed. The bug is that we were entering the kernel from usermode, doing nmi_ent=
er(), turning on interrupts, maybe getting a page fault, raising a signal, t=
urning off interrupts, nmi_exit(), and back to usermode, with the signal sti=
ll queued and undelivered.  This is all kinds of bad, but I still don=E2=80=99=
t understand what softirqs or idle have to do with it.

But I have the bug fixed now!=
