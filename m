Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A11C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7012469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY9Esepc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgB1BPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 20:15:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45159 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730148AbgB1BPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 20:15:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id m15so584889pgv.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 17:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O+5GIeJyL2gtlOdW0SKFFjMgLBOt56yNEFcuq5D5UzE=;
        b=jY9EsepciEE4B8pAidHluOcxIEhSCAXUIBSt6qRZFxeqDGXCUoIr13RJBMnRAAdYFU
         OTzX0Qt8vhxnkP25dbdNiwrw6jB3XiBiDXH1oHUKNbTnJv8ZIByXB5Hgp53CmH+UjpUN
         lEpHBfwOj9kBwa2NA+xxBYbvQveMixCrnh6nSH1G07W1mh7TzIMvjUdiRp/t42ODzIuk
         LYNzh0X2xhhhr1eEgqgoN/5fkfMoP5s+0mU2z45063hUG8pQ9+ZmMnpZlJVFHwA3SdeC
         0arsbXavbl6dIx2URE4wyEcwGCRQa83+Qw1qpw/RcDYM+x8lJzla5i+yUMfef+IoFNSX
         L8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O+5GIeJyL2gtlOdW0SKFFjMgLBOt56yNEFcuq5D5UzE=;
        b=VSYcRCm+yliO9yW0oH0Yfr1APQqrp3XxjX9vDEV1lIADfq2l8wq8uhzcupa4RttSa9
         iOTcIM2ZpE25Qkbbap7rUteA90L1Kdjq/7YjVSz4HpssLwYXI7ArH71G1KNG4+nvBAUh
         LhddULuMAj8bQM1UoGN5Lz4lv6xNNDjPJsMtDn15+4EnLE1pn/6N6+d6s0VH0rqQ0G24
         oPrDnXinXMZBJOe4Aa5oGYWJJaV0aC77Rkwns145M7tuqz7L/ofNbKJ8gInR5z3nVCgk
         A3jYy4psQhacsBdg0k3LnKhcxzIKobUpSbK/AT/Dz2KcWRAiTN1sAAy1Zt0Nf6+hLlUM
         tuIw==
X-Gm-Message-State: APjAAAV0s0p5ZM54mkCyyCpYsyTSUOXOI93yslyALHURO/qxwECzbepw
        bavWSQ/iwSIl0Lytu9E++g8=
X-Google-Smtp-Source: APXvYqwZJCvojPpJrNRSIlw2yYYhDpsAp7mwOkbZ5QS8xdTQnVl5HAC7s5NvgxvC1i+9713cdP5uzA==
X-Received: by 2002:a63:f84b:: with SMTP id v11mr2008402pgj.133.1582852506037;
        Thu, 27 Feb 2020 17:15:06 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id b4sm8816963pfd.18.2020.02.27.17.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 17:15:05 -0800 (PST)
Date:   Fri, 28 Feb 2020 10:15:03 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH v1] lib/vsprintf: update comment about
 simple_strto<foo>() functions
Message-ID: <20200228011503.GJ122464@google.com>
References: <20200221085723.42469-1-andriy.shevchenko@linux.intel.com>
 <20200221145141.pchim24oht7nxfir@pengutronix.de>
 <CAHp75VfR+X6Mw8ywKNW5mTomzmuHSM8ecQUhxtM=LUkWaSe9CA@mail.gmail.com>
 <20200221163334.w7pocmbbw4ymimlc@pengutronix.de>
 <d6c3b369-9777-9986-f41f-3f3a4f85d64c@rasmusvillemoes.dk>
 <20200227131428.5nhvslwdmocv6fkb@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227131428.5nhvslwdmocv6fkb@pathway.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/27 14:14), Petr Mladek wrote:
> 
> Is still anyone against the original patch updating the comments in
> vsprintf.c. Otherwise, I would queue it for 5.7.
> 

+1

	-ss
