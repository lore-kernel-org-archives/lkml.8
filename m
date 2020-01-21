Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA94EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739E024125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J3TBRnTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAUXbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:31:09 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:34801 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAUXbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:31:09 -0500
Received: by mail-vk1-f195.google.com with SMTP id w67so1455102vkf.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 15:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dp6oasckur6kjovlcP2IlFs4QaVQn/76z7EhwGccLDg=;
        b=J3TBRnTZI4uUGbi4rWEZghUZesIEtVlTjYCY+rxoMv7hrpLiVTkqnfCSOgVpyvfDXY
         mQfY3jzVPs186SZW85z37ZcCQuB1+SIhqQ418q9FCsJf4vni2k0iyT1X1a9ZfJKhv1UJ
         AuyoC8X96dasJ3F2w+r2Z5KdbMr9qmv6uWFEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dp6oasckur6kjovlcP2IlFs4QaVQn/76z7EhwGccLDg=;
        b=c5dOwF0o6yb6ubKXvhzmPzJi/JH8f+s6vGSYJCEcmgkCfSIQW4YV5iVB6akCExhpvH
         d2y508BO4pLDP+nFwrjoRu3XVJq2/knIj6LqVuEKJNjmlWnti64ouNSv0dKSwBMYYLYd
         oJ1KNH85s+tQAy6VYeNMxHXeS6RzH9SxwYl+AI6yKq43wGa8cftYCNGpRc2V3gNMaY1x
         bjQCDloN7ciq7uXE1JpyulMExiDCLZ0B5A7duEDw+ZfUEFCmwNt3Dpx62/lEpwjShLE9
         30AZWnLxrlCVHjnRCmpbB8tqr7uxXYiey1nkJNloGTZZL5tj1vc27DAVd2fHzSV42C0u
         BqBQ==
X-Gm-Message-State: APjAAAVeZenlYchk0XtmAgcCRZk3FzqbVYAFRRExrClwAF1JujfPikfJ
        yJzOcdHaAoTIc5SHleqJZGsqv471PvW+O58O/DAqug==
X-Google-Smtp-Source: APXvYqw8tIdQkMrg0Ci0wzIi38KfztjpuxnmWALDiTnxfOAIqPWBaTzwDW0hVJRBpuNvoYVGQWrBw76xIq4DC6CU1xA=
X-Received: by 2002:a1f:1144:: with SMTP id 65mr4584579vkr.77.1579649467467;
 Tue, 21 Jan 2020 15:31:07 -0800 (PST)
MIME-Version: 1.0
References: <20200117212705.57436-1-abhishekpandit@chromium.org>
 <20200117132623.RFC.1.I797e2f4cb824299043e771f3ab9cef86ee09f4db@changeid> <ACAE240C-345B-43F9-B6C8-8967AF436CE9@holtmann.org>
