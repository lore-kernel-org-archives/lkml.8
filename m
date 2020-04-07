Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F7FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93E82074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kaGPRZ5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgDGP2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:28:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:38351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbgDGP2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586273312;
        bh=PW9nWiKEd4LakOhfHv+P2aNfB5cbJPHqrZElCVNMsHI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kaGPRZ5Pb5Jl4JT5OHwQs9zQoba7YCf9yp6aQmBYtk79E+YnZgZlQAlthQA3XtJ2L
         HdmIw0jBk6F6Y3ubpUOwQNVxUX2FM6B+LZzlhfWFn7nbrEyfod6zD2bWnvjvuaQ9gI
         eFJH0S6p0pa9HjbYHmOsercsWlZiqih1E0YeN5ig=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTABZ-1jjrDk4Al5-00UeuO; Tue, 07
 Apr 2020 17:28:32 +0200
Date:   Tue, 7 Apr 2020 17:28:19 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>, devel@driverdev.osuosl.org,
        Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Forest Bond <forest@alittletooquiet.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/3] staging: vt6656: Use define instead of magic number
 for tx_rate
Message-ID: <20200407152819.GA3495@ubuntu>
References: <20200404141400.3772-1-oscar.carter@gmx.com>
 <20200404141400.3772-3-oscar.carter@gmx.com>
 <20200406142212.GA48502@kroah.com>
 <20200406163835.GB3230@ubuntu>
 <20200406175808.GB167424@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406175808.GB167424@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:/PHq5dWE5ZsCFqBfzBcgj4+7MRSAkm+q4J6GW5SBYhn4bC2tRUr
 POqW/pDtJ5STZOQVSpsI4KgnQymPOJTcTtWLXbB0E6PKgEcXdfXNnVNvoS4M+Ne9Soll92U
 grmm61i5EUQLs1Lj7oiPngN/oNHNjJQ7+1mJftE9J1xZbo2+/xACpfonCFMyTE45R83bewl
 3ZielW7WQjJjdjDyQ3ggw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KWHlGHO0NxA=:DwVW0Dc6tAB3N55mcpQllp
 F5GlXjvXA1wcDtMZDMJdUaq/sLx8BS4/HVf9V+R6VM9sS+us9fHmDvemRcfcxCXyn3qGk+jVK
 KSl7QA0ZAeiy9xOV4uhSAzR8VYFlXzHG7UExOJfvN5vpGk0199TFVEWAhZ1IhZ07FhfZ4kqKm
 ku/HLJavaPf3z3zmFMIQVze6mkER8OEOq1tYC544T7yOkqT4Fv+orQo3ZtodSeZYkWoJagZhA
 +2g0aEGz+sTAANLI/jUkK6eclZFwQY44b/AhtMdV+lLjmPShUD+XNs5KYDuY/V2ULGrM1QK56
 B6lw9bAzme6aMzscKkMddf0hCdBaMGo/t6XEFn4e9LOSeDcAzVgOl/nyaYwlB1DYlbXZzk0SS
 AmCt5EkJWOsYfgNHKpGKuT1h+3Nu0S2rxreCVD2m+Cx7RsBA8v1lCL3nY7fMhtoEVB1ve6hbh
 lI1ZeRstR/ZSBHFhmLoOQs6M8DD+c279aLq+gV+MZCaZH/XSQ6+HztSrBEiHsP/DbUet0G6ne
 oxpBmuQGi55RcAvgUEcXbGVxGvtJ+YQUvX+TOtq2hDG+WsEz7vh3DCV3mMgzrXtHd0xWakvxA
 53HOL8FlbSekUWKTv1cva42IZdz+8fKy7MNZBBN7UEJTxDiMuGok4sbIGd39sICFdGLnoT2m4
 9yJs/jU44IM5r6a8ULy5qd1c3RzKkUuUcUnZUIM5LlR72nQ+qR+n27NiKDfOEav3Gt9G0RRm4
 VtuPhaYOB6TCeDnDYX8DeIwv1TZoPbTIGdu/DuQcn4OshjY0h+SrSVH2pNgI6RSAUJTPf22cC
 3CddTH9/ZR3jpnbcYnHQ537OA+w4sI/2/Zmw8kjloQLktLuM+5mEkHPDGCMk81DTRNaIWi2Ka
 BG3XjWz2lwBiDsdCRzWn6yUT58pzc6NanEbLZZVH+bFaG7wbp0sZt/wcIT0ZhgNqYxrShSkHt
 MCm6uOXThcU3oSDKz5YKD2h35t2svCDzJv/y96iy34z+fThIRAXlN5XChLIKtP6JlVDawb66C
 +DMvWuC32WXYV1IwgTvIWT6g60e7v706/5vAO7mwGb/s9H+9PgdOfQMohzcnYBOhUFbQnu1C9
 7n5XDxezRjKQwvhcCtb/h8QPlEkk0wFKboXeF2f0Y0xOQxcIBbJjjgsLtD8mknipPCY8fHr+6
 J/7FDGzqoz5O8OjX3RtUg/LOPEbAz4CvH13sm/Gz+MQs5/uf9mO/gW0Q4hGhIt1389wuPoP/C
 GOjS9OeeN30dPiWbR
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 07:58:08PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 06, 2020 at 06:38:36PM +0200, Oscar Carter wrote:
> > On Mon, Apr 06, 2020 at 04:22:12PM +0200, Greg Kroah-Hartman wrote:
> > > On Sat, Apr 04, 2020 at 04:13:59PM +0200, Oscar Carter wrote:
> > > > Use the define RATE_11M present in the file "device.h" instead of =
the
> > > > magic number 3. So the code is more clear.
> > > >
> > > > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > > > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > ---
> > > >  drivers/staging/vt6656/baseband.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/v=
t6656/baseband.c
> > > > index 3e4bd637849a..a785f91c1566 100644
> > > > --- a/drivers/staging/vt6656/baseband.c
> > > > +++ b/drivers/staging/vt6656/baseband.c
> > > > @@ -24,6 +24,7 @@
> > > >
> > > >  #include <linux/bits.h>
> > > >  #include <linux/kernel.h>
> > > > +#include "device.h"
> > > >  #include "mac.h"
> > > >  #include "baseband.h"
> > > >  #include "rf.h"
> > > > @@ -141,7 +142,7 @@ unsigned int vnt_get_frame_time(u8 preamble_ty=
pe, u8 pkt_type,
> > > >
> > > >  	rate =3D (unsigned int)vnt_frame_time[tx_rate];
> > > >
> > > > -	if (tx_rate <=3D 3) {
> > > > +	if (tx_rate <=3D RATE_11M) {
> > > >  		if (preamble_type =3D=3D 1)
> > > >  			preamble =3D 96;
> > > >  		else
> > > > --
> > > > 2.20.1
> > >
> > > This doesn't apply to my tree :(
> > >
> > Sorry, but I don't understand what it means. This meant that I need to=
 rebase
> > this patch against your staging-next branch of your staging tree ?
>
> Yes, and 3/3 as well, because I dropped the 1/3 patch here.
>
Ok, I will create a new patch series version rebased against your staging-=
next
branch and I will send it.

> thanks,
>
> greg k-h

thanks,
oscar carter
