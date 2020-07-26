Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22F4C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991402065C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzC6Rkjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgGZI4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 04:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZI4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 04:56:06 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D1EC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 01:56:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 1so7488863pfn.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BiHp5LUc9PuHCot82qcRCOL9br0dFdzgknx8tkEtCyo=;
        b=AzC6RkjlolNsWZXQ1jzEnFUYelHlzN9vaw4Mo7YjLgPC7C4QvAkSMSvgUsyqrFC5xV
         cx6O9RKDTsKrQusl0BYJm841lANFn8nUizwXv5tLilClZTJdfmxsqm1eYVx4hsKcZhD8
         mVf5iPIjvaN5Ml95jYWPGMff0z9LaohLAolIAJZ3jDJhkL6WQIxTLV/lwaGCOvi30BKT
         ArBZ70amdW4zSqa9mFp5rAqePmoQSqL7yHQoDb9EBJIkVWgGBB3ttB+ixNrQglmtngCz
         i3/mDjTRyBmEMqiPDquucRPL86ZpNncPo58YnGKdnYMU5T1z/pCkrvsScdOIed7LIwmp
         B27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BiHp5LUc9PuHCot82qcRCOL9br0dFdzgknx8tkEtCyo=;
        b=fuwudOjTMNxRQ4+S6/Ubjs7M7vszqlFU2y1g7I2KHpiqD8IrLd5MuaztCJYCF5s8Xw
         x4zypcNDALpy4fORJuwnUR4dmc5nNW60QA3eBUoY2UGfFv1io1ilzBflkecxZr2Js93I
         R0c8IkKiryxTL1C26SdG9lttSGMA5JelxE85oaurhugHFVlkmI+rdmn+ZvIOfUH0SxHF
         DYCU55/IrjKt7dDrqCHOi9rtVXYkhqnFu+02xbK8kaGTTXfsYMxzzN3rtNColjO6wwJ8
         A6ZZjFeVoLhF/YkKbnjp1D19kyvNyXi+3aRoMll3xTvjwqU2dx64nLH5mABwCIsHmZeb
         EhLg==
X-Gm-Message-State: AOAM532BxrWO9EAzh/mjrzQSFLpJjG4Yac8moN3DKixJTMy3bPz7YDbk
        4I1DDjo51ObJgAJ/fIrgapxzaaQ/fBOmyU8ZH6Q=
X-Google-Smtp-Source: ABdhPJyFfPKbmYFTGSrQjEu+YSR9sojkqP2HJW83W3cI7AAOjVWSpnJEqxjzmJC4XyDEYaDuz3qAKc26hLkGxKs1JsY=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr14817755pgn.4.1595753764903;
 Sun, 26 Jul 2020 01:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200726052804.GA51199@xin-virtual-machine>
In-Reply-To: <20200726052804.GA51199@xin-virtual-machine>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Jul 2020 11:55:48 +0300
Message-ID: <CAHp75Vf8h2kXnn-2xf3BFFDvBTSUH3w0z_S-FyKdB7MSJ_1j7g@mail.gmail.com>
Subject: Re: [PATCH] tty: fix pid refcount leak in tty_signal_session_leader
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, yuanxzhang@fudan.edu.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 8:30 AM Xin Xiong <xiongx18@fudan.edu.cn> wrote:
>
> In the loop, every time when p->signal->leader is true, the function
> tty_signal_session_leader() will invoke get_pid() and return a
> reference of tty->pgrp with increased refcount to the local variable
> tty_pgrp or return NULL if it fails. After finishing the loop, the
> function invokes put_pid() for only once, decreasing the refcount that
> tty_pgrp keeps.
>
> Refcount leaks may occur when the scenario that p->signal->leader is
> true happens more than once. In this assumption, if the above scenario
> happens n times in the loop, the function forgets to decrease the
> refcount for n-1 times, which causes refcount leaks.
>
> Fix the issue by decreasing the current refcount of the local variable
> tty_pgrp before assigning new objects to it.
>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>

This SoB chain is out of order. If you are the author, your SoB should
go first, if you are a commiter, the From line should correspond to
the first SoB (not yours), if it's a group of authors (funny for
one-/twoliner) then you consider to use Co-developed-by. Please, read
Submitting Patches document.

...

>                         put_pid(p->signal->tty_old_pgrp);  /* A noop */
>                         spin_lock(&tty->ctrl_lock);
> +                       if (tty_pgrp)
> +                               put_pid(tty_pgrp);
>                         tty_pgrp = get_pid(tty->pgrp);
>                         if (tty->pgrp)
>                                 p->signal->tty_old_pgrp = get_pid(tty->pgrp);

I guess this patch wasn't thought thru. You see the get_pid for it
happens twice in a row. Perhaps you have to get the logic behind all
these first?

P.S. ...on top of what Greg said.

-- 
With Best Regards,
Andy Shevchenko
