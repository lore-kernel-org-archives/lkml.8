Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84883C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD9820714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XQI6xGSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbgDAQzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:55:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:37843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732246AbgDAQzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585760141;
        bh=jufOl9LToMfDMpVOPWx78HZPLIFoXwerAO2+O83FXV4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XQI6xGSNwQQ+Vb7W2guxnfhA09G4esx/7qIH0ovYyGso7e7lG9NfoBhDAoKAZ0y8Q
         eEvzdQlUtiLuQHCKXgKqHGHJyDnw/NSkMsHpeQ3ikHJNHqNSprwne8z1B9cEus5C7l
         YjFGLEtSkwUwoXkgS0EKHJ4HUVAFcwHZ6x3KNruc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6lpM-1jPkva3J3m-008Gl9; Wed, 01
 Apr 2020 18:55:40 +0200
Date:   Wed, 1 Apr 2020 18:55:38 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Use defines in vnt_mac_reg_bits_*
 functions
Message-ID: <20200401165537.GC3109@ubuntu>
References: <20200328095433.7879-1-oscar.carter@gmx.com>
 <20200331102906.GA2066@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331102906.GA2066@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:+gPfFoS721r+mvPOMeEJLs+3wcGSjyf6c/ZvFKIvawJoJwQJjOB
 laYts9bS+jFq9IaO1hPlLoO8I1IpU79ypPH5pQNr7SrMdSIiNxkmuVcP/7lNyxQoxYuGqii
 WYTWbPvSqFgARZEuCY6XXJub6t6xpSnkIRh+ZWFYgNZKlDfj3NLI3IqEHXRXxz2gsHh+IPU
 RmK9g9WJlKuUJEJi0qDiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TThDrtfsJsQ=:2H6KhCTRNDVxktbJMpTT43
 lvHtTWfY88j2YOMRksIFIAYrFOTSfqr6BpAhC0Y5TNlDh5snnZkyOcER1C0C2Wvk+KJsB+7lt
 /z3i6Po6kdOQMpw2oGjOsE9mAYBITN4iBuLvne+kk7DTfQbcVQR/40p/1e2qZnBtJv4S9ULyR
 WvnD7dC6AlriMEYRBkEgzCws/vDCwHbsE9CJwx5j2CsP/bX+1mzTSjn4Sn3rLuJWSYW+gCE5z
 oi8+K7SJ1ulSfIydzwGM/86C1zaNPw2be2ForDkRsfCIPeQjuoO6PjE7/DNaFQ/5O3D0Taqvu
 UnEMzZkGnLhtF4l1JtxqqRMF2C8ee7o5GzshphljEH8G1zh/HAa5+p/aPc1QDqMsMZQ/XFj2O
 wBMWtADYK1K2Gl5ruTmUZM4XCtm0fsZNAJCPOHb7IaCURxfd+RdJ+Y8zqbd7+qAb2kAS5oUnn
 5lr4bYA/gfZcB21qxeZX/MZqcoa7DrI0HRwRBsXJhbi0LVuHKk+UoufivarbcTR4zMLGaSofu
 mqF9yLMziE0bC+X4wIN0VmsmH6UJ1jW89NXHeUJdaKxtTdtGCCb23C3xUxSgLnZlZqQ/BR5+y
 DmReS54laoLvdc/AVQI+IvP9j38OFbXqdGwwd+Ila21pB9lFkocr2ZP9o3qG1a6lifhp6XaZb
 cpwAnDRUTklZgNJ5uFY5uIeNHe1FcTCo7MnuloMPBsE1URLhnfDLJzFsYWOtXVjeZ8cbYBrVJ
 ITVuaPype9EOk/RS5IxZb64zMGZ8IHG6wXP3G7QuFaARIQ8yrTyd/AaJ5ks70pGwEN6zkYNwN
 eJTtNSfqUDTcn5LMISiKX1bLP+3or+reJzywqxeCZlbk3IA9CNgvzk0a7G3uqDjqtLw8hZlPq
 WTxGSPOO3BTQDho7H69AElxVHfdmmejfcAQA+sq4orlkOZO95rbuvo6WVG7nZcXeqfwaXspjN
 6JOrlK9FaTWCIscdrTRdkXUFpT5ssonN/5WSTovyEsRrfGXinY5iJYk9deH/4aRlyhQaFL7Wu
 hj8WRXAQ4L7DfHukUfSx1eG5g+xD+q+eStAww26OGgK/m23o1wuZSFOeUah206enlpuNO0p2P
 HUxa8We3NaPCf2zZMPdiIDBR2j/4lRFZtSuo/anDYCJODRdI/TWV/HWo5lUNcKGi0Zc4y3gyK
 3KxOWqEyswL+ySn0BvCosyanMr9xYh/6W/XgPSGNh2nn5mGkkJ1UDa/O+ThPer/r3prE5r11z
 3R7Xe1CqCzF4TcvwK
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 01:29:06PM +0300, Dan Carpenter wrote:
> On Sat, Mar 28, 2020 at 10:54:33AM +0100, Oscar Carter wrote:
> > Define the necessary bits in the CHANNEL, PAPEDELAY and GPIOCTL0
> > registers to can use them in the calls to vnt_mac_reg_bits_on and
> > vnt_mac_reg_bits_off functions. In this way, avoid the use of BIT()
> > macros and clarify the code.
> >
> > Fixes: 3017e587e368 ("staging: vt6656: Use BIT() macro in vnt_mac_reg_=
bits_* functions")
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > ---
> >  drivers/staging/vt6656/baseband.c |  6 ++++--
> >  drivers/staging/vt6656/card.c     |  3 +--
> >  drivers/staging/vt6656/mac.h      | 12 ++++++++++++
> >  drivers/staging/vt6656/main_usb.c |  2 +-
> >  4 files changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt665=
6/baseband.c
> > index a19a563d8bcc..dd3c3bf5e8b5 100644
> > --- a/drivers/staging/vt6656/baseband.c
> > +++ b/drivers/staging/vt6656/baseband.c
> > @@ -442,7 +442,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
> >  		if (ret)
> >  			goto end;
> >
> > -		ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY, BIT(0));
> > +		ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY,
> > +					  PAPEDELAY_B0);
>
> This doesn't clarify anything.  It makes it less clear because someone
> would assume B0 means something but it's just hiding a magic number
> behind a meaningless define.  B0 means BIT(0) which means nothing.  So
> now we have to jump through two hoops to find out that we don't know
> anything.
>
I created this names due to the lack of information about the hardware. I
searched but I did not find anything.

> Just leave it as-is.  Same for the rest.
Ok.

>
> There problem is a hardware spec which explains what this stuff is.
>
It's possible to find a datasheet of this hardware to make this modificati=
on
accordingly to the correct bit names of registers ?

> regards,
> dan carpenter
>
Thanks,
oscar carter
