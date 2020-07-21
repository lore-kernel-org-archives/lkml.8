Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33803C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE1320792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUKUr55E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgGUQ0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgGUQ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:26:15 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA62C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:26:14 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id h7so4048057qkk.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UBP7qP0FYUChGaa0hrCulaczX/efODgBvnjZrXBVhPI=;
        b=nUKUr55EXExbEWdGOSEgTubGim/24Vyuixpdf0xLuViukQ1HYqXJ7wLSsx+StUT43t
         K7S55wPrevvD8wkT/jrhclLmMejSUMDLw/wfvqShS0D/yhLD7MZQeo5BKdYi4rR98vdh
         A4Abp/qboL4FVZMjQwFlFG/Qg49E4D6cnF+/nV1uHLYdZC2dmvQK1VAuuU6ef+ygSSnQ
         8nE6dM9lGyZyn4qkp8Fh/bl8PGghxxHCR1zTT9HnL1uv9lfgENAOh4F46b94eDP/ywhC
         fHczpcKRfaXaS77iH+rIzwkD7Z+il6u/vAyKFt8XUshWYfbGW0VPWA07ft3AHzYXsQOH
         rEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBP7qP0FYUChGaa0hrCulaczX/efODgBvnjZrXBVhPI=;
        b=VV5/J5tn2Sagh9GvkBN4RpMk886TlCFPIvuCVzfIkHwvIFXj2t7lBwth3B09MEPr1i
         BN6Il48kkhPkrW7Pd8/NO+nqMQR4UcopM2Mhzh41bcijJD6E+0WKwnW9UUBLO0jWlMwC
         wVBCrahPXna4QAeiJ8SCJoAflMUjx/eaELlhkbJ8y5Vf2gsx3KSKIV33AuRF1khOdfgu
         K4+SdI6l4P2jDH/urbc5HHoo3KKrrray76PDcrZRT1e/Q/rN80ceWFHfoWsIx7EfqY/u
         uHp7RwnJxgluIcfXCLI0mACYFo0+QFUuYKZnKJNIEyDm8kBQzGZl3+ywRI2VN0d6EkUW
         +q5g==
X-Gm-Message-State: AOAM532BhOc19XYjRgOKDVZrna8iIKKzt7ZDFcdDu7vnwFWsXwUikKy3
        us0toTaaNG+aWZfJCvT5lWQIin3y
X-Google-Smtp-Source: ABdhPJwv7l6NSdtUWUi3w/JFmJsTeZDPNmRGMPEj8FrMIp0kykTH/IDykRuidD0zTmwZr9VgAevM9A==
X-Received: by 2002:a37:a08f:: with SMTP id j137mr1571194qke.150.1595348773530;
        Tue, 21 Jul 2020 09:26:13 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id m26sm24924541qtc.83.2020.07.21.09.26.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 09:26:12 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id x9so10266562ybd.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:26:12 -0700 (PDT)
X-Received: by 2002:a25:6d87:: with SMTP id i129mr42670421ybc.315.1595348772036;
 Tue, 21 Jul 2020 09:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+FuTSeN8SONXySGys8b2EtTqJmHDKw1XVoDte0vzUPg=yuH5g@mail.gmail.com>
 <20200721161710.80797-1-paolo.pisati@canonical.com>
In-Reply-To: <20200721161710.80797-1-paolo.pisati@canonical.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 21 Jul 2020 12:25:36 -0400
X-Gmail-Original-Message-ID: <CA+FuTSe1-ZEC5xEXXbT=cbN6eAK1NXXKJ3f2Gz_v3gQyh2SkjA@mail.gmail.com>
Message-ID: <CA+FuTSe1-ZEC5xEXXbT=cbN6eAK1NXXKJ3f2Gz_v3gQyh2SkjA@mail.gmail.com>
Subject: Re: [PATCH v2] selftest: txtimestamp: fix net ns entry logic
To:     Paolo Pisati <paolo.pisati@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jian Yang <jianyang@google.com>,
        Network Development <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 12:17 PM Paolo Pisati
<paolo.pisati@canonical.com> wrote:
>
> According to 'man 8 ip-netns', if `ip netns identify` returns an empty string,
> there's no net namespace associated with current PID: fix the net ns entrance
> logic.
>
> Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>

Fixes: cda261f421ba ("selftests: add txtimestamp kselftest")

Acked-by: Willem de Bruijn <willemb@google.com>

Thanks for the fix.
