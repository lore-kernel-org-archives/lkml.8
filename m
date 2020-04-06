Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A706C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3221024965
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MFG6rXiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgDFQiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:38:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:52519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbgDFQit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586191118;
        bh=w3UbNz9WVDwj6f3Rz/KrSMUxNxensD50y9LU7VpbUH4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MFG6rXiRYWZ5jJOIQ2v2u3TyXoeKqAxwr31m6KEa8u+Vg38sgECa7kKwXLEvK6CCP
         VT4Xcy7WLWbDdhaR+fe+1uzqpUdhrMdzA3zqzx+5MiPC/emBNFRONEAo0xfuYzM5pg
         Txd1drXg4mxQboOYsOXE23E5qbPwAbBvR39otjMU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MV67o-1jmPaS1XSY-00SAmV; Mon, 06
 Apr 2020 18:38:38 +0200
Date:   Mon, 6 Apr 2020 18:38:36 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/3] staging: vt6656: Use define instead of magic number
 for tx_rate
Message-ID: <20200406163835.GB3230@ubuntu>
References: <20200404141400.3772-1-oscar.carter@gmx.com>
 <20200404141400.3772-3-oscar.carter@gmx.com>
 <20200406142212.GA48502@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406142212.GA48502@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:PWcb7TKfBCjP5J41/evS8VzfKGQ2NGhrEqncwMb6FiIoe5Qb1jC
 AqQ31UAA1NB0izfHGaooW2w2y9qJElbSqwzM8IQgb9fhskxE3X+owYUQYW/s95Y8YWE0z4k
 m1qL2r7TM4OAC/7Zw4g9F5fHTmTPhIivmLJi4VRL0x+SN5rTNQslCF9xF4Gi5yVIIuUaK5W
 f0H/EKVRXo4LADs3sehLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HFUHSZHedLg=:UjzjxrjYYVrfeFH7TeXf+3
 Ijgl9/R6JH2rIYaKzE4XOa7a0ZvbpNhRAoLDAN8v5mDMqzr32iuWAm02/I0ux3gCeuBo0BoRW
 k0n5E7BAbMupYO1YBYG7Fmim65BV8zhyRSWtLB2CR11wsBsRL3VYcQyQTCajwb/HDqM6aN599
 RfoWlSMwyPYU0DpOI0PQrktNSdOmPSiTJjkpbG2AC+hAf12VtXkB0G7zpRlqHme7sB7RjW7vf
 IfbQrocGo7O14DZo3a8PG6+3k/aIS/ikOAUsza0ja3acL7nYE1lXE8WRk0kh1Zl0sP67EqRuf
 pVL9Eb6pcLePwe3CTuSHZ/wfQfEj+dpoYWNPTn9L6zPb2ZGJfa3VoqFc6MGDD0sbvXQ/xdoaw
 MPCWAewsdllrDYAqeCid1ZHxR4Oksj78Fw48ykuVwXhy19+lpk3HO9/ptSZgdYO2PnJ83M9yw
 n8Y7nZsaZM9+vOgm7ss4Jah1lNJ5D5TpzJWMY9aMiwgQ29P9AROLUNsPEXAlIFRyI3+SLPEsI
 tRJ9eTE9gwk914IYMkyAzKzQSCRgaZe8ywY7JpN716+Ss/k+2gJKuZFQ0MF0urDQ6V+rFO8vf
 m+B+7pgwQWDTJqRwDfxEEBpvIStmlSetHUg27W963gAcOY9g6++wCmMfQQZ1rMJrlWFKWkWNd
 A8RX25KbRtaYa0b7wKp4eqZpNAxgDKV+v3ixMwdemA3uGhEYaEWnU4HJIR4Hxj72DAK8dFMh6
 dVakVsaC4AZF/XV6js0Y7dOkxNvXOzLVgx0jkiniF/sk7VMFMihJJWn8oQtjuEd2DqP/ocvpI
 hwdedmcrDWmC7uj3WJTaRFXkrM4noZjZShBoBwacyaKx7oRTCiGBDJDjffxn3qxXuE8Gls9x6
 R4Pxw6c+OyCDMPG5toWSaDyAY32ApmbasYxgZIrXNDvrnBLD4NahisWzNpQpJJtkHzu/a2Mpx
 urdxx+8qQldKUK/qcPBcyqm9t3ETgtV3toms1Tz96Sxbh/KcObQgX2iZilJ+9XbYdfQZ9iPgR
 0LNXk26hL+u7Imu3rwmsAcE6XTFzGg4kgchjIN2vR/qbia5a0dZx7v9BkLHhXFgea1nZy4v5Y
 Lqy+3Rz49H+61U3SeHS1aAvDv+3/gnfNl/8Y0Ahg9M4J3mdE2G5s+pQV7Wg9hiYVlmut0dA8t
 X2lTkL6kiXJ7N5FfF+9RNzJkHo+Ewbok6DLdal/c2yunCkSjM9pb0Di860YdPsNp+yYwZGoUP
 924G6EjxKc0w8URVt
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 04:22:12PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Apr 04, 2020 at 04:13:59PM +0200, Oscar Carter wrote:
> > Use the define RATE_11M present in the file "device.h" instead of the
> > magic number 3. So the code is more clear.
> >
> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/staging/vt6656/baseband.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt665=
6/baseband.c
> > index 3e4bd637849a..a785f91c1566 100644
> > --- a/drivers/staging/vt6656/baseband.c
> > +++ b/drivers/staging/vt6656/baseband.c
> > @@ -24,6 +24,7 @@
> >
> >  #include <linux/bits.h>
> >  #include <linux/kernel.h>
> > +#include "device.h"
> >  #include "mac.h"
> >  #include "baseband.h"
> >  #include "rf.h"
> > @@ -141,7 +142,7 @@ unsigned int vnt_get_frame_time(u8 preamble_type, =
u8 pkt_type,
> >
> >  	rate =3D (unsigned int)vnt_frame_time[tx_rate];
> >
> > -	if (tx_rate <=3D 3) {
> > +	if (tx_rate <=3D RATE_11M) {
> >  		if (preamble_type =3D=3D 1)
> >  			preamble =3D 96;
> >  		else
> > --
> > 2.20.1
>
> This doesn't apply to my tree :(
>
Sorry, but I don't understand what it means. This meant that I need to reb=
ase
this patch against your staging-next branch of your staging tree ? Or it m=
eans
something else ?

Thanks,
oscar carter
