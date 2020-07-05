Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C37C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D5720724
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgGEUNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:13:18 -0400
Received: from ms.lwn.net ([45.79.88.28]:51566 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgGEUNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:13:17 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 30160739;
        Sun,  5 Jul 2020 20:13:16 +0000 (UTC)
Date:   Sun, 5 Jul 2020 14:13:15 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     j.neuschaefer@gmx.net, cohuck@redhat.com,
        mchehab+samsung@kernel.org, logang@deltatee.com,
        mgreer@animalcreek.com, abbotti@mev.co.uk,
        gregkh@linuxfoundation.org, jacob.e.keller@intel.com,
        colin.king@canonical.com, tytso@mit.edu, ebiggers@google.com,
        jack@suse.cz, tglx@linutronix.de, akpm@linux-foundation.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        jgross@suse.com, mike.kravetz@oracle.com, oneukum@suse.com,
        andy.shevchenko@gmail.com, pavel@ucw.cz,
        jacek.anaszewski@gmail.com, alex@alexanderweb.de,
        dwlsalmeida@gmail.com, dsterba@suse.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Replace HTTP links with HTTPS ones:
 Documentation/admin-guide
Message-ID: <20200705141315.17b4d70a@lwn.net>
In-Reply-To: <20200627072935.62652-1-grandmaster@al2klimov.de>
References: <20200627072935.62652-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jun 2020 09:29:35 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Applied, thanks.

jon
