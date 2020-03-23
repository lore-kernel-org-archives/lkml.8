Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E45C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6702051A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QZFAJNVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgCWTK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:10:56 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39069 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbgCWTKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:10:55 -0400
Received: by mail-vs1-f68.google.com with SMTP id j128so2949592vsd.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tp3bC93e0nUfPggrmvnMYoBNQ6UWOR58w4LV4ZhNS0=;
        b=QZFAJNVnkEz6tJ6FzoGWo4cS0Tr0c2wT3Gyl8gMiNmkTeIqbKiWYsC2rYDsKnGt2e8
         t0G0SzWlbvcpkKDxM0HH2DVdv5P7T3kTpraFDN528g94nBDdv0LJS3W0wP8SJBTPgyTD
         qgcvi04yAeh1TRoLfUD0Y6hp2xFWkCWWHiQaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tp3bC93e0nUfPggrmvnMYoBNQ6UWOR58w4LV4ZhNS0=;
        b=Hdv/cKPhE9KcMhbtnXvdtP4rIkLpFl99OnaeQqe5F8ZtWdh3LZ0UpMy9imQHB0IxZ4
         5CGLYIoMr6y/eqLtmckU2mqedabLYbnDFBPYvmmRJCAPMaB0cOP+noHZUf47zur1nzAB
         2Ye4ropbwGl45RmInHFWsM0E2m0pjSVDhGmolq67c3HeProla/M3J5ZUFjXfYmzz23km
         GQ7/RSM5FAte7DeGszSBnqVnNTR65X0/G+7v0GkssPFy+Ef5zeHHK4qhg0XSlrKsWAU6
         B3O26r1La5DPZ8+O+3SGjsZ5YfD1NoaESFWFlFzM0sGsUgQM4qWD07RdaOQmrZHSWPu8
         a31w==
X-Gm-Message-State: ANhLgQ0di3PG8lxnhRAS41PPsDTRp+BqreEr5R+9JcRpQKgvwK800b+D
        Ai+Jt1WnmexOX5Yd9voVNufeVM3poE4Foy4XVFf21w==
X-Google-Smtp-Source: ADFU+vuXszqaXED87ZaiMONJXX8a5RIeucsij/ir43q9RdI+5nS8boUUKde8aIEelt/LyWxeF7BRDsbfceIVon8FCw0=
X-Received: by 2002:a67:c01e:: with SMTP id v30mr17629845vsi.71.1584990652351;
 Mon, 23 Mar 2020 12:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200320231928.137720-1-abhishekpandit@chromium.org>
 <20200320161922.v2.1.I17e2220fd0c0822c76a15ef89b882fb4cfe3fe89@changeid> <C09DCA09-A2C9-4675-B17B-05CE0B5DE172@holtmann.org>
In-Reply-To: <C09DCA09-A2C9-4675-B17B-05CE0B5DE172@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 23 Mar 2020 12:10:40 -0700
Message-ID: <CANFp7mXG1HXKNQKn2YTsEOX6puNz=8WY6AHWac4UOiVMVQyEkg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: Prioritize SCO traffic
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
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

On Mon, Mar 23, 2020 at 11:58 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> > When scheduling TX packets, send all SCO/eSCO packets first, check for
> > pending SCO/eSCO packets after every ACL/LE packet and send them if any
> > are pending.  This is done to make sure that we can meet SCO deadlines
> > on slow interfaces like UART.
> >
> > If we were to queue up multiple ACL packets without checking for a SCO
> > packet, we might miss the SCO timing. For example:
> >
> > The time it takes to send a maximum size ACL packet (1024 bytes):
> > t = 10/8 * 1024 bytes * 8 bits/byte * 1 packet / baudrate
> >        where 10/8 is uart overhead due to start/stop bits per byte
> >
> > Replace t = 3.75ms (SCO deadline), which gives us a baudrate of 2730666.
> >
> > At a baudrate of 3000000, if we didn't check for SCO packets within 1024
> > bytes, we would miss the 3.75ms timing window.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > Changes in v2:
> > * Refactor to check for SCO/eSCO after each ACL/LE packet sent
> > * Enabled SCO priority all the time and removed the sched_limit variable
> >
> > net/bluetooth/hci_core.c | 111 +++++++++++++++++++++------------------
> > 1 file changed, 61 insertions(+), 50 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index dbd2ad3a26ed..a29177e1a9d0 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -4239,6 +4239,60 @@ static void __check_timeout(struct hci_dev *hdev, unsigned int cnt)
> >       }
> > }
> >
> > +/* Schedule SCO */
> > +static void hci_sched_sco(struct hci_dev *hdev)
> > +{
> > +     struct hci_conn *conn;
> > +     struct sk_buff *skb;
> > +     int quote;
> > +
> > +     BT_DBG("%s", hdev->name);
> > +
> > +     if (!hci_conn_num(hdev, SCO_LINK))
> > +             return;
> > +
> > +     while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
> > +             while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
> > +                     BT_DBG("skb %p len %d", skb, skb->len);
> > +                     hci_send_frame(hdev, skb);
> > +
> > +                     conn->sent++;
> > +                     if (conn->sent == ~0)
> > +                             conn->sent = 0;
> > +             }
> > +     }
> > +}
> > +
> > +static void hci_sched_esco(struct hci_dev *hdev)
> > +{
> > +     struct hci_conn *conn;
> > +     struct sk_buff *skb;
> > +     int quote;
> > +
> > +     BT_DBG("%s", hdev->name);
> > +
> > +     if (!hci_conn_num(hdev, ESCO_LINK))
> > +             return;
> > +
> > +     while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK,
> > +                                                  &quote))) {
> > +             while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
> > +                     BT_DBG("skb %p len %d", skb, skb->len);
> > +                     hci_send_frame(hdev, skb);
> > +
> > +                     conn->sent++;
> > +                     if (conn->sent == ~0)
> > +                             conn->sent = 0;
> > +             }
> > +     }
> > +}
> > +
> > +static void hci_sched_sync(struct hci_dev *hdev)
> > +{
> > +     hci_sched_sco(hdev);
> > +     hci_sched_esco(hdev);
> > +}
> > +
>
> scrap this function. It has almost zero benefit.

