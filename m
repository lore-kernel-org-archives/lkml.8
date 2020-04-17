Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7DFC3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40173208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4YmkWFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgDQKXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726207AbgDQKXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:23:03 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE69C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:23:03 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h25so1448452lja.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9SoAxqx0wV4yZ0UGikmTbn4vHQRbkKq+2OlRZBKv8C4=;
        b=t4YmkWFDZCXwb+ryIVWzCSgXmXd0Db+Pf8Medr2SOrZRnotI0lJS0x5toISt4jF+K+
         CzIg5jjxb6OcGzL7GWkWftNxHTRuDq1sMNst9JK6lPY6Mw25f4axEyrj2VL3HC/xEDk/
         JT2uOtoj+5S0e7bNFWw0go2659MiHihG0jTGKjzsDVJ161oiv4XJ6SNzyOvz03as/MY9
         RW/VJ9EG0iuJ0Rx/9CQaDq8bBbs3a4XzLoZn5IhjekaRupuy0DFRDUbbPCstDi9ZTZus
         FC8wZHj50q361k8NKo5n/1d/Mmv+aPwKOQ0YjUHQKK0xq3CaJyMgZ0Er56YWVXDpeee3
         d+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SoAxqx0wV4yZ0UGikmTbn4vHQRbkKq+2OlRZBKv8C4=;
        b=MQ9bzBslpJcd/3wfwDvD3MCX1iZmp9tr0uMt3RgX3cKvqO6WFDvhIHcofdsoEVDMWD
         QKNNH9HOPzeSq4xhLX3JFh8pqd9jrFG5C3f4kJQ3U8+5ejw+mCf3z2tnS7Cksvu9sTRX
         Lq7PYxV3nNJePQ46b2IkAW62pVHQQrJPZFGtoUXFAxdW+4rHUeu3VqXfK4GlCZManmaN
         E//Sks5xATjmjTZ4O7Os2oCa5DyO3wy6nMcSo775dEWfcP23IqjN5tQ+jGi6URx/qk77
         N6290HCK6kju6noNOsVLd9tRBeA4cYGjd/rQpTsT60tUEAiSIPCyNnx7wkDAofvz4w3N
         Axfw==
X-Gm-Message-State: AGi0PuZVvowJ3SaFsjEYVwWvrVEodD6aND9UyfyTpYOmfzgc4lwOEj6N
        5hpOTI5tuNNF3VWRYjnuDbpJROpFtPhaI35hGnT7cQ==
X-Google-Smtp-Source: APiQypJC5+LuoR9lfzOLklye/sLtm5NMNAyhjdFOoiPtogmKVDgo0tnZLxO32XaPTCqCLNoXTvBBHjJBlIYRxhrDugw=
X-Received: by 2002:a05:651c:23b:: with SMTP id z27mr1605999ljn.125.1587118982016;
 Fri, 17 Apr 2020 03:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200417145017.3932443d@canb.auug.org.au> <0f828695-71cc-ab94-e0f0-ae63a192b283@infradead.org>
In-Reply-To: <0f828695-71cc-ab94-e0f0-ae63a192b283@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Apr 2020 12:22:51 +0200
Message-ID: <CACRpkdZ9rKHiszLYAbbhaTCzgMdH1gzRmbsB9G2g4+B=KpdfgA@mail.gmail.com>
Subject: Re: linux-next: Tree for Apr 17 (pinctrl-mcp23s08)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 8:16 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 4/16/20 9:50 PM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20200416:
> >
>
> on i386:
>
> WARNING: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pinctrl-mcp23s08.o

Thanks, got a patch to fix it too, folded in your reported-by.

Yours,
Linus Walleij
