Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A7BC2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE58920644
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgDGJe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:34:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41877 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGJe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 05:34:26 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jLkci-0001sz-RN
        for linux-kernel@vger.kernel.org; Tue, 07 Apr 2020 09:34:24 +0000
Received: by mail-wm1-f70.google.com with SMTP id a4so472771wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 02:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uPsTNxLdIDWlRCtJqG7CoBzdAg59oIT20FSzJSMfJfM=;
        b=B6LRD4mclXrTEEhXFGb/Jjaxif0iugfVEcybu6i/Prdq1l8cGAQ/R/RjInH9kTO3UA
         nUv924UdS5qqOY9/wREigcvK0tXuy6dKtcH6TxeldnfTFHOOfAcMt/2EkapYGJ3Atl4a
         rYbtgZdbkYv9sNckbimozEol9YEUHqPoo2+f/mpyfhSbp0k72du9EUaVWV4XMC5T7tn4
         i77BTtKNWe+fm+Gq31slF8D5tStYz0wOPC5SegB5eDbqjIRoHKdNnO6a20rY9P+Q4RkJ
         jUFDTupJK+TansKlww5NkDOuee/2xOeDbK3OV+B9PKsFG3itBU/UUe0S/jgN8dL6SZ/v
         Vw2g==
X-Gm-Message-State: AGi0PuZTGIMoIi8gTjtnxl+atS5uA2QYFxcD5ZPK4LYk98L8zhgwH5KO
        DF6wNbMY8wCYFpwJCMTOFd949SV9msgoNobxqJmPrkFa624/RG6Ulj4j4gOU4sBz5KgPJbuvXHg
        EDVx7B13Iu6dmW1N4CZQecdgXihVYjpdG0aYLRI4AuQ==
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr1442654wmc.15.1586252064435;
        Tue, 07 Apr 2020 02:34:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypKmrWsL/bX9oZ/TNvsql4F4PCjQsXe8fa6CUIX/VQhprHmkFfhDzZXlUz4Tuus9VKxSSbzujw==
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr1442631wmc.15.1586252064149;
        Tue, 07 Apr 2020 02:34:24 -0700 (PDT)
Received: from localhost (host123-127-dynamic.36-79-r.retail.telecomitalia.it. [79.36.127.123])
        by smtp.gmail.com with ESMTPSA id f5sm20796541wrj.95.2020.04.07.02.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 02:34:23 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:34:22 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     Piotr Morgwai =?utf-8?Q?Kotarbi=C5=84ski?= <morgwai@morgwai.pl>,
        Colin Ian King <colin.king@canonical.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ptp: free ptp clock properly
Message-ID: <20200407093422.GD3665@xps-13>
References: <20200309172238.GJ267906@xps-13>
 <1196893766.20531178.1585920854778.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1196893766.20531178.1585920854778.JavaMail.zimbra@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 09:34:14AM -0400, Vladis Dronov wrote:
> Hello, Andrea, Colin, all,
> 
> This fix is really not needed, as its creation is based on the assumption
> that the Ubuntu kernel 5.3.0-40-generic has the upstream commit 75718584cb3c,
> which is the real fix to this crash.
> 
> > > > I would guess that a kernel in question (5.3.0-40-generic) has the commit
> > > > a33121e5487b but does not have the commit 75718584cb3c, which should be
> > > > exactly fixing a docking station disconnect crash. Could you please,
> > > > check this?
> > >
> > > Unfortunately the kernel in question already has 75718584cb3c:
> > > https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/bionic/commit/?h=hwe&id=c71b774732f997ef38ed7bd62e73891a01f2bbfe
> 
> Apologies, but the assumption above is not correct, 5.3.0-40-generic does
> not have 75718584cb3c. If it had 75718584cb3c it would be a fix and the ptp-related
> crash (described in https://bugs.launchpad.net/bugs/1864754) would not happen.
> 
> This way https://lists.ubuntu.com/archives/kernel-team/2020-March/108562.html fix
> is not really needed.

Hi Vladis,

for the records, I repeated the tests with a lot of help from the bug
reporter (Morgwai, added in cc), this time making sure we were using the
same kernels.

I confirm that my fix is not really needed as you correctly pointed out.
Thanks for looking into this and sorry for the noise! :)

-Andrea
