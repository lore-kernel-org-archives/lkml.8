Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C7CC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE4820866
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EeSGNtZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgCHQNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:13:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:36901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgCHQNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583684011;
        bh=JA7KelqRX2ELKkZBiFXkGdbfW7TRtIGf4MCv3XKkKbE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EeSGNtZC0B3ykVAsfykY7ZIbZ5tOHlRL8BoP/0uolfcR0zWel+MO3tBDb/rKfdPvJ
         XxkiHRZR+/eWaLVJpb+gsIthhKjpR+2AS6/Wd9bpQVKQfLRc14WCj83PtwE2o2fNqc
         a6VKbtRIMMvKPTAghCAfB4WkE1u4NOs8TX00RPsc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKKUp-1iuokP40tT-00LnKg; Sun, 08
 Mar 2020 17:13:31 +0100
Date:   Sun, 8 Mar 2020 17:13:15 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Oscar Carter <oscar.carter@gmx.com>
Subject: Re: [PATCH] staging: vt6656: Use BIT_ULL() macro instead of bit
 shift operation
Message-ID: <20200308161047.GA3285@ubuntu>
References: <20200307104929.7710-1-oscar.carter@gmx.com>
 <20200308065538.GF3983392@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308065538.GF3983392@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:6xtxvJi0FfjwnfVyBu2Z2AJkOlgf8yEKyfAHWWDPyJI2yHaRHD8
 XzrrZ4HsqEOJlW5S6p0yI+wdDyzQ5WsCxnOF7zzTWIi+4CLE6E4oOuQRHFJ5OTGA6yU1qKB
 O9fmRN3+Z0LT/UdjrdXAKv8D0GBK/s63IJpSIlD8GmsuM9uo9s//3e3IsunTlNCadhji55j
 q+dEqaWwfGRMTFQh5qZIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OzKg9uzPUdw=:dUn0lwO+yKYtK2S/EVDzha
 7U0Mc3vIapzWR409zdisVcU22VcV3z2DZKRUml94MsucIG/OmPEGZLbY5CpmlM7aqWwXGdeKP
 SScU3F9k+a2sas2FP25eKvldW/h6/mZV7W6NzoY8poe3sqdzDwAHVfmEJSmGsSUV54RAUUzwv
 x0OkJdNU5z8499pH6CvbZJosSSNBs4+sR8GByOlNs3x7jmCnTZnsxvN22YQIhBfJfcMJRJWBS
 TjYl9Et6eq5aAPFrY2hNfEjHTZGwHHg3kMCfQ9D2c7XoBi3Nce/EZnddxFgpalt7wiSlQZFrX
 il3+35wFNZF5k8w1y1NF49DYLbmAFBoN3XR/gBnX4gkJsBn6XCj8x8NW2h4DpHqW2JzmE/Q58
 UwCve5L2/YCUdu9XfslOeqo5Cz+UsXILZAGMRm+1dfAvI5q3gbgfseGCo5QUg5DrmuNL1dW8X
 ssuU2U70T898UC088eTZylcVxAzaMqds46Xa8BSOvTs1TmU0s7VUAsw8WVpjXsXGHqJJwGxe0
 fsUMurrCQ114BsVoyceqYq2CXOfNHzf8kZwioXobjbf6e3JSPIOAOJ0tjVMAdOkNA/eFEzNLC
 2HDoow5tGGnfK189qK9N+78tiKoWEEZ1c8H5Vs3MEsHftcgY27v+ohhPIgTYxv0lerSlT2DuP
 YU1zwyx0i/hC/xH03O8ej1KFhxA4h+e4mPIYeIiBh68NIUIXJucf083+Q3YytOXnIH0uV/ywf
 YAJAbVyGcdi2troOrDiyPzFECQ9ZiRw7g11XsLGLWU2XxrT1hOs9L6GO+Wm0R8HCxgJw32tS4
 O9lLai89w7b5SNR8LCS87BGKVM8v/8U1Roc1v1G3oTUgVW4I+yMACFGTBpiDOOHRzaXRSF7jr
 8tNOLuoMwnuT/CQG5Q4XG17jBI7hPjBC9ZvOalolJ9emAl06bnhF3ZXL4N1DO5RgAHJ2Kha+N
 O1gBwXsgotsCsHdJJ5rv6dlDbHKkGGEYtocHt63trSdn+5xVSZwOlvweVbD1J6kXxDDIT1jVq
 vyEgDo/1IYHRCZ1Xqiezs1j/gkbsPUs+y3DAwaB8qay2o2L9LNdjpFjuOKmoVD4Ni8chu2Ib2
 hh2bjEtA2XImjhISNDTmGehfx084nhwC6CG2vNNq+x7mVh2Mr4GCs5vKS/GO0da7CzlcF1BRi
 0qGvKKBSnmIYvWxRAdpQm+HXIKDJS5hZqoVbkX361hfFrJniBuYjYNBqeX8x92dVKDpt31EXI
 unANMlp44fA71xiSw
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 07:55:38AM +0100, Greg Kroah-Hartman wrote:
> On Sat, Mar 07, 2020 at 11:49:29AM +0100, Oscar Carter wrote:
> > Replace the bit left shift operation with the BIT_ULL() macro and remo=
ve
> > the unnecessary "and" operation against the bit_nr variable.
> >
> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > ---
> >  drivers/staging/vt6656/main_usb.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt665=
6/main_usb.c
> > index 5e48b3ddb94c..f7ca9e97594d 100644
> > --- a/drivers/staging/vt6656/main_usb.c
> > +++ b/drivers/staging/vt6656/main_usb.c
> > @@ -21,6 +21,7 @@
> >   */
> >  #undef __NO_VERSION__
> >
> > +#include <linux/bits.h>
> >  #include <linux/etherdevice.h>
> >  #include <linux/file.h>
> >  #include "device.h"
> > @@ -802,8 +803,7 @@ static u64 vnt_prepare_multicast(struct ieee80211_=
hw *hw,
> >
> >  	netdev_hw_addr_list_for_each(ha, mc_list) {
> >  		bit_nr =3D ether_crc(ETH_ALEN, ha->addr) >> 26;
> > -
> > -		mc_filter |=3D 1ULL << (bit_nr & 0x3f);
> > +		mc_filter |=3D BIT_ULL(bit_nr);
>
> Are you sure this does the same thing?  You are not masking off bit_nr
> anymore, why not?

My reasons are exposed below:

The ether_crc function returns an u32 type (unsigned of 32 bits). Then the=
 right
shift operand discards the 26 lsb bits (the bits shifted off the right sid=
e are
discarded). The 6 msb bits of the u32 returned by the ether_crc function a=
re
positioned in bit 5 to bit 0 of the variable bit_nr. Due to the right shif=
t
happens over an unsigned type, the 26 new bits added on the left side will=
 be 0.

In summary, after the right bit shift operation we obtain in the variable =
bit_nr
(unsigned of 32 bits) the value represented by the 6 msb bits of the value
returned by the ether_crc function. So, only the 6 lsb bits of the variabl=
e
bit_nr are important. The 26 msb bits of this variable are 0.

In this situation, the "and" operation with the mask 0x3f (mask of 6 lsb b=
its)
is unnecessary due to its purpose is to reset (set to 0 value) the 26 msb =
bits
that are yet 0.
>
> thanks,
>
> greg k-h

thanks,

Oscar
