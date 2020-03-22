Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F15C4332D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 08:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A9820753
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 08:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcSLAkh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgCVIPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 04:15:42 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43489 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgCVIPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 04:15:42 -0400
Received: by mail-vs1-f66.google.com with SMTP id i12so3376561vso.10;
        Sun, 22 Mar 2020 01:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ezcgfr720kBfY/HJS4uuB/t7vgSWU2iG9iLOlGLgKJI=;
        b=rcSLAkh7COROd7o4ApgHEMEtSLdExdWECEl2GabkxrsN+ajPA3EU8JS1OZl6Icyf7x
         Y0BQvlpEvAxK5C20AtiAX/TXpsBpjkpJIgWUSDfH/5jKlo/lIJ/o+cMJhOdBTdCMJBag
         0DyrmKqON8QcLvN80mh+5px3XsjyFARF4DCVyv1ScbEVYHs8sTEPKCKyZ/pN7gb29dAV
         +zBWweAs00EYhERPlLd2tNxp3Zr9RghPSPVQAbD2JF5PNlTCZtjOS2gQVN5h0OPQrnyE
         zpI5GEMYpCmNOLdPOy2G7kE4rS3sig50kY0YNG60CVNyvFuUJnnqyvZTgc9WoU9WNebr
         4mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezcgfr720kBfY/HJS4uuB/t7vgSWU2iG9iLOlGLgKJI=;
        b=b/urVFpKXlI48SeHWGGm1K9RO8ZIGUgkBCv8lnA/pscLFie35j6bIqI13NIe+wqKyp
         XHfqevazXWNZYIguLXZStLJzQAuRGrqWRAWbWWwOlCWVQx4ElYlSG0iCqMvYJxMsmNrz
         MvBcZ7OqVkCRjKy7vE/BT/yxjI6ROPBSva0V4PuikYfcG7y/jrXD7Lrc3ytfoYHux7gW
         l5wwexAtZCNSFaSFwRxXCer24Dcpt+ZUPtzc1Pqxy1sU9QrfdnBrkjl0qWObSjMjPv/W
         WaBRz4D6T9EIb6ey66yzAFTFqmnUDRFoldQP2nORo32Yb6rPG+zaheQ5WgAXFrQRBkV1
         I9og==
X-Gm-Message-State: ANhLgQ2eBlM3843Q8xIKQokVlZdM3x91tkZwoAIL1UxOj20rObenLFj2
        plxCF3CcX9b2ixKr3H2ZrJLqAH9ALTJ8ZJAKQJg=
X-Google-Smtp-Source: ADFU+vtkMCRgTxiszn+evIYmA8iNm7v4BrYphINlVDqn6EguH6H6hzPEt788R/4wOf7kBv6RpieQU0M9GuiJtSdGBX4=
X-Received: by 2002:a67:c189:: with SMTP id h9mr1262941vsj.91.1584864939578;
 Sun, 22 Mar 2020 01:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001a033405a15e3acb@google.com> <CADG63jBdvJMAem7_VF3GbCUSXGRuFrrv6_GqFc=KcKkxcNebCA@mail.gmail.com>
 <20200322075850.GA68214@kroah.com>
In-Reply-To: <20200322075850.GA68214@kroah.com>
From:   Qiujun Huang <anenbupt@gmail.com>
Date:   Sun, 22 Mar 2020 16:15:28 +0800
Message-ID: <CADG63jD5vHoTqfmqeRjcYniBLk8reBRfKy+=ZT2aJfcRDa4S6A@mail.gmail.com>
Subject: Re: WARNING in hwahc_probe
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+df767d588771697b0433@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tranmanphong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 3:58 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Mar 22, 2020 at 03:53:44PM +0800, Qiujun Huang wrote:
> > The return value of snprintf is longer than expected if the string is
> > truncated. Bytes need to be checked here.
> >
> > diff --git a/drivers/staging/wusbcore/host/hwa-hc.c
> > b/drivers/staging/wusbcore/host/hwa-hc.c
> > index 8d959e9..1475a48 100644
> > --- a/drivers/staging/wusbcore/host/hwa-hc.c
> > +++ b/drivers/staging/wusbcore/host/hwa-hc.c
>
> This file is no longer in the linux-next tree and will be deleted in the
> next kernel release.
>
> Also, no one has this hardware so there's no real security issue here at
> all.
>
> And finally, you forgot a signed-off-by line on your patch :(

Get that, thanks.

>
> thanks,
>
> greg k-h
