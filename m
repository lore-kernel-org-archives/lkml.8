Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68513C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EFE20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwV/TR6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgA2Nlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:41:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40611 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgA2Nlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:41:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id k25so8859179pgt.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 05:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0tZE62WBzPWCSIO5A3zukAMo2WVPPoketIRy1ieABu8=;
        b=mwV/TR6xO8fH/ulTLzvgHMwGo0zuZ0q/PxyqEdXlx+ZEswhJHmrAMqY2p2PCfIzDVZ
         Txh/AVntcSf06xgPQEuu518CXbpg7jaVNfnxGikTaqeWwHwit7D1knJss22B+RyBCai9
         SRrQgc08ZpsyYQSMeglr1KwD5K7wMXYiutK4rXkhDcPyzOYlHp+jdO40503uaN6/T1Xu
         XnqUlLl4bit/RVcpG/Pjknbc/zZQmzVbGxP0WmTRWhekgGWz0w+lvnLWAPfe+gSDzt9p
         DXSMLQzWnr8gUye/vw7WuLxd8OLHhMu08uBvHjsJoStXQhfj+y1TgJWotaOPB2ezPk9M
         ipYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0tZE62WBzPWCSIO5A3zukAMo2WVPPoketIRy1ieABu8=;
        b=tzKgAbIEI8BcmWx2sYMnHxxPQUoazfwuXFY4y6hYL8i2vPWjJ/+t3wZ/9orczMBb7P
         /wW3KF+XD64NYapyx3FtKxg1nAUqkndvnZcjzqCd1zhO/t4YNFXx/Ay8L5eWjk/VHAUC
         ktsWYJQZ1OA4eZ7T9Y925r+GCXGpvM9lBsHFHvRN6Jukkw/wKac53djZt9cAOlB8lckg
         hYibj62H9fhZhJfh0UavskJDxEuR8+xdbqT6GZZjUlAOwZKtpU0wded0ghruq94v49Dm
         pOUAafj644RPj2632H8oOl5m9G1rLWVlJ/lz59SjMyBg4zSM9OSdn3jhTUW/LrYM+TIu
         DcBg==
X-Gm-Message-State: APjAAAXsp1xdNDHqklO0ICAN6IaPDXQ282mxek+QFRAz6SQGkaZUA+P5
        1oIUkfLHTqUS7kk5wXY7AcE=
X-Google-Smtp-Source: APXvYqyedOV1C/HDAoJ5wfFVOKZ7vM1pfDk7tN985jqgo5uyCIbSGphol1Hxima4ZAdGxJl4qwVpWQ==
X-Received: by 2002:a65:6842:: with SMTP id q2mr31396668pgt.345.1580305305515;
        Wed, 29 Jan 2020 05:41:45 -0800 (PST)
Received: from localhost (167.117.30.125.dy.iij4u.or.jp. [125.30.117.167])
        by smtp.gmail.com with ESMTPSA id u3sm2786107pjv.32.2020.01.29.05.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 05:41:44 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 29 Jan 2020 22:41:41 +0900
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] console: Introduce ->exit() callback
Message-ID: <20200129134141.GA537@jagdpanzerIV.localdomain>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-5-andriy.shevchenko@linux.intel.com>
 <20200128051711.GB115889@google.com>
 <20200128094418.GY32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128094418.GY32742@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/28 11:44), Andy Shevchenko wrote:
> > If the console was not registered (hence not enabled) is it still required
> > to call ->exit()? Is there a requirement that ->exit() should handle such
> > cases?
> 
> This is a good point. The ->exit() purpose is to keep balance for whatever
> happened at ->setup().
> 
> But ->setup() is being called either when we have has_preferred == false or
> when we got no matching we call it for all such consoles, till it returns an
> error (can you elaborate the logic behind it?).

->match() does alias matching and ->setup(). If alias matching failed,
exact name match takes place. We don't call ->setup() for all consoles,
but only for those that have exact name match:

	if (strcmp(c->name, newcon->name) != 0)
		continue;

As to why we don't stop sooner in that loop - I need to to do some
archaeology. We need to have CON_CONSDEV at proper place, which is
IIRC the last matching console.

Pretty much every time we tried to change the logic we ended up
reverting the changes.

> In both cases we will get the console to have CON_ENABLED flag set.

And there are sneaky consoles that have CON_ENABLED before we even
register them.

	-ss
