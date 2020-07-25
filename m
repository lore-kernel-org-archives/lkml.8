Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A80C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 15:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D02206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 15:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eiqJ0eUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgGYPUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 11:20:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:38337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgGYPUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 11:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595690369;
        bh=M7ZVrLG59meQ+/xq2KDXwLm/Fv7Dp09V+3wvtzhXw1c=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=eiqJ0eUo19kLfKKxQYBhePEa20tgMnl1G0Z7jF2SvS8tjgeluDziv7xM9q60HznBK
         4OXqxWweHEkSYHidkehkdeiBqk/UtNOXgug4Vi/MVIngPYCJmQNpXU0dZ1QyuYMcRH
         bgEWjLh1qtD8Yfx207+3AbQN62iZ9RT7vK9vVp2g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7R1T-1krdBV3p1B-017keI; Sat, 25
 Jul 2020 17:19:29 +0200
Date:   Sat, 25 Jul 2020 17:19:26 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/2] kernel/trace: Remove function callback casts
Message-ID: <20200725151926.GB3362@ubuntu>
References: <20200719155033.24201-3-oscar.carter@gmx.com>
 <20200721140545.445f0258@oasis.local.home>
 <20200724161921.GA3123@ubuntu>
 <20200724123528.36ea9c9e@oasis.local.home>
 <20200724171418.GB3123@ubuntu>
 <20200724133656.76c75629@oasis.local.home>
 <20200724134020.3160dc7c@oasis.local.home>
 <20200724175500.GD3123@ubuntu>
 <20200724143457.27755412@oasis.local.home>
 <20200725150914.GA3362@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725150914.GA3362@ubuntu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:bhEAsx646eWEJ4mh6b8CjZMW+XE0ssjoMVZXkhqRCcbHKpd1Xdr
 GH+Zk4bnWM7udBoyMrGWQNfpoUrwobl/8ngqfJcvmMucFCbXiStmnl/mGa4HwSynslNLGeD
 kDzJLaQjCK8tJKF0QEd3E85SnfI4rC9x6bXMHiHPD9ZRTGyL+Qf1qaSzyV9i/q/AW0cC755
 bqAKkmoZDvtVpQG5auCRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z+H1eZsL9mw=:Oz8B6PwR1wJtZ50Ku59HAQ
 12xOwyNHJj+iaBjguYoa1rLlRihsjqEBAJzjTThAata28bOyTx3nKcMoYovMGVGVurlfrgIX1
 Bf+9Uia9xI3dd+INMDC//td336qZOOXIYYrlB5C2R1YlP4XNqv7gMTEMqJp1V0GuDQ2HxpOFz
 /BZRs86bfUrAfeU9uxPIQotmANn1h8iI4fdXsvjKj30L8naRqKGo52CH70hVHHT6+dl0nMgTT
 xSQM7fNWe1tgQP49EK1ZdKI4jPmEw4adtURTGszoXdTRHf20PdUv6wlAwxeiCX1wYsoszGQIi
 obb066FhLLi7rVDc0fFYjwXag0XiwB/z3clJ9/XABKX3IZpPxswVpPdbJOMXo5PDYEPqUQXms
 fT7x5KxjqjbDI6uYYz2xNBOvwUhs+55lOHL7bh1rTaRMSoH8EoXXn9AK4WpZpCmoEpcozb9WI
 IJHOwe8SCIaILsNy5I/vvRTvuQ6hP4UKawLBJiGZYHYCZ6nY4jFI4QYqHhvwbw3FALtRlVQza
 RtRyY1CpFAP2JvV1sj1svPef2a+vRR2pyOxP36KsOdvCbFbE6greDVmgtt3YWlbBCQ45hNQYh
 APEggQraF4BnPaObzIw2+pKqylSMWyl1yDTX89JBbwnt43qCOMgfxW7aUAedNYUTN6bXOwVqF
 iThkqE/44Any8TNvpIoxiEFDRxAYqHud7joz8b1f+w5+EZCM0DSh1umQ6ycW3mrhvJv/YCfFc
 y5gZF4UpCx6wfGE9/g1CuNdg6AaAN7rN8/WQY7WkA+F5RgNI/UwkktEHVm3amclLFmPzqylVq
 WJe3iQhIY/ckCFWtWXpkieJtMO26St9ARPwgvF7HxcklKpzO2I1HbGc1dyEl+djWWVfK41TPH
 OHg/bBk3QYtaXNtq+WkFDXMYhQBea24NFMsvc/gN9CIVzzTAT3kK4hZyAvaBprVaHH4QnBcwX
 9EOqbK05wxWJbGZpYmXCbAUeDz4DgIaa4JHPihkViuSExHakFuxVeur+M18cLCXZlohyRpMnt
 L6g5Bf7PbF3lMlTti1G3rA7Io0lixcRre4pzs2NpisTRPaaaOM+lQ3WpqrUZKhJ77EWVx4F1P
 Ri8mQTqw6mRT4TAYT1CKykXSep3xUuMusvxT6quQUG2d6tG7Bqj3i2WghlFIIi9YMvxB23yoT
 lxWL1Lf/HEW1Kg/rs0FJE1Vcf75BKfurtW536Q29J3tcbAFUxvCcVqH93GelEHt1ZFb64fORg
 1W80OF/XUBOoa5IjX3qA/mQbTLINGPEpAwCzXZw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, typo correction for the last paragraph:

On Sat, Jul 25, 2020 at 05:09:14PM +0200, Oscar Carter wrote:
> > I would be will to add that linker trick to remove the warning. Or we
> > just use that warning as incentive to get architecture developers to
> > implement this feature ;-)
>
> In my opinion it would be better to leave the code as it an make the war=
ning
> visible until this feature has been added.

In my opinion it would be better to leave the code as is and make the warn=
ing
visible until this feature has been added.

Thanks again,
Oscar Carter
