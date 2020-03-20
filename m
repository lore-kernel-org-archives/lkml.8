Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B26C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CA120775
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgCTSg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:36:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36860 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCTSg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:36:28 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFMVC-0001zz-JW; Fri, 20 Mar 2020 19:36:14 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 03C6E1039FC; Fri, 20 Mar 2020 19:36:13 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
        mingo@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, will@kernel.org, peterz@infradead.org
Subject: Re: [PATCH 0/4] A bunch of renames
In-Reply-To: <20200320115638.737385408@infradead.org>
References: <20200320115638.737385408@infradead.org>
Date:   Fri, 20 Mar 2020 19:36:13 +0100
Message-ID: <87r1xm7u1u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> While going over a lot of code, we ran into a bunch of confusingly named
> functions. These 4 patches try and fix some of that.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
