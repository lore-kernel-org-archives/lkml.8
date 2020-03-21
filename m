Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5777BC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 17:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C56206F9
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 17:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgCURsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 13:48:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39232 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgCURsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 13:48:04 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFiE6-0007K4-Nt; Sat, 21 Mar 2020 18:48:02 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 35B7F1040D4; Sat, 21 Mar 2020 18:48:02 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>
Subject: Re: [tip: x86/cleanups] x86: Replace setup_irq() by request_irq()
In-Reply-To: <20200321172626.GA6323@afzalpc>
References: <158480051619.28353.14186528712410718742.tip-bot2@tip-bot2> <20200321172626.GA6323@afzalpc>
Date:   Sat, 21 Mar 2020 18:48:02 +0100
Message-ID: <87imixr44t.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

afzal mohammed <afzal.mohd.ma@gmail.com> writes:

> On Sat, Mar 21, 2020 at 02:21:56PM -0000, tip-bot2 for afzal mohammed wrote:
> Oh Thomas, you picked up v2, i had sent v3 [2], wherein i had taken
> care of your comments on v1 [1] as well as with more commit message
> tweaking (v2 was sent before you commented on v1)

Bah. I somehow lost track ///

> powerpc - in patchworks it is shown as under review after passing all
> the tests, so expecting it to go in soon.

Ok.

> ARM - i am expecting these to be picked up by Arnd/Olof shortly as
> they are yet to pickup any of the pull requests for ARM, you have been
> copied in the followup mail [4].

Ok.

> As of now only c6x, hexagon, sh, unicore32 & alpha are the ones that i
> have to send you. All others have been picked up by respective
> maintainers & are in next.

Cool.
