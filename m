Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBACC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 07:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4AD207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 07:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn0av2B5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgH2Hdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 03:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgH2Hdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 03:33:45 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC70C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 00:33:45 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x77so879760lfa.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 00:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EymIr82sWdWEIJpbB29qEsVht7ZTs6u+3DBHuAQDqEU=;
        b=hn0av2B5bLE6silgq7fc3nRrQYff8d+mi+3tMEvCrLTNLZQd5g6XzaRjRz1sYKNeuQ
         7qUO1x4y+5LJjYvpcSqvLARv7i0nYcTmy/L5OPbK5P3ncJRiS/AM28aXLPXpKTU4ndcS
         8rnc4myKQ+xj5SUEQMfZBXcBPJ9jk2+hWVQcgYbdptXP8wTLetT2+VZ4RQwYU/D3Eklm
         OSUv2POQJJCnaplG9XYkzdoRGqD8IsN7wICdxptles3QXHDQStYRqRfLSrxY3PU0yJqw
         tBooWVSgWrRA2Z1QBVLON69uYphbad6UYJCTHl4IK3QLSGNZ5DrZ8ucjTq5qieSqb8sO
         Hjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EymIr82sWdWEIJpbB29qEsVht7ZTs6u+3DBHuAQDqEU=;
        b=sdWtyspLCr8AQoD4RZkAmLO/CZf0lDlc4gPkthzkbITLsMXzm89BvMZy6H2feBdm8k
         ogEZxfXVcypP/lE6ojzARxLFpwwFSVQ8cuuPULgvRX67oiD8MTAK2M6Qm0uGbnbtmm8D
         qnJzPQbP6Gs36ptSH4SboAp+s5/BB1WkA56VT2S4Y2o/ghm3Ble3rjb11ALeHjla92sB
         imPc8ryCfOQgu4bpKVRVRK3P688KNyEFNbX9SlYJnOCO+UOlHoPqEyGGwGLtS/3jw4ov
         AdcsJSZHftp+Eni57ZqoXsiRApA/3owZi09kWo02TzHvE3mIU2Eq/OExNIfLFn2ApFRH
         LrLQ==
X-Gm-Message-State: AOAM532CxLG/Ez82gdDtiBqK0YRJlsLeJCnd/M4IRMkKEirePnKvIXlx
        NOZso8UpVDd68aaMe+tO2My6raaagQIcJNUDBC5HOCqNYdI=
X-Google-Smtp-Source: ABdhPJzvpHomp7Qre7y4tdeCJW+EIEwH4wh5T7U9ChsCQBZ61AOPXWgsjNfmKphPC7Yoje606utdH9Ih+/oI1suEcQs=
X-Received: by 2002:ac2:519b:: with SMTP id u27mr1097975lfi.10.1598686421917;
 Sat, 29 Aug 2020 00:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200828085301.78423-1-luc.vanoostenryck@gmail.com>
 <CANiq72no4vv1dX13W8LL6kXj_0ethn0cbUfxM5Nn_Nxag-BrfQ@mail.gmail.com> <20200828201516.p33577vucl6ke4j5@ltop.local>
In-Reply-To: <20200828201516.p33577vucl6ke4j5@ltop.local>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 29 Aug 2020 09:33:31 +0200
Message-ID: <CANiq72njPaiPgTKWhZ696Nr+jDiTN1Vqu0ML8DdK==sjSnS1aw@mail.gmail.com>
Subject: Re: [PATCH] sparse: use static inline for __chk_{user,io}_ptr()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

On Fri, Aug 28, 2020 at 10:15 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> But to the bot, any change to the content of the warning itself
> or its associated info is presented as a new warning.
> I've talked to the bot's guys about this problem and they've
> replied that they're seriously considering to change this behaviour.

I see! Well, I guess having a "false positive" is OK in that case. It
makes us look twice.

Thanks, queued!

Cheers,
Miguel
