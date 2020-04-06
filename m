Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FD4C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B0520672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PX5OsGtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgDFSOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:14:14 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38534 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgDFSOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:14:14 -0400
Received: by mail-oi1-f193.google.com with SMTP id w2so13948012oic.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwVWsV6gvenKctyiGuAe/rKGjJgMe6nws/3+z+88G64=;
        b=PX5OsGtHQ5vrvMMRHJWDxtd3qsLGmxs9MKDmzcXi7/JX27vQnN40VlYEFYk8OsFC1z
         x5BOV5QG5QGwNq46mBWYQbtT2WLCSDBMLw6fFaibZU36uV3tns7UJ3LDFs9v3TTyFWJr
         FTRNIJu646fPbuGqj/gwVJdLOiMIgZ/7AGbco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwVWsV6gvenKctyiGuAe/rKGjJgMe6nws/3+z+88G64=;
        b=KKr6EWm3zA/kVpxsfOwMFPOWqWpbWBKMT7FrOWfiiutGpujJXXdgH6KS9D91xBxB17
         1wYNFOL0whdVwrZccEIDUzs1JF7HGnP7BBiuw2l/gvOJbEJwbfrNtql2tkxMGN4RY325
         ///wBco4vLZ3GOpDka/hjmmeClm8ZYz17bl6q2pdy7Wv20lv0sEfEPLIbY51xMeHgKT9
         ZRFxlBUk/X7vruq82YIMNWSx8pJPDnlIh6eRbBlqZC2BgKndPFzyzY1PekjXPtCvYNkq
         3iNZVtb+gAVorclzH94tQ06Pe7dC/CD6qiyist+qKJFNQaBOWoVXKJ6CnqE1QbxD6FTG
         pSng==
X-Gm-Message-State: AGi0PubNiSZxyASFWah8iihEPTi1BSXcv6a2+Awjg0lPMj9htvSDafpq
        26DHEGXnZkDPniEc5tHP1vUJCilLjwi2WObI8HHlnA==
X-Google-Smtp-Source: APiQypLbtJZTqw6lkz0tgTD0wNHJBu2c0EA99/ztDuYY3F80XImvHPC8Fw49gTf5ZQbdilv1ovkqByCQa5yDryPTV7Y=
X-Received: by 2002:aca:dd55:: with SMTP id u82mr384440oig.27.1586196851625;
 Mon, 06 Apr 2020 11:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200403150236.74232-1-linux@roeck-us.net> <CALWDO_WK2Vcq+92isabfsn8+=0UPoexF4pxbnEcJJPGas62-yw@mail.gmail.com>
 <0f0ea237-5976-e56f-cd31-96b76bb03254@roeck-us.net> <6456552C-5910-4D77-9607-14D9D1FA38FD@holtmann.org>
In-Reply-To: <6456552C-5910-4D77-9607-14D9D1FA38FD@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 6 Apr 2020 11:13:59 -0700
Message-ID: <CAOxioNneH_wieg39xLyBHb_E12LXiAm-uZBqvt3brdoQr0c7XQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Simplify / fix return values from tk_request
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Alain Michaud <alainmichaud@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Can this patch be merged? Or do you prefer reverting the original
patch and relanding it together with the fix?

On Mon, Apr 6, 2020 at 5:06 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Guenter,
>
> >>> Some static checker run by 0day reports a variableScope warning.
> >>>
> >>> net/bluetooth/smp.c:870:6: warning:
> >>>        The scope of the variable 'err' can be reduced. [variableScope]
> >>>
> >>> There is no need for two separate variables holding return values.
> >>> Stick with the existing variable. While at it, don't pre-initialize
> >>> 'ret' because it is set in each code path.
> >>>
> >>> tk_request() is supposed to return a negative error code on errors,
> >>> not a bluetooth return code. The calling code converts the return
> >>> value to SMP_UNSPECIFIED if needed.
> >>>
> >>> Fixes: 92516cd97fd4 ("Bluetooth: Always request for user confirmation for Just Works")
> >>> Cc: Sonny Sasaka <sonnysasaka@chromium.org>
> >>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >>> ---
> >>> net/bluetooth/smp.c | 9 ++++-----
> >>> 1 file changed, 4 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> >>> index d0b695ee49f6..30e8626dd553 100644
> >>> --- a/net/bluetooth/smp.c
> >>> +++ b/net/bluetooth/smp.c
> >>> @@ -854,8 +854,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
> >>>        struct l2cap_chan *chan = conn->smp;
> >>>        struct smp_chan *smp = chan->data;
> >>>        u32 passkey = 0;
> >>> -       int ret = 0;
> >>> -       int err;
> >>> +       int ret;
> >>>
> >>>        /* Initialize key for JUST WORKS */
> >>>        memset(smp->tk, 0, sizeof(smp->tk));
> >>> @@ -887,12 +886,12 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
> >>>        /* If Just Works, Continue with Zero TK and ask user-space for
> >>>         * confirmation */
> >>>        if (smp->method == JUST_WORKS) {
> >>> -               err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
> >>> +               ret = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
> >>>                                                hcon->type,
> >>>                                                hcon->dst_type,
> >>>                                                passkey, 1);
> >>> -               if (err)
> >>> -                       return SMP_UNSPECIFIED;
> >>> +               if (ret)
> >>> +                       return ret;
> >> I think there may be some miss match between expected types of error
> >> codes here.  The SMP error code type seems to be expected throughout
> >> this code base, so this change would propagate a potential negative
> >> value while the rest of the SMP protocol expects strictly positive
> >> error codes.
> >>
> >
> > Up to the patch introducing the SMP_UNSPECIFIED return value, tk_request()
> > returned negative error codes, and all callers convert it to SMP_UNSPECIFIED.
> >
> > If tk_request() is supposed to return SMP_UNSPECIFIED on error, it should
> > be returned consistently, and its callers don't have to convert it again.
>
> maybe we need to fix that initial patch then.
>
> Regards
>
> Marcel
>
