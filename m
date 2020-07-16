Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8969C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C447920787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="obEan/jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgGPO2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbgGPO2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:28:20 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7A0C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:28:19 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y13so3372835lfe.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8z5jVj0dStGocFUNAEWnetN1Y7eNdK3d0AYJ2HaWYpg=;
        b=obEan/jtTHl0udOXHPR3KmPT44fbc0xUj31hTcpD//hyUGJUo81vOrGp3s283u40T1
         +qx/p4WjECHNx0owRE2krlth8/ZwxMnWsqxm3kOLnSPpUXtrxBGdDPOb85rjIShvDPTY
         y1Kkvd6voK4s7xyTce53xenzUbxCnYvr5MnUF3r/QUX9tqP6CRCIK1WZvGZKnjURvtkD
         lBkPWQnsLJpo4BwQYoKapbk8y06OaXZGnBv79TP8RJuOOXmcgkWMZEHn8lfN9UGcu38a
         r20Hp3VmyT0dPMPN9GUdee/eU0E0Nu+BqwP2vGnJ0SXrosdffcUs8QdJhwJodn7wIEZ3
         Qhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8z5jVj0dStGocFUNAEWnetN1Y7eNdK3d0AYJ2HaWYpg=;
        b=d8f5FrmDOvAGU2ilfy707wxM8L1vgv5z0X0kG2j4keiWcIUwkoM09JYjRoBrA7RuBO
         +ZQTihQvY/Ccaiyzfxeumz8NaahfGWnODxDNwIVyQ3/1LAEWMiLn7nYqyhE7FIS9PNW7
         p75L7mp3PI5RNZPAc95jC8W9BTIfJPqZWqTGzJONKKSJFt1OZlBA4KBP7h1m5cu5ju4U
         wDPlItrZbXd6bbdEz6gYWrRJnXugzE4c7Yn2PwAqVMWa9YrmMPfCn4jMPa/Ff/AKftRR
         k78zF20G2c/Jm45OgfE3YJ+wHK56NAB/hJsQFs3+nsOqubSyMg/7f8KJAC/WvELNMitJ
         +jNw==
X-Gm-Message-State: AOAM531OnpKvUpjoytfZ5qz9Ut4lAoc7ehAsk9OEjtnd88Vr+Ha/86h6
        8HxzcDad1g4+irFbLISxgRFk6oQNJ9P+d+k29T4FdA==
X-Google-Smtp-Source: ABdhPJzJFvr5vBcuV9MJ+9cegE1/UH2yId/s/8BzF3bEwGOIeUu86iS1G6nyjne+JIuplPRlLlDEGTnH0/RZ7D4ZA8M=
X-Received: by 2002:a19:c797:: with SMTP id x145mr2250613lff.143.1594909698207;
 Thu, 16 Jul 2020 07:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200716141747.wewrnejrygosqhd5@pesu-pes-edu> <20200716142537.GA2176745@kroah.com>
In-Reply-To: <20200716142537.GA2176745@kroah.com>
From:   B K Karthik <bkkarthik@pesu.pes.edu>
Date:   Thu, 16 Jul 2020 10:28:06 -0400
Message-ID: <CAAhDqq3EeWGOJHaW37iQN5UgmvTf3AP10fhrVdJ5GuYjBt8f3w@mail.gmail.com>
Subject: Re: [PATCH v3] staging: comedi: comedi_fops.c: added casts to get rid
 of sparse warnings
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Michel Lespinasse <walken@google.com>,
        Divyansh Kamboj <kambojdivyansh2000@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:25 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 16, 2020 at 10:17:47AM -0400, B K Karthik wrote:
> > fixed sparse warnings by adding a cast in assignment from
> > void [noderef] __user * to unsigned int __force *
> > and a reverse cast in argument from
> > unsigned int * to  unsigned int __user * .
> >
> > Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> > ---
> >  drivers/staging/comedi/comedi_fops.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> What changed from previous versions?

As Ian Abbott said "Minor quibble: the reverse cast is actually from
unsigned int * to"

Hence this is a change in the commit description.

>
> That always goes below the --- line.

I did not understand this sir, can you please clarify?

thanks,

karthik
