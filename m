Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A8BC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3DE24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXRfh1jy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgBSONH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:13:07 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45867 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbgBSONH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:13:07 -0500
Received: by mail-lf1-f65.google.com with SMTP id z5so191360lfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 06:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Q5/oJCbHi3HZIxwvSzo+SI3C1PqT+M1oUVxHQ2q6Vc=;
        b=bXRfh1jy+X9xKVlEm6kmq/REEQ8++dIr7z5rqDeQW4y2W/9EaBo0CYo9IdiTyWFFhs
         rDCQS+BbX7l8ggbpnen4oemUX2zhvQtcIqSZ8LggZKwYFFhi6wTjEkJj5PLtezmNg+un
         eWspMrGHxGABKQor2llTsCH6ObLzcvqIhrjnpGXtZIkf9/E2GiaiCFrD8myAOMfzqKp0
         8+5euhfwPLdtJGB78vA5W3CzhrK4vbxdlpyQU2eVaETBuhUU81ujjPCfONMaahxVrS8l
         02h63x3HMoMkMfg5NZ9Kef6uCKQ29p4wvsPhCJw8lU7rHAyOBmAS7E1lviDTQbesLyrQ
         PB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Q5/oJCbHi3HZIxwvSzo+SI3C1PqT+M1oUVxHQ2q6Vc=;
        b=JyazuCwTCHeou+xgxmjpSShjNXS0j4doTDI9GncJyHkiMddFko6R4emlcL5YwCf2CP
         95Z9hkVCBmwBnoNWd8+H0W+UB/ALp8OiSuf6NyEjRCqPQwfYGLLL/5Do+U2HO47rJ7xx
         prjKRGQa4UGb/axuosV1k6GiB9+np2CYptBewcSKmMc5cDhSxPtiIZYMVb9x/4zHj20n
         v4IfWWYMxMB633r1+GmenffjZNIU9YIRmNL0YRVz7eGPuUZUMJldupl/zbj0ovh0WzK3
         HcfK9qvnioQshzGO8+kPglejwokaMbPCKHMaMD1UzCmUZLacjwKZnxCIWFU+GrDB1Ruw
         mb3Q==
X-Gm-Message-State: APjAAAXfEwg1hv/Hhz0eqGuS166KLO77HnX4eQTV8/bYZCwMfz/tDeOR
        ya66+0WKqUN3avOmtoyjOh4yqBJPVzhflfqswSA=
X-Google-Smtp-Source: APXvYqwyUqmr4JNOywiK0Drohm6Y1B5bZJK4M7Hnz9WTDLpSfEuvupO9hQ8Jg2Q0W7crcd0xgXhpZyFv4KrWE3ndLx8=
X-Received: by 2002:a19:4a:: with SMTP id 71mr13712990lfa.50.1582121585329;
 Wed, 19 Feb 2020 06:13:05 -0800 (PST)
MIME-Version: 1.0
References: <67aa82a8-3c8d-d1eb-7e83-4f722b1eeb2a@oracle.com> <20200219012736.20363-1-almasrymina@google.com>
In-Reply-To: <20200219012736.20363-1-almasrymina@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 19 Feb 2020 15:12:54 +0100
Message-ID: <CANiq72=DUyJA0u7buHv6gJiHib22ix-1Krgacx-vCkU27j_Qzw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/hugetlb: Fix file_region entry allocations
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 2:32 AM Mina Almasry <almasrymina@google.com> wrote:
>
> - Fixed formatting issues due to clang format adding space after
> list_for_each_entry_safe

Note: that's because clang-format knows it is a for-loop-like macro,
so it formats it as a `for`.

Cheers,
Miguel
