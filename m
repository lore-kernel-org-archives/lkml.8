Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE92CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A3024656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmUuB5ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAVU1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:27:24 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:37369 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVU1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 15:27:23 -0500
Received: by mail-oi1-f172.google.com with SMTP id z64so704202oia.4;
        Wed, 22 Jan 2020 12:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LnqdAbJts3a0XaSvmh9g8p5TOum1oVHEfyTgSaH82js=;
        b=KmUuB5ht3BMM3xcsIsdcFIsWrT5RVTyDyU9Rpkz6Uj2B7mikeTEYbP1TBk0wFN0RsY
         tk/B0deGZhfwfPJCqLihKwA/8S1Uf0/pPdTomrGYn1fch7/zdSBfye/Xuml/BKPQ82yv
         V8Je8egfLJGq8kS2GupREnWz8QTiYrE57CSBvQsMt5EquI4e3NVtDLq3P9jkvo25ZV6E
         kJYrqUCb4tzHHUBPSzPBkiAi1Pf82l17+bOAjxb7ksJKHYlIx+r+7ad4/+mGkywM+j3L
         /6ihBYPBifHli3AzfS2BCL6xJrXYBVElB6f2D83Cw3uF1lFnxtHdtFtIEw7E+0e8POA0
         fqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnqdAbJts3a0XaSvmh9g8p5TOum1oVHEfyTgSaH82js=;
        b=Ne8wZEorfe6NkaoK7XYECzZ4IWRrDpSq3uN5uacFiBAY7m7Pn7rc0N8JXuhitd30fc
         cmrgC+l6X8VMnHIWFpgvXVSioigk4mY74/LMcHfD7vQm/F1VeQfvtwLGdouks32iag/D
         ZziazZuF8nraW1YnxQxEP2yHUjG9L+gh0ajTcMnJpXr+sz9MFicExqBxocJoxI2+XAAX
         V+kE0+/spqvmhAKCfg6n8MSGpQxO9Pp0vQPOYO1TZwEMjjW0UL9hYJXk1nT3IjBpxRbD
         0bNnSjOQm5YerQAopobghDNhjUn3Dcb90yy9BX7dBeaVMHskPty7e/vgGJmi6C3uFs9O
         s8IA==
X-Gm-Message-State: APjAAAVziXtrm6t4eCczzuNZgVWTMfGof3thUA4qSsplB/EZRXM9MRp6
        7yNYYeq9HfteS8ca8GeJS/l6N+YVgkrCY5bzL9Y=
X-Google-Smtp-Source: APXvYqwJRL57BTkEFoJksXrBIRxMAyMAmGYyQGXlw56/J5hf8IaXbaA9g0GkeednsimQh+6wZKm2eouuYzx4rKQZTx0=
X-Received: by 2002:aca:1e11:: with SMTP id m17mr8159109oic.5.1579724842530;
 Wed, 22 Jan 2020 12:27:22 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006370ef059cabac14@google.com> <50239085-ff0f-f797-99af-1a0e58bc5e2e@gmail.com>
In-Reply-To: <50239085-ff0f-f797-99af-1a0e58bc5e2e@gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 22 Jan 2020 12:27:11 -0800
Message-ID: <CAM_iQpXqh1ucVST199c72V22zLPujZy-54p=c5ar=Q9bWNq7OA@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in __nla_put_nohdr
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     syzbot <syzbot+5af9a90dad568aa9f611@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 11:55 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> em_nbyte_change() sets
> em->datalen = sizeof(*nbyte) + nbyte->len;
>
> But later tcf_em_validate() overwrites em->datalen with the user provide value (em->datalen = data_len; )
> which can be bigger than the allocated (kmemdup) space in em_nbyte_change()
>
> Should net/sched/em_nbyte.c() provide a dump() handler to avoid this issue ?

I think for those who implement ->change() we should leave
->datalen untouched to respect their choices. I don't see why
we have to set it twice.

Thanks.
