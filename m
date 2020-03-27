Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D0BC2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7206320774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PN5kNO2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgC0C70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:59:26 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45934 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgC0C7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:59:25 -0400
Received: by mail-vk1-f195.google.com with SMTP id b187so2303586vkh.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 19:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=efTQZuBY/BdGfCfIti/x+eiTAFDqkj9PxcQRTVTmyvU=;
        b=PN5kNO2Y7Hatz8rIRcoPnXIU8mrZax4gEuaM4gYGUvAR0T+yaNwxlUB4HxBPh8/tJD
         QlaJ57p+hjcFxR3Hce0XwoA+X/KiThWplYxgAGee7iJHAFxDwY2d0ahgVf7D6aC4uXWd
         8u7hA7WRnVXCv44NGJxiFFZWUulBbnxQe1yXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=efTQZuBY/BdGfCfIti/x+eiTAFDqkj9PxcQRTVTmyvU=;
        b=WVpPm4zpGZqJerMescy2BYCUUUeiZOoutOylqEBMvA9BR+/8HuYDfHiQGpO40MzCuA
         JEhP/NGhk0FZsDUL7rRjM/RpLyrcPgqI4P5oKUcuLib1Mpeu6wtaxQ+FRQ+S3m7OuuTI
         aNLQz67cVqBgKZFUR4AbPm3HFuoYuY6KpmkPao282ieYPgnsHFwKgHPLJPIAfzHlz2fE
         hNMbxhIlg2btgEqKYQ/vlUn8v4K48fdaIBFmzc91b49Bsgfhu5wa9yH6FIu4wcej7xpc
         kw2xB6fUfLTXcuJNUDR0dA+PK29BxnrimcpbgpteT8s88qjhkA6ukugjZ9fJm11DwUVP
         d0Aw==
X-Gm-Message-State: ANhLgQ3EkbLxwp9SoRDW8JI3604XHzR/LQ+ft5F+aAC9NY/rBP5mPTOg
        OBNTR9f7j6HQrD+L8cqFVuD28w8Yj1KpEEedEULw1g==
X-Google-Smtp-Source: ADFU+vuZLKGOnsm6OEMlUxXQh1lnoHRPEGsoLXro6EVkvPJIkztcCUU1ETtAxDELD2TaI4PY1Ozcxx+NYyavz8ak7SI=
X-Received: by 2002:a1f:2706:: with SMTP id n6mr4191470vkn.88.1585277964583;
 Thu, 26 Mar 2020 19:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200326054517.71462-1-abhishekpandit@chromium.org>
In-Reply-To: <20200326054517.71462-1-abhishekpandit@chromium.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Thu, 26 Mar 2020 19:59:11 -0700
Message-ID: <CANFp7mX3VhgbqSixv9BtWU5C4xy0RGqyPfV5SmruyngkkjM-VA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Bluetooth: Add actions to set wakeable in add device
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
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

Hi Marcel,

Does this look ok? I'm working on the accompanying Bluez changes as
well and will send a new patch if the mgmt changes look ok.

Thanks
Abhishek

On Wed, Mar 25, 2020 at 10:45 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
>
> Hi Marcel,
>
> As suggested, I've updated add device to accept action 0x3 and 0x4 to
> set and remove the wakeable property.
>
> Thanks
> Abhishek
>
>
> Changes in v2:
> * Added missing goto unlock
>
> Abhishek Pandit-Subedi (1):
>   Bluetooth: Update add_device with wakeable actions
>
>  net/bluetooth/mgmt.c | 57 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 47 insertions(+), 10 deletions(-)
>
> --
> 2.25.1.696.g5e7596f4ac-goog
>
