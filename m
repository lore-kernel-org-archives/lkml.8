Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7083C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC8E20726
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4cEmg0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgCCHZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:25:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41175 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgCCHZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:25:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id j9so1009793pfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 23:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=87hB7A48w6ZPL5vlh3XXx7v/HdijujfroRa3zZA6PTg=;
        b=F4cEmg0p+pH3r+ECnP2J5qwqoh94V9GbqA8chkXtNf3XsvMXqi1fta9JMBcQt98oT9
         riwy6FKiteE8jeug8NeFdx0sXotVW5oe0YVrexPzhQHco4OHQjhjShXUunB+MpcI/uTe
         YHVj6du0eWJG9URPJS8Lmc2gT9D5B72ZWpbglmcUCS8T6XALw6vupu5jdd/ObtUgir96
         VM5zziwazF5GbGkkj1nO53rUK7mBowBR1h7GnTjfDbVMlh1rTIl8EokWuKFnTmE3r0cd
         J+gsV6C2stD98bvQXQ8WZomFbhLamB14iug48KRvVrqRU2as6mW560ZG6m62mXyjr4cU
         WyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=87hB7A48w6ZPL5vlh3XXx7v/HdijujfroRa3zZA6PTg=;
        b=IeD905LgUM4caxyx557k2O79VLV7f4jrGs2qYFm7gEHHmd0vXcedzaXe7KL9NBicH6
         TEdT66/AKvL/XZQmyRTIOAdm3YOgojGr1Qqz0Pndz/IP5fDCzZPBjU0k9fXUpeLk0OkH
         R3t7RuOaQYtvaeYB7UuIzsPtS2if1VzvTmG5n8GBCJDOKQO71OGCf9HyJk1zAIMlkVjt
         NuMmbiRhNXJOhS7ytCLU/DjKB9STfPhOdkAreuMkRFzao8ciOYhh/JTAc8TvcJQUs2Kq
         04rkmSIQHu5VkOkp3OUvVmpqosNyltjVSdtkQZYa2TBhG9aLl8fSC5DeYrVppjJrymae
         db+Q==
X-Gm-Message-State: ANhLgQ3b0Z591XP5qf0X1g5EAOop56P9yyL6qQ81nPzfjsKUgpN9FFb+
        aaR+J4qDRFJu9XjSWa6N6UFKUm84
X-Google-Smtp-Source: ADFU+vs8acFS4UWINjK6tNZkcDnwRkoBHOSmNR1KMgWKe5IidZKcPqznYOJg8egW2DRbqP+GTQlTQA==
X-Received: by 2002:a63:257:: with SMTP id 84mr2769387pgc.304.1583220300675;
        Mon, 02 Mar 2020 23:25:00 -0800 (PST)
Received: from localhost (167.117.30.125.dy.iij4u.or.jp. [125.30.117.167])
        by smtp.gmail.com with ESMTPSA id m128sm23999659pfm.183.2020.03.02.23.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 23:24:59 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 3 Mar 2020 16:24:56 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH 0/3] lib/test_printf: Clean up basic pointer testing
Message-ID: <20200303072456.GA904@jagdpanzerIV.localdomain>
References: <20200227130123.32442-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227130123.32442-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/27 14:01), Petr Mladek wrote:
> 
> The discussion about hashing NULL pointer value[1] uncovered that
> the basic tests of pointer formatting do not follow the original
> structure and cause confusion.

FWIW, overall looks good to me.

> I feel responsible for it and here is a proposed clean up.

Extra points!

	-ss
