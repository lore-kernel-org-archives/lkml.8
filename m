Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BD9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA973206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="SzPJFfIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgF3EvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgF3EvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 00:51:11 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51F0C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 21:51:11 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z63so17436477qkb.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 21:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zCaps0loQaEmR/b2P5B3LXujzdso5k67v4HcTYc+GR8=;
        b=SzPJFfIcOzkcEYGA5v9ELeSfWERhjHPdjUj+Nvn1dSi0ZNyXp3B5TJjdq6S8/qq6NM
         MObyQPupwPQ94gzOYT3piiHl/suxo+twRdybak+evrIGY2afwXFKaJg0T2TdJa+QWGbY
         Tu2zbOgHLVwAHmYeDTm8zzrCFZrA+V8rG9G3dt53CdRnL+F/ou52CAMIEjcJUMMgW2uY
         AFXgTEzAQdXPos6Zngn1kQjD4qX+FMMb6JQnuN4azoc5ArC5CeKxSSbXcAWfkFeU3xeY
         7BfZKszqNNDiHTTGuFHPDefnVeq2lygo+b/kAKQuh6Yl4yTwamXJwBfOOOHKISJdJKTZ
         jA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCaps0loQaEmR/b2P5B3LXujzdso5k67v4HcTYc+GR8=;
        b=ueAVnySG+Y5KiWDtksaJHQVMVyhmlNGE0bp4XM3pC/mxJUg8tyBx8FA3SUrblG7vGk
         pAuS15Lk2EQQeRA/IExQQdhGy61VV7OizRuOXAC8MS+J3hv9v4dRJfGAUJBOth7imGcW
         hQHoPBCeS2NAq++AkKk9HxGgEh88J0/RL2XZw46K2hr7vgzm5mvNqQEbYztew3LLJ/7+
         jkZjyzLVIDFeD+bH49VSCexDH6FQkDdPBvcJGp2YMvXOIJ8ANtYg3zkx4Hm4+H5pSr30
         kaOBza6t8PNvv9YtAVlC0B8XzBbUbXIqyflFKJpwb0yR9yWYiIXrRvYZ9h06hbzfj95W
         0kww==
X-Gm-Message-State: AOAM530esFbS//KIa+gbWX/UcUHNEsdLkYg6qtKMDeheXUyRomD72hc/
        WbkXZzR38kN1/GrKeig7z7cPJ+jWHS8to3WgyH3u0Q==
X-Google-Smtp-Source: ABdhPJw17VDeB/8CSFZtI1dZDGngtZx5LKNRhxlkstFd7Z07UhFZgOrAGsTMwXB66P4UhkkHf9YFAHtAUqayNpl+n6Q=
X-Received: by 2002:a05:620a:1273:: with SMTP id b19mr18111737qkl.10.1593492670843;
 Mon, 29 Jun 2020 21:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200629211801.C3D7095C0900@us180.sjc.aristanetworks.com> <20200629171612.49efbdaa@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200629171612.49efbdaa@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Mon, 29 Jun 2020 21:50:59 -0700
Message-ID: <CA+HUmGjHQPUh1frfy5E28Om9WTVr0W+UQVDsm99beC_mbTeMog@mail.gmail.com>
Subject: Re: [PATCH] igb: reinit_locked() should be called with rtnl_lock
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        intel-wired-lan@lists.osuosl.org,
        David Miller <davem@davemloft.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Would you mind adding a fixes tag here? Probably:
>
> Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")

That seems to be the commit that introduced the driver in 2.6.25.
I am not familiar with the history of the driver to tell if this was a day 1
problem or if it became an issue later.

>
> And as a matter of fact it looks like e1000e and e1000 have the same
> bug :/ Would you mind checking all Intel driver producing matches for
> all the affected ones?

Do you mean identify all Intel drivers that may have the same issue?

Francesco
