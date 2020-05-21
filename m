Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB8CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 04:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BDBB2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 04:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hifECBLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgEUEcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 00:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgEUEcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 00:32:14 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6283EC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 21:32:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f4so2514822pgi.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 21:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=giyDZYsddXSLGh0PmNhF6czurjr/9oMLKVT7TwPE9rk=;
        b=hifECBLBaMj3032ovwzd6ETRWcP8zXJ9m0vOgUPqo7KH+SQdyNKYCH3Rdav8W+/HeQ
         i0DDwnSnacUgylo0zWlnEC3Uo5FwtTCK2yqEwuvma8/S0bxLIjpji/3Iat2EN7usThHY
         KGLXpPpYFd3WVkKwwTo4x+X0McNteYH2NKywKHBMyr/PD7t/NUtVDNNComrUwusYNnC6
         QeME+duaPCiYbsqp8+65DY2ufAS9eiB7xvH5IgJrmv7LvNqQjmGkLpm0N4/DVbeSqxHN
         8pnjZ4F8+vDo8picSFa5Knd8n2LNq4Ro+nC15xXeYNmM9HPE1NylAECyDgu4CzhM1Cjn
         6tVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=giyDZYsddXSLGh0PmNhF6czurjr/9oMLKVT7TwPE9rk=;
        b=Jd5aSQGqWyK+J34/44b+FvZ1jVKu4f+qKcMa7WTZCCLHeAkgpPQ8wD1yy4ZrsGHHtJ
         t720TRs9Rhnq7Cp6dWPofOqpKeXRRW2yX5Dw1er9HJ3Tc9J+4syA58JecSMAamKIOE/3
         8iSCGWYT0i3Ak0iXtOdEa7Q7EztRagMQUwEplVVan85Ergidt0xB8QguksojzCzgkEJ0
         /eHlDVps1hZ9g2dl3IoBacDiXpE3H9M7sRIwhYWGVCKLzOFXRhJs8T+oV0bffs/y0jn7
         9AZgOe1ttrXjAwCtbZFgcdZFxjZWc1ci+yycHVZCRDqv7h5Of+GY87oaTJgWb8lD2oCh
         cB6g==
X-Gm-Message-State: AOAM532MF1AbW/L3KgrVe5mnCfewfU6pMqBhi+WK1xHXQyCnj+Q/D+WY
        0gu4MUaYJOvYrCBKQx8bgZdGGKfQ
X-Google-Smtp-Source: ABdhPJywTihiyhaiAJZn6B8Ew+N0DDUzTBCwcHtuOisVx+xI6xMuINEbM18E3jA8pIrHtdUkiZSsiQ==
X-Received: by 2002:a63:b64e:: with SMTP id v14mr7344574pgt.164.1590035532794;
        Wed, 20 May 2020 21:32:12 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id h17sm3374947pfr.25.2020.05.20.21.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 21:32:12 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 21 May 2020 13:32:09 +0900
To:     Joe Perches <joe@perches.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
Message-ID: <20200521043209.GA755@jagdpanzerIV.localdomain>
References: <cover.1589916689.git.joe@perches.com>
 <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
 <20200520044127.GB938@jagdpanzerIV.localdomain>
 <ae3aff79301c130aa15b3fe0ff801804bb019384.camel@perches.com>
 <20200520121000.GF520@jagdpanzerIV.localdomain>
 <19a8c717f8d9dc76f2b09e6dd19f3fbb71bf29c5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19a8c717f8d9dc76f2b09e6dd19f3fbb71bf29c5.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/20 13:36), Joe Perches wrote:
> > We can split command line in a loop - memchr(pos, ' ') - and
> > pr_cont() parts of the command line. pr_cont() has overflow
> > control and it flushes cont buffer before it overflows, so
> > we should not lose anything.
> 
> It doesn't matter much here, but I believe
> there's an 8k max buffer for pr_cont output.
> 
> include/linux/printk.h:#define CONSOLE_EXT_LOG_MAX      8192

This is for extended payload - the key:value dictionaries
which device core appends to normal printk() messages. We
don't have that many consoles that handle extended output
(netcon and, maybe, a few more).

	-ss
