Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8164C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E8D2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OUVGMDqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDJRRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:17:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:59715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgDJRRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586539050;
        bh=OknhL+dWbzP6DoI+4HmmR01y+Q6JNKzHBccrGewbg+Q=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=OUVGMDqOpWObl63V+g4fyTdDqjN+zyXimTh7l/EmnhO399VKex+evYkdpxeWafbXJ
         4t2RG/hqH+8Mcjz7dADWbRX8LR7DKKcxZjUGrWHXzbmka4A01w6a071brI4ypgDedB
         Ds/X6G57GBfUxprPzIypXb32BGaSIb+883Y3goqU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N95iR-1jBbC92uLH-0168wW; Fri, 10
 Apr 2020 19:17:30 +0200
Date:   Fri, 10 Apr 2020 19:17:28 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Malcolm Priestley <tvboxspy@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: vt6656: Refactor the assignment of the
 phy->signal variable
Message-ID: <20200410171728.GB3426@ubuntu>
References: <20200410112834.17490-1-oscar.carter@gmx.com>
 <20200410112834.17490-2-oscar.carter@gmx.com>
 <986e8e5e-245a-cc70-2c6f-8ac3a4a485c9@gmail.com>
 <20200410155911.GA3426@ubuntu>
 <fcc434e9-9da4-4f24-19cc-bac8fc7166ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcc434e9-9da4-4f24-19cc-bac8fc7166ec@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:27q35nxGK3q2xRnJOp8V1guiMD64c05HSKVZUFVsHrBN06g+XxU
 gmed7ieyuTcUN8SocH7KH/wdtl0oRegNqzj+LR62Q28TSjpnvxLU9FZiFoIiLUwGDXi+RCd
 S2x2vpyt28gTK+LW2/Uh7gyvcCIQTznVb1j+q5YLLS3chRJzb8bM7VrOw6gidXyOCPemFxQ
 7fIlu53q0hwhvZOSy740w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JHeNEQktVis=:DS5il7YFW+VCEYBpd5CTMc
 x/jQIsgaThVTYZGeuoeweM9p+Um73hbo1NDVCL2ZhWebQm787C85e4H0OBmwWY4kfLP8p7cEp
 q8oIcOULG2asKqiX7jXLjA8mnEBku6GcAufTPZhu2ECHUNA81UI4HpQArgwE/1mbVS+0L3Cfy
 bHStxL0chAJklE9MnAfWzBH7BphaEVrOadTfjeViOWuZS+BQwQUr/Xy19/MrvQP0588F5e9uC
 3EzkQf37qx6wbCPXrdnK/1GYLbXsANAahIpPG3TfcEKelabWsCY30GLyZu3ii4mMOECCLqFy2
 DJPKshZ5nxFel+QZ//50C8m9hgKsk0nMkGnGzN1hGszlfMAUJEOEGxET0zodjJWgepUUEcXyw
 f5AjixWy0423ucVdpf2I7JCjLZdrXZEjZVaX33lIpOJ4rmmdjdNToiW78BWtmH6Jel6/AIoEq
 9+yduamGSWOT/bRIirbXntgtgBd4tqv9ANhC/E1NTf+SuDx2QOGZY5cZAs+FZyRS4d0czFLTC
 HniQVBXeNWROukWPxNkHFNpnp1WxNHJPIQBmRQEugOwapKw56VpWLXGeOZi9j0/S3x01H0H2+
 CK7BvnHFtFrw18O4FNUCXkHkRfMZ99/LIlIf6mZJ5qGtJtl8RnmM/75GVa7ptSsIDUcH4IT0G
 /N0f7guFzqzj0bEH3ERXAbcF8dvOPS61g72alZOfeyBNa0sUrN09Y84PowsdsPHxAvPWP0h+l
 /nfeJfV2fzFfVivxHRGWkgl7Zs9Gi+t4ISyLcYdm5lTs26gRwWH3jswhA5L9ieGNfnvYs4u6N
 yBpNPIMKXgqFMo4on9QxvCVHUcFYvUnVIdzTqLffuczAasWpEgT3u/ZsNE+RndtgmOxyPGXGX
 Pm256flWpzQtF449YMSca4I5J02v1OmFOZuSdA+/6N1okG9v99k83ZjVa7zHQPSRCBWwMdd7D
 Nb7/mh0BuEgjxie3zh6qm0HXTDQy/Fhs7eQNrIpdb7UsaRjihKFy9QzHM1Wj2rP72AzM2lD2f
 ggLKYrU6VN5zuEjZFjROuHMd6C7mOeqVWLfMB0jVq7S/QlXcYD81+kIIHq87wnNW704dW2gc6
 yfRrbFQKfwLlWTeQAcg4BrQLHtbZflhvHCzcpQKls/KBB4mJY9IpLW9yMMwCQn8jizjf67Wmr
 DztBRiZIyKm+CrkPTwzg9AkZUB60InBl3YCO7+l8QFh+ESwWqBE8vQaUtiIJVD5wtgWuwsiI9
 FfHMKs+BCbDC1EHXW
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 05:40:52PM +0100, Malcolm Priestley wrote:
>
>
> On 10/04/2020 16:59, Oscar Carter wrote:
> > On Fri, Apr 10, 2020 at 04:37:59PM +0100, Malcolm Priestley wrote:
> > >
> > >
> > > On 10/04/2020 12:28, Oscar Carter wrote:
> > > > Create a constant array with the values of the "phy->signal" for e=
very
> > > > rate. Remove all "phy->signal" assignments inside the switch state=
ment
> > > > and replace these with a single reading from the new vnt_phy_signa=
l
> > > > array.
> > > >
> > > > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > > > ---
> > > >    drivers/staging/vt6656/baseband.c | 101 +++++++----------------=
-------
> > > >    1 file changed, 21 insertions(+), 80 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/v=
t6656/baseband.c
> > > > index a19a563d8bcc..47f93bf6e07b 100644
> > > > --- a/drivers/staging/vt6656/baseband.c
> > > > +++ b/drivers/staging/vt6656/baseband.c
> > > > @@ -115,6 +115,21 @@ static const u16 vnt_frame_time[MAX_RATE] =3D=
 {
> > > >    	10, 20, 55, 110, 24, 36, 48, 72, 96, 144, 192, 216
> > > >    };
> > >
> > > Actually you don't need the second values
> >
> > Great.
> > > >
> > > > +static const u8 vnt_phy_signal[][2] =3D {
> > > > +	{0x00, 0x00},	/* RATE_1M  */
> > > The driver would never attempt use preamble at this rate
> > > so it's safe to include in with the next 3 rates
> Sorry got this wrong the driver is trying to do preamble (short)
> at this rate and it is not working.
>
> So don't apply it to RATE_1M rate.

Ok, I take it into account.
>
> Regards
>
> Malcolm
>
Thanks,

Oscar Carter
