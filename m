Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C45C3F2CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB35B20719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQs1PTnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbgCPRmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:42:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41961 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731136AbgCPRmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:42:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id s15so18737966otq.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhncLtarCzRlJMoBi8hB921jlCqL13EkGiu5gBmAYjg=;
        b=dQs1PTnjnl/5W47pOKmpnd1Y2tKhX2upHf4sIuVADHlRkbwGArJ0Yj5dG+Gpg0Bux9
         Db11yvt5seTO9EUFw97JDcQMyEvgcyWdUvEnVhv6tvSuSy0OCBdfrBtbyl/hXMUQgEgo
         UKjyieu99l5kLxB1zV/StaLaraOFzOmlLGahOyBxBx2HIspDPg5y5vHcPNJjRu3/iC/r
         XfoQrmbHBUYo7YpgA0qs/naQXj+x/kX53Dv5yX+0d3XRD/Bz9gk66RshjZtnirKrOo1s
         vhL3exYJaJGGg6XjjccWJ9HsNtTQQVHk+VRHm5ZzHAAGwRAa9rP90s5kz/t7Q4cjzyol
         xRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhncLtarCzRlJMoBi8hB921jlCqL13EkGiu5gBmAYjg=;
        b=A4KMy3YpFar2aXYrVqMqeXsm19Nubhb1vkvM/OPMD7+QlsgU7fENof7FcyVcsF4PGk
         4iOKtRRns2vz2NA/SQeAb6KqhPuXwqJI8DRrUJC4pf+EMJ9QAzFC59BKylPPB+In5KlZ
         ex3bpcIpqxv46o+hg512HSO/iZo3caZMJWNanoxqt5SnyUuT4LrjvwfPHjmgs2Vuu0xa
         AVCBYfgAlv0TK0fk++i++/Vb3GQ1EtKd4uAL/dcd7gi3x1gG/rdNksDf4jbK3YxkhJ9g
         ZCPA7zRC8HcBEE+UrmPRD5DczY+dHK6Pwn4DGJGmqpFEmkuFEYHvPHyH+MY0ZFtKwsDd
         cwVA==
X-Gm-Message-State: ANhLgQ1m3lmmrrH4cq8phdxYSg1Yz93/cRl82Q/ccjlydXP67I//NG3l
        30Nl8VP6KOutT+4khpL4xiILQwnat06RQs55twUp+nTd
X-Google-Smtp-Source: ADFU+vuP/KkkZgDywii83iNHUDiefA29hNlDag61OgomS1t4Udsa1TmC2ebMVs5Ip2CtPXE3wttnfYR+56S3gzF7DkI=
X-Received: by 2002:a9d:75c6:: with SMTP id c6mr314816otl.352.1584380534428;
 Mon, 16 Mar 2020 10:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200316143752.473f1073@canb.auug.org.au>
In-Reply-To: <20200316143752.473f1073@canb.auug.org.au>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 16 Mar 2020 10:42:00 -0700
Message-ID: <CALAqxLVbG8C0h3OkCGOAQPpFjrwiqddjONTO-EGmhzz52LnKMw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the usb-gadget tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Felipe Balbi <balbi@kernel.org>, Greg KH <greg@kroah.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Yu Chen <chenyu56@huawei.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 8:37 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> After merging the usb-gadget tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> drivers/usb/dwc3/drd.c: In function 'dwc3_setup_role_switch':
> drivers/usb/dwc3/drd.c:551:23: error: assignment to 'usb_role_switch_set_t' {aka 'int (*)(struct usb_role_switch *, enum usb_role)'} from incompatible pointer type 'int (*)(struct device *, enum usb_role)' [-Werror=incompatible-pointer-types]
>   551 |  dwc3_role_switch.set = dwc3_usb_role_switch_set;
>       |                       ^
> drivers/usb/dwc3/drd.c:552:23: error: assignment to 'usb_role_switch_get_t' {aka 'enum usb_role (*)(struct usb_role_switch *)'} from incompatible pointer type 'enum usb_role (*)(struct device *)' [-Werror=incompatible-pointer-types]
>   552 |  dwc3_role_switch.get = dwc3_usb_role_switch_get;
>       |                       ^
>
> Caused by commit
>
>   8a0a13799744 ("usb: dwc3: Registering a role switch in the DRD code.")
>
> interacting with commit
>
>   bce3052f0c16 ("usb: roles: Provide the switch drivers handle to the switch in the API")
>
> from the usb tree.
>
> I have added the following merge fix patch (which may need more work):
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 16 Mar 2020 14:34:31 +1100
> Subject: [PATCH] usb: dwc3: fix up for role switch API change
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/usb/dwc3/drd.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index db68d48c2267..7db1ffc92bbd 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -478,9 +478,10 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>
>  #if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
>  #define ROLE_SWITCH 1
> -static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)
> +static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
> +                                   enum usb_role role)
>  {
> -       struct dwc3 *dwc = dev_get_drvdata(dev);
> +       struct dwc3 *dwc = usb_role_switch_get_drvdata(sw);
>         u32 mode;
>
>         switch (role) {
> @@ -502,9 +503,9 @@ static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)
>         return 0;
>  }
>
> -static enum usb_role dwc3_usb_role_switch_get(struct device *dev)
> +static enum usb_role dwc3_usb_role_switch_get(struct usb_role_switch *sw)
>  {
> -       struct dwc3 *dwc = dev_get_drvdata(dev);
> +       struct dwc3 *dwc = usb_role_switch_get_drvdata(sw);
>         unsigned long flags;
>         enum usb_role role;
>
> @@ -550,6 +551,7 @@ static int dwc3_setup_role_switch(struct dwc3 *dwc)
>         dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
>         dwc3_role_switch.set = dwc3_usb_role_switch_set;
>         dwc3_role_switch.get = dwc3_usb_role_switch_get;
> +       dwc3_role_switch.driver_data = dwc;
>         dwc->role_sw = usb_role_switch_register(dwc->dev, &dwc3_role_switch);
>         if (IS_ERR(dwc->role_sw))
>                 return PTR_ERR(dwc->role_sw);

Yes, thanks. Bryan pointed out there was a problem with the internal
api change in -next, and I intended to resend the set this week.
Your solution looks like what I have in my tree at first glance, but
I'll double check to be sure.

Thanks so much!
-john
