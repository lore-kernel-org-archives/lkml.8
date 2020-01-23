Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8BCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E0B21D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zr5YfkPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgAWPeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:34:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38206 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgAWPeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:34:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id w1so3942639ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 07:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGc9Zy7AW/fR7fXYuwont3bFuuFXgBZFTRJ7sZoElSo=;
        b=zr5YfkPmo20rKsCQ5i5CEu7VVdzgywAvimLQi/Be+hihr8BxcOGs1gOLYvBxcxEQOD
         AIEdG53EEtE7XKpMSBJAJ05lGssxylwhusa/oumgsziAG8F3/PDhCOgdzDt4DOI8DCWY
         9vAGBbU1wqSWPOshk4GC4xr0KlPg0Fm5IqTXGy7s9erZlT7ASoQiyG9PHIOsas4ZNATH
         KmBzdqlw1SH4LLofdn2e5EbKiCnvRSZ1iCHU0zsqNmKLgAnvxuRGLORPkEji+YRreWG9
         QPhlz61MbXIEtrqZaIbAY3YLa2nxG3F4DGmbGA34/0nmBwU6wU65hZeFgEOAIro/l4zv
         wk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGc9Zy7AW/fR7fXYuwont3bFuuFXgBZFTRJ7sZoElSo=;
        b=PaGHwuCPrSOa4RSBcb/NRPj2dQ9Z5pZxXHB0+fcmi+bhe8TRTQeTGSMsBLsnK4sTOp
         fncopgUerj620VHlIgnpJkxo05G7jGcpDm1Z50ZDf+npQg4eeW4hfw0cxdqlZeuk78yX
         aBCWpqcReXU1JQRS7UyJYVYXYfnsjRm15AHvaFPKVYiMf3ZUaUV2J1Tho+UTbHKZc340
         owVy+2HbhJcaNpK91IVoOMWNfaQ7+bHtuOPDJ/8Ru7Kel1da4gH/VNCqIxE8NbQCxMXr
         +Y8sKp8OTA0HMPGS/La5iJNjcbl6IsYV0yFb5eYj7y+I6dl/nPGeG4GUxeybfTZ9c1Mq
         G/yg==
X-Gm-Message-State: APjAAAWCqmmZOnXzVpahijlXogplHYo+FZtTiypvOjYtcp/+NkQn/026
        Pglfwa0x/Q5KlKH4xQqUhHICdjnGuto2Gjzvk3P7c2sqKDY=
X-Google-Smtp-Source: APXvYqwhjq9wryjQTKjeZHti7yKynQUDY6uaABgQtqtZvxRMmxVUb0GvwQ6R1tROoIrXOsYgqsVVabM6LSPuaQhLoww=
X-Received: by 2002:a05:651c:111c:: with SMTP id d28mr24194674ljo.32.1579793687669;
 Thu, 23 Jan 2020 07:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20200103170155.100743-1-joyce.ooi@intel.com>
In-Reply-To: <20200103170155.100743-1-joyce.ooi@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jan 2020 16:34:36 +0100
Message-ID: <CACRpkdawgTzXSRs7DUV7n6fGDWvUs_yG_4aTYa-DOzBMtu5XbQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO maintainer
To:     "Ooi, Joyce" <joyce.ooi@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Loh Tien Hock <tien.hock.loh@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>,
        Tan Ley Foon <ley.foon.tan@intel.com>, Ooi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 6:02 PM Ooi, Joyce <joyce.ooi@intel.com> wrote:

> This patch is to replace Tien Hock Loh as Altera PIO maintainer as he
> has moved to a different role.
>
> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>

Patch applied to the GPIO tree with Tien's ACK.

Yours,
Linus Walleij
