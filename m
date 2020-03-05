Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA9CC3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722DF20866
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g06UWHHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgCEBaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:30:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38178 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgCEBaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:30:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id p7so1889741pli.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 17:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bukUsdEeXOt13OEWxPTm2hiZd36XqTTzhqAt335l4G0=;
        b=g06UWHHudkUqv2Q5AMjN7eznXNf7KlfgLUS9XYjThsRrt2bpLxNqrfuc7CYFTBhld8
         A7LvLmR+sDZpyzCLbdj0nuqvGxMr4KfSLG3vBSn7ny5LgcnpJ+gadAYneIYcIq53Pd/M
         LT+KwJcui2ixJK5WJx3IfpxgjBW7XYeo5twjjR+7yVMfQet3V5KvdTpH8rN5Vo54brMZ
         dZRLv2b3U9GRVZDgCvKIFjpVdBCWwZ1sJ3vSobLFbkv3XvVF5EfYpu963WtrxxCpufEh
         XCL32NsKi/KBoSUtLAmcPYMFtzFOj+2jLw45+diZqlA5ldnB2S9jVL6z1sl0zXiQOXyo
         TPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bukUsdEeXOt13OEWxPTm2hiZd36XqTTzhqAt335l4G0=;
        b=aFYlE/ADBGV05+hi0+dPALhmnfvw7D7eglslfCUR/JK2lkiIwWQW09lNpS4uZ9b/Ew
         ALGTEVPeeBPPGzLJfV7znHAPwOT57rU7kecCe0rIb/7/xlKqt+zyaR4vPVQaiJIHK3Iq
         2az+HE31ZpZIHSkOx9cidamngHgjh2irNcMTHTIcdc8LjO0mz73Bqg7bT5mjaht5D5SC
         MaO1yc+LXO94E0v7/bzw+MmisRwp+Xnx16d+ftQa/vMfiHWwfqJQi77LOic3CZWxQD+D
         1UI2TbrdyI3yq4lU1Z0buPVVJX0+M8nl5vSpb8lYlnGbYWrSwNH1pGV0gxtedmiTDmpR
         tNVQ==
X-Gm-Message-State: ANhLgQ1NjRLtSNdpnFcexavaYKaNHdAiMzaEGTX8MLLopK38mJFuBMP6
        r3NPipXXfeuOUT73byz9h4w=
X-Google-Smtp-Source: ADFU+vvYsXGf0bkXDkX5x/pZMUrDxHK7vZ7Xid5HkW+02zq0MKJqpZfm4vxjY2y0saJSucWiww1Rwg==
X-Received: by 2002:a17:902:2e:: with SMTP id 43mr5762803pla.326.1583371816977;
        Wed, 04 Mar 2020 17:30:16 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id k5sm13521893pfp.67.2020.03.04.17.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 17:30:16 -0800 (PST)
Date:   Thu, 5 Mar 2020 10:30:14 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCHv2] printk: queue wake_up_klogd irq_work only if per-CPU
 areas are ready
Message-ID: <20200305013014.GA174444@google.com>
References: <20200303113002.63089-1-sergey.senozhatsky@gmail.com>
 <20200304152159.2p7d7dnztf433i24@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304152159.2p7d7dnztf433i24@pathway.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/04 16:21), Petr Mladek wrote:
[..]
> > Fix printk_deferred() and do not queue per-CPU irq_work
> > before per-CPU areas are initialized.
> >
> > [0] https://lore.kernel.org/lkml/aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com/
> >
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Reported-by: Lech Perczak <l.perczak@camlintechnologies.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Theodore Ts'o <tytso@mit.edu>
> > Cc: John Ogness <john.ogness@linutronix.de>
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks!

> Now, the question is whether to hurry this fix into 5.6 or if
> it could wait for 5.7.
>
> I think that it could wait because 5.6 is not affected by
> the particular printk_deferred(). This patch fixes a long-term
> generic problem. But I am open for other opinions.

Good question. My 5 cents, I would _probably_ push it now. Not
because it fixes any known issues on 5.6, but because we have
a number of LTS kernel (4.19, 4.14, 4.9, 4.4, 3.16) that can be
affected should 1b710b1b10eff9d4 be backported to those kernels.
Which is quite likely, I suspect. The sooner we fix printk_deferred(),
the sooner -stable/LTS picks up the fix, so that we don't have same
regression reports in the future. The regression in question is
pretty hard to track down, git-bisect, perhaps, is the only reasonably
fast way.

	-ss
