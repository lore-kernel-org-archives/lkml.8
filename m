Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C024FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9876B20674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH3vrIhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGXJZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGXJZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:25:01 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D748C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:25:01 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y18so4818424lfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uISTKh0LkB1Y51DT4ziKFSK/MvT4j5M200tE0cMBtoU=;
        b=LH3vrIhXws4RzJ7m8Q3ZD69UZQn2vbgzkrm2G4AslhmYUsiEYo91SHX42zbPFiYYY0
         LLgSOUwQEWcEFyMUvJKuiny7utbeubHx2UtASNV8uvHfEFAIGmZNk4GYzqxkEwLDQV2C
         pSqcA7SX5lRq9PEVWXpkCYAHmZxTNiea5BcNboset9QC2rJVnvEO5Cn9nb6ZmDj8Pm+u
         stDQFKpK6rujcAvPGF0o8Gpu12ZHUMmhaafvnFmqY5QeJJFs2TyqWqEH2BYBD6o+o1Vq
         9ku3nCARK02hTB/Yig9Coraav8PsMbyyyu4cnAAhK+DKOBP6iyRxWH4Bdv4ne7urLWzn
         o2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uISTKh0LkB1Y51DT4ziKFSK/MvT4j5M200tE0cMBtoU=;
        b=ZCXROjbJzADuXUqKTh7PYhOgaZVTE9QFaN3kfVOAgETk5hJ0pLL0SOmavRj7xQw8AL
         kbMAG6UJZ5jkL6lBP4bNWDgqVBv48uPfLvVN+gbChDG3hheKZSp/d67dtaePt3k0GpN2
         XBFY2a2N5cNZMM1ekH1kuWougC5aYqsrEpQ7QioBs1udRLCz+Q/ITNmwjJcIKO9gFTj0
         yXES1ERdUSEMfegS9vrWkso11sUYrw5GN6FRzBHlNp5lTsfgftHrjz5XinLhaECQm+Sy
         1l/lQyZzpCSq8sI4GHhnDPKtqDYQzR0ChPiLlxwatq/oJAkYjaJVdlKm3/+w/LuJH8Go
         1kiw==
X-Gm-Message-State: AOAM533HFwpToKyk3mns0dUAFUgsevNb7TiQfIXIh3FgRXqkF27S8nCK
        wo6T5t+L1RDwjBrEBji6KwzeaAaabx2JRXH6nPY=
X-Google-Smtp-Source: ABdhPJwSQvteM/Wuj0a3VybjIKQA0hvryI5FhZSDtQlBzqbd54ppMy5fNedagEuZiaE6IMZvWmy17ulvdhVFUWe/O/Q=
X-Received: by 2002:a19:cb51:: with SMTP id b78mr4566256lfg.130.1595582700119;
 Fri, 24 Jul 2020 02:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200723205341.1099742-1-ndesaulniers@google.com> <20200723205341.1099742-3-ndesaulniers@google.com>
In-Reply-To: <20200723205341.1099742-3-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 24 Jul 2020 11:24:49 +0200
Message-ID: <CANiq72=esLJRBH2YCnz31-V2WTFmwB7dTdQJLOg=zN8xskVXXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracepoint: used attribute definitions from compiler_attributes.h
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Thu, Jul 23, 2020 at 10:54 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Just a small cleanup while I was touching this header.
> compiler_attributes.h does feature detection of these __attributes__(())
> and provides more concise ways to invoke them.

Thanks for taking the time to add this patch to the other to clean this up!

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
