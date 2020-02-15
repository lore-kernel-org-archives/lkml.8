Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B09BC352A3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 20:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BC6207FF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 20:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9RDrS8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgBOU3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 15:29:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43004 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgBOU3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 15:29:23 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so12471688otd.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 12:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccNZTvPbaibkVBW0vi774/WAW+4mE2s1NM1qiYlPWio=;
        b=B9RDrS8SC0doMYaW1giT2lxXmhgxu18FeDLnOBQfHltXGzSJ+hKD8fojoUHwNwBjVP
         l3skGAlLHD23uDWhsbHv5srViEFSI1HFmYWseQGHA5WhYQL0UNJMu40z++27Q2mwoWrg
         /kv+mliUNNUJ8o7k82iOENeFH8FRwC7g2uxgrZIXG356aCg8EeISNyHggfDF6lANbp/4
         vVhNZnJkwVyqliPrO4whV10h76HqAon4jXZhBL5V8a96APLe0q5Y9aRy3b4JscxG2Av7
         fLjWXLnO5yIZ37B0kla4/LighTWC591M7QtNHeW09w34tfJcpKZHcYmOznA9tSRbRR1v
         MYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccNZTvPbaibkVBW0vi774/WAW+4mE2s1NM1qiYlPWio=;
        b=uBpbh0QTYF8m1SvAXiTJ489v/kWIjr+WVfBBrswaw4QXPZA2IUNiU26LFRqikm840Z
         DVV/MDV1wSoQLWLtXX842zT/v8nI9CKe1LL4QMaFiEDZx4O5RIu9owqt/P4aeMS1oX7H
         qNH8FuQ26iy9krp3f/lO7RMRgO3hOpFU1fTLQomqQfxkzswXG44zh2Jt4WTa/5dL9g/l
         UiqAWsJYimTIJMf8Stb6E1cvBtCacNxj0ofo1LL5hbiROBm24HC9vgSuFhFlQPptu3Et
         hpEtMqq70vo9cazB3mI3cwkr4zAo/yXjTmurwb+ya42lUVtZE1Ob3vvMmAVDjCFcxPaB
         pymw==
X-Gm-Message-State: APjAAAWAss31tiUIT1fKs0QJTq7nFjrGagqBvrbZpKjOT+uVBqC/It8p
        UlskDzKUwxUaAWPG60owGRMzDMgpJwpuCZKt3T6Nzr16
X-Google-Smtp-Source: APXvYqy0IA05EYw3/iVjH+WBtQJ6zvcQiVKqTl6U2ydjzPtS5IrPjs5cmfSAp5R12bH/2ox2Xgz70+U0/oCm7vgFrrU=
X-Received: by 2002:a05:6830:1f1c:: with SMTP id u28mr7236314otg.143.1581798563050;
 Sat, 15 Feb 2020 12:29:23 -0800 (PST)
MIME-Version: 1.0
References: <20200211092211.GA23598@ogabbay-VM>
In-Reply-To: <20200211092211.GA23598@ogabbay-VM>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 15 Feb 2020 22:28:56 +0200
Message-ID: <CAFCwf13fMUkKjA-a24bAfmg2TLpArnZpBCBxa4VPzq_1RuNHzg@mail.gmail.com>
Subject: Re: [git pull] habanalabs fixes for 5.6-rc2
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
Pinging about the pull-request, just in case it got lost in the mail.

Thanks,
Oded

On Tue, Feb 11, 2020 at 11:22 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> Hello Greg,
>
> This is habanalabs fixes pull request for 5.6-rc2.
> It contains two important fixes for the reset code of the ASIC and another
> fix to reference counting of a command buffer object.
>
> Thanks,
> Oded
>
> The following changes since commit 95ba79e89c107851bad4492ca23e9b9c399b8592:
>
>   MAINTAINERS: remove unnecessary ':' characters (2020-02-10 15:29:09 -0800)
>
> are available in the Git repository at:
>
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2020-02-11
>
> for you to fetch changes up to cf01514c5c6efa2d521d35e68dff2e0674d08e91:
>
>   habanalabs: patched cb equals user cb in device memset (2020-02-11 11:12:47 +0200)
>
> ----------------------------------------------------------------
> This tag contains the following fixes:
>
> - Two fixes to the reset process of the ASIC. Without these fixes, the
>   reset process might take a long time and produce a kernel panic.
>   Alternatively, the ASIC could get stuck.
>
> - Fix to reference counting of a command buffer object. It was kref_put
>   one more time than it should have been.
>
> ----------------------------------------------------------------
> Oded Gabbay (2):
>       habanalabs: halt the engines before hard-reset
>       habanalabs: patched cb equals user cb in device memset
>
> Omer Shpigelman (1):
>       habanalabs: do not halt CoreSight during hard reset
>
>  drivers/misc/habanalabs/device.c    |  5 ++++-
>  drivers/misc/habanalabs/goya/goya.c | 44 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 46 insertions(+), 3 deletions(-)
