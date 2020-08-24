Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D707EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 05:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A92CB2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 05:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyXGABs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgHXFhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 01:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgHXFhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 01:37:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4CCC061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 22:37:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id n3so2709355pjq.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 22:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VTbspYLWEm5A7CDSAhaKSzWJDq2Y3rS2DPVET/55CrM=;
        b=HyXGABs59Hi6a04xgBiFgN7Enkzv/x4dXM+VkqV0/fHObKOMiSv4CGAu3/RzSo9epx
         xaUYunnERG7+/+1luuipmrsiwfiKDJ+YBliXZK3o7ASoIKH67qxm7wSodxTq2h3lFsst
         XrBJIuRe/k2Cu01rI6AR0bjBeTvYcEB1gp9qib5BAVIxMtMGl1M0VLyNxKQjRQBN+ur3
         BQAcr/K0lqq1VPZZLa+XJcs6Cc9i37sqvx7h/j/jlSBPcNA/BpwbkvI/qDTrYIY9bWjA
         Hvf91+p5sJKsOhdismkS1AZk2dYJ8uAy8+5w7eEJuGn3ypWAItNTRQzoLYzOBh0l96r6
         iacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VTbspYLWEm5A7CDSAhaKSzWJDq2Y3rS2DPVET/55CrM=;
        b=IhFlstXcEvU+SJQ53hwmh2o7vOi/KdQDI3yX//eiC9yCNoWdncAXQBEFh1lniAVleV
         sBR+t4yaqip7x/GCoCsExrGZV1KYMcB1RpufITiwsD7leu3Sref/snXHctIOcc6bFPmN
         quc0hG6FPLcoUhlpVtZt/14lOkv60ngC++EVwMhpVM3XSISkLNwApCqnWJP5O8rXACNr
         lw+MHGXyBvozCPzmQ1CB2M1lbtuBOB4usF+4eBO87NEZdZd/etpprNi5tX/1Gpyqwbxs
         UVLSM9oKwOAgSMix5H0d97PtLOfZFUGN74OQPcTKxMLMd5JJhvZz5eIR53gOhh91Nk88
         tkGg==
X-Gm-Message-State: AOAM533cg8IrwPr3iFXMaTULO4zydIG8fSqbR9C//QOxl1Twb0WoPIfF
        9WZZJoNX5ndyVrRF4aRRolk=
X-Google-Smtp-Source: ABdhPJw0E1Leu7m0BVn7We5vU8ax5JeFo1xKpABa9IZ7kd1gr5DyNONWHsX16cZKWY+VrgbfBsVEww==
X-Received: by 2002:a17:902:9a90:: with SMTP id w16mr2647842plp.181.1598247423252;
        Sun, 23 Aug 2020 22:37:03 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id x15sm10240444pfr.208.2020.08.23.22.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 22:37:02 -0700 (PDT)
Date:   Mon, 24 Aug 2020 14:37:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] printk: implement pr_cont_t
Message-ID: <20200824053700.GB567@jagdpanzerIV.localdomain>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
 <20200819232632.13418-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819232632.13418-2-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/08/20 01:32), John Ogness wrote:
> +#define CONT_LINE_MAX LOG_LINE_MAX
> +#define CONT_BUF_COUNT 10
> +static char cont_buf[CONT_BUF_COUNT][CONT_LINE_MAX];
> +static DECLARE_BITMAP(cont_buf_map, CONT_BUF_COUNT);
> +
> +static int get_cont_buf(void)
> +{
> +	int bit;
> +
> +	do {
> +		bit = find_first_zero_bit(cont_buf_map, CONT_BUF_COUNT);
> +		if (bit == CONT_BUF_COUNT)
> +			break;
> +	} while (test_and_set_bit(bit, cont_buf_map));
> +
> +	return bit;
> +}
> +static void put_cont_buf(int index)
> +{
> +	if (WARN_ON(index >= CONT_BUF_COUNT))
> +		return;
> +	if (WARN_ON(!test_bit(index, cont_buf_map)))
> +		return;

Doesn't WARN_ON() do pr_cont() print outs as well? I'm a bit worried by
the path that re-enters pr_cont() from "broken" pr_cont() path.

Just ideas, to keep the discussion alive:

Overall, I wonder if pr_cont buffers should hold more info, e.g. owner
context. If the same context does "normal" printk() while still owning
the unfinished cont buffer then we should flush cont buffer. I may be
in minority here, I don't see a very strong reason to keep the global
order of the messages - e.g. if pid 234 does printk on CPU1 then we
probably don't need to flush pid's 8889 cont buffer (which runs on CPU42,
for instance), but keeping the order of the messages within the context
is somehow much more important. That is, if pid 8889 starts pr_cont buffer
and then triggers a pr_warn() or pr_alert() or any other printk() then I
think we need to flush the cont buffer. Just 5 cents.

	-ss
