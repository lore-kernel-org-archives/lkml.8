Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EC3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B5E20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=exactco.de header.i=@exactco.de header.b="NTEPj5O+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbgGHPpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:45:44 -0400
Received: from mx.exactcode.de ([144.76.154.42]:51794 "EHLO mx.exactcode.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730515AbgGHPpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
        h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:Content-Type; bh=Zj361zsG2x3D0tFpvDtnlDC6Z5lAcIx4dO3Y8wWMAg4=;
        b=NTEPj5O+Y/lUIUlEzajb7EwBhgGTZkmnb9Aq/csCS5ytE+Lc3V4SL706pRni53+lFH/iH5cYHxVd+EVPMCn2a2OEsDTxYD2+tdAhCokOvTzj9EkZtpyjvrtQW6if5PnRxrt655F2csUJNH1ADljfnambDQ7pIXrVJU3gE3IU7cc=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.com>)
        id 1jtCGY-0004iJ-OG; Wed, 08 Jul 2020 15:45:46 +0000
Received: from [192.168.2.174]
        by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86_2)
        (envelope-from <rene@exactcode.com>)
        id 1jtCIo-0001uz-B9; Wed, 08 Jul 2020 15:48:06 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Vectored syscalls Was: [PATCH 0/3] readfile(2): a new syscall to
 make open/read/close faster
From:   =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.com>
In-Reply-To: <20200708153859.GB715257@kroah.com>
Date:   Wed, 8 Jul 2020 17:45:36 +0200
Cc:     linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <48C35DFC-ED0A-4878-8AB7-1C4DC1BB6752@exactcode.com>
References: <3ADE6606-6572-4D7D-BB8F-9286B368DF93@exactcode.com>
 <20200708153859.GB715257@kroah.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

> On 8. Jul 2020, at 17:38, Greg Kroah-Hartman =
<gregkh@linuxfoundation.org> wrote:
>=20
> On Wed, Jul 08, 2020 at 05:16:41PM +0200, Ren=C3=A9 Rebe wrote:
>> Hey there,
>>=20
>> maybe instead of this rather specific, niche readfile syscall, would =
it not be beneficial
>> to allow issuing any group or bundle of several arbitrary system =
calls so this could also
>> be used to speed up other, more demanding high performance =
applications that need
>> a bit more than just readfile()?
>=20
> Why not just use io_uring for that for I/O calls, that's what it is
> designed for.

Sure, but last time I check you can=E2=80=99t queue open, read, close =
like this ;-)

> More "generic" syscall batching always ends up falling down in
> complexity anytime anyone tries it.  Good luck!


Well, given latest hardware security vulnerabilities it looks more =
useful
for real world applications than the very special case of just =
readfile(2) for
small to medium sized files, =E2=80=A6 any maybe more worth the effort =
of a new
system call.

	Ren=C3=A9

--=20
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin, =
https://exactcode.com
 https://exactscan.com | https://ocrkit.com | https://t2sde.org | =
https://rene.rebe.de

