Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6C4C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AA720663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GDBssRqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgCLOaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:30:14 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44766 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbgCLOaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:30:13 -0400
Received: by mail-qv1-f68.google.com with SMTP id w5so2674997qvp.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vM6oc6fo5COIOjScDqQkExf4k5Kw0lPjKerDiWDWlLs=;
        b=GDBssRqB5HoCEcSFAl4veBaM3ULCEz87+H9W6shCKz64VI7iHbHXaLRH86hKhzvEAO
         58U9az8YW2VX9xEZYQp7XKEFT9IWX9XPPupTTDtiE7hEclU/O4UdhKpffh9pTWyoBReN
         FYibIJc5xTWXHNfpH66CYQZ2J55UiZBNv5thKuW4lkbwQlIneziO+dxsXT6vqTqk+OtT
         fljVAqZVwnVn1yQkaiyFqVE1+anbH9REtujwJh20Z8o56OsxetVSycWbuDPL9eIBaomZ
         7B8PERVfeQ2ipNQnx0y5xoWFpJjQyEdkBLdMiUtEspgf/nUw1WJzgCA//C8J6rRlQJLJ
         WjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vM6oc6fo5COIOjScDqQkExf4k5Kw0lPjKerDiWDWlLs=;
        b=RHg3vyn500eVJX1dayXWxMsPXJYCzOYGWH5rMQrAcp0bAq/wf8FG1adZYrc9OHYJ2Y
         j121u/K3wPcvpkTE5EdfXapjxd/h6xgNoQEs6G7C7JFPHe0Z+W0QOxc6L0aOyyNtuyLX
         bZn0yreeT1DlRc1pSfBrM1oTqGN0JFjYcSTgaO+ROjvpQkQPvxsNe+spj89scPf5V/5o
         PvRKzplsbJ1WUOZrzfvd5uHLlhT4xF4wALWSonDXzLsACXWYDLScg2JYRgY93zjHFUf9
         vZV4lUJ1t/R1LzOnbSmxd282W2Md/3WU/wV70vSTwJy+ZOYR6WD4T/BZVc/3JOSfz+C3
         GOYA==
X-Gm-Message-State: ANhLgQ1CTrly5noPModI3jvHIfJHL21T2FmRd8XHyhNCqVU8EP4O7KkL
        k+NXH/XXT9Rt6MA5Ja9CVmVwDi3yyWVl1xHe5gpWFw==
X-Google-Smtp-Source: ADFU+vskodzAfAY2XYiDJ7aqoyeN9fXBPZhIj/VC7r42Db/fA6y3KJYApo5/zk+3zEyUUZ20T56TyvRlxLq9E51aDII=
X-Received: by 2002:ad4:4a6c:: with SMTP id cn12mr5105765qvb.148.1584023412109;
 Thu, 12 Mar 2020 07:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200312094008.1833929-1-gabravier@gmail.com> <CAMpxmJUUth5w8tvZp8mFV-FDz0YivmRWAqsOQSTdze1xagMX8A@mail.gmail.com>
 <38cbabe3-151b-1fd6-9d36-f27e9c9aa414@gmail.com>
In-Reply-To: <38cbabe3-151b-1fd6-9d36-f27e9c9aa414@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 12 Mar 2020 15:29:57 +0100
Message-ID: <CAMpxmJVSPA9CQBGULyk69KaP42oMdKGg883z0FeFC_mSA5w2xA@mail.gmail.com>
Subject: Re: [PATCH] gpio-hammer: Avoid potential overflow in main
To:     Gabriel Ravier <gabravier@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 12 mar 2020 o 15:21 Gabriel Ravier <gabravier@gmail.com> napisa=C5=82=
(a):
>
> Ah, that was accidental. I was applying scripts/Lindent to my code and
> ended up also having it applied to part of the old code. Didn't think it
> would hurt, but I guess it makes sense to be this stringent on
> separating logical changes. Will send a (complete) corrected patch
> in-reply-to this message.
>

Please don't send patches in response to other threads. Always start a
new thread and increment the version in [PATCH vX] tag.

Bart
