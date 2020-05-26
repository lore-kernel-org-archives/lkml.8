Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60D1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A45AC2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590510659;
	bh=G1i/DFFK4r1d4g6VOkkZwAg9/EbFlpBFpifSzWCYECI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cFxdgyjBnfRDDW1c53S0ThbWhEpI3QnSzilOcYIQ06ghbC7E7Hb6Kbnxj7k52uPBn
	 lp0i5SIKO7wfTlosYMLGtcvOzb+8VKUBJg1KlvYt13CKPWF+MDu/TjLiQhAPeGPUm3
	 PQkii2A8FjVaUeg2fS7zfp18b7s1Iu+SVnu0WwbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbgEZQa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388729AbgEZQa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:30:58 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20AFB2073B;
        Tue, 26 May 2020 16:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590510658;
        bh=G1i/DFFK4r1d4g6VOkkZwAg9/EbFlpBFpifSzWCYECI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FmZFhadHLyMQUwt7zSrM9ke0bbSrnz3owm1GPOLDriq2jhCfi7QKAbE/KYL/jIK6g
         dkowKj2Le9GjQQZVtC/hfoQpz4OPRjRp6BcwORN0/dMaQZ4axG0wINS4CqY/EyEnYO
         Y1Rp9cds4F9HXmLdr1ESSHqsgcUkeDZ9UtVg6U0A=
Received: by mail-ot1-f54.google.com with SMTP id z3so16791428otp.9;
        Tue, 26 May 2020 09:30:58 -0700 (PDT)
X-Gm-Message-State: AOAM531ey+RL/5FvxSfhZmBUBX5JWwzNl5bVlsaEzBRe/H1dfjRWLmXe
        v4jUKbkLVU0z7HRTLd9ce0m4NVWY6te9txxYow==
X-Google-Smtp-Source: ABdhPJxd3nfLX2WlQgLiFOwdbw6tXPu3JsFKeVwEFv4E4VaAbFfaEaUuHS/49qtdwmFGJBDC6MmD8dmG6nuCHA4YBfc=
X-Received: by 2002:a05:6830:18d9:: with SMTP id v25mr1388923ote.107.1590510657485;
 Tue, 26 May 2020 09:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200504211344.13221-1-dmurphy@ti.com> <20200504211344.13221-2-dmurphy@ti.com>
 <c6dfde9b-e1a7-1959-1413-16ebff803536@ti.com> <20200526122934.GB4600@amd>
In-Reply-To: <20200526122934.GB4600@amd>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 26 May 2020 10:30:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKzTJObLrw1XrD05-OWfhEqBnLQrAza6orRs0UEb2VN1w@mail.gmail.com>
Message-ID: <CAL_JsqKzTJObLrw1XrD05-OWfhEqBnLQrAza6orRs0UEb2VN1w@mail.gmail.com>
Subject: Re: (dt review needed) Re: [PATCH v25 01/16] dt: bindings: Add
 multicolor class dt bindings documention
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 6:29 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > Rob
>
> > Can you re-review this series for dt-bindings?
> >
> > https://lore.kernel.org/patchwork/project/lkml/list/?series=441958
> >
> > I know you may reviewed them before and may have acked them but they have
> > changed enough that I did not feel right about keeping your ack.
>
> Changed subject to grab Rob's attention. It would be nice to get this
> to 5.8...

Resend to the DT list if you want it reviewed. It's not in my inbox
and there's no context here.

Rob
