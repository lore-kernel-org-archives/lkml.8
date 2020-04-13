Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A5EC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516BB20732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ALACTwc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbgDMONm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:13:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:60945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730417AbgDMONi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586787209;
        bh=fsy7pbyVHuLxcF0YdSrvHewVvvVq1Q53I/0F2aOE4NE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ALACTwc9Ve7aA1UcHApC2Tu9knx4ZjbO+KhmHxfHIgFeUphJwt6p2vqLZIO+P0lKm
         UQKHwlIXA0ZAPQj5dNnVOX4u4pK9qiwbv7ThrRBhP+3qZ75hEyPy6Gidd5PQ4/1/SB
         6wfAszM4lWTp2WO5P3Vfd47I02HRbehPNvoPwPJg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mxm3K-1j3i4N01aY-00zJfT; Mon, 13
 Apr 2020 16:13:29 +0200
Date:   Mon, 13 Apr 2020 16:13:15 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 1/2] staging: vt6656: Use define instead of magic
 number for tx_rate
Message-ID: <20200413141315.GA3101@ubuntu>
References: <20200407163915.7491-1-oscar.carter@gmx.com>
 <20200407163915.7491-2-oscar.carter@gmx.com>
 <20200413125633.GB3127208@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413125633.GB3127208@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:2ADjKbcyP1Uqbfc5HGXxmv9sHYISCCpoF8znnylwnSdy1Rqg4DD
 hA6GTRi2oACLltq5zb6Mg2OQgEB5UWYLsxZhrhCsF6BF1k/8atd3FF4A8avCv0CTy7pIUqb
 japaMQ/DQICbgyeQmwAQRlZrZic9tzJ48oviQ/V7j6M1ThR9lIIQPW0in0u8qA03N+pPlO/
 /ISpu8D/nEZ+yDSKdI+RQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U8SuuQS1uaU=:3TnpPg9hfWRzjErBGedKeu
 FoUa76tpPcI/Y3GT1ukoPg4NrshP+0QgZMPtBu0sicyKL5YOYKsXYpS6AtCWp2wHt1h4VRdJR
 TSCP/Y3B+uAnxB/4eHC6XkTItGhARYj4XJMfR60N0LP+jZ+KSvp81EH6/09iCGmubnRLbjjC6
 e/0W+f+qXBdRN193VyMEAz1JZiknG6c16KYuwwmqu7I6YedPFxWl6vDF87mITvkQpMWe5Yyot
 fIkVWYn0AaxKP76+w0HVH+nNTBE805g5+TTPaIJKB6JcnY8Ye/7zskwzvsSeqzgqXrm5557Ts
 xbZBUu47dAp5H7VRkWTIkgjn02tVCzKTLSmwu570XB5/DTekWA1hXEO2wsfBN7769la8qtUdd
 UxVxjIjjNyJ+DIv86BRLfMCYNSjixe6MLurywlVcojs8ajDn8ZrL6Z8G9DY/2ephJxN/sJzVR
 djBlm4dD8K+f7bUS1PsEBBltxNlipJE1A788fEbeZ2JFjtCpWMC6cHZI8SU8QsUoFdwnRP5EK
 Mzii4T6+oB0oeFyH3rHS115Pbbl3Q09zfGYx1nGy86jMNT6pphQlYEIrFPkzkf+snA+bD8N/N
 xVgeVP53B60CYjBKu8p/3xqcnZL0uN51oMyF5mLc2TRCKanZ9b20IqzYF4eZPQLKNS9wVuk4P
 DEhA1/0hqnVdO8RLeovrElbuPztCb+UPrNx5ZJ+Vq1UHCsw1sM8/b1ux8HWnF6yn6PZ+F17I2
 clDPF4fUTqFDhjNTOHPPSZM/KuSRC8C2sL7xMGja08JirFx321mcVTwB74QP1DotvHEAUTotF
 ysCNt/rWB4mkMsIXJFvC5vC75pzdlwY3q5g9kjG0NLeXKUh1tcQm/MvSWDsQhW/PnCSH4sv1r
 pLIaVVXP9PIi6fekzG0lZZUtJ6Y8mlA4n8DyMo0t0srFGIMT7haZb4DuWerz/GbT/MJ0pmbqB
 xoJaFPm+96vSiyTfm5ESEyCgjbE6auRxCOEsCyoODTFeFZYnnQLirmfWjJa/ZFByqi5xaJ213
 FkuEXlw4iJjf93l4xbgVrujtiH3T8iwpig90b7oO/lVjonBXy4qLugDEykftGxz3011ysiO33
 VV+qcMQG0klJubBAAlt4XPZnsAnAlBOzALeKQu6TxoxBd63EidsK+XvnJC39MBbXoixYwy87b
 vlvjGG29KaoJhWteU2Ostp88/6fKhdi1lZsAsQCq0Uf+zdp+8b8jNyOFosUq/SqcnSz1R0w+Y
 t/nXdeIgUQ5yIzM6a
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 02:56:33PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 07, 2020 at 06:39:14PM +0200, Oscar Carter wrote:
> > Use the define RATE_11M present in the file "device.h" instead of the
> > magic number 3. So the code is more clear.
> >
> > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > ---
> >  drivers/staging/vt6656/baseband.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> This patch did not apply to my tree, please rebase and resend.
>
I need to rebase only this patch for this serie so, it's necessary to send=
 all
the serie or only this patch?

If it's only this patch I need to indicate v4 in the subject or a v2 due i=
t's
related only with this patch?

> thanks,
>
> greg k-h

thanks,

oscar carter
