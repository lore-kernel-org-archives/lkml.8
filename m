Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D984BC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFAD20728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="slq1poX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbgAPVvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:51:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33033 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731354AbgAPVva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:51:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so10591674pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 13:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RBOCGtg7OqAgrI3CtuSLrCxr9lwFIXwjsb8KVNmSEs0=;
        b=slq1poX6QT1mdlAs0mhAti1++63GhPd/1Qk3vqW0XPVF/uz8ZSX2EqTBj+ztYuz57q
         F6wCcqa0sDdCoNiBDtAUTuelE6jMTuaDy8T/eVNq4+sO1Wq1QlSE+rd/vb7wMV/1cxIz
         4B674XomkdbUPce24vkhYL8Cr+Bl3k6S6dPTnE0HftrgNITEwVKODf3pmxd3ZAUw7JNy
         SjcDfK+8gcrVzLQeKVS1TZyPlEvENCHpg+gme0El9hTJSG6EWDbEm8obzMf5gP+qhPp3
         NmviYpuWn3/uBdfUwwt8ZIvXOFU8/KM6Jhmyp/me3T7P1Cbm99O0TEXolBVOUqMu7m/H
         xugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBOCGtg7OqAgrI3CtuSLrCxr9lwFIXwjsb8KVNmSEs0=;
        b=UPb1rHEsM3ah6cwilZbfq7gNANPZ9d6gI+jZPH90aRPdwsIvYK/drl6wEfaB1VcH0k
         Bnm6Dyrp1/u6OJkrsp7wtXqF+KgKl2Io2F3MDg5lv8YKqt3cWxwWp5OUXIpIsmnevj3z
         wGppgKqzx+chL0yR/TdtKcEYguPfaKsQO/NZoqsYsTsA0Ak4vKFLM+QgFNvnPFhGhEFG
         l6ZHsYo3Ou75kZVAbtPtRoe/lzgSmN2VdM3eZSoJ+RInCvJ403pgNmTMwFi1T7wyeIPd
         or14lW15zbQ8WgRSYDO2LfdR9SIPCjNPIAMLY4uPtwf13ehc7eZrVr5/kD4Dse8X0Y0d
         6ulw==
X-Gm-Message-State: APjAAAWnKz7huF2iKM+HP2Hg0LQFU7a7ZCBUTXMA+XCsV/gvDJd4GV//
        3NozsvU1IJhIZcTO/E5L2JnW/2V8i1Ul9bMoSPcgHg==
X-Google-Smtp-Source: APXvYqxKRBlPOO6aG5PBNNFYt04sSl1hIoQ9O5cuGjINA6P60NdufKcO1BhAUbbheNUpu4pj8g0xIy1giFyaLijE3vw=
X-Received: by 2002:a63:f24b:: with SMTP id d11mr40917074pgk.381.1579211489460;
 Thu, 16 Jan 2020 13:51:29 -0800 (PST)
MIME-Version: 1.0
References: <20191022132522.GA12072@embeddedor> <20200113231413.GA23583@ubuntu-x2-xlarge-x86>
 <20200116154503.Horde.MnWaeq-f0qzzp8gx01ERP2p@embeddedor.com>
In-Reply-To: <20200116154503.Horde.MnWaeq-f0qzzp8gx01ERP2p@embeddedor.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 16 Jan 2020 13:51:18 -0800
Message-ID: <CAKwvOd=cA7E0MOtFfaQ5-+-v=+YNHYQPgMq6yS517PLLKn=Qpw@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: adv748x: Fix unsafe macros
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 1:45 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi!
> Friendly ping:
>
> Who can take this?
>
> It's been almost three months now since I first sent this patch out.

Kieran is listed as maintainer of:
  998 F:  drivers/media/i2c/adv748x/*

but I'm guessing the tree would be Mauro's.  It would be good if
Kieran can review, then Mauro can pick up?

-- 
Thanks,
~Nick Desaulniers