Done.

>
> > static void hci_sched_acl_pkt(struct hci_dev *hdev)
> > {
> >       unsigned int cnt = hdev->acl_cnt;
> > @@ -4270,6 +4324,9 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
> >                       hdev->acl_cnt--;
> >                       chan->sent++;
> >                       chan->conn->sent++;
> > +
> > +                     /* Send pending SCO packets right away */
> > +                     hci_sched_sync(hdev);
>
>                         hci_sched_esco();
>                         hci_sched_sco();
>
> >               }
> >       }
> >
> > @@ -4354,54 +4411,6 @@ static void hci_sched_acl(struct hci_dev *hdev)
> >       }
> > }
> >
> > -/* Schedule SCO */
> > -static void hci_sched_sco(struct hci_dev *hdev)
> > -{
> > -     struct hci_conn *conn;
> > -     struct sk_buff *skb;
> > -     int quote;
> > -
> > -     BT_DBG("%s", hdev->name);
> > -
> > -     if (!hci_conn_num(hdev, SCO_LINK))
> > -             return;
> > -
> > -     while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
> > -             while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
> > -                     BT_DBG("skb %p len %d", skb, skb->len);
> > -                     hci_send_frame(hdev, skb);
> > -
> > -                     conn->sent++;
> > -                     if (conn->sent == ~0)
> > -                             conn->sent = 0;
> > -             }
> > -     }
> > -}
> > -
> > -static void hci_sched_esco(struct hci_dev *hdev)
> > -{
> > -     struct hci_conn *conn;
> > -     struct sk_buff *skb;
> > -     int quote;
> > -
> > -     BT_DBG("%s", hdev->name);
> > -
> > -     if (!hci_conn_num(hdev, ESCO_LINK))
> > -             return;
> > -
> > -     while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK,
> > -                                                  &quote))) {
> > -             while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
> > -                     BT_DBG("skb %p len %d", skb, skb->len);
> > -                     hci_send_frame(hdev, skb);
> > -
> > -                     conn->sent++;
> > -                     if (conn->sent == ~0)
> > -                             conn->sent = 0;
> > -             }
> > -     }
> > -}
> > -
> > static void hci_sched_le(struct hci_dev *hdev)
> > {
> >       struct hci_chan *chan;
> > @@ -4436,6 +4445,9 @@ static void hci_sched_le(struct hci_dev *hdev)
> >                       cnt--;
> >                       chan->sent++;
> >                       chan->conn->sent++;
> > +
> > +                     /* Send pending SCO packets right away */
> > +                     hci_sched_sync(hdev);
>
> Same as above. Just call the two functions.

Done

>
> >               }
> >       }
> >
> > @@ -4458,9 +4470,8 @@ static void hci_tx_work(struct work_struct *work)
> >
> >       if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> >               /* Schedule queues and send stuff to HCI driver */
> > +             hci_sched_sync(hdev);
> >               hci_sched_acl(hdev);
> > -             hci_sched_sco(hdev);
> > -             hci_sched_esco(hdev);
> >               hci_sched_le(hdev);
>
> I would actually just move _le up after _acl and then keep _sco and _esco at the bottom. The calls here are just for the case there are no ACL nor LE packets.

Then we would send at least 1 ACL/LE packet before SCO even if there
were SCO pending when we entered this function. I think it is still
better to keep SCO/eSCO at the top.

>
> Regards
>
> Marcel
>
