Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C65EC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA5E20732
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgC2SLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:11:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56773 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbgC2SLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:11:54 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jIcPY-0000GE-Q6; Sun, 29 Mar 2020 20:11:52 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 489B2101175; Sun, 29 Mar 2020 20:11:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Pending setup_irq() removal patches & core removal
In-Reply-To: <20200329162919.GA5317@afzalpc>
References: <20200329162919.GA5317@afzalpc>
Date:   Sun, 29 Mar 2020 20:11:52 +0200
Message-ID: <87ftdrvxnb.fsf@nanos.tec.linutronix.de>
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
> i have sent the pending setup_irq() cleanup patches & the core removal
> patch,
>
> https://lkml.kernel.org/r/cover.1585320721.git.afzal.mohd.ma@gmail.com
>
> sending this mail in case you missed noticing it as it was a bit deep in
> the v1 thread (wasn't sure whether to send it as a new thread or as a
> reply to v1, since you had replied on v1 though v2 was available at
> that time, the patches were sent as a reply to v1 thread)

They are on my radar.
