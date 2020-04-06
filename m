Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C03AC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFDC2495A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lWOyYvOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgDFQ2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:28:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:44107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbgDFQ2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586190475;
        bh=FRIKvjiq28REAum1cMDGhYM9/roKmK1fSCayFBmXFgU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lWOyYvOYa11ecx4G8duAfFNsE3LC4IB0vGz8O5Z93F4cOppirBDoLZR//WDCBkyVK
         8I4EhRdxsoYkpxjRW9Kuh/4IjO5ij9aq3DD3SIGenUQHcQAmq01HtWR++e05RSY/+4
         9m19OuAXaWetgfKivN44k4MJDtjvXyoGlKEhYIP8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFKKX-1jWE7O0293-00FjJI; Mon, 06
 Apr 2020 18:27:55 +0200
Date:   Mon, 6 Apr 2020 18:27:42 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: vt6656: Use ARRAY_SIZE instead of define
 RATE_54M
Message-ID: <20200406162742.GA3230@ubuntu>
References: <20200404141400.3772-1-oscar.carter@gmx.com>
 <20200404141400.3772-2-oscar.carter@gmx.com>
 <20200406111323.GD2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406111323.GD2001@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:T8RilL9H1r3t+wcwqfqUctvy8o8lnGN+LwBkrhd37tZNI0Hg7hX
 sbLPA+0DkJwEFiKrwbe85E2U2V3eDR0Hp0bEnQymF023ct09DHkfUWE+kAUY9DlZgfKnPwa
 8ULu4PKW1SInKncw5yziKJjWg1VGvXbX3vcaF1kMV1ZTBK3rZou3XfGBmLcv6eMGinOA5kc
 X0ysxxyHJ6uvh22pEKk6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xi8YNRbZVgM=:+WNzK0tl47HV8TcxIqRdwF
 +a3Cm6phfalLHfZ70JO9on5BA9sswVp6Be8Ed1zZKPuhYb8Eyv5U2ofDHR9elcuS7qTvZ8igg
 qBx9X4tfHvsMNt+Bpf+fh7+zYJbN98aXHPocMFAPCQTsVWRfZyRIaBS0MLgbGi4JAtmxLzkxG
 XDwNZRRwv9+vIbRv+6cuTMIaYUg/zq3Xjmf7XCiBujy0cooBIuuRK+19Bk98XRjMYTMMry32H
 KQ8M/8I5x6J4Leantd5O18jNN29w3sMzV0mPgs+TAFBu7wWaAQ5awxHfSFgwn2f0tr7sp/P5c
 tbER7ozPk1ZjRZ58g3lEbwvH6gokjOse0C86awSFgbtOgVty5YlyiQSjn5lp82GInkfYG7Ssn
 iWprGKx7uAT88ZEj48caWkyoEHe+1n9yI+bBr3EY6JSk7fcL2DvLrlAeFaed2+dKo6Q4tqNJ1
 bFZ4BgygxG1ZFYP0+cWAUewLQAoZZuQKwBfrukzGzzeMOmyVrxKEcHFEyvCTg3SQzkI+MgfPV
 F61ymjO//wfAqHC435NrjdxoF/94aDDPI47uN80ZUBvM8MPf9jxDZwvV8YYXHNA04+9nPkxsP
 WlHDpbtITSRME9TpiP2HGLLxDoPN9wXaEGSRxUnDl7K3DdUI1uo4V03RGZ1yHN4Os1DLuWbPO
 ZwCgfdM5XW0CCc5/K2trK5h7S5I94f2LGdrGW5UMarWO2QqB6DpECbOqqPOlPc4iakmDOkfkd
 VXRD/eo4AQRzLE8stsOoO+67FbjryL2+C9h4e8qEgQbG+GyPnSJgaBtNBnEvlAO57j4Nuc7Ah
 gLk7z3yMmwG7pjpw1epmaKGcErqmrsEtWQmK7dCfo0szAsDPqC8ZEvPic47vTcKl3KxstNe66
 OFM5+xkoxv1z9DHyr0/VEcI/xIL3tfhh14xMA4+W/VyPXHZXNroPUEwutj7OmayClcENBqhL7
 kd760vg1QJNgcKZbMgCGfDbDcSGIKDHgNA8KOEt5Dn3zjzq2CLjGcQrzUmiRlPAIS16gTiXV/
 yDlCI3cHIXukKVmbcdraLOVDoQu7G+a6CVOz8wTwHLFl6S/+p7dny+eJ+qkqmmq6Og462+/m6
 oMLOKkk3fy0wXe8a38kVzZScpS4z0X6RthkdLFyIRNLLzQ29K+TsmeXURi/WB/Tb9hn+QzcLx
 ElJIT2TUYYfXmoRCasSiJnd9sY/yxZ8pO36/GRJ3uXPheeOCIYzehtBLNvAgGoI2/vwPf8Uam
 LK2tphXxiPI6wjdQL
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 02:13:23PM +0300, Dan Carpenter wrote:
> On Sat, Apr 04, 2020 at 04:13:58PM +0200, Oscar Carter wrote:
> > Use ARRAY_SIZE to replace the define RATE_54M so we will never have a
> > mismatch. In this way, avoid the possibility of a buffer overflow if
> > this define is changed in the future to a greater value.
> >
>
> Future proofing is not really a valid reason to change this.

Ok, then I leave it as is.

> We have to assume that future programmers are not idiots.
>
That was not my intention. I'm sorry.

> The only valid reason to do this is readability, but I'm not convinced
> the new version is more readable.
>
Ok.

> regards,
> dan carpenter
>
Thanks,
oscar carter
