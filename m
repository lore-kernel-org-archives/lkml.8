Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D3DC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5367720678
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="W+mtMBsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgAUK1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:27:40 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34017 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgAUK1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:27:40 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so1852910lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 02:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SMMEyvcnG2pHD47DYznHA3pzNWYIWShQugit/uStDZ4=;
        b=W+mtMBsPULmyhpTjqsmmsHWep5n8rZ+yDCZYhIdCuQ4wN5tk3y8wKVFcofU+NxY4/F
         P/Uq11AtX8gIEsOki4qun8WXyufwSyQyXSvxh6WHGNGe+BuaON+UV5LpaF/161O+8X+P
         vkh4fekf9Era9GYaVTJ7VNd/gg0D3jlD5sGMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SMMEyvcnG2pHD47DYznHA3pzNWYIWShQugit/uStDZ4=;
        b=kLVkZ36ZoQ4G5kGDGTZeP5Z2g0rUDrX9Ic3a8qJrMWhNnEou5UxLsOmOsnK4rL5glJ
         zET+S6HFPsLzuMpGesN4pEoEk67SAClUBT7nzi+blLOPde6x/JMLwPlpAQ6KPuEMYXCB
         wphBSytteUOg/veubG/Mpz8mS+JEM4LRPx70NIMfA2NlzjTZijNePSIJ7Mb/Ui0dZq5B
         1KPXLCOPU0t+dnaiZK9i52wksz4ZuiqYRs9kGInBT3xsrGMCqEWNsOaoIhlsa5NjNVOa
         +57GWqKvgt47iboW7wah60BiAsSxfp1oYWsh01nT3YjiWVx9ieZJKEBf5qPP5gBydFob
         0Tyw==
X-Gm-Message-State: APjAAAWCKiT1lg2dIOpAvXCB+Xwc0Cr4FxB8N9P9V/FECQ8h/d8YstSJ
        iTXN8ZMPGhwxcqPFmEBWazQlKQ==
X-Google-Smtp-Source: APXvYqw8UA1rEjZLDAkIU+mKRQkrGHqdT0Xd8lU1o38AWPs+rMj77qBWNAmOxCQFBtwXwuAErulNcw==
X-Received: by 2002:ac2:43af:: with SMTP id t15mr2390891lfl.154.1579602455818;
        Tue, 21 Jan 2020 02:27:35 -0800 (PST)
Received: from [172.16.11.50] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y29sm18199445ljd.88.2020.01.21.02.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 02:27:35 -0800 (PST)
Subject: Re: [PATCH 0/2] printf: add support for %de
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
References: <20200120085508.25522-1-u.kleine-koenig@pengutronix.de>
 <CAHp75Vei9_xqxiiAWBrcMp3yOWmMNmdRmNEwO=Ht+URsnoD4Pw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f039631b-8a90-48fc-c80f-1160628469a9@rasmusvillemoes.dk>
Date:   Tue, 21 Jan 2020 11:27:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHp75Vei9_xqxiiAWBrcMp3yOWmMNmdRmNEwO=Ht+URsnoD4Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2020 10.32, Andy Shevchenko wrote:
> On Mon, Jan 20, 2020 at 10:57 AM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> 
>> this is an reiteration of my patch from some time ago that introduced
>> %dE with the same semantic. Back then this resulted in the support for
>> %pe which was less contentious.
>>
> 
>> I still consider %de (now with a small 'e' to match %pe) useful.
> 
> Please, don't spread the extensions over the standard specifiers. The
> %p* extensions are enough for my opinion.
> NAK.
> 

As I think I already mentioned (and what led me to do the %pe), I'm with
Andy and Joe here, I don't think modifying the behaviour of stuff other
than %p is a good idea - especially not when it's only about saving a
few characters to avoid the ERR_PTR() wrapping.

Rasmus
