Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567BAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 23:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3263F206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 23:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ci92my1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgFLXwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 19:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgFLXwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 19:52:10 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ABFC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 16:52:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y11so12976423ljm.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 16:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5ngALuwgd2UZp15ZYB2LhrDQynYsE132uhUeXOpEus=;
        b=ci92my1ZAUe4UyS0wP9gpUITvBjosTAhuGtf9IxMXi1eY2r/xuLb2p+Qvo+UCOXgvk
         Zstx17w5x487Vl9jajqvZlnrqSRg7Az/eH8km2aMCoilixtUYE+alqukimUB7QOcY6eR
         Jls33PaT5jVnckx47c0nQwOvup15kWdja40zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5ngALuwgd2UZp15ZYB2LhrDQynYsE132uhUeXOpEus=;
        b=QWoKmW0pjZwllbjOX22vnR8m3osTwlywzb71zlPO4r2ujFiHgYVPP01IrSN022/QAd
         1r1y+PeTIX2yseAPC1ahl0+oC5pBgu7z2LlcpcIQo2ymcueJqkL9cu4xnHDVnurIRQdU
         +T1qxDjFHJRm5Jg3pjQnJu+Gq3DNwJwMZN4LGcQvnqI7EDkvX2sIgeuyYVenU4+DdAzM
         +SAFp3mm1bOUUkwxH+LfM4iJwdEK+r6PTysVjkSXerVmgY33C7IucM2z0AMfenrChnTU
         SxboA4K5skJxyh0PpieB018ysvZxXaosMGpsvplS7pM/EPhmrzuS19coFRg80/8klb5J
         SFCQ==
X-Gm-Message-State: AOAM531GA+tCW3jfwGG+E0EkeN21FhCgocQecWzrgJZgK7ND6g6FNyY8
        ZcGMDFw1T5R+GsJM/25GAh64gMg0wjP9V40KDysdtA==
X-Google-Smtp-Source: ABdhPJz2Mdm0Z7Fl1At0M2nCNbzBCJBpo+fZ879WiaZQKbv5YiEXypRoNYnkQLC3gigJDLewRFNFFS+qryDgCKFP1jg=
X-Received: by 2002:a2e:92cf:: with SMTP id k15mr8109767ljh.333.1592005928015;
 Fri, 12 Jun 2020 16:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200611231459.v3.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
 <20200611231459.v3.4.Ib4effd5813fb2f8585e2c7394735050c16a765eb@changeid> <20200612104952.0955d965@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200612104952.0955d965@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Fri, 12 Jun 2020 16:51:57 -0700
Message-ID: <CABmPvSHphwBuWy-pr4rro1MxS_NO5OLYsq56Fd=oed8gx7hYkg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] Bluetooth: Add handler of MGMT_OP_REMOVE_ADV_MONITOR
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

I uploaded v4 to address these. Thanks for the reminder.

Regards,
Miao

On Fri, Jun 12, 2020 at 10:49 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 11 Jun 2020 23:15:26 -0700 Miao-chen Chou wrote:
> > This adds the request handler of MGMT_OP_REMOVE_ADV_MONITOR command.
> > Note that the controller-based monitoring is not yet in place. This
> > removes the internal monitor(s) without sending HCI traffic, so the
> > request returns immediately.
> >
> > The following test was performed.
> > - Issue btmgmt advmon-remove with valid and invalid handles.
> >
> > Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
>
> Still doesn't build cleanly with W=1 C=1
>
> net/bluetooth/mgmt.c:4009:46: warning: incorrect type in argument 2 (different base types)
> net/bluetooth/mgmt.c:4009:46:    expected unsigned short [usertype] handle
> net/bluetooth/mgmt.c:4009:46:    got restricted __le16 [usertype] monitor_handle
> net/bluetooth/mgmt.c:4018:29: warning: cast from restricted __le16
