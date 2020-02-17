Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340BAC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0765320578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USK84gRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgBQNDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:03:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35966 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgBQNDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:03:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so8861058pfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 05:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fWZH+6YrPRkMGfbfqWKUBa/nvmNwL5/tpZkf81djjwU=;
        b=USK84gRojiXLsBtSaVFO2lgNbukZpelPMdU02WXZUUET51hu09uNq86FXgqJnNBKg3
         PcCfJ2qLj8tW5z8iD9I/cc9CZZImdt2er9lqFbN3ntE93iWak3aGQXtI9QyhaUbqBoE2
         WcQNCsyy5MPl8OYAONSDon1mSyhiAgK+CfvQ/njrXZRhqjhC9DhS7b/lDa/jbXcpFmfG
         lN/Axlx6NiuKqF5Cbq8CPAANU8cb+gRl5ZAT6Vx0ay3/KU/gbGJGlsCBnI2aPPAFs901
         GJBePWcbeXQhy4ppTTjt3/0AYsMYja/g3khc83cv+4QIvFUEN8pXmRo6FjaC5B/N+Kb/
         whOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fWZH+6YrPRkMGfbfqWKUBa/nvmNwL5/tpZkf81djjwU=;
        b=rxt9t/Tz8ImjzB1EOe0ZeM7BCoUL4fM51tmwSVvdAScmanZpn/qUWBGmbpDcPvwGJF
         USF49Db9P3mCYqEvYoKpJR5vzjXIcr3kvZllp3QXhftTYs3tPN+mHIcxIYvCqWeETw2H
         g2/JGeyVy5ugfueOtOJ68LDjve2+viROTW47qcTrj1HDGccsm9r5ZIpg/eQeF+fgDdcJ
         gE7lEMFyByJJP3FjLhq5SaQjqwopOJMbUnHivYyMALjNzx02TqD2uMkhxTrpe6RLT6Ue
         15P+ksB6l0wY9bT2Xt++R6MjugERpyYxPVumXibShiR1JcL2Yasyh2F0KntFK1oD9RCt
         m6ug==
X-Gm-Message-State: APjAAAU+jwOtCUHwsBXshcsIPX9aaXrXZ7p98UtzZAo+cuxa+z/VjFBw
        OYHaZY2A2clMocoRvb5mPA4m0RqS
X-Google-Smtp-Source: APXvYqwN0F4W6ydOVVq1HwX993F16H2p2YXsP8Eg6jQ5B7DzM1BPrxfkkboja/8P+rcHeLCjCGo0YA==
X-Received: by 2002:a17:90a:bd01:: with SMTP id y1mr19647415pjr.129.1581944592476;
        Mon, 17 Feb 2020 05:03:12 -0800 (PST)
Received: from localhost (167.117.30.125.dy.iij4u.or.jp. [125.30.117.167])
        by smtp.gmail.com with ESMTPSA id e9sm578703pjt.16.2020.02.17.05.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:03:11 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 17 Feb 2020 22:03:08 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] printk/console: Fix preferred console handling
Message-ID: <20200217130308.GA447@jagdpanzerIV.localdomain>
References: <20200213095133.23176-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213095133.23176-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/13 10:51), Petr Mladek wrote:
> Hi,
> 
> I send this on behalf of Benjamin who is traveling at the moment.
> It is an interesting approach to long terms problems with matching
> the console preferred on the command line.
> 
> Changes against v3:
> 
> 	+ better check when accepting pre-enabled consoles
> 	+ correct reasoning in the 3rd patch
> 	+ update a comment of CON_CONSDEV definition
> 	+ fixed checkpatch warnings

Looks good to me,

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
