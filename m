Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4361C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 07:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA63D21974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 07:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="L88xN24A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgDSHrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 03:47:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:55645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDSHrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 03:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587282450;
        bh=vUSOECUk4A1mxf1ROMn314fFRK9fMORoG5b7Bw2RiDE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=L88xN24AYqj90BWGl/q2KoIEmUQBg9VI9P377qLfYrtGRzd2BycuRy3r2pnP9kaj3
         I4QgbDPnvoXLIXwzcXhOhwBVtQ0wrl04h+rnqgq/yumEoOZet5mkjgJjyjcAzWMp5Q
         SwzA1awLY6+T65DOcmYAh8ULPyKAX4iOdza6FDtY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwwdf-1j2vsn0M6F-00yTuy; Sun, 19
 Apr 2020 09:47:30 +0200
Date:   Sun, 19 Apr 2020 09:47:17 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Malcolm Priestley <tvboxspy@gmail.com>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: vt6656: Fix functions' documentation
Message-ID: <20200419074717.GA3244@ubuntu>
References: <20200418123659.4475-1-oscar.carter@gmx.com>
 <20200418123659.4475-3-oscar.carter@gmx.com>
 <adc4bc72-5c80-e8f4-8d48-052109ae18b7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc4bc72-5c80-e8f4-8d48-052109ae18b7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:C+eQwfMRlP9LtW3tNHYP23t/9OFkChviWB5f1D306aNEAqLQh/f
 PZq2e+MsIGdN5uaBB//2rSMKODQt3trR63byvjSBzXjQZp6GGdFHgSKSI890l5I4WYXVu/M
 SF67fTyzYlFK8evNfdqjSWxro4t4MZrBmtBPfQaDM+pbdFN4Y9WF2xAOQ8/FDt+dh/3If2E
 lFTPH9rS0aLBMiWv8d8YA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LMwP+G4IPtI=:j736PCtEgPykBb0xF2qwnY
 0TgUwgJv8SbU5ltOB9UImauPJ2uSmbsFHiPnBX+udnnR1Tp/jkfFYIQ2PqKJVMy5g5+CYNDeU
 DCWwUx+avuF8CCZgOYd0ROEFy0JM+sNc8j6zvXhhpRNaSgCJkEPllCBDM6DJXa8QzB/VMoV8n
 kIIzqUvKRbWn+SZLncD8iEJGx+A8KV2sbci0tNSzc8m9qKX6lA1bRy5Gnq/btlMKwKueVfMKH
 vtRwjCaWM7X0eWdpXA1JdyciVkBMlv5XSb4uh+xUlv7HM08BEd7xpr1DGBzmecV+h8RTr5GI8
 AdVvs51UeFnwhfyeBbi28iOmiBXPZEtJN/dBdK99eK9IDFVRTffBblClcfaQa9bCxd9FtIeXZ
 j5KG7opdj52/m5QOeaFGCr+c+hX+m6D25BiiXgtOZdgckFmFVPh/nAxF8CZ9W7zjYdxndy4i9
 KXr7WZU2GXim2Yc2QsLEXNpqunGPJZakysFE5KJ+nIoMSULSUf8tN9Iwd/lc6HcsmqQxxDkQu
 SruE/mlZrAmXAspwhSt1OvF8qAOayIvWrAwXBHB1viRxLSaEdoKkgxD95JlSK0SgZ+4pdRwuw
 KJnYD1MFIStcIZN5+zK+wUaTIVLcWiL/ZShbrci8Laz6jEdEns894856zHTZHhsz0lZhmmp6m
 yHcoIR45xUdVlOsGG1TgSlmUKayWyjitOaztf6dscXCyLLRK+quECuADuqdKzusYl8Sgpl7HY
 d19u1E99/cBaw2nMYsKPt08/qzVcPW6HflnQ1qThGz84S4L64omHvremoqwp9uQIgBgrnSAS7
 MNGQ2lcDxpDDCSKEkxVjtXKifQNPDKKXcyEQ7aqriz2AEHXrV6YXsAeg+0C861GIQSUG541yb
 kYoQZHBZJ/sv3ovPtHeU7mm+4fJTBuQPa5tO3Gm6KkF824F8AyxL/al28xx4pEVIxfzNq5I0+
 Gj+dv4G6TqebTgzXsRVGe85YlYwAL3ku6/r2fqYPnKUohSLh45afpetZ34Hkk9IYf17qLa+R4
 QLOE28iubMHH04Ti1YrX8fiBbQmXyopINcUh4gKDEjaeEsoqFZRNbJjPosUsr4MddB6XxbLvH
 Pacjy2rOc+IqmfWcWsw2QFJPNNo41WLxY3J0M4kBWouh1T/auhnosi/KbExPTVvY0+4a3Lv1H
 oByUJIYLNh46JzcZpeP+c9EFDL5PJRE5VBn0DIeH3bt4Imh9IPBm9c6Qqf7NfqUD7KWoyKsMM
 k3jmHouw+vYGtSUVg
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 07:05:53PM +0100, Malcolm Priestley wrote:
> Actually I don't really think the function descriptions are needed at al=
l the
> names of the functions are enough.
>
Then, it would be better leave the documentation as it was before or remov=
e it?

> card.c needs to be removed the bss callers to baseband.c, the tbtt's to =
power.c
> and the rest to mac.c
>
> Regards
>
> Malcolm

Thanks,
Oscar Carter