In-Reply-To: <ACAE240C-345B-43F9-B6C8-8967AF436CE9@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 21 Jan 2020 15:30:56 -0800
Message-ID: <CANFp7mVjR9X=UjPZ5puX1z87NAeOBpvvQM8ASjijKAHz2+Uq8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Bluetooth: Add mgmt op set_wake_capable
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 8:35 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Abhishek,
>
> > When the system is suspended, only some connected Bluetooth devices
> > cause user input that should wake the system (mostly HID devices). Add
> > a list to keep track of devices that can wake the system and add
> > a management API to let userspace tell the kernel whether a device is
> > wake capable or not.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > include/net/bluetooth/hci_core.h |  1 +
> > include/net/bluetooth/mgmt.h     |  7 ++++++
> > net/bluetooth/hci_core.c         |  1 +
> > net/bluetooth/mgmt.c             | 42 ++++++++++++++++++++++++++++++++
> > 4 files changed, 51 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 89ecf0a80aa1..ce4bebcb0265 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -394,6 +394,7 @@ struct hci_dev {
> >       struct list_head        mgmt_pending;
> >       struct list_head        blacklist;
> >       struct list_head        whitelist;
> > +     struct list_head        wakeable;
> >       struct list_head        uuids;
> >       struct list_head        link_keys;
> >       struct list_head        long_term_keys;
> > diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.=
h
> > index a90666af05bd..283ba5320bdb 100644
> > --- a/include/net/bluetooth/mgmt.h
> > +++ b/include/net/bluetooth/mgmt.h
> > @@ -671,6 +671,13 @@ struct mgmt_cp_set_blocked_keys {
> > } __packed;
> > #define MGMT_OP_SET_BLOCKED_KEYS_SIZE 2
> >
> > +#define MGMT_OP_SET_WAKE_CAPABLE     0x0047
> > +#define MGMT_SET_WAKE_CAPABLE_SIZE   8
> > +struct mgmt_cp_set_wake_capable {
> > +     struct mgmt_addr_info addr;
> > +     u8 wake_capable;
> > +} __packed;
> > +
>
> please also send a patch for doc/mgmt-api.txt describing these opcodes. I=
 would also like to have the discussion if it might be better to add an ext=
ra Action parameter to Add Device. We want to differentiate between allow i=
ncoming connection that allows to wakeup and the one that doesn=E2=80=99t.
>
> Another option is to create an Add Extended Device command. Main reason h=
ere is that I don=E2=80=99t want to end up in the situation where you have =
to add a device and then send another 10 commands to set its features.

Sent an email for doc/mgmt-api.txt. I think adding this to "Add
Device" would be acceptable. However, it is possible for "wake
capable" to be modified at runtime so it might be more appropriate on
some sort of Set Connection Parameters type command.

>
> > #define MGMT_EV_CMD_COMPLETE          0x0001
> > struct mgmt_ev_cmd_complete {
> >       __le16  opcode;
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 1ca7508b6ca7..7057b9b65173 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3299,6 +3299,7 @@ struct hci_dev *hci_alloc_dev(void)
> >       INIT_LIST_HEAD(&hdev->mgmt_pending);
> >       INIT_LIST_HEAD(&hdev->blacklist);
> >       INIT_LIST_HEAD(&hdev->whitelist);
> > +     INIT_LIST_HEAD(&hdev->wakeable);
> >       INIT_LIST_HEAD(&hdev->uuids);
> >       INIT_LIST_HEAD(&hdev->link_keys);
> >       INIT_LIST_HEAD(&hdev->long_term_keys);
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 0dc610faab70..95092130f16c 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -106,7 +106,10 @@ static const u16 mgmt_commands[] =3D {
> >       MGMT_OP_START_LIMITED_DISCOVERY,
> >       MGMT_OP_READ_EXT_INFO,
> >       MGMT_OP_SET_APPEARANCE,
> > +     MGMT_OP_GET_PHY_CONFIGURATION,
> > +     MGMT_OP_SET_PHY_CONFIGURATION,
>
> These are unrelated to this patch.

They weren't there on tip last time I rebased. Should I create a new
patch for this?

>
> >       MGMT_OP_SET_BLOCKED_KEYS,
> > +     MGMT_OP_SET_WAKE_CAPABLE,
> > };
> >
> > static const u16 mgmt_events[] =3D {
> > @@ -4663,6 +4666,37 @@ static int set_fast_connectable(struct sock *sk,=
 struct hci_dev *hdev,
> >       return err;
> > }
> >
> > +static int set_wake_capable(struct sock *sk, struct hci_dev *hdev, voi=
d *data,
> > +                         u16 len)
> > +{
> > +     int err;
> > +     u8 status;
> > +     struct mgmt_cp_set_wake_capable *cp =3D data;
> > +     u8 addr_type =3D cp->addr.type =3D=3D BDADDR_BREDR ?
> > +                            cp->addr.type :
> > +                            le_addr_type(cp->addr.type);
> > +
> > +     BT_DBG("Set wake capable %pMR (type 0x%x) =3D 0x%x\n", &cp->addr.=
bdaddr,
> > +            addr_type, cp->wake_capable);
> > +
> > +     if (cp->wake_capable)
> > +             err =3D hci_bdaddr_list_add(&hdev->wakeable, &cp->addr.bd=
addr,
> > +                                       addr_type);
> > +     else
> > +             err =3D hci_bdaddr_list_del(&hdev->wakeable, &cp->addr.bd=
addr,
> > +                                       addr_type);
> > +
> > +     if (!err || err =3D=3D -EEXIST || err =3D=3D -ENOENT)
> > +             status =3D MGMT_STATUS_SUCCESS;
> > +     else
> > +             status =3D MGMT_STATUS_FAILED;
> > +
> > +     err =3D mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_WAKE_CAPABLE,=
 status,
> > +                             cp, sizeof(*cp));
> > +
> > +     return err;
> > +}
> > +
> > static void set_bredr_complete(struct hci_dev *hdev, u8 status, u16 opc=
ode)
> > {
> >       struct mgmt_pending_cmd *cmd;
> > @@ -5791,6 +5825,13 @@ static int remove_device(struct sock *sk, struct=
 hci_dev *hdev,
> >                       err =3D hci_bdaddr_list_del(&hdev->whitelist,
> >                                                 &cp->addr.bdaddr,
> >                                                 cp->addr.type);
> > +
> > +                     /* Don't check result since it either succeeds or=
 device
> > +                      * wasn't there (not wakeable or invalid params a=
s
> > +                      * covered by deleting from whitelist).
> > +                      */
> > +                     hci_bdaddr_list_del(&hdev->wakeable, &cp->addr.bd=
addr,
> > +                                         cp->addr.type);
> >                       if (err) {
> >                               err =3D mgmt_cmd_complete(sk, hdev->id,
> >                                                       MGMT_OP_REMOVE_DE=
VICE,
> > @@ -6990,6 +7031,7 @@ static const struct hci_mgmt_handler mgmt_handler=
s[] =3D {
> >       { set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
> >       { set_blocked_keys,        MGMT_OP_SET_BLOCKED_KEYS_SIZE,
> >                                               HCI_MGMT_VAR_LEN },
> > +     { set_wake_capable,        MGMT_SET_WAKE_CAPABLE_SIZE },
> > };
> >
>
> Regards
>
> Marcel
>
