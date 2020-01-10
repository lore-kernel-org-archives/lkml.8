Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DE2C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DB520678
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgAJRrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:47:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59048 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgAJRrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:47:02 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ipyN7-0001Xb-Vl; Fri, 10 Jan 2020 18:46:58 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D7AF6105BDB; Fri, 10 Jan 2020 18:46:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH 1/3] y2038: remove ktime to/from timespec/timeval conversion
In-Reply-To: <20200110154232.4104492-2-arnd@arndb.de>
References: <20200110154232.4104492-1-arnd@arndb.de> <20200110154232.4104492-2-arnd@arndb.de>
Date:   Fri, 10 Jan 2020 18:46:56 +0100
Message-ID: <87y2ufqk4v.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> A couple of helpers are now obsolete and can be removed, so drivers can
> no longer start using them and instead use y2038-safe interfaces.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
