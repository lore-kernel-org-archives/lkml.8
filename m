Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1D1C35249
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 01:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17702084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 01:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQ783VNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgBDBe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 20:34:29 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33907 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgBDBe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 20:34:29 -0500
Received: by mail-pj1-f66.google.com with SMTP id f2so368791pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 17:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4WBTaHmj0lic5OuL1hJx9NATNMcQcvwr1hm/AfOlI2o=;
        b=oQ783VNGm7P+CZRfLlr60B7rLQSmwzge5tymoPBE0BlzaMuPf7yQFuGQsRrlp5nnnB
         k+wNb3+NNwBA7uhv2lnSVusQTEFe35JE0Nstss/IKfgk8bQluFRBZg3EmZgwPfe1MMSH
         0hLbh4z4X3aBPZ1uVwOHUXYqZHpMf86sK9mcs/Q2rIN+Wwf5i4mCvipVdElrDS8gMGNR
         hxKxpXp4njeGLqP7zqgip99Fni4INwtTGfDM/EKEHslnNMz+jdt5XG7UgdHS2ad9eE9j
         g6s30orJIQZqBBQX1TJ8pFfWHzzHX8M7nK+1cmjWwifTQf1UrYsSotjUd0+Fj0WYPAlq
         wuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4WBTaHmj0lic5OuL1hJx9NATNMcQcvwr1hm/AfOlI2o=;
        b=eYqeSzA3hVrFV0hcM/+g9nBGf4zKaA8nVNw1NRJcwJ7ObMNuwebZN0Im55BkG84F+K
         sfFx16Ko7fBZ4Zn0p4jAvxFvFN3EgEGcd0pTLU2hyG6LrlMZGZ5UA81P3ssvG8CmyHYN
         u3ANUEsu4Dy1HwYdh5lXcKlfj8+3p3x1LnOQMqj+t30UjjkbAPOyq0znNK5PRL3dPW+8
         7JAghoLQsfUQo2tPw4CJC00keq8javNsaeT1noqf3h5KPe/5lgUNkcLvxw1AkD1l1+iG
         bxx0B15GT1kcqLHeZAPj63kBOudx+ipsDPGOuqA0j+8r2q6FnpYmthHdaUFG19AQ6qBk
         16+w==
X-Gm-Message-State: APjAAAVerGkXiF4Kk9aaT2w7aGNV1FfsMgsI9/uJ1ASjXxaAzoWoTNdX
        L56wUO1YjrTHN07DTM9Wnr9XlRCX
X-Google-Smtp-Source: APXvYqyKd6xSDsc64CCNTz6VrjURWCNz9knfsKTPVE1AZrCnvfKK/aYIQ5RZUsbaeie/KLX6EqFaJQ==
X-Received: by 2002:a17:90a:fe02:: with SMTP id ck2mr2640199pjb.10.1580780068752;
        Mon, 03 Feb 2020 17:34:28 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id v10sm20984451pgk.24.2020.02.03.17.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 17:34:28 -0800 (PST)
Date:   Tue, 4 Feb 2020 10:34:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5 1/7] console: Don't perform test for CON_BRL flag
Message-ID: <20200204013426.GB41358@google.com>
References: <20200203133130.11591-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203133130.11591-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/03 15:31), Andy Shevchenko wrote:
> 
> We don't call braille_register_console() without CON_BRL flag set.
> And the _braille_unregister_console() already tests for console to have
> CON_BRL flag. No need to repeat this in braille_unregister_console().
> 
> Drop the repetitive checks from Braille console driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Looks good to me overall

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
