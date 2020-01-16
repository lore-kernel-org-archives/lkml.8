Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A3BC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CE0207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579169370;
	bh=/lPEd1hvkxi7tQJuErw28/9BVJ750Vvq6gMKJni+Pu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tI354tjyrak2sKxxB1rcmX45MwtotTWfzsjZq+Qq2MARM0yIgDRvVtPlG7BGypik2
	 5oJR4PQ/fepwCG+cLBNJZd53oetRJ7xnl6vWyWlz/FOUu+anLSfPFFEf5r6avUOpIE
	 zqRXRGceY9DCwEbpXsboPNIGamb0berI8wff6QyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgAPKJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 05:09:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgAPKJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:09:28 -0500
Received: from localhost (static-140-208-78-212.thenetworkfactory.nl [212.78.208.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FFE9206B7;
        Thu, 16 Jan 2020 10:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579169368;
        bh=/lPEd1hvkxi7tQJuErw28/9BVJ750Vvq6gMKJni+Pu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ox0yAvyAFyiTcF7TdtoXDSErZLw71AKR4SbaGp3NoEplXZv/2DQ4t/4CZuY4e2xrH
         XKpvgX8RMIEjHf/axYG4D1ClVNmMn24ptb/hQRXGe3VMdSsVZPhdmHzIPrUX9cCEat
         6rV4a79QBulPu87G8i2X/9C6FG+T8kQtwS+F7ioM=
Date:   Thu, 16 Jan 2020 11:09:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Masami Ichikawa <masami256@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tracing: Do not set trace clock  if tracefs lockdown is
 in effect
Message-ID: <20200116100925.GA157179@kroah.com>
References: <20200116094707.3846565-1-masami256@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116094707.3846565-1-masami256@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 06:47:06PM +0900, Masami Ichikawa wrote:
> When trace_clock option is not set and unstable clcok detected,
> tracing_set_default_clock() sets trace_clock(ThinkPad A285 is one of
> case). In that case, if lockdown is in effect, null pointer
> dereference error happens in ring_buffer_set_clock().
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1788488
> Signed-off-by: Masami Ichikawa <masami256@gmail.com>
> ---
>  kernel/trace/trace.c | 5 +++++
>  1 file changed, 5 insertions(+)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
