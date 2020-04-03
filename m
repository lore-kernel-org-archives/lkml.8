Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB097C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D882073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vO+eeiD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391098AbgDCQ5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:57:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40006 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgDCQ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:57:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id 19so7635813ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 09:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lrcp2Eiyu9q3gbWwkT5O7o0+h0SVlGQKfd2CEGLpkSk=;
        b=vO+eeiD/lQC1CSyjmAXdVYyjpxA/6wbx6QY3B5R4u3MdCODxv2AslQR1ctFAaT7Aiy
         M9dGkV21vwGECTPiycUVxQrhI9MhY1PzspHbaY6FW/oApQmcN7Cj68qfIrILTvpecWZ6
         dtnrdRZbuRoQGG8bZNEuizWEXp98DPxaS/0Z3pMrDqmgQ4pQrasHu20byweMwOpvHP9o
         lznug//ruWUFVKFQHNlmQKZV780xNoLsJbugMYOVO1u99suFlF//O1oyjBBhXoCtaK2q
         NgiTmlJL0R8sTYudb1wOCt7/AaDp4bNDioFGPUcAlU4I9f9g5m96fBeiIq1D24Pxf0n2
         h4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lrcp2Eiyu9q3gbWwkT5O7o0+h0SVlGQKfd2CEGLpkSk=;
        b=af+H/erMxfLZ+BUIOGR3D+ukMYRYzl94asqzYc6ZkCnAkVXHdaXvnCw/ws/xzszT70
         F8FZDVEioGh9GgPWwhBhE9DQlpucdQDbGCmuxFRtJg2INPgQ8joyFao+IA76ESHN9YC4
         6fEitb/yOL04A87OBo0D7wuPUoxVyWZjY+VkgrmTLskWCp4oBbQGIpQWsIXue2Jk5pg8
         rMxVB1wkgdHfQ+OUUrp/F0K+U97j7dcYVjYKadllbC/kUsk4+xKqWk3rOlFGGOLfvoTk
         lSvlTK3xyKV8YjiAWivYjdJIGozrpCS7Sf0Uu+5otu+WYERmoKc2TbFmc+FN5gRGIsND
         4zQQ==
X-Gm-Message-State: AGi0PuaZCsWzKKe+QXwRFJKfJWaM9z93BYqcUMR205UHMb7mmiNFbLx6
        2NrjBT4h8rn1J5WRBTOmggarlK2qrTJ31DOzo7j++Q==
X-Google-Smtp-Source: APiQypIlLBI+GMXY4EL8caQJbBUdCkGKQlXcd5SlW80FB8+ShNTXifqmL5vhorVKpCVB2cT5Q8vEf+GzUWvAc2TqhHI=
X-Received: by 2002:a2e:9652:: with SMTP id z18mr973853ljh.79.1585933029892;
 Fri, 03 Apr 2020 09:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200403150236.74232-1-linux@roeck-us.net> <CALWDO_WK2Vcq+92isabfsn8+=0UPoexF4pxbnEcJJPGas62-yw@mail.gmail.com>
 <0f0ea237-5976-e56f-cd31-96b76bb03254@roeck-us.net>
In-Reply-To: <0f0ea237-5976-e56f-cd31-96b76bb03254@roeck-us.net>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 3 Apr 2020 12:56:58 -0400
Message-ID: <CALWDO_VfZV0_uvsXyWAa-uOQ21228rUDsaChgkex88pyiP3U=A@mail.gmail.com>
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

On Fri, Apr 3, 2020 at 12:43 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 4/3/20 8:13 AM, Alain Michaud wrote:
> > Hi Guenter/Marcel,
> >
> >
> > On Fri, Apr 3, 2020 at 11:03 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> Some static checker run by 0day reports a variableScope warning.
> >>
> >> net/bluetooth/smp.c:870:6: warning:
> >>         The scope of the variable 'err' can be reduced. [variableScope]
> >>
> >> There is no need for two separate variables holding return values.
> >> Stick with the existing variable. While at it, don't pre-initialize
> >> 'ret' because it is set in each code path.
> >>
> >> tk_request() is supposed to return a negative error code on errors,
> >> not a bluetooth return code. The calling code converts the return
> >> value to SMP_UNSPECIFIED if needed.
> >>
> >> Fixes: 92516cd97fd4 ("Bluetooth: Always request for user confirmation for Just Works")
> >> Cc: Sonny Sasaka <sonnysasaka@chromium.org>
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> ---
> >>  net/bluetooth/smp.c | 9 ++++-----
> >>  1 file changed, 4 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> >> index d0b695ee49f6..30e8626dd553 100644
> >> --- a/net/bluetooth/smp.c
> >> +++ b/net/bluetooth/smp.c
> >> @@ -854,8 +854,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
> >>         struct l2cap_chan *chan = conn->smp;
> >>         struct smp_chan *smp = chan->data;
> >>         u32 passkey = 0;
> >> -       int ret = 0;
> >> -       int err;
> >> +       int ret;
> >>
> >>         /* Initialize key for JUST WORKS */
> >>         memset(smp->tk, 0, sizeof(smp->tk));
> >> @@ -887,12 +886,12 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
> >>         /* If Just Works, Continue with Zero TK and ask user-space for
> >>          * confirmation */
> >>         if (smp->method == JUST_WORKS) {
> >> -               err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
> >> +               ret = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
> >>                                                 hcon->type,
> >>                                                 hcon->dst_type,
> >>                                                 passkey, 1);
> >> -               if (err)
> >> -                       return SMP_UNSPECIFIED;
> >> +               if (ret)
> >> +                       return ret;
> > I think there may be some miss match between expected types of error
> > codes here.  The SMP error code type seems to be expected throughout
> > this code base, so this change would propagate a potential negative
> > value while the rest of the SMP protocol expects strictly positive
> > error codes.
> >
>
> Up to the patch introducing the SMP_UNSPECIFIED return value, tk_request()
> returned negative error codes, and all callers convert it to SMP_UNSPECIFIED.
>
> If tk_request() is supposed to return SMP_UNSPECIFIED on error, it should
> be returned consistently, and its callers don't have to convert it again.
Agreed, the conventions aren't clear here.  I'll differ to Marcel to
provide guidance in this case where as a long term solution might
increase the scope of this patch beyond what would be reasonable.
>
> Guenter
>
> >>                 set_bit(SMP_FLAG_WAIT_USER, &smp->flags);
> >>                 return 0;
> >>         }
> >> --
> >> 2.17.1
> >>
> >
> > Thanks,
> > Alain
> >
>
