Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CCBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 23:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F6320772
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 23:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VH/aoSyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHRXeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgHRXea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 19:34:30 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9E1C061343
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 16:34:29 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id r7so11050651vsq.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 16:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cB70dETR/NyGQeHCHTARFj9L+SQvd7OlAWQERQoCVII=;
        b=VH/aoSyZVjORXv3NGcpvObwwphjJTPh8Teb99rTAe6HRr/0164LWsOX0ahj5q7dRDH
         5XIXK3BbjyjgmjpUwj+nAZSn4w6cRWSM6sGsH3NJe0BMbCbtUqKkHOyOIsqpouIwIB9O
         4HAUlPnDMdu4VX491vMC+FOMEBW2rpYRT6IV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cB70dETR/NyGQeHCHTARFj9L+SQvd7OlAWQERQoCVII=;
        b=fS+1LFpHsoI5rwlcN10t3SyNfmYnuXc+t1osV75iriwJYlYofVWoRyVKZjbwmG/kyw
         8KsiwWascxQgXxuWgnVAHv0p4Zh13Fw/5qyXwgUN4LiRCJgc1JED3LeiXG0jGJLqI0GU
         EHl6FBwAGZlMtxhLSjz9NdEISOF8fPBzzJbmA26V3svIv4QSJdSvhA3bS+dtPpEMaEjP
         Jsmd0ToPDKO7AZCslb7eQ66pZmHrRBAPIruZ1sbgzfPvOhdeq908wPqm22IiKRQk0U4C
         aCzkV1EYJMqox/aCeRkJ6l4igFxq/4Jgb00gnhW/S+tLf/507SFgodh8LA+6uvEwDhb/
         iexQ==
X-Gm-Message-State: AOAM5312H1RXv33Zcvha2uHbiW7CxSCqyFQ8ek1hyMWeaVSuRwTTx2Ny
        E8CYltIzlzkm4HtD3Lp+Njot2n62spiGu396FaAdng==
X-Google-Smtp-Source: ABdhPJzHyqzCkUdY55haN8OFBGZb0CYfaDh2JhndlSCGSs7EgCkjOFsKH6Ao88fQ+4pSMDiQMP+cyYhtv/6vgWxYkag=
X-Received: by 2002:a05:6102:311a:: with SMTP id e26mr13531599vsh.86.1597793668644;
 Tue, 18 Aug 2020 16:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200729014225.1842177-1-abhishekpandit@chromium.org> <CANFp7mV0TP-WbBWGSpduERaf9-KBXevhG7xKvjkMrqrtWWkZ5w@mail.gmail.com>
In-Reply-To: <CANFp7mV0TP-WbBWGSpduERaf9-KBXevhG7xKvjkMrqrtWWkZ5w@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 18 Aug 2020 16:34:17 -0700
Message-ID: <CANFp7mW3jXf1Djp=j3nYRzzoJAptJ8Z2JJCP+N6pMHGWXx=9cg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Bluetooth: Emit events for suspend/resume
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Please review this patch. A newer series for how the controller resume
event will be used is available at
https://patchwork.kernel.org/project/bluetooth/list/?series=334811

Besides usage in bluez, these events will also make debugging and
testing suspend/resume for Bluez easier (i.e. finding spurious wakes
due to BT in suspend stress tests, asserting that wakeup from peers
occurred as expected in tests)

Abhishek

On Tue, Aug 4, 2020 at 10:11 AM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Hi,
>
> Gentle reminder that this is waiting for feedback. Related userspace
> changes are here to see how we plan on using it:
> https://patchwork.kernel.org/project/bluetooth/list/?series=325777
>
> Thanks
> Abhishek
>
> On Tue, Jul 28, 2020 at 6:42 PM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> >
> > Hi Marcel,
> >
> > This series adds the suspend/resume events suggested in
> > https://patchwork.kernel.org/patch/11663455/.
> >
> > I have tested it with some userspace changes that monitors the
> > controller resumed event to trigger audio device reconnection and
> > verified that the events are correctly emitted.
> >
> > Please take a look.
> > Abhishek
> >
> >
> > Abhishek Pandit-Subedi (3):
> >   Bluetooth: Add mgmt suspend and resume events
> >   Bluetooth: Add suspend reason for device disconnect
> >   Bluetooth: Emit controller suspend and resume events
> >
> >  include/net/bluetooth/hci_core.h |  6 +++
> >  include/net/bluetooth/mgmt.h     | 16 +++++++
> >  net/bluetooth/hci_core.c         | 26 +++++++++++-
> >  net/bluetooth/hci_event.c        | 73 ++++++++++++++++++++++++++++++++
> >  net/bluetooth/mgmt.c             | 28 ++++++++++++
> >  5 files changed, 148 insertions(+), 1 deletion(-)
> >
> > --
> > 2.28.0.rc0.142.g3c755180ce-goog
> >
