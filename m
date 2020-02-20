Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CC5C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD1F20801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CdzKYncW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgBTK0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:26:00 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35595 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgBTKZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:25:59 -0500
Received: by mail-qk1-f194.google.com with SMTP id v2so3057915qkj.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1rjvByHZQlMhjuCjov0yod+UTGqrYRpU4C6ciuXo5jA=;
        b=CdzKYncWBcR3FH6IHEtYZ0S+4IOaHJ8BZumMqmbBM5KnI/rVVZtzcF95PvC9a4YLpE
         Umlu/ONx/RIa9VNI+7jEUtROC3vC37mEt7oDRUXC4e/5Q56CvkXZIpmeEPyITPBktM7r
         IpA/e4dXSUK7R4QRt79HUQgfaINm2xY/BSLeayOyZ6Jrt4HyvVappn8GF7mWsGhviR1/
         iBtjL0jEkDQFbsFzp4XqQ2dcAzTDCI9YHs1SDGurn3nNo6gv4jLJq/F/iK6DB5lOpSdH
         5wwaViz71p6RdAGz4t4ZHl5vyX58i5/HbEXkIfquHEBaVoLvCFdqYNHfPVwi3ww75gfH
         gYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1rjvByHZQlMhjuCjov0yod+UTGqrYRpU4C6ciuXo5jA=;
        b=Zx/1A2MBjd4woVlrTYn4IUchGoEliHkePUlOxT7YbrON3EfaN6DGYO3NtE90TrQXI8
         CyH+XRrAXFKsASKqu3jdBGuA5DDRNOLMt0zVqCd9bjwasAmr9s+ejP3QNWmJbBz6TcYi
         asLzT6goXzEveUwjg9Vm5zGYtz4MYp7dUeaIqskMMsD/7hvH6D/pKoGiFN8gssGP8kmi
         wZ4qoey/EXRto5cLQdVpsOstoxbzw1oHHnXhUmNlEqjEebFsZ8DF4qK/Wf5jxmJKXLDg
         s/x493Yk4aI37QLcEXDr6WQZIcM01g81Mkw6PKa+nvtcTxUeLBvcrVKvXsAoXFbjGO+F
         WUwA==
X-Gm-Message-State: APjAAAXMf4gyaQ/c7/IApzUZKUindDWPJsuM0zQhSYLZvNTVp9wY2EKB
        FzchyvgkbVIPT2kQFA9p7URVZUKkFRhhFX/8xCvVOw==
X-Google-Smtp-Source: APXvYqxR/dbvUf90qEuyfKeW+D4uBvlJHQinz1rXJBsKijjqfrR5Ujk5GurPtgBSmU/7aaiZPFsK04HuHH3vVOvHces=
X-Received: by 2002:a37:8343:: with SMTP id f64mr26249549qkd.21.1582194358643;
 Thu, 20 Feb 2020 02:25:58 -0800 (PST)
MIME-Version: 1.0
References: <1581942793-19468-1-git-send-email-srinivas.neeli@xilinx.com> <1581942793-19468-3-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1581942793-19468-3-git-send-email-srinivas.neeli@xilinx.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 20 Feb 2020 11:25:47 +0100
Message-ID: <CAMpxmJWi4izL5MgZ3vkE-a3e0jR3nhwUax4mSxQF-Z_r9vjLUw@mail.gmail.com>
Subject: Re: [PATCH V3 2/7] dt-bindings: gpio: Add binding for Versal gpio
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        shubhrajyoti.datta@xilinx.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 17 lut 2020 o 13:33 Srinivas Neeli <srinivas.neeli@xilinx.com> napisa=
=C5=82(a):
>
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>
> Add binding for Versal binding.

Please add a short note on Versal here as well - don't worry about
duplicating commit messages: when I git blame the line and go to see
the commit that introduced it, I want to get the whole picture.

Bart
