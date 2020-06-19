Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6192C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF502080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="FTMyTBMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbgFSK0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732283AbgFSK0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:26:34 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AC2C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 03:26:33 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g18so6729493qtu.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 03:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6sl0V6oSF+ayLjJO92Gb6jDxQHsMRD4h3oSfs3nUus=;
        b=FTMyTBMM0WhdezxS9cKagR+7bmzV4MCbxW+PeNlxLWAYveMypleF5j5yWeEHqCKSnm
         Pql+E4txHJ/+BYxTlolI+gp6gz+Rr4pcpAJVEJV/OWJX7GknKspi92ixJwxzvo8XSOZm
         nBiK3GgbVeH6mM994YVAK7LfXOWApaDMGWl9zN1q5WgjCzSVHANhEWkOkaOeZd8VxvIg
         pVzxKNGTZ15ZjJTWhX6IhxBwRpqwiYLMzhzTCTaqdxsaBh3Xoe0PQez+US73lnbzga4Q
         1LoxLLp/0JUMPdZp8uPek7N1kQcfPH345HVhNXBs3keIO/eOMrEXvkEkmcwBF113jYTK
         KjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6sl0V6oSF+ayLjJO92Gb6jDxQHsMRD4h3oSfs3nUus=;
        b=fNVN4xODYLJHgc53HCghfviPwxVk3UXlszCDdsVSD4W25bjgKcjzChfmNULj8mwr2u
         yDgZ4T+HnQcRmThNgyxzkadYQo2Pxh6YcuQaoEOGma5vd5oy0+fitpNub0kmeF1UYfXF
         oJuV4xZ0gHakYQtHLR9HFNp831+m8VRHaDi1GyBUOwguasf2rEoY3+Vt5kMMsZhDVv3M
         ZjK76SYnbmchXGznDQ7s/4OPENQFEco6D1CuasSkePW4jDLEHOUEY9kxf6L7OHZR8kHg
         YuS4MCm4H0XGL8kltaUkMwrrXTwSfG1mgjXPwDZr1CbkYwbIllMBrFdLOfe8mAItV+Vf
         iY0w==
X-Gm-Message-State: AOAM5330Nd/ed1IoAkBEXhHcxi/F/m/YO//bc4UAh/RfZUJnPFo1v4vm
        QGiRFV7xIbE9qXxp6G9tMUZDd7ivxi2fZCKvqAw=
X-Google-Smtp-Source: ABdhPJw4L0mljF2l27HpeZcatzsAaqywsSlC0wRli/G07dmQg0qAaoKE064RDeqMRqbuMOQry3QQFMjUP6vC6W4vX34=
X-Received: by 2002:ac8:6a08:: with SMTP id t8mr2571945qtr.271.1592562392543;
 Fri, 19 Jun 2020 03:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200608210058.37352-1-jarod@redhat.com> <20200610185910.48668-1-jarod@redhat.com>
In-Reply-To: <20200610185910.48668-1-jarod@redhat.com>
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date:   Fri, 19 Jun 2020 03:26:21 -0700
Message-ID: <CAL3LdT5Bo3Cca1eiGykOvPAw18oH3ePQyB0wwEUYKq5ZDHX=3g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/4] bonding: initial support for hardware
 crypto offload
To:     Jarod Wilson <jarod@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 1:18 PM Jarod Wilson <jarod@redhat.com> wrote:
>
> This is an initial functional implementation for doing pass-through of
> hardware encryption from bonding device to capable slaves, in active-backup
> bond setups. This was developed and tested using ixgbe-driven Intel x520
> interfaces with libreswan and a transport mode connection, primarily using
> netperf, with assorted connection failures forced during transmission. The
> failover works quite well in my testing, and overall performance is right
> on par with offload when running on a bare interface, no bond involved.
>
> Caveats: this is ONLY enabled for active-backup, because I'm not sure
> how one would manage multiple offload handles for different devices all
> running at the same time in the same xfrm, and it relies on some minor
> changes to both the xfrm code and slave device driver code to get things
> to behave, and I don't have immediate access to any other hardware that
> could function similarly, but the NIC driver changes are minimal and
> straight-forward enough that I've included what I think ought to be
> enough for mlx5 devices too.
>
> v2: reordered patches, switched (back) to using CONFIG_XFRM_OFFLOAD
> to wrap the code additions and wrapped overlooked additions.
>
> Jarod Wilson (4):
>   xfrm: bail early on slave pass over skb
>   ixgbe_ipsec: become aware of when running as a bonding slave
>   mlx5: become aware of when running as a bonding slave
>   bonding: support hardware encryption offload to slaves
>
>  drivers/net/bonding/bond_main.c               | 127 +++++++++++++++++-
>  .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  39 ++++--
>  .../mellanox/mlx5/core/en_accel/ipsec.c       |   6 +
>  include/net/bonding.h                         |   3 +
>  include/net/xfrm.h                            |   1 +
>  net/xfrm/xfrm_device.c                        |  34 ++---
>  6 files changed, 183 insertions(+), 27 deletions(-)

Was this ever sent to netdev (the more appropriate ML)?

-- 
Cheers,
Jeff
