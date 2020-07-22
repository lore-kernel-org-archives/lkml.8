Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5930BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBDD20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncE8eTDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbgGVLhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 07:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgGVLhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 07:37:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F5CC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 04:37:13 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k4so835342pld.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 04:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fRFcXIoqaZPkq/8SxG7xG3az+v/OSHcmdZX1E5pBxVg=;
        b=ncE8eTDH6xFiIMeHKH9CT5kXc5Yc5ti9HCPh98dFO5BTWq1umDj5idDLA3cqBDeKAN
         8N1AW24dxzHHikXdShdPaan+14ky2VFs7bJt8tcsgLKjKRXtxwJbSY0wOG7DYXN1Acbe
         jGch+v2mvpA1wC/yN2n1eVjsCCnB0/vZVtuR3sTvjth0aORyHRyi/aRxm10OpiEy6pGb
         QncnpvyoxpnMs2l9xBk6IaASU24qVAaidPY/rHfg1Dsub81Mv1xYRQcMC3R1UOvQ/xiy
         KkrQWtQchxK6m6KIqWByB5tA5iRmne1mhQtQP3VdBV1+hQSq/2zF0JDTFprDh8SVXxsf
         aDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fRFcXIoqaZPkq/8SxG7xG3az+v/OSHcmdZX1E5pBxVg=;
        b=ES1HYeOIiORqJ13Hk3GzZYs+1kMgZFR7KkFG6fYO7NfkJ1TsRr7k7l6Yo5DP91z/OS
         I+OAL15Ih7X/rjwl+nPGyns5OuXRbEokcmvUCLXIUTjzIDyKEq3saBNzyO+wj0l9PC/e
         fAnfNi93n7LcVEWiftqy9+WFCdgVeDTKdLNz67g10lBJRDFMM+XSZcHKfq2xE5yCwfBr
         lkxCDM9kkna2Q3JyXQH8tctzCapvWYkIyd6EX4bDZFo+xdS+dYn7EhhU4/rwc0PFP/6J
         BLLf+xP1eD/iqPMg9ZLYz6m7YZ3xyG6MXdTSpC5zvPc6bIF161DtHNRcod9ErQ7gEK4j
         8+Aw==
X-Gm-Message-State: AOAM5307uX9/jkZQ1mSXRoOntXlL2LjGD8VdMnXV0oadk2/OKfwWLLaZ
        iiRTkUOGzyyRTPbG1V9wIVs=
X-Google-Smtp-Source: ABdhPJwcZ2MbsEaobdQ6x2+F4XHz/H3Shl4Eks0lWU8PsTGw/qodX6GvRBdJ6g3djuk6tceYpg4nvg==
X-Received: by 2002:a17:902:7605:: with SMTP id k5mr25561132pll.331.1595417832989;
        Wed, 22 Jul 2020 04:37:12 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id a67sm2455311pfa.81.2020.07.22.04.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 04:37:12 -0700 (PDT)
Date:   Wed, 22 Jul 2020 20:37:10 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        jbaron@akamai.com, mingo@redhat.com, kernel@axis.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] dynamic debug: allow printing to trace event
Message-ID: <20200722113710.GD428@jagdpanzerIV.localdomain>
References: <20200721141105.16034-1-vincent.whitchurch@axis.com>
 <20200721173045.540ae500@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721173045.540ae500@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/21 17:30), Steven Rostedt wrote:
> On Tue, 21 Jul 2020 16:11:05 +0200
> Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> 
> > When debugging device drivers, I've found it very useful to be able to
> > redirect existing pr_debug()/dev_dbg() prints to the trace buffer
> > instead of dmesg.  Among the many advantages of the trace buffer is that
> > it can be dynamically resized, allows these prints to combined with
> > other trace events, and doesn't fill up system logs.
> > 
> > Since dynamic debug already has hooks in these call sites, getting these
> > prints into the ftrace buffer is straightforward if we have dynamic
> > debug do it.
> > 
> > Add an "x" flag to make the dynamic debug call site print to a new
> > printk:dynamic trace event.  The trace event can be emitted instead of
> > or in addition to the printk().  The print buffer is placed on the stack
> > and is limited to a somewhat arbitrarily chosen 256 bytes; anything
> > larger will be truncated.
> 
> Is it safe to have a 256 byte string on the stack? That's quite a bit.
> How deep is the stack when this is called?
> 
> You could run vsnprintf() with a zero length to get the size, and then
> just allocate that from the ring buffer. How critical is the performance?

Hmm.
Can trace event contain a fixed size buffer or a dynamic array; then
we'll pass fmt and va_list to trace event so it can vscnprintf() into
its buffer in assign function?

	-ss
