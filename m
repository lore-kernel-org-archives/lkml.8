Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293C5C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071422098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OGseXIem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgDWPJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:09:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:45773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDWPJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587654551;
        bh=San9SLO/1f35dByeKyY8xo3JJC4OXQOxLntT54Yf/Hs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=OGseXIem1YnnXyGA2FiPbnzR5oxYP4AEZZ0C0Rg0bcLdYpFMEWJmaXaUtqDezrMJy
         5aeajbQ7h5QQSwKzFAkj+2/+fcmDFCufkzmOjUCJMoUa6eduepnuNw8Vdy8CCDxLiu
         9OMxF8wfQ79fjQMeHyhQipch7ANWNtinT5xUxDQI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZCfD-1jebvK1HsX-00V6KW; Thu, 23
 Apr 2020 17:09:11 +0200
Date:   Thu, 23 Apr 2020 17:08:54 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: vt6656: Check the return value of
 vnt_control_out_* calls
Message-ID: <20200423150854.GA3667@ubuntu>
References: <20200419104821.6127-1-oscar.carter@gmx.com>
 <20200419104821.6127-2-oscar.carter@gmx.com>
 <20200423114032.GA3838948@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423114032.GA3838948@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:QF4MJaR6kGciPbJHwmpHWraX+DPE/W/SElp/vknERb+6Ij41MFy
 lu4GXiSt5dxXZPrXzT+OXf2g1W06ncLGtn+SDQrC0jvX0X5WBr2ceNLAGnocP97kuoStMCn
 bodD3V/x66pgeNv1tcxpcgPkrRcPJWgZhpoLqIUB+3YP8J6M65tw+E5P6xP7gDGBCFmCneU
 4OWhodkxEaUhUrLapGiGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gdvsFbu0xuw=:SSKx1zEZOmOeup00jMMQUz
 IHOIQmopk6vJNrSwhKbOM9/8i4WGpm/93n5lOBrQAVrzJm74acTIqvQ5qrm0CnJ4Ym5uJwN3h
 mDsxOQDVa604PUwYvqm+39/HbBpOI4/a7yJJLRItnoNvjsbh12JdyfDwpG2306KYed+PDly4/
 JkuG5vVv7VdLpPBS9aB82gSTXxf8J/Hu3NBMTPDcXFa6yQhVJzp9Yjvv1aL/z6ja0kdyFxjYM
 cWxYmdqdMPmqBxYaW/MeoxAy4WlI3vp69NpSCkSVlv9IPUYRNn93E/2GGaERDXgSiAAJXxPrz
 8W/KYG5XIXD4sRC6iJGXgqFbt1nGNfnqdGzT6x8GZs1Nm6E9PSW2Vb+MQCVe4s9tfWbcjtxis
 bolAYBgRF8nn28eiqdsDRpLgfVovNVAcrySgcu598SPXnUYrVo1n4+BEDQ7nxm+578UkNzuBN
 GR+EfDyyOW1zU3WKMuwTvlLKZznAUaaSBs7Zfp+KItJMzzL7y7e7IYeMjybTG7NCG+AcTtK0G
 cTGr2LwSSrKJaoydsp6dqMCcZOdoqS3AlNjbPWVLPmv2AqILv3YmgXj+jWAFk4fxkGgVI66BU
 STescRwb4R0Z2fIMa86rgyAZuhswimzFvidvowJ4AzhXCIuAFHZyXD9dwcETgRD1PdP21dpHO
 n7o3wXm+0lqenIfxTiz3lt6EOiVU4wtaUAeSbVW/7UgQJ75Xo4YVEroOcsVcXEbOjTW58Zx94
 QoLkfXchgyhTBthc8G+3SYFnESveFjj4OCbMPYZqRgKwo4PPmwOzbxmgGO+FoBhKFEEfRsdFe
 95IY6RvBKWcZhNXDbZVMXZrUm127A8iIK0ZBH49XnJaB2Sx2RB5Fkd227guYy6MQUJ6RmG930
 5DA+IUiWHuyofMB9FEZifm4Nt3UiuZuTCiUjrIoxCIr74bikCMGqknpmf4z0LjqvOPJxkLXR6
 6bVov5qH6VCP89RS1sRPz/swJ2vEl1h3eIzg+Qu7ywndH6w6tMrDJQmZnGINXpZhOIWjIGL0c
 HFVRuQosej4sc9mXSrMDQD0+AGvbXMkCvQ9rjfqIEISQUCIf3Ahxerp5JyRQUBqPG81nTAk8w
 rgwJ68f7OJOr621gqb4Udb/6Qzm5gIiQqJrHH72BnxXTduxusviKCPlnJeTZNJ5rbcTtQ8vvW
 RF+2rLACSTS/R8YKFphxyUGRm4IwPtuouNVPhJFotXVduZ42zVCJdrbjTM+2jVjAIPDtFrwIp
 K/UE23dyfwbPP0RYv
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 01:40:32PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Apr 19, 2020 at 12:48:20PM +0200, Oscar Carter wrote:
> > Check the return value of vnt_control_out_* function calls. When
> > necessary modify the function prototype to be able to return the new
> > checked error code.
> >
> > It's safe to modify all the function prototypes without fix the call
> > because the only change is the return value from void to int. If befor=
e
> > the call didn't check the return value, now neither.
> >
> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
>
> This patch, and the 2/2 patch did not apply to my tree.  Can you please
> rebase and resend?
>
Yes. I will rebase and I will resend a new patch series.

> thanks,
>
> greg k-h

thanks,

oscar carter
