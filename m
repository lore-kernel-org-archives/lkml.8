Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD37C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A115C2074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QskeIAbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgGINWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgGINWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:22:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD2DC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 06:22:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k5so1101500pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QXLrUMHB0nCEwvB1Ac392tWUxQyyKOk9dkQPn+DmJ1w=;
        b=QskeIAbBk/ESXbQrUJ3ZV1ckuVRN6E+X+ciJnrGSYoXB/TRM97t6bycljABVXYuPtg
         xj21VnWypO/cVRG3n1/nQfa6rjczqiqY3xD9aZd0PaXMIhMXoLw6MlhLcSNm2VLgf2sH
         YU1em6aD5yC4Ww5MabwWAqQbfy6oW87/Zyls0q6i2m2+mOGWcy29l/TCFVGyR+ADCt9C
         huYfy8iKlPLyyGplZ5AVYnNA8ZvK50lTsNIasrCKAUJUcj5zW/FlH9gmYqvmr09hvzfX
         r8uNDkdM72H3njSVuySbBNGIkeqYd1DXG/n5JCD3sbGGIrKJHCAUNqTHfeZKSd3TMhEG
         LjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QXLrUMHB0nCEwvB1Ac392tWUxQyyKOk9dkQPn+DmJ1w=;
        b=cF2GZWfVR9wSj5a6oAjYigNL7G2h2avBIZfN167sYHN0YmlgcNLG6BRResRLpX9ffU
         U96Ot0Q75YrhXB5oH5+7XwvffZe1qtn9Jq5FntIFzcopyWw1RY3RxHnYn4gZJZ7YS9WX
         zDBmsGRSTOSJC+XwzwRDi6zxcDd3Qf4JNL5ov1bliSo9hmVGUKNFj7/D/oEyNxVDn028
         l4PFB6dCxpJmP6gIXkS5CyrP09dwHImbks37sz39nbYAsrT9wtX2kkzuJ7Z7wQjgDwiO
         1VYju+Y/XiD5LAMceSc32CfKMNIrn2+0HK7BK+G2DATtmSY1cEQDaTs6FXIkl+LifKt+
         C/5Q==
X-Gm-Message-State: AOAM531iU3gknPQ9QWYXBfPNgJTtgIjyHX2LH5ghrALM3J5s9+0Rr1wg
        2n5/7Is5oJw02qMQ/ZXLgBs=
X-Google-Smtp-Source: ABdhPJz1N1kRgfTY0cVsqNATEfnwHRc3ytlT4RZEplJSn3YCLmmQDBxcVj8aRj1fEESS5c+vcHsy6A==
X-Received: by 2002:a17:902:6194:: with SMTP id u20mr55925017plj.333.1594300952424;
        Thu, 09 Jul 2020 06:22:32 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id q11sm2701311pjj.17.2020.07.09.06.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 06:22:31 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 9 Jul 2020 22:22:29 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Raul Rangel <rrangel@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "S, Shirish" <Shirish.S@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: UART/TTY console deadlock
Message-ID: <20200709132229.GD4380@jagdpanzerIV.localdomain>
References: <20200630180255.GD37466@atomide.com>
 <20200702051213.GB3450@jagdpanzerIV.localdomain>
 <20200702160514.GK37466@atomide.com>
 <20200703103241.GB182102@jagdpanzerIV.localdomain>
 <CAHp75VdvNi_LWv7QhEsm1vQikeiMpi68qmCwoVttjnp7oq0ahg@mail.gmail.com>
 <877dvg6ft6.fsf@kurt>
 <20200706144314.GB1485@jagdpanzerIV.localdomain>
 <87o8oqa1zy.fsf@kurt>
 <20200708080712.GC571@jagdpanzerIV.localdomain>
 <20200708095215.GB4751@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708095215.GB4751@alley>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/08 11:52), Petr Mladek wrote:
> 
> I still believe that this is a false positive.

I've no problems with that. The thing that I'm trying to improve here is the
fact that from lockdep's point of view there are no false positives. lockdep
reports the problem and then waves good bye. It disables itself. There might
be some real suspend locking problems on some particular setups, but it's
hard to tell, because console startup blows up the lockdep first.

	-ss
