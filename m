Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F685C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C4E20719
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVbnPD2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgIJUfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgIJUdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:33:42 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B7BC061756;
        Thu, 10 Sep 2020 13:33:42 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id o6so6521434ota.2;
        Thu, 10 Sep 2020 13:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2xxMUg4YSEJ8+qQQfSkzr3XLf7gNJ6w0iCY9QUxL74=;
        b=eVbnPD2HB48RTKktK5rySccaXQcuW4w9adK4fCt56fJLoI+DqNWFD//4QJE4Sl0I/l
         rZIA1b6Gmu/asCuyca/D4VQ85ipjy+FqH7J0omPjTudyr2y5LZ+uwpIn+NsqhP/9ueIS
         yNOVLKxWgWflD6EHdOrJaVRVPd+vcuKYEqMxUNS/uPit23dgj7knlam6xTEUeBn7nuVS
         ITQxSD5fToeXCwNySpwWOpAfn2aTi7wJoag1c7AbjnittP5cjXe1Kf8hsGOmoLVYF4qO
         y0SIRI7Di+3ry6285IEqYZbE4vm1tzgdkTVAJwNDqwVzeXCevFD8FJMONiAo34JONUKJ
         nvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2xxMUg4YSEJ8+qQQfSkzr3XLf7gNJ6w0iCY9QUxL74=;
        b=Mo7Irw6z8jzb9sZY/KKerxvEj9jtMGtvOQ2HKnxd9k2VM1XHzWTPhrLOBM4r4nNU2x
         zhxKiL0wAiNq8e5/5xnCeIlhL9W02jRKuieQTxw6bPUdStdjLFHWyV/vELt3OjqVU4fn
         CbBxN7Cg7QzaAePSy7z+qEGycv+uoo7n6sAY/amV4+KzcaqZGwmPs6eOTZmmoXCQXWBO
         uqPS2R5tSUVXqFQR4otE8RYxeUhRI5MBbzTJkS032/O+ayPuffVqowraQe6FU2xYXsGs
         mf34J1tXi7jvOKyGjhMnU2VLrfY/T03vRjY8vdsGTkyYXFQap35CcKUWPf5+9Cmg269U
         c1fg==
X-Gm-Message-State: AOAM530cPPrQYAOJFBjD3wfJblS5C85g9oRCGJ9JdMxeqp8XZ/9DnFn1
        ZbPl1oMpgs+OCElQNeLcaTUk0o2IJnYr7QqhDZxFmiehkHHqLQ==
X-Google-Smtp-Source: ABdhPJzdmvnDE2vCLZfSPVTj4CcCg2X3KhVfTMeM+U/75GSOoXhtuhwWBH1AijdBajaCfeTrBMD4MSdRV2U9LGAWbuw=
X-Received: by 2002:a9d:5a92:: with SMTP id w18mr2020424oth.145.1599770021872;
 Thu, 10 Sep 2020 13:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200910161126.30948-1-oded.gabbay@gmail.com> <20200910161126.30948-13-oded.gabbay@gmail.com>
 <20200910130138.6d595527@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAFCwf113A_=da2fGxgMbq_V0OcHsxdp5MpfHiUfeew+gEdnjaQ@mail.gmail.com>
 <20200910131629.65b3e02c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAFCwf10XdCDhLeyiArc29PAJ_7=BGpdiUvFRotvFHieiaRn=aA@mail.gmail.com> <20200910133058.0fe0f5e3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200910133058.0fe0f5e3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 10 Sep 2020 23:33:14 +0300
Message-ID: <CAFCwf11sXmBLLZsoAGTbnUVduy2oVqbO97tRGEFgHMckronOkA@mail.gmail.com>
Subject: Re: [PATCH 12/15] habanalabs/gaudi: add debugfs entries for the NIC
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, SW_Drivers <SW_Drivers@habana.ai>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Omer Shpigelman <oshpigelman@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 11:31 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 10 Sep 2020 23:17:59 +0300 Oded Gabbay wrote:
> > > Doesn't seem like this one shows any more information than can be
> > > queried with ethtool, right?
> > correct, it just displays it in a format that is much more readable
>
> You can cat /sys/class/net/$ifc/carrier if you want 0/1.
>
> > > > nic_mac_loopback
> > > > is to set a port to loopback mode and out of it. It's not really
> > > > configuration but rather a mode change.
> > >
> > > What is this loopback for? Testing?
> >
> > Correct.
>
> Loopback test is commonly implemented via ethtool -t

ok, thanks for the feedback, we will take a look at it and update the patch.
Oded
