Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4729C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899222073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KwxTTmSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgCZRKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:10:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:60761 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgCZRKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585242645;
        bh=hvqInh9aY84kozIuxBpF3a7NAoi9KTncxIFpjJt9bBo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KwxTTmSKCLthuf2GfZr5/jtUsyQ4kYDtguvgWdNYdUA/phY32xtMTnbS91sGex4ew
         BQeKIG+4lhMjIObVUzVevw6Rgu/8EtMrDmJheMovb3NI/JxDnnW+aEc+BRgfLqObSS
         8EKqrkKqr4swymIbZ8GM/80srpWVfPClL0CVjwU4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkHMZ-1jfpMq2kjR-00kfcV; Thu, 26
 Mar 2020 18:10:45 +0100
Date:   Thu, 26 Mar 2020 18:10:43 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] staging: vt6656: Use BIT() macro in vnt_mac_reg_bits_*
 functions
Message-ID: <20200326171043.GB3629@ubuntu>
References: <20200320181326.12156-1-oscar.carter@gmx.com>
 <20200323073214.GJ4650@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323073214.GJ4650@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:O4+keqWShH3MXaNp9FG4v4kYmJ4mELgnL0HyqbFWwfZtObOpAfE
 UyCDl2MuflZMd0WG6YPyRFLzX6iI3CQNPCGnOR0MHQrvxAS4SL58V2bposf8Tlonl3ivmkB
 dFQFLjfVzoGZrHtkMqwyqO+YugPZ8WsKhBQA3ShWpY8Cv0wCQJ1J1NYVkwwR8NIHJ6xs5U+
 XMpjBf+sT6X+UyxEioc/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sH6Qqv5PV5A=:4VzFhpqAvOF3jlTjlng9rs
 TEKvaPTISxxY3Pr7WjmYQ6hc62VJ75dq7JVx6SnkAFvptRXP19+70AmHko30FT8VBDcmZMe1D
 DLA19OSzDKgEq6Zzi0iFPacTI/IqaaDE5C6Ya++C6V5xiCwqQBOaTa8Bq78FZsKwTxkp9ABtm
 90RKw4SC7FoWoqsXM102ci4fgRi7+0X7xZA38cuCU1ToBxi8knJ/Kf45hpaRKcXpq0kaoyTya
 hN54quAv6JRzzWFDTuDuS70gPZXVJYgYfdx+PytNJ4XHVRqG/ZPI2M1TYjHfb2GZOnUohdbn8
 sGDEXcbvJeLSTKbfI2M5w+t9tIjaBqLOTbEF/cP1Sr96gavTqeDK5Hqtetc8VeotIEUHFbXJq
 9rtKUeTx9cB5xOrG7BB4KT306gjTgHMDMHKe3zPAhQxaBdKo6uffzkkX2pDjpqi1DJVm3lLB3
 l0Ur/McEN4EVXQZzL2aq1fF4KvR/X1pRzyaPob9CKMllH9FC5yBgYtlo/sAg1V9J7EupY8z7c
 G+O2N2amIuyWQgyUQafzTxB3f3G6Ed4R8xb/2YYkS5xxOKeclYBqT8pn5520PUpfJIzEYMg/o
 rjzlXilGUPrIg5B9wXgn+3RNGv17vCN7khtEVhITSVVQo3f/JY6cVv0/4PIXckNPhbnGAzoGg
 AI8a7ecL42pjnTKtLk7EAh3yZ+B6Dgw6DNDmA0YLpFV/3BvEOJNzSZ7UeeIsvP7dzxv1UfhW5
 JZLr87AJEyL9VOdFKDTj5Q6K0RMvWjMAeHWxffQge6Exfn49B7ZRqK7AoUhNJRESt35MDonAN
 6IlnjpWv42x1PqBv1KaNFm4iTopYdH0+Lm1WxyiwSwgqznBR/d0+zuxSOYvh1IxIwQb+YYzRt
 WXM5Fx17aVOiECvu2wP7EbPXlRVbMJGXJyG2hY4eC2Fu+M4gGvCAz91dBcmm8sHB0OpSKe/oj
 HbxG4+B2rok6vXWbwAkYE1i93IOhZyvZ8tKV8UcoMQapPkwYHWNtD0XZz7pu4gfdh887zRvzf
 AAolpVA1su58DXKUm5KRTmgcnOnY31dfDTDjKVNtT9Li83FmapZfky3nbpVDLK6qJwsu/Smeb
 KvLZdy5UOcZCeAVsTWj7Ftry3E+YCN4hOYJQ8h93dCIyOo/ZMxNeAdVVJbSuYarAkZu7gzqNR
 TP+ydh5JiCptnFqDrWIZxfwBjx/kerdLjSw57rS3pNXcJkBYiGzZW1EA/1z9LdGYgZs3+0GPt
 ZGDf0rIBFbXgv6wH0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 10:32:14AM +0300, Dan Carpenter wrote:
> On Fri, Mar 20, 2020 at 07:13:26PM +0100, Oscar Carter wrote:
> > +#include <linux/bits.h>
> >  #include "mac.h"
> >  #include "baseband.h"
> >  #include "rf.h"
> > @@ -468,7 +469,7 @@ int vnt_vt3184_init(struct vnt_private *priv)
> >  		if (ret)
> >  			goto end;
> >
> > -		ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY, 0x01);
> > +		ret =3D vnt_mac_reg_bits_on(priv, MAC_REG_PAPEDELAY, BIT(0));
>
> Everyone knows 0x01 is bit(0) already.  This isn't more clear.  It
> should be a define instead of a magic number.
>
I agree. I create a new define for this case.

> > @@ -63,7 +64,8 @@ void vnt_set_channel(struct vnt_private *priv, u32 c=
onnection_channel)
> >  	vnt_mac_reg_bits_on(priv, MAC_REG_MACCR, MACCR_CLRNAV);
> >
> >  	/* Set Channel[7] =3D 0 to tell H/W channel is changing now. */
> > -	vnt_mac_reg_bits_off(priv, MAC_REG_CHANNEL, 0xb0);
> > +	vnt_mac_reg_bits_off(priv, MAC_REG_CHANNEL,
> > +			     (BIT(7) | BIT(5) | BIT(4)));
>
> This one especially is just a lot longer now but still not clear.
>
Like the previous one, i create a define. In this case to avoid the magic
number or the OR operation between BIT macros.

> regards,
> dan carpenter
>
I will make these changes and i will send and incremental patch with the
"Fixes:" tag due to the this patch has already been added to the staging-n=
ext
branch of the greg staging tree.

thanks,
oscar carter
