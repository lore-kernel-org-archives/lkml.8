Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29737C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E996424686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snQkQloV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgA1J0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:26:01 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:40427 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgA1J0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 04:26:00 -0500
Received: by mail-pf1-f182.google.com with SMTP id q8so6320295pfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 01:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pI2FaxZxfMgvAjpHH70HxA2BLNDvcKHeNnWfplF3/f4=;
        b=snQkQloVebSLjGU/YXBhGzPG5LnFdLUrZ6d/buzRrvwsfGMxMwMmSD1FDBzkUA5uL3
         12cAt8iMU8JcINxWjqmTOZz3I1kP69JK5jNQbhQiwEBs0W0b+IzrvbjTYA3L2WqFonYP
         d5b+ENxEMl99gSSArop04JBGAQ7HdPIG8qPkcLSWeEbP0zwMNBcOcUNeKHSWZlfE95tQ
         I6ThcPXrE91ZXYJvO/xIipkI/S+2nwaPUr1FpL4zizFVO4gpgdiN7iluy33ZZszqdRn7
         yq0vQI11qnAbjTu8+9+U+SLl48MXX39f3TgagSuQTsaE526GBtQUXHcoLGIsTZe3nt6D
         rrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pI2FaxZxfMgvAjpHH70HxA2BLNDvcKHeNnWfplF3/f4=;
        b=qAMaaMHCJ1uw5NU8m93AYAGl4LZkbYcxqzgYrC6wUAiZwcDgWK5vGFe57EC0AEOK2q
         vDwRxI1rXdoQ0VTVf/nn6B9IYLCrOK4Cr9qgvFC19JKihalFcPBH6gEGvZzT0DIf3AW1
         eeG1DrDa62xBpAhges8d/GbF6f9cp1ncW0IWpJKeQA+OUYvu6RP0IJIBG9uBl71fXaPX
         NAS4cUmfHsgj6k+3C4A/FbwdiSK3sdgBlKH4LtxqX3nzBj84secK+ux6gcEuzS4LwxOP
         jSZluqxQsu0gthUOTYr81HsVMjpZ1MSD/Yc8bMwclskJ/8wl4Xgdmv6AsdAKsbPbKTuv
         8BDQ==
X-Gm-Message-State: APjAAAXC8fetz58qPKQzSs6tsrD7GoMY7lXXn/ISw5g7H/4TfRPHhexY
        0VfLmlBGFpvthvMJCTg/v3Q=
X-Google-Smtp-Source: APXvYqziQH9rbicB1k5YzkLoq9jbUTfkV1rDV0gL67buxnZulnw6F/JE8K5asv7JWcQL4BX+WI/HAg==
X-Received: by 2002:aa7:8007:: with SMTP id j7mr3013905pfi.71.1580203559991;
        Tue, 28 Jan 2020 01:25:59 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id h126sm19024978pfe.19.2020.01.28.01.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 01:25:59 -0800 (PST)
Date:   Tue, 28 Jan 2020 18:25:57 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] console: Avoid positive return code from
 unregister_console()
Message-ID: <20200128092557.GD115889@google.com>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-4-andriy.shevchenko@linux.intel.com>
 <20200128044332.GA115889@google.com>
 <20200128092235.GX32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128092235.GX32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/28 11:22), Andy Shevchenko wrote:
[..]
> > Console is not on the console_drivers list. Why does !ENABLED case
> > require extra handling?
> 
> It's mirroring (to some extend) the register_console() abort conditions.
> 
> > What about the case when console is ENABLED
> > but still not registered?
> 
> What about when console is ENABLED and we call register_console()?

I think that ENABLED bit makes sense only when console is on the list.
Otherwise, I suspect, nothing will be able to access the console.

	-ss
