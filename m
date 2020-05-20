Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AA0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2262072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgETVoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:44:06 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41865 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgETVoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:44:06 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M9nlN-1jeYuf1IFp-005u8h for <linux-kernel@vger.kernel.org>; Wed, 20 May
 2020 23:44:04 +0200
Received: by mail-qk1-f179.google.com with SMTP id f83so5174160qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 14:44:04 -0700 (PDT)
X-Gm-Message-State: AOAM531qa+THUt+okdcXId3Dj+fzfkkRiEy3NrCdK/nGSUNMdrh0LI9c
        0EAJyK5hT3NnpqtueLtnXatQ7fm4Txx1AfGk4cw=
X-Google-Smtp-Source: ABdhPJxw+j9W721PET1+TWLk0kKUz9+TLFF4EfNOqjhc/UDiL6eBxAoB3VV8f/cbbKxllbgBNziyQkQ/LjQzSTsgNqs=
X-Received: by 2002:a37:46c9:: with SMTP id t192mr3919380qka.3.1590011043228;
 Wed, 20 May 2020 14:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200520195440.38759-1-hdegoede@redhat.com> <20200520195440.38759-7-hdegoede@redhat.com>
In-Reply-To: <20200520195440.38759-7-hdegoede@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 May 2020 23:43:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3fUUpixJu-jbhmhMMXP-tJYxYfLq78OUTTVaN+_c8ZwA@mail.gmail.com>
Message-ID: <CAK8P3a3fUUpixJu-jbhmhMMXP-tJYxYfLq78OUTTVaN+_c8ZwA@mail.gmail.com>
Subject: Re: [PATCH 7/8] virt: vbox: Log unknown ioctl requests as error
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IB5QN+LONuBQkdWGgA4OISgSP3DOneWz6uJX3g+wQVx7robAo4t
 5Qi669O06ro9rzpJdeX5jN0vw3jPyY2Npq81yEv1m2ErUr45TtT0wUmXyRYf0QIIx5IM0Tv
 A1jV9wzlO3Z4N8rb9jTnjSOqHafO7qz6Ta3bfdIA8hmEbP5QJkuu27RujSg+sDqDeSicOFA
 1SoMmojTjEQKsqkZob2Cg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zg8qSJ6Z5us=:zuBiOggFp8LyrCX+zx8PE6
 +AXWs5z3Dx8GwFfeUYfqyKv4VngEB1okYzyNIkFkRSxeCSGOaXaT/qpt1kqC1sQDpPUIC2Tgd
 JF4hZAEa/pYQrEbuIOgYXGkVvDSio/FfIyofYVCCQNaflhJyQp5mjIkzQT9CeWQlaWPiUVFTC
 OFzg9JTViEW/C+FNR+WK0tGvpJo9Qshk/OEwBkEFGEwxdUa12+J/ZAHrV7WRXQ343Ukmu382+
 hAaqZvNBum5oIIgA3nKlqR6xRYPOEu1gM4oWoZPyfCoIRnVtQQHfrTBTkqZD+MpLtqHagr9Ag
 AoiF9mC+cBvX1xjDDMwRz1Xd5Kf8IPXXmDdmaomLCreEMU9sqBSigXjsUHWYtno7Zxg3m0lOS
 ocTIyFfL0tlxFfDZNIgVDX2I8RA2sN3JhYRfowBq53+P5+BCB4TJWuLvSqI4oo6Rh7md4CDOD
 mfrkcT4mt1q2QZVMjDkEikGQaAp4k7xeY8TINPrjOFbFR0focsHs5w6ZTX57A7NcOUrbFVplP
 S0sucy/y9mGmAQZqt5tnQl0NIf08H2zu0W4IUqrXkGNeH+R0zUsXh5BdMRqIJN9HG6pZhh+W9
 l5jgc40DW+XGWBMTq/FwLchQbKvOGe7iq2JGg0gffHDRJ5c5o/PhcPZXqSB3wR4raeG15ZkCK
 VMY0qQaLzjkUISP0/Bw5nzGsZfWQ+Q269cpVgTmHxCjyh7HreU+H45izu7SWLk+3K7eimrZRm
 MtfmYvg/kTq/PrHeo0E4vNxqSzedA6JDI8GgxGGKGWxcuVKz/YbOi7yxCd3voIhpEsnDBcr5j
 smUXKkJOoaWCyuLSQ901t+lYwrZpzF46Bxa+7VIdbiLEMk+2XI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 9:55 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Every now and then upstream adds new ioctls without notifying us,
> log unknown ioctl requests as an error to catch these.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/virt/vboxguest/vboxguest_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
> index ffd76b949276..e0e343d0ba93 100644
> --- a/drivers/virt/vboxguest/vboxguest_core.c
> +++ b/drivers/virt/vboxguest/vboxguest_core.c
> @@ -1739,7 +1739,7 @@ int vbg_core_ioctl(struct vbg_session *session, unsigned int req, void *data)
>                 return vbg_ioctl_log(data);
>         }
>
> -       vbg_debug("VGDrvCommonIoCtl: Unknown req %#08x\n", req);
> +       vbg_err("Userspace made an unknown ioctl req %#08x\n", req);

I think these should be ratelimited to avoid spamming the console with
too many messages for something that can be trivially triggered from
user space.

       Arnd
