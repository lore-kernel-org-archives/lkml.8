Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ED9C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42F220708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/GTpPg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbgBJNDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:03:15 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40581 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbgBJNDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:03:14 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18so7032984ljo.7;
        Mon, 10 Feb 2020 05:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6lu8sBXp8JHHurlMIEQwdSiN2rr5XyR8FkJivCTaMM=;
        b=M/GTpPg361poO6OCc0npy2tdg1ba2G8dftTxVq7BKDvX2l/xBs05lzQH66uGICesq+
         hoEHLSYpnnuEteD1NDA/94wNuftY7nwqaE8FvqULXO1utH79+h8XAWax9fZsiIp8Hevh
         CE5T8WQCmhiptm0ZWAF35ZGZ2MsugGdKgxPEfkEEBF8JKa8F/YLglZBh6HqOhu+8t9qd
         5F9lw7Fg9DiZM7jI2ocY1opU80FC3yBOgM82xcHGkD5fayiyNyGc8+17pAlLoTLyw2UZ
         MmVeMArux71BAsX+bNy454ZFt+F2LY9P7o0KQ4H6ZK73Dml4lU4ri7i5ZF4evOwApBYh
         pZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6lu8sBXp8JHHurlMIEQwdSiN2rr5XyR8FkJivCTaMM=;
        b=PBsKw42TNO+dU6lzhkR5MqYtYFg58GhLeVDSN3UReJ6PKAzdV7notFhaECllA2bVGo
         W437WtZNX+FID9+gWY5X4Md1/L8vcdIjyGw8AbbxSZzz7jPdzwqWQPZDOWr80R0nIXWb
         NgldkoPCOqpYUFqHB9e93wG8bZRacGAE20YHKsdYhhpIPkUata2uuQ4QS55ogq6XLuIL
         U/h6KNtDEzv/owG5+0rJJs24hHkXfD/nNb2Gja4jP9y6YZ8wuE1Q/aBjtA+BPuhBUJY+
         rl+tWgru515qPDN99TErl2ykkMlGzgpNm+0md+eHNK4Z86NEJuP5HoonhZbNEQOIB3nZ
         KpQg==
X-Gm-Message-State: APjAAAXwZTbk0sodGUGZG3mMJe58XEWLS2VN+QjMnYzB40pysRfy+CPS
        477mgbSHDF4gtU8/2sLEXXv0/4X5TEYXa56vS32ERPaq
X-Google-Smtp-Source: APXvYqzQrdKskHkEyJ4zkF1QTSx7o77BUq34khhxz6R2rFlKflCc0ODiLlihWvCmOJanCH2+C5GQp46+nqKLoMT+8SE=
X-Received: by 2002:a2e:2e11:: with SMTP id u17mr854487lju.117.1581339790595;
 Mon, 10 Feb 2020 05:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20200210122406.106356946@linuxfoundation.org> <20200210122431.731980081@linuxfoundation.org>
In-Reply-To: <20200210122431.731980081@linuxfoundation.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 10 Feb 2020 10:03:00 -0300
Message-ID: <CAOMZO5D5U+OmQk5D-ObtR6O9hBm4S8EnycMLnAghw2vsyOG1cQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 261/309] regulator: core: Add regulator_is_equal() helper
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 9:38 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> +static inline bool
> +regulator_is_equal(struct regulator *reg1, struct regulator *reg2);

This causes build error. There is a fix for this in:

commit 0468e667a5bead9c1b7ded92861b5a98d8d78745
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Wed Jan 15 12:02:58 2020 +1100

    regulator fix for "regulator: core: Add regulator_is_equal() helper"

    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Link: https://lore.kernel.org/r/20200115120258.0e535fcb@canb.auug.org.au
    Acked-by: Marek Vasut <marex@denx.de>
    Signed-off-by: Mark Brown <broonie@kernel.org>
