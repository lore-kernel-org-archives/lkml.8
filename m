Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE029C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F09E206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jmtpfdya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404536AbgDCSKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:10:37 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39533 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404349AbgDCSKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:10:37 -0400
Received: by mail-vs1-f67.google.com with SMTP id u9so5527951vsp.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rZFwcLh88yvLFoU8cFxaAMsHIVK/kbvNYFcbKC3BCso=;
        b=jmtpfdyamIsA1Ylu3Q/6gwghzY6og8+UX/ZfkZuJ6ROuYXbTpehjoFhXuYiOyoEYBE
         8SgfiyG0zzWYFb4teybGEj1op9SUHS9ckHvLKUkNKa8pMBBt8gSrQi7I2FxDRcHvg2lq
         N2UY2EM7oCBqkzhdI2i06UDSCWxD2d9XLXBA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rZFwcLh88yvLFoU8cFxaAMsHIVK/kbvNYFcbKC3BCso=;
        b=PDV9wnBgPKCo3ERQZ2D3KL3EL1Dxn94xsBCotW5+DYBuGy6zNZeD3KQ41KwLzFo7Th
         bpBLB+fP5TFg5YK73/vHVL2RKlpD3cCqmBs50EtJ8YxlCWl33ykASVfuW4eQTyWFdt7U
         3ga0cJ7VAS0gzvRs91c4hinfrCBYxky5S8Vjzeq88/bXXQ/J7ayneSzD+UKqqIPqSx/6
         By2BRO2SfR+HrQcwW1UQZ2sZQXtx7eMmmhtZwTWvsDzzWah13/wpQN9nunOiBi3CYKxv
         /bw7qj1IwZeOdHyTDb+XGhVKZg4JHHNVTnK/kuYUulrxVznqmqm/z5z7WheAsseH0FxH
         xYSA==
X-Gm-Message-State: AGi0PuY3AXIsRYAKvfsZwtgUPPkKQ5pbCR3tH0ev3cJ5GjqdTJMyqAQs
        DyRQUKcAZ+NLQKb41JQ3xdSbFd5kCov1i9t7p8odBw==
X-Google-Smtp-Source: APiQypJxM9qgTZhmPUIT1h2Szg6sGhwsSGY749rhsDMKaR+M4LwrlPNfAZF627ZfAsj+u/oTmccg/Qr3VE1hGfznd+E=
X-Received: by 2002:a67:d49c:: with SMTP id g28mr8255493vsj.71.1585937434649;
 Fri, 03 Apr 2020 11:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200323194507.90944-1-abhishekpandit@chromium.org>
 <20200323124503.v3.1.I17e2220fd0c0822c76a15ef89b882fb4cfe3fe89@changeid> <7FD50BDC-A4B5-4ED9-8DAB-887039735800@holtmann.org>
In-Reply-To: <7FD50BDC-A4B5-4ED9-8DAB-887039735800@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Fri, 3 Apr 2020 11:10:23 -0700
Message-ID: <CANFp7mX=LvTzttCHcb14TRF8YukQt_WdMpYzJP5LP_ZXwzQTsQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] Bluetooth: Prioritize SCO traffic
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Thanks for merging.

I agree that the distinction between SCO/eSCO and ACL/LE is a bit
concerning for scheduling. I will make some time to revisit this as
part of Audio improvements we are making.

Thanks
Abhishek

Abhishek

On Thu, Apr 2, 2020 at 11:56 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
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
> > t =3D 10/8 * 1024 bytes * 8 bits/byte * 1 packet / baudrate
> >        where 10/8 is uart overhead due to start/stop bits per byte
> >
> > Replace t =3D 3.75ms (SCO deadline), which gives us a baudrate of 27306=
66.
> >
> > At a baudrate of 3000000, if we didn't check for SCO packets within 102=
4
> > bytes, we would miss the 3.75ms timing window.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > Changes in v3:
> > * Removed hci_sched_sync
> >
> > Changes in v2:
> > * Refactor to check for SCO/eSCO after each ACL/LE packet sent
> > * Enabled SCO priority all the time and removed the sched_limit variabl=
e
> >
> > net/bluetooth/hci_core.c | 106 +++++++++++++++++++++------------------
> > 1 file changed, 57 insertions(+), 49 deletions(-)
>
> patch has been applied to bluetooth-next tree.
>
> However I have been a bit reluctant to apply this right away. I think whe=
n this code was originally written, we only had ACL and SCO packets. The wo=
rld was pretty simple. And right now we also only have two packets types (i=
gnoring ISO packets for now), but we added LE and eSCO as separate scheduli=
ng and thus =E2=80=9Cfake=E2=80=9D packet types.
>
> I have the feeling that this serialized packet processing will get us int=
o trouble since we prioritize BR/EDR packets over LE packets and SCO over e=
SCO. I think we should have looked at all packets based on SO_PRIORITY and =
with ISO packets we have to most likely re-design this. Anyway, just someth=
ing to think about.
>
> Regards
>
> Marcel
>
