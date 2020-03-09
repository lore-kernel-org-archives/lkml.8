Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D28C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B579921D7E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583763751;
	bh=ytIo9RpOOdyCB5diioQmFsxB6XvmESUhpwWHbL/ER88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TxUUjJxlymwcQNOr23SzCfysdmlJhLL2D5qni9z+J5te31HA4VeUglliGSmfxi8pH
	 2lP1KkqJbMgWUWxy8UxgrYicWBNvf27jo9Mow9vorjcey6p/bcFvzHljUSNiB9akeO
	 YGmcqNpS/I9d17PPbz30LenYXoyLZ4kzxYDJ1+Sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCIOW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgCIOW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:22:27 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F141420873;
        Mon,  9 Mar 2020 14:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583763747;
        bh=ytIo9RpOOdyCB5diioQmFsxB6XvmESUhpwWHbL/ER88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAmSBoq4OYSgV9X+4OC6OQOzrcD2qUw4V05nKa/uhgza1ZjWigdCJ3kLtN/jCsHKz
         RUW+h0176sDJ6JVxSDAEagUXL0VSlOvpswCCsbGfYTAozjaQPlPzWfKh49I60PXPju
         3wfDeXwsy1//cVaNekSbujQJ4sa2lV1FJIungxrk=
Date:   Mon, 9 Mar 2020 15:22:24 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: [patch part-II V2 01/13] context_tracking: Ensure that the
 critical path cannot be instrumented
Message-ID: <20200309142223.GD9615@lenoir>
References: <20200308222359.370649591@linutronix.de>
 <20200308222609.017810037@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308222609.017810037@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 11:24:00PM +0100, Thomas Gleixner wrote:
> context tracking lacks a few protection mechanisms against instrumentation:
> 
>  - While the core functions are marked NOKPROBE they lack protection
>    against function tracing which is required as the function entry/exit
>    points can be utilized by BPF.

Just to clarify things up: IIUC, BPF scripts can be called from the
function graph tracer hooks, and that BPF code uses RCU, right?

> 
>  - static functions invoked from the protected functions need to be marked
>    as well as they can be instrumented otherwise.
> 
>  - using plain inline allows the compiler to emit traceable and probable
>    functions.
> 
> Fix this by adding the missing notrace/NOKPROBE annotations and converting
> the plain inlines to __always_inline.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

