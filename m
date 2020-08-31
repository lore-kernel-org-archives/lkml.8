Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFCBC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1692C20866
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PKX3NGBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgHaQwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgHaQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:52:08 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F583C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:52:08 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y3so3605126vsn.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2wssN0DfVl0Q5ulsK8rehD0qys9A1UTSyxawRAlJec=;
        b=PKX3NGBdootImldgizkUZ9JNq2aRTpLy+LDPXgaGjN67aJZcX5pKbxjF6UCyW/HP/1
         1xIphJEPk/1dlpzCnvwdr8psoRTZ4SQXSMEmtmvUrQlJjlhEMVNcqa79KrQe88WEXmBS
         Tu8vgti347fq8k6r++gj5T7TkTnDDswBF6FeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2wssN0DfVl0Q5ulsK8rehD0qys9A1UTSyxawRAlJec=;
        b=f5P3ScxhboNxmZSRxZ1Pr7mHH5/Tgn9gRqzv09l+BnXKNZDVOoKfHixxT6kCicKeUE
         PkFaRQPqpcd1wchIvrOBXrVwQeqIeANJ2LZZdoyYf2I0yLYasApzQCo3E83qdmt1HJB8
         tX+XMmo9yNxVQ/3Jjg8/Vbw0inogJkbnVvDne2rXr9bWBpA9LuW9npZMotWSO1JFbN2u
         QUVuVRJM5r2cPSnpS/nHlJHTYTD02b9GGHSFYPkxxOuT349c/cYFnr7NbxD5mYl5lPwc
         5/RgVKr1VJJbTMZ6A4/hyRbIWGQu+IsRmq5h38ZYttTNnls3+riYF/70jB/ZLetSwjgp
         gsIg==
X-Gm-Message-State: AOAM531uzxIV/roMoLre0YZE2jcdv88P1nrkF7wEA3qW/F3gNBC5jjJ2
        quTViACd7FJRThLYQEdIpRw8vTrHghRAjLRm8I2DPw==
X-Google-Smtp-Source: ABdhPJzRl4IzM+/5e+TD8Pd7j+A6SmKTwYoGY5YNvdrKb+tJbT1J0kMH3uJc5Yi9i1lQvDnOm0uTXj7cCiaXUmoq3bo=
X-Received: by 2002:a05:6102:1045:: with SMTP id h5mr2083568vsq.42.1598892727414;
 Mon, 31 Aug 2020 09:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200826154719.1.I24fb6cc377d03d64d74f83cec748afd12ee33e37@changeid>
 <A69701BE-FBB3-4053-8187-618C0BD4B380@holtmann.org>
In-Reply-To: <A69701BE-FBB3-4053-8187-618C0BD4B380@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 31 Aug 2020 09:51:56 -0700
Message-ID: <CANFp7mXY7--Mziduq69gUj5cgCiZCZ-47JOpBNL6H0bLpN2bbQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Clear suspend tasks on unregister
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 sent with fix.

On Mon, Aug 31, 2020 at 8:49 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> > While unregistering, make sure to clear the suspend tasks before
> > cancelling the work. If the unregister is called during resume from
> > suspend, this will unnecessarily add 2s to the resume time otherwise.
> >
> > Fixes: 4e8c36c3b0d73d (Bluetooth: Fix suspend notifier race)
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> > This was discovered with RT8822CE using the btusb driver. This chipset
> > will reset on resume during system suspend and was unnecessarily adding
> > 2s to every resume. Since we're unregistering anyway, there's no harm in
> > just clearing the pending events.
> >
> > net/bluetooth/hci_core.c | 11 +++++++++++
> > 1 file changed, 11 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 68bfe57b66250f..ed4cb3479433c0 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3442,6 +3442,16 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
> >       }
> > }
> >
> > +static void hci_suspend_clear_tasks(struct hci_dev *hdev)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < __SUSPEND_NUM_TASKS; ++i)
> > +             clear_bit(i, hdev->suspend_tasks);
>
> I prefer i++ instead of ++i.
>
> Regards
>
> Marcel
>
