Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09FAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A138F2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OMw68Gk8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rDHGw38w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgG2Ojz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:39:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43248 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG2Ojz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:39:55 -0400
Date:   Wed, 29 Jul 2020 16:39:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qTdOFK6ssJyxU1epN5OpTYyVYChTQiUbyU6vzACtn3A=;
        b=OMw68Gk8Va8zSkLCCoIblVe56//o9CO27kItHu+0sbjHBPvpuXvv2lEFSDm+EPm1hMBBJr
        in/4pQjvGNq/X4dOUKKnl+ocHWrsOpvbfVCanvxlgGW257NSRusqA+xLPc1LOcauJdvnvj
        3fk0I8nKCIl7BGzqiNAGMOXBgqNlVU1qNsIhBi+UMetvnuhZ48l/sYIju/AjY0zsh7hcSz
        jv3XCTGmHwUaCfN0hS5h7DKh6oU8CAu5V2U4yYcaH1rPlv71VjB43Ewrmbxhy8Gop0nL/4
        OQ43jd7woNeP+3nZr/aGejlIrRQ3+MY2H6oq8W+RWuh/IoLShqZXanEvU1+PSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qTdOFK6ssJyxU1epN5OpTYyVYChTQiUbyU6vzACtn3A=;
        b=rDHGw38wh3U56DhXn/DmAdnpoxnYUTQmBMRmrV/kXRuPlfnrQLs1onj77Ftezh9D0q4xV0
        xIgC8hvg7hOWg1Dw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de,
        paulmck@kernel.org, bigeasy@linutronix.de, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, davem@davemloft.net,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] seqcount: More consistent seqprop names
Message-ID: <20200729143951.GB1413842@debian-buster-darwi.lab.linutronix.de>
References: <20200729135249.567415950@infradead.org>
 <20200729140142.552991630@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729140142.552991630@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 03:52:54PM +0200, Peter Zijlstra wrote:
> Attempt uniformity and brevity.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Acked-by: Ahmed S. Darwish <a.darwish@linutronix.de>
