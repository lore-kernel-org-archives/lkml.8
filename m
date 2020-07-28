Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ED8C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FECB206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWs0cbIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgG1MWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgG1MWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:22:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5157BC0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:22:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q6so20880554ljp.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TESeuYU5SfzLxBWMQ4kl8vP13Tpf9d4XmBM8Gp63Ao8=;
        b=tWs0cbIEtxsoEEWx87oQK2/AgPlRAXgY0LbgzgRA3ewO5DWL6Fyxb8WS3aulE9/J9C
         X3RsXavLk4qFUAWa4p05w6NqoVN+pucr64IBxtUbfF0Mf29aAXTZyAEJTyX15Z9ovorj
         wQEi4O2bCR8ckUmBIg6mwgpxBnP5IMhwzOd86n02qGgjjYaAjBM79Rn3x2dlCYpTnBqV
         I+UTfpEnvgnzhrgm3JZqje3nsXlj8agQslaPouGHWhmpPABmgolCN9NXsxPDZd1PQh+v
         NGQwfGtgnwr0M3pbpqj4n2+rOU/1w12GWAALbgiFNbUtF3NmRBGZFe+sqUlrg1pbaDHE
         v+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TESeuYU5SfzLxBWMQ4kl8vP13Tpf9d4XmBM8Gp63Ao8=;
        b=UiuOEp1vaHwtFyTJS2xJ27l/PvtzKraOJvTOWCeRtJWEG5ZlyZ/msogjZAlfVZN6y0
         QvDWFbBWmJ4Z0yJqGptlNfMhPSvjXteMCYdLXc4q7lUfS7zX87ClNxGzgAWkII5jnTAk
         9o3hhpEugiakKrGsEc6CG78pFRGz7EXZ11IQ0DKqFcZstpaTgAevBxaUcsEi3TRR2qEs
         LFz6HgRFDcS3nyKA/1446/GeOfgCvpYhSMLVB3obUas4yLhDD89WMC1ZZQFy5Jz1hlRb
         xDXdaH85ZUfwypckcxkhbGbFCGSH61Yz3U/7ItFurvgto/OxrkJwbKUT7Ap8lRaX7XR9
         w2zg==
X-Gm-Message-State: AOAM531X8/2EIPedt6Gm1EoxE0JOz2VVgSqcsBf6xpPLv2Wc5wCPuBGP
        4jbHCur0oCvHKONuviTqhY4pmEaWYwr4wEd8Rx6ygg==
X-Google-Smtp-Source: ABdhPJxFKokBgoeIMtwaFCWZjTjcyuOq58U+G8s0TH2HfjNeeOsLST8x9LgKqX+cy/D0oEkPhul5xgMLR5yLY5nKt8c=
X-Received: by 2002:a2e:90e:: with SMTP id 14mr5500607ljj.293.1595938960755;
 Tue, 28 Jul 2020 05:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200726220557.102300-1-yepeilin.cs@gmail.com>
 <20200726222703.102701-1-yepeilin.cs@gmail.com> <CAK8P3a3NB2BVo9fH-Wcinrhhs-QJ=9dK59Ds83TvgLmEkRy3qA@mail.gmail.com>
 <20200727131608.GD1913@kadam>
In-Reply-To: <20200727131608.GD1913@kadam>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jul 2020 14:22:29 +0200
Message-ID: <CACRpkda7k4L+nqAYE6z2FVZF-WT2Pm3CHH_=fW24xz_u+QCMRQ@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH v3] media/v4l2-core: Fix
 kernel-infoleak in video_put_user()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peilin Ye <yepeilin.cs@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vandana BN <bnvandana@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 3:17 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Here are my latest warnings on linux-next from Friday.

Thanks for sharing this Dan, very interesting findings.

> drivers/gpio/gpiolib-cdev.c:473 lineevent_read() warn: check that 'ge' doesn't leak information (struct has a hole after 'id')

We are revamping the ABI for 64bit compatibility so we are now running
pahole on our stuff. I suppose we need to think about mending this old ABI
as well.

Yours,
Linus Walleij
