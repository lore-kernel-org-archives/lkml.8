Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D296FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C7020CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AI8iO1se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgDJP7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:59:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:45641 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgDJP7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586534365;
        bh=1F93Ep3etTDE7a506QogajIZjQjOu07qM6i9ZlQqgik=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=AI8iO1seAAXv7gLlfOonQDJadbyZEEVwZ/KxcDsROwOqKIZKapwUomeZRtm71s62o
         YoGGCu84CYhUfWD9md3mIdDv8wnqs8o/XVj44eS1JfKli9ErJ9t96/kg43auPw2iuY
         HPg6VSGRh/GPZFxYAcppjn5jUuaDL1287kxVmlS0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGQj7-1jUvkP48HV-00GoHi; Fri, 10
 Apr 2020 17:59:25 +0200
Date:   Fri, 10 Apr 2020 17:59:11 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Malcolm Priestley <tvboxspy@gmail.com>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: vt6656: Refactor the assignment of the
 phy->signal variable
Message-ID: <20200410155911.GA3426@ubuntu>
References: <20200410112834.17490-1-oscar.carter@gmx.com>
 <20200410112834.17490-2-oscar.carter@gmx.com>
 <986e8e5e-245a-cc70-2c6f-8ac3a4a485c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986e8e5e-245a-cc70-2c6f-8ac3a4a485c9@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:ou8M4Ssva0Szw+pYRlRW+QGxsgzYCNwOuEqt2DeZalYu9o6IK0t
 BbVvcNUZHNR0a31haR2XMfPU+3sL1v3raf0MQ0kPrWicL9JoyaKvZ75VOM47MI7QBvDJuY3
 XL+JjN58HJ6ujvnyMooID3Oz4t/AjtctiNuY6T2uRYlAVQqFhzBEqkKSWNnHYV/nporOhKP
 bZKbxFeLoqFk/i0cn6wKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9VV6u/D4l7Y=:mO2wgneHoaRuHlHrH/uy+1
 BXUGpgMTrZi5hIfwjO+1wbqyJplB8rgr8dVLOHDGhUE++fluahrepCOUlSIpv7v9uJTaBaQTI
 EBNT6XLw3LNI/I2gq0vic4EMa1Ii/iGpwiTeFKrcZp+f+88K6nstfTTcFwY+cD40O3KQO4PGz
 kanEFarjWh1IQRRjQB54g0WGAOoqjlQ1JyDUQKQUt2KcUq9w/kMIquGFTxzorysuq+1/cwBmg
 V4ub/73/engaDboqcFSUuhZS1fYsn+BUYUlFyfDB6v/yHKFU25P/tlpTOTzUab07QLh9n644V
 +T5Qm9gJz0epZTfqJtLqqV+f2F6Apyb6QhUocKWTny3mx4b1jHKGHyF5z+SQ+i5SQsx1TXlhp
 Wzs2Vx/zk6oixG6KGea2Kk8M+Ffpkm70BhG6GkGo4CdYd6YXNI0XsonwMoLTYJbuf+PgNiJp0
 WVayK7U1GbKGKprUdTNVWxbRBfbo8gtzXeYQAUXv7VZmO26YZloKFRpw2bpAnPgvpeZ0rgiN6
 7gFwNGUNripkYdjFrA2a1TORd9WJo/L8oL55i4OiupFIq5MEl1ET2H9o3wFUMQY/HerOevIRw
 YODlvCFLXqfotOzHB/wDh9Wha3ZVeoX6S7MsG5yAQHFqBNdSkux7IIn42byYKpn4mef0RFUVD
 RbNyGqqO5w4sYdM18YjXbVQlynmkaWqriQiyUTAuzh12FnNo+j01Gk5JCQelr4JcRH68TUi0L
 M716fjE3wc15HDjuYugwdbctHXdNx1yR+UTPpibrAh5/gpYKx7EED+TI0t6WPHr/CzaVGn5VR
 v2u9L1qt+m5qXC9CW3mdip+chDkyC4k+OdHMqghMuJEulF4lIpuxNpjWMPC6yZcPVJeXRC2zL
 dNIjV15NiDkTd7Li53Rb69fw+95I20N1iqhPu4Z0CzIbwsoDwgbOLBLgfkLSmFxjb+96wU9HS
 1R91/Ab+hlnWOOmD5uKtH/7tZWf4ULWFHhpk8hTGXGH0CFNwlYsRM+wYzvbehnq0ilqkcJ4uY
 KABExsxbO42Ji1Pp2y2E0iyJ3ovas55qH6iXgJJJgLCqlkIxrmlebwvOcrYkfcT2QZR/Adyw7
 OvcNg9jTBgLFy5+3NZfqcvoQWTq73g7UDEBUElZG5U4aZSocaxa2geqxaooa6t3SWvs8ontD7
 WRQUtjx0CceirQXf9G4QxYbILlxQFpTDKxG5fWIcpVD70VRkvY0Aydz3B7azbUwPCT0FGOMBY
 N8buYtYIKv9QzqVbq
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 04:37:59PM +0100, Malcolm Priestley wrote:
>
>
> On 10/04/2020 12:28, Oscar Carter wrote:
> > Create a constant array with the values of the "phy->signal" for every
> > rate. Remove all "phy->signal" assignments inside the switch statement
> > and replace these with a single reading from the new vnt_phy_signal
> > array.
> >
> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > ---
> >   drivers/staging/vt6656/baseband.c | 101 +++++++---------------------=
--
> >   1 file changed, 21 insertions(+), 80 deletions(-)
> >
> > diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt665=
6/baseband.c
> > index a19a563d8bcc..47f93bf6e07b 100644
> > --- a/drivers/staging/vt6656/baseband.c
> > +++ b/drivers/staging/vt6656/baseband.c
> > @@ -115,6 +115,21 @@ static const u16 vnt_frame_time[MAX_RATE] =3D {
> >   	10, 20, 55, 110, 24, 36, 48, 72, 96, 144, 192, 216
> >   };
>
> Actually you don't need the second values

Great.
> >
> > +static const u8 vnt_phy_signal[][2] =3D {
> > +	{0x00, 0x00},	/* RATE_1M  */
> The driver would never attempt use preamble at this rate
> so it's safe to include in with the next 3 rates
>
> > +	{0x01, 0x09},	/* RATE_2M  */
> > +	{0x02, 0x0a},	/* RATE_5M  */
> > +	{0x03, 0x0b},	/* RATE_11M */
> just |=3D BIT(3) for preamble.
>
Ok, I apply this OR operation.

> > +	{0x8b, 0x9b},	/* RATE_6M  */
> > +	{0x8f, 0x9f},	/* RATE_9M  */
> > +	{0x8a, 0x9a},	/* RATE_12M */
> > +	{0x8e, 0x9e},	/* RATE_18M */
> > +	{0x89, 0x99},	/* RATE_24M */
> > +	{0x8d, 0x9d},	/* RATE_36M */
> > +	{0x88, 0x98},	/* RATE_48M */
> > +	{0x8c, 0x9c}	/* RATE_54M */
>
> Again just |=3D BIT(4) for PK_TYPE_11A
>
And this one.

> Regards
>
> Malcolm

I will create a new version of this patch and I will resend it.

Thanks,

Oscar Carter
