Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8646C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D4B21974
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IutIsFNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGNC4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 22:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgGNC4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 22:56:32 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A1EC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 19:56:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a24so1324581pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 19:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GYXfA88REP7Ii+n/TRWlnJSZZVN1GYMTJsLHA5GKXTc=;
        b=IutIsFNFnLOk4TxOKdywm5EsL4Di+SUjng9rJf9O1FjmjruWa3tdRKdD0rtzb2wTv5
         w1xulcBvv+aBQ+cOJ0tq236sP4fea3kBz6Zaxdd1eWSGs904og6aAxg7fFPXj/1T3TFq
         IK8M8Fwo3H7FHhDFBHtSeXkatXF6rO6P7g2ZwPk9esvHvmAqTeITFxGLQ1GgDuUE3sp1
         SlEE+HV9p8u2C2JrFyOIrcPYNSqWFGQih71F838u9un8n+0A7pSF9Vu1oyiJ/Uro/0V9
         puvQ9SePEz3fDiCpaEJuYx7bljIF6mZGO0KFwv1BS2qDajlEpIWbSX9zaVpBlmeHSQTE
         lSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GYXfA88REP7Ii+n/TRWlnJSZZVN1GYMTJsLHA5GKXTc=;
        b=SZIMBXV9rsQWfHQGcyZo1mrq6difF92/oN/kf6EVbW5JaaEz58x7bJXfY+yMT0kboB
         7EjaBfSITDB6DrNeHX5CVRH2j7VOZjkJ8lc3T0wacJ52j0E03zHdBUnvvsK4Smqm4wm3
         91dZHpvWpqmxvzJhr7osNZRxb2TvPN0EzsXx/YCqmQ+ryimpqWWx3gg5XsdaFQ4z58sQ
         MuAYZr453rhGCEnuhFWp+hUMd/BMYyiixTY3hZR6MHT76XBbQRjntkh9O/ZZ9GxTpdbz
         aO3ygsGNkK7Fewtq0uZK169LCg+jo91mBi/KVhwJwSngQrhz5u8n0NC7x+dlcGFqsGYI
         8M3g==
X-Gm-Message-State: AOAM531DIiK7bGjRceXvWBKGeYT0RiT6oQEYl/FE6gFylMZ+nHHJDx8/
        OuhRscVMRk/ynq3x7jMq3qQ=
X-Google-Smtp-Source: ABdhPJwdobzTsnXXvwwSwUC7GWjx6B+1yH89Vzmd+jsP5xUlFPAhafRrcAiP8n8pSC+zQnc31qliSQ==
X-Received: by 2002:a63:1d4:: with SMTP id 203mr1695817pgb.356.1594695392152;
        Mon, 13 Jul 2020 19:56:32 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 2sm16048049pfa.110.2020.07.13.19.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 19:56:31 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 14 Jul 2020 11:56:26 +0900
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] printk: replace ringbuffer
Message-ID: <20200714025626.GD491026@jagdpanzerIV.localdomain>
References: <20200707145932.8752-1-john.ogness@linutronix.de>
 <20200708152005.GF4751@alley>
 <87wo3d9nlo.fsf@jogness.linutronix.de>
 <20200710091137.GN4751@alley>
 <87o8onhf31.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8onhf31.fsf@jogness.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/10 11:58), John Ogness wrote:
> 
> IMHO users of these sequence number interfaces need to see all the
> records individually and reassemble the LOG_CONT messages themselves if
> they want to. I believe that is the only sane path forward. To do this,
> the caller id will no longer be optional to the sequence number output
> since that is vital information to re-assemble the LOG_CONT messages.

Agreed. The caller id thus probably can be extended. Right now it only
tells us either we are in a process context (PID) or in something else.
This works sort of fine (I guess) because deeply nested printouts (printks
from NMI atop of process or irq printks) land in the deferred printk-safe
buffers, but things will change with the new logbuf (and after removal of
the logbuf_lock and per-CPU printk-safe buffers).

	-ss
