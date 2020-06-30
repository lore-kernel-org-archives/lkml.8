Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2D8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32A22073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vyf6XWz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgF3V4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgF3V4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:56:01 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09476C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:56:01 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id s16so6886359lfp.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmOZ0XuG4g2eZl+4ZC4AL+xOIxaD6EMfVCRTLIIYYGE=;
        b=Vyf6XWz5jRcDww52yc4d4Oq+roFuuZKNq/BHB+ZWpxojfUqNPllihDN3f5lJ8Y/T9Z
         mwZ+lFjbe/hrfezCl+gc8clJtr574NRs/xP5o/wtJ8y+u91ep3VP16u8K22A7ej7qLdC
         ehvTBg23bF+6odhA/tdesc/Y3povKcjIUODms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmOZ0XuG4g2eZl+4ZC4AL+xOIxaD6EMfVCRTLIIYYGE=;
        b=cvXxLusmEl04W8uKWihYATjTDtnCLDS3McR0cMS76B6bRt+7djWpRwmQtTm2YblQze
         pVJyEgd4d8w4Wx5LGduMrBPa0tT8LBsqoHHHHpAtuj1iD+PzPESDjrnsmMhLv2UGP37y
         3OlIaeI8DdvtQ2YWTrGXfnJ0eNtHabZ0QIaoCA6brFz5p6PtsKj990JIl9tYIjoFeWF5
         NsETxh9zSPNetjlOa7qOxGdFzLm+vKO4z4YtlZ3CyM6cGb9Pl4MAmJDMSszZBP7YJ49O
         nghoKHnndTywMkUujupZ55HQtHWGWJLxk0YOlgr8sWAxv+oqhr5wgb9JlbOOAslac9R6
         6LaQ==
X-Gm-Message-State: AOAM531rpbUey6cNTU5b+EkohyjwaXhjll9PFGqD/LW14kA8nIC5blym
        Ki+9CgJ9w96jhuFvXhnsZFppWepohfjtxTBnaSK2QQ==
X-Google-Smtp-Source: ABdhPJwR94n+7xH83mHqidczu9CR0DjnMKdnF/jaaPKl94g8fG7h0fWVOeEftBCONCQWeAKI/tJPnTqCAI/9SJ7Gstg=
X-Received: by 2002:a19:8407:: with SMTP id g7mr13225699lfd.61.1593554159514;
 Tue, 30 Jun 2020 14:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200629201441.v1.1.I162e3c6c4f4d963250c37733c3428329110c5989@changeid>
 <968D6753-8ACB-4298-91A4-F2C9438EAC06@holtmann.org>
In-Reply-To: <968D6753-8ACB-4298-91A4-F2C9438EAC06@holtmann.org>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Tue, 30 Jun 2020 14:55:48 -0700
Message-ID: <CABmPvSFq36OA-dxXxjhhocZjoJ1ZMZXZ4TULRYyTxcpksuXA7g@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Fix kernel oops triggered by hci_adv_monitors_clear()
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

hci_unregister_dev() is invoked when the controller is intended to be
removed by btusb driver. In other words, there should not be any
activity on hdev's workqueue, so the destruction of the workqueue
should be the first thing to do to prevent the clear helpers from
issuing any work. So my suggestion is to revert the patch re-arranging
the workqueue and apply this instead.
I should have uploaded this earlier, but I encountered some troubles
while verifying the changes. Sorry for the inconvenience.

Regards,
Miao

On Mon, Jun 29, 2020 at 11:51 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Miao-chen,
>
> > This fixes the kernel oops by removing unnecessary background scan
> > update from hci_adv_monitors_clear() which shouldn't invoke any work
> > queue.
> >
> > The following test was performed.
> > - Run "rmmod btusb" and verify that no kernel oops is triggered.
> >
> > Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> > net/bluetooth/hci_core.c | 2 --
> > 1 file changed, 2 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 5577cf9e2c7cd..77615161c7d72 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3005,8 +3005,6 @@ void hci_adv_monitors_clear(struct hci_dev *hdev)
> >               hci_free_adv_monitor(monitor);
> >
> >       idr_destroy(&hdev->adv_monitors_idr);
> > -
> > -     hci_update_background_scan(hdev);
> > }
>
> I am happy to apply this as well, but I also applied another patch re-arranging the workqueue destroy handling. Can you check which prefer or if we should include both patches.
>
> Regards
>
> Marcel
>
