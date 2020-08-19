Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF1DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC7120772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0BR5IAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHSH4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSH4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:56:14 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42903C061389
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:56:14 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g15so6530654plj.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7wXztS79LI0rWMpxUVb3wcZ1sGeK3lVeAu+MbX7v32Q=;
        b=t0BR5IAJOw2WzO8Nqa0Jmmc8W/3aVWOUlO/PxPBMtLPUAPs7Csuu+yDchyWEG2B+pl
         lw/d0gaIhkEpQd/0j3QtJyt1jIZ20cARGfF48GYIgPO654a+MSPU3X5yEYEH0yRdzNnC
         CAgzVjjiRC+TavgNmlK49lVRa5ObNP29oAVqrXNjs5Q89tTewfYH/T5b1CivasjGxkwd
         2CcWEU+D3KPj3rxop1SdtwSyma+Auwzmi1a38DNCqs6yex5xH/jfpodgWRM7Om7WUQAa
         GoAGHJcLUjma6gIGpEVGlnTx5EYgcNoYgEvdGMUR9vOVVAVXB7vr87PvBaMM4mvUafYY
         CTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wXztS79LI0rWMpxUVb3wcZ1sGeK3lVeAu+MbX7v32Q=;
        b=LKmlllkonIuEQcXIx8x82rFM80tVd+dH1CJrLG0FZd4vwNL9WB9D696bfEa0dpkwr3
         3tnkGVUWKq0MgdxFgASDBkTbm2AoBGwxaTedkcAIuiqwBIf+SB0jWj73goac6n5iRIV/
         U2NKXr5X+gSQZ/0EOUfQB/3M6sXwQkhoK97AG56vKN+oiJjCQEgdQLz2/kq0VC0fU8p6
         y5RtxJEI1cE1xF+3cR9FKhVxi3aFG4QTEPiv0B1AuVXeVX4wE9pHOUFDpgaA8Tcb9kE/
         3QTg3GMFOOTixeZqCH4GU9GQygSX9L4fJYwH2AuGkBjSFBxq2oytC5KiKxrQRwp97bd4
         tSbA==
X-Gm-Message-State: AOAM5334PI0WXPm4xw8IBfKFho+nhjydY/K5/Y5X+tbCtHtdvdeB0N1J
        FJQ+fNLnZlg+Oa0hNo12G62dCC10uzFxcRqLfS5MBY+xtq53yQ==
X-Google-Smtp-Source: ABdhPJw9D5WNAFW6OPQ8/ni4rhOuEfMkBmqLb602Ph09WmYIYmKaz2aC6lE/zYBMXieO6Y2GiAQRcGllyCQG2itJJqI=
X-Received: by 2002:a17:90a:bc41:: with SMTP id t1mr3016829pjv.181.1597823773763;
 Wed, 19 Aug 2020 00:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200818084044.GD1891694@smile.fi.intel.com> <69e13a74-8b8d-cbc0-915d-ce289e7d4a70@linux.intel.com>
In-Reply-To: <69e13a74-8b8d-cbc0-915d-ce289e7d4a70@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Aug 2020 10:55:57 +0300
Message-ID: <CAHp75VfwBnDgR6WR_On1nh+dX4meWrX1Q-CiUKqkV39=o2m5Hg@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] extcon: extcon-ptn5150: Add the USB external
 connector support
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 8:38 AM Ramuthevar, Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> On 18/8/2020 4:40 pm, Andy Shevchenko wrote:
> > On Tue, Aug 18, 2020 at 02:57:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> >> USB external connector chip PTN5150 used on the Intel LGM SoC
> >> boards to detect the USB type and connection.
> > Internally I meant you can send cleanups, but couple of patches here are the
> > features and were still under discussion... But here we are.
>
> you mean asking us to implement the Heikki suggested as below..
>
> Heikki Krogerus: register the port and the partner attached to it with
> the USB Type-C connector class in the driver. Is my understaanding
> right? if not, please explain it. Thanks!

When you mention somebody, don't forget to Cc them (now done by me).

-- 
With Best Regards,
Andy Shevchenko
