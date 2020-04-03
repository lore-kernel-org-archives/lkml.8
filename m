Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B33C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC5F2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NnJYHcrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404130AbgDCPNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:13:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41585 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbgDCPNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:13:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id n17so7299756lji.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSB/s+jkbmzG+872wg2P5RsXw25dw+k96VoLRNM+xIk=;
        b=NnJYHcrEmoB8qNXKZ3slYqn5PMbvp36PsylL6He+9olAxu//fFL0pW4XIUIvD8cMrC
         Y6yJUUkqD6a9+uUEcC8JRoRzvnPwwrxRCwu5cm7XKxdFF0A/t/nmcgJKXjWTTn4txEwc
         Zq2lnpBvjQjY0ThdGLJ6pNVSru7mBNvrD2SWMqXXZmWfZHKPmHXm4eNcwAw8ElBj/jT3
         cNeyUrYOt0SLmx7WShfQxs1JwZ5G+ZKdS5bWF08a2A6lsdVXeADyUkvgW+k9aHrbsLSu
         +O5s8Z35IVJrBBcJYxOOQJRSxgQpvskRgy5RHSR0ueUphiBEl+Tl3s1X/15Em29ndTdH
         X6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSB/s+jkbmzG+872wg2P5RsXw25dw+k96VoLRNM+xIk=;
        b=ls4yhpWD1iUZtk9WmFcUtZfEchrBKKimda9o66JzVF4Ax1/jfhF/mYqBbZ5aMMa1tH
         ukJrNggr/l0V8hVVKsFgVfxDJWdbiQuI1IyHcz5DUIqeUs7+a7qI02e0YvVAWATTNS60
         cPoSP4Zm0vIzHgtz3izQATV1mZYZt9sVC+aVWM5ypzmY+t1fMmXX4oyNiYlQvCYuTAy9
         4k+bmGzeCVXzKw3Z/vHa+nGvBRpRxPAKGbOMw0H50kFVKMS5WrFLR+nrFanLB7cD5d8F
         jB+pQNGH5FbxG2cPWkbrCKgN/jWeHcR7oLw15PNnqJ3lzhozBFI27Boz/Bsvp0NGwnum
         2fag==
X-Gm-Message-State: AGi0PuY42dHc/6BfeH1GEpV6881DIzsHaOKNmkvphQmQkoOFB1tj3RcN
        sKxOtp92j3Q+tVzaLdCZbUvcVrOEFrx3u8fCOAVqGw==
X-Google-Smtp-Source: APiQypLtONB4lTDIuQGKUYhKGtjTQQxubEMFFX2sH19d1M6w/MHAofyXnuV7Dw13bDwXeScnw2+wB73K329En9qbzbE=
X-Received: by 2002:a2e:9084:: with SMTP id l4mr5287406ljg.277.1585926830857;
 Fri, 03 Apr 2020 08:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200403150236.74232-1-linux@roeck-us.net>
In-Reply-To: <20200403150236.74232-1-linux@roeck-us.net>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 3 Apr 2020 11:13:39 -0400
Message-ID: <CALWDO_WK2Vcq+92isabfsn8+=0UPoexF4pxbnEcJJPGas62-yw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Simplify / fix return values from tk_request
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter/Marcel,


On Fri, Apr 3, 2020 at 11:03 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Some static checker run by 0day reports a variableScope warning.
>
> net/bluetooth/smp.c:870:6: warning:
>         The scope of the variable 'err' can be reduced. [variableScope]
>
> There is no need for two separate variables holding return values.
> Stick with the existing variable. While at it, don't pre-initialize
> 'ret' because it is set in each code path.
>
> tk_request() is supposed to return a negative error code on errors,
> not a bluetooth return code. The calling code converts the return
> value to SMP_UNSPECIFIED if needed.
>
> Fixes: 92516cd97fd4 ("Bluetooth: Always request for user confirmation for Just Works")
> Cc: Sonny Sasaka <sonnysasaka@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  net/bluetooth/smp.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index d0b695ee49f6..30e8626dd553 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -854,8 +854,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
>         struct l2cap_chan *chan = conn->smp;
>         struct smp_chan *smp = chan->data;
>         u32 passkey = 0;
> -       int ret = 0;
> -       int err;
> +       int ret;
>
>         /* Initialize key for JUST WORKS */
>         memset(smp->tk, 0, sizeof(smp->tk));
> @@ -887,12 +886,12 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
>         /* If Just Works, Continue with Zero TK and ask user-space for
>          * confirmation */
>         if (smp->method == JUST_WORKS) {
> -               err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
> +               ret = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
>                                                 hcon->type,
>                                                 hcon->dst_type,
>                                                 passkey, 1);
> -               if (err)
> -                       return SMP_UNSPECIFIED;
> +               if (ret)
> +                       return ret;
I think there may be some miss match between expected types of error
codes here.  The SMP error code type seems to be expected throughout
this code base, so this change would propagate a potential negative
value while the rest of the SMP protocol expects strictly positive
error codes.

>                 set_bit(SMP_FLAG_WAIT_USER, &smp->flags);
>                 return 0;
>         }
> --
> 2.17.1
>

Thanks,
Alain
