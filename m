Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AFEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A94B2078E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rf6EAJMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbgFWVpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388329AbgFWVpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:45:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10557C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:45:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id t194so279139wmt.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nqTtGFr7emsA5ETTuz1egKRqJYyb++pVmJLzqCk4LIQ=;
        b=rf6EAJMkXyfEwYNgddcaUAF8lJkMF3/2uGkUpuzTmuco4IOzUK3YevBpfPut6GxqFC
         aJLMYVwp1UlXaA7ztLWSVy9L2N/gcaH4tCqtpHAqggUODCvmby3NgynWkA65Hx59NYXt
         FSe3dRfQfEbBJJ0XJtQ5tlp8XyuiFnXaX5a4nGwBZR7INlzkd4b8bsQZ4/DXZ7WbC6xI
         PcS+VT7f424ihlMy7/ni7Mq6TrroNnfNap4s6ZRFHcbJ1uXSOCY5EJS/HjYQ4OOtY5kQ
         drLND7wQO4yeQJunuOen++WFwZ4v0vDZXHX61NilNo5K1AFlueEfe5cgu5rxN4evTip/
         KIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nqTtGFr7emsA5ETTuz1egKRqJYyb++pVmJLzqCk4LIQ=;
        b=PAXOQZ5JkDqCzEHT8tO5MlqPdtsX3V09dFrveyO0xHgFiCWL3q7YdZLKh82Jq9o3NZ
         CCosUJXSgS+rAxBbpub7OiE0zVM6VM/P4BG3h2LeDuWO/rHD+sIdEgm2RQmkcCCWy5LI
         Pdgc9oE39c26ABJ49Aq14mCav5URh/9tXO62Nt7IwEyj6QmsOBxt4nd1G9iZrK1YEw79
         JkF31UmvvcduMrpPvK2T6y2xsT+9JiBTW63FeUkF+mfbbRtkqI/PcFV/nJZO/1Md0hU+
         4o4hJAQrHULG4x6o+3XbeGUSAvfHV3OmUWf8+t0G8UxGsfhrPAoL2Gj7tyCrTfCQflq5
         aWnw==
X-Gm-Message-State: AOAM532beYyletBRqjkedhzQ3y6tMfT0FrvvQHAsUKtS3/w46/xImwaj
        QfmkfkeMCVo/HjeIpJ/Gcw==
X-Google-Smtp-Source: ABdhPJwhkIsNJyWqUCw2Q/TwDLVClOwPOg1DHTh7yp8Iv3HII60B5y8Q4ExGxKj3F8eof7gDY4RZnA==
X-Received: by 2002:a1c:1d46:: with SMTP id d67mr27938641wmd.152.1592948742763;
        Tue, 23 Jun 2020 14:45:42 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.162])
        by smtp.gmail.com with ESMTPSA id i19sm18629571wrb.56.2020.06.23.14.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 14:45:42 -0700 (PDT)
Date:   Wed, 24 Jun 2020 00:45:40 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: process '/usr/bin/rsync' started with executable stack
Message-ID: <20200623214540.GA42941@localhost.localdomain>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
 <202006231131.AD0A7F5F@keescook>
 <alpine.DEB.2.22.1.446.2006231430280.3892@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.1.446.2006231430280.3892@trent.utfs.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:33:50PM -0700, Christian Kujau wrote:
> On Tue, 23 Jun 2020, Kees Cook wrote:
> > > $ checksec --format=json --extended --file=`which rsync` | jq
> > > {
> > >   "/usr/bin/rsync": {
> > >     "relro": "full",
> > >     "canary": "yes",
> > >     "nx": "no",
> > ^^^^^^^^^^^^^^^^^^
> > 
> > It is, indeed, marked executable, it seems. What distro is this?
> 
> Arch Linux (x86-64) with 5.6.5.a-1-hardened[0], running in a Xen DomU.
> 
> Christian.
> 
> [0] https://git.archlinux.org/svntogit/packages.git/tree/trunk?h=packages/linux-hardened

Fixed in testing (rsync-3.2.1-1-x86_64.pkg)

  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000  RW     0x10
