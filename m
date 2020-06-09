Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96585C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA9C2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQH8iye3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgFIXCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgFIXCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:02:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD22C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 16:02:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g1so23343edv.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4TDkIk2ODziXmKt8htHNeZJCGvaya39PyKoQ7mO+wOk=;
        b=AQH8iye3E5UIrmfSlfoG1uM6KQrByz7Nm4bW/IjPJ5xKycld9tFBmQoFO0N6p+lNHr
         hc2+UWANAY0GiHVTXtivOlIUNnA00aZZKWpoFwD5tx/6qxnz+kgfnypHSdUrmFiAgyGT
         QJf3aZEnU3VemyKoKO9FdpYqutmWTN6Ze4Vn1kf+BRIRSWmsDzI1zJh//AldfmAbvfuC
         QvzSoy98Ee7MdAiBp/0PZ/2NfgE0EDMOsVflzrqFoKXBd8GsW6Yg5QzU9oKFXCrqi9iH
         D3fwU+DDIQ8SZK/sTVMoZq1qWVYt1dwsHi04zrP7HItIrKNArN4P3TngrjQ22J2Mlosk
         xKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4TDkIk2ODziXmKt8htHNeZJCGvaya39PyKoQ7mO+wOk=;
        b=Ld8TVaaJIIyuhqlHNE/TuGM5NdWpgaA+pFV3sUcqSOWEhKwGM3fcuvDEsWSEPDATv7
         xfT32h1FoyA7ejyN7Dfbkoh5QdDPRhORPty/ox6oAubXjVDahWpGbUh8O7NkIht4MQY2
         tOvyedJtbB7wwLbDuXzwMgnif2YNxtG3A9vmT8a3zioxtdcZfslcBJJmv6UVHtEC+doi
         JWdLfbR3SmlpPcQNQeHiUxgdla1sjSZn9ickjUlsK3U2sgL0OSwL8q83MDHWkJJZa3uy
         Npu5u9/pLVfnvtDWBBaePlkAyCyoy+quzpbG5BdXROu+TUjVxp3ryjeWglNzK/2Y4yKw
         DTJQ==
X-Gm-Message-State: AOAM532GJ/JHOJZD/Tiwm3sRY9fOZWbHcdsFr45WxcsalIYEzZ77etFP
        Q2XerZuC9zIdEk7r8ebjulN5LX28
X-Google-Smtp-Source: ABdhPJxqbY8AeJXu4V3rRd+i1psI52voUadjVzVZsBsYSnBzcxUxfT4Q0gQU+vpXhZ86hy/2GcgtOg==
X-Received: by 2002:a50:d556:: with SMTP id f22mr33823edj.307.1591743762634;
        Tue, 09 Jun 2020 16:02:42 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id kt10sm13927078ejb.54.2020.06.09.16.02.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jun 2020 16:02:41 -0700 (PDT)
Date:   Tue, 9 Jun 2020 23:02:41 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2] lib: test get_count_order/long in test_bitops.c
Message-ID: <20200609230241.gdqebrspmucnru5k@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200602223728.32722-1-richard.weiyang@gmail.com>
 <CAMuHMdUfnmm4bXVRvFOmG5DFYR+LtcZ1UviDszr9bByiN=DO+Q@mail.gmail.com>
 <20200604122805.d2ndjmkmti6wl3nz@master>
 <CAMuHMdXnLUS8F4nWJBqDjoKhBmF2_ihfwe4jTGxuZ1e_WKRNPQ@mail.gmail.com>
 <20200605230610.bizp2j23ivyma5rn@master>
 <20200605171629.d931068c1a4d720d8faa2704@linux-foundation.org>
 <20200608223112.ftncszh7hfnmqj3m@master>
 <20200609091649.GX2428291@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609091649.GX2428291@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 12:16:49PM +0300, Andy Shevchenko wrote:
>On Mon, Jun 08, 2020 at 10:31:12PM +0000, Wei Yang wrote:
>> On Fri, Jun 05, 2020 at 05:16:29PM -0700, Andrew Morton wrote:
>
>...
>
>> The test on 64bit machine pass. Since I don't have a 32bit machine by hand, 
>
>Out of curiosity what that machine is?
>

It is a Intel Xeon Gold CPU.

>> Geert, would you mind have a try on 32bit machine? 
>
>-- 
>With Best Regards,
>Andy Shevchenko
>

-- 
Wei Yang
Help you, Help me
