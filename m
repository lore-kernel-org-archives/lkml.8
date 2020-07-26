Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B06BC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 13:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55ED32065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 13:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3yJeASRs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GEo/PhYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgGZNjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 09:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGZNjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 09:39:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91848C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 06:39:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595770784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hUdRpYGybzkQeuRC0LrAh9PG6lkeuFtqVs0xckYrYTY=;
        b=3yJeASRsHbg6/KbgTRXggUqDGYTpz6fIi7aJ/vmWsU0rH8vSWxRq0ym4XgJk83pU+6GlDG
        09QBG/hiwb9tVUuaRvbcsP2qx022Dw90HVtpmWH5dn6pbn/QLr7lxyrbjDIiQGp9UnBrDk
        NIz2vTH6R0DoUT4p3UT/UBeVsz9VDx6c67bhO1Msx4WbKYBnjJ+uCmbAqJSix40n3le9Dx
        TsKr2lfWiZN1zJomdGzaaqByM0LoFPGaDcxEdSGBDWRnyAUX+2LAc3A01Y8DBomcXAC9/7
        5eNIdsz1TErqyu7OufjKzoSxauXvXeTcDsQxovj35Cu4csm+b18jfI6qaqyfQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595770784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hUdRpYGybzkQeuRC0LrAh9PG6lkeuFtqVs0xckYrYTY=;
        b=GEo/PhYVamnkY9A/IyiOFuBTfKoy3Oc1jeiy2OgObYisuf4vzEfJiZPzhlt5w+L5+Hc5gg
        tQgVXoiEFCT9V6Ag==
To:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2] entry: Correct 'noinstr' attributes
In-Reply-To: <20200725091951.744848-3-mingo@kernel.org>
References: <20200725091951.744848-1-mingo@kernel.org> <20200725091951.744848-3-mingo@kernel.org>
Date:   Sun, 26 Jul 2020 15:39:43 +0200
Message-ID: <877duqcs4g.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:
> The noinstr attribute is to be specified before the return type in the
> same way 'inline' is used.
>
> Similar cases were recently fixed for x86, via:
>
>   7f6fa101dfac: ("x86: Correct noinstr qualifiers")
>
> These 2 cases were carried over by the new generic entry code.

Yes, my bad. I merged the above and then forgot to carry it over.
