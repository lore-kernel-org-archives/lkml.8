Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F8FC33CB7
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 01:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A0B2063A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 01:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flKXuCvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgBABIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 20:08:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44702 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgBABII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 20:08:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so4474508pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 17:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tOdD7sEFO/Cm1Az2WTVTh+0ICXmcDk9hUOt8MhdrW3g=;
        b=flKXuCvOe0TKMKlJgp5elm6wrxTqWzNK1ADjY2qsAvDIOUMYnGIBJM6CNcQYzweZ7S
         gqGvTDrLWNFZ1jUzO3Q7HfbO3cKdufyj02+JwDh0MNAi6kHN3edQk8MEcxOq/ehpGtJ3
         lR6d77hdMaO3StZvriz/4vAdxze4OnS+MiGbWBUXqY3NJD/MN9OQxQ0MLkqD7VFHNAzz
         HTNz1+b9iAr0j7T24Wiv/nvFWTgl6RfdEZIbdntqL0XhO1d2FpfXkKP+yb74YOvbN7Q2
         Xz7sjXgyG6FdVb/HawpqICouMPfZOc0+/dviJo1gU+WxKPKGmcDi5QKsczdWRzwcqXV4
         NJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tOdD7sEFO/Cm1Az2WTVTh+0ICXmcDk9hUOt8MhdrW3g=;
        b=S3Y2Vxg5t7BYaraLrGC6JUvr/aiBeHf4YV7wlX+2pKOsKzH/RpzBnSwySYYf1azNcf
         d4R4611rhd8MH9KAr0HtbSKGweLI1ffSfhoSaSF5SXiaFscWEtNwV4gzJvt5jB3dhzcH
         yAMv8Hvdrx4Ob4rgU6GSJpLSS9PstlsTelAIOOvQEYNGmMZyZ04tLNUOlrJuFUjxwrhe
         LPBlDqkV0d8CRlHtDbaqSes1cpO5G7Hr4Ek3E3lTA0kfCdgwgMVB+rGKhd4B1phLrGaP
         dpRthyneZXKVpdbpBM7DcxDOvLNgyatF54KyWrOgHX12KFxI0fwIMXIoRbqEzZqUQG9E
         BYUA==
X-Gm-Message-State: APjAAAUIqcnxW1pwqmGgHNkx5EghA5mYKP5vc8rg+0kYtRzocMRu7tBD
        1D0nVC7vQ1jTcvz162dMgOY=
X-Google-Smtp-Source: APXvYqwJaA/CeAPva6qGN2HiTlf5T+eK9r+4wdYl3huDpKyxMF1+1b5jliuG6FrGJCO4BQffvZvINw==
X-Received: by 2002:a63:ea4b:: with SMTP id l11mr12851871pgk.357.1580519288066;
        Fri, 31 Jan 2020 17:08:08 -0800 (PST)
Received: from localhost (167.117.30.125.dy.iij4u.or.jp. [125.30.117.167])
        by smtp.gmail.com with ESMTPSA id z18sm11950481pfk.19.2020.01.31.17.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 17:08:07 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 1 Feb 2020 10:08:04 +0900
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] console: Introduce ->exit() callback
Message-ID: <20200201010804.GB1352@jagdpanzerIV.localdomain>
References: <20200130152558.51839-1-andriy.shevchenko@linux.intel.com>
 <20200130152558.51839-5-andriy.shevchenko@linux.intel.com>
 <20200131013154.GH115889@google.com>
 <20200131112724.GM32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131112724.GM32742@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/31 13:27), Andy Shevchenko wrote:
[..]
> > 
> > I would probably push it a bit further (I posted this snippet in another
> > thread). If console is not on the list then there is nothing for us to do
> > and sysfs notify is pointless.
> 
> I didn't see post in the other thread, but I suppose that this snipped is
> for patch 4 in the series, correct?

No worries! Yes, for v4.

[..]
> > -	if (!res && console->exit)
> > +	if (console->exit)
> 
> >  		console->exit(console);
> >  
> >  	return res;
> 
> ...then something like
> 
> 		return console->exit(console);
> 
> 	return 0;
> 
> ...or...
> 
> 		res = console->exit(console);
> 
> Which one is preferable?

I don't really have preferences here, so up to you guys.

	-ss
