Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC91CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B451A207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgFZRCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgFZRCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:02:22 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85424C03E979;
        Fri, 26 Jun 2020 10:02:22 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C15A6374;
        Fri, 26 Jun 2020 17:02:20 +0000 (UTC)
Date:   Fri, 26 Jun 2020 11:02:19 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     changbin.du@intel.com, masahiroy@kernel.org, rostedt@goodmis.org,
        j.neuschaefer@gmx.net, andy.shevchenko@gmail.com,
        mchehab+samsung@kernel.org, logang@deltatee.com, abbotti@mev.co.uk,
        jacob.e.keller@intel.com, colin.king@canonical.com,
        gregkh@linuxfoundation.org, mgreer@animalcreek.com, tytso@mit.edu,
        jack@suse.cz, ebiggers@google.com, tglx@linutronix.de,
        akpm@linux-foundation.org, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com, jgross@suse.com,
        mike.kravetz@oracle.com, cohuck@redhat.com,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, alex@alexanderweb.de,
        dwlsalmeida@gmail.com, dsterba@suse.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/admin-guide
Message-ID: <20200626110219.7ae21265@lwn.net>
In-Reply-To: <20200621132049.45624-1-grandmaster@al2klimov.de>
References: <20200621132049.45624-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jun 2020 15:20:49 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

So for this one ...

> diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
> index 5fb526900023..7186ed9b42fe 100644
> --- a/Documentation/admin-guide/README.rst
> +++ b/Documentation/admin-guide/README.rst
> @@ -1,6 +1,6 @@
>  .. _readme:
>  
> -Linux kernel release 5.x <http://kernel.org/>
> +Linux kernel release 5.x <https://kernel.org/>
>  =============================================

I'd really rather just take that URL out of there, it makes no sense in the
heading. 

[...]

> index 9443fcef1876..bc3abfb33476 100644
> --- a/Documentation/admin-guide/ext4.rst
> +++ b/Documentation/admin-guide/ext4.rst
> @@ -611,7 +611,7 @@ kernel source:	<file:fs/ext4/>
>  
>  programs:	http://e2fsprogs.sourceforge.net/
>  
> -useful links:	http://fedoraproject.org/wiki/ext3-devel
> +useful links:	https://fedoraproject.org/wiki/ext3-devel
>  		http://www.bullopensource.org/ext4/

This link looks pretty obviously dead, you should just take it out while
you're in the neighborhood.

>  		http://ext4.wiki.kernel.org/index.php/Main_Page

And this one already redirects to https, is there a reason why you didn't
change it?

> index fb95fad81c79..b333ba5cb144 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2786,7 +2786,7 @@
>  			touchscreen support is not enabled in the mainstream
>  			kernel as of 2.6.30, a preliminary port can be found
>  			in the "bleeding edge" mini2440 support kernel at
> -			http://repo.or.cz/w/linux-2.6/mini2440.git
> +			https://repo.or.cz/w/linux-2.6/mini2440.git

A repo that hasn't seen a commit since 2009 doesn't quite qualify as
"bleeding edge" IMO, but I guess we can let that one slide...:)


> index 874eb0c77d34..e87bf0135edf 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -9,7 +9,7 @@ Overview
>  
>  KSM is a memory-saving de-duplication feature, enabled by CONFIG_KSM=y,
>  added to the Linux kernel in 2.6.32.  See ``mm/ksm.c`` for its implementation,
> -and http://lwn.net/Articles/306704/ and http://lwn.net/Articles/330589/
> +and http://lwn.net/Articles/306704/ and https://lwn.net/Articles/330589/

Why did you only change one of those?

Thanks,

jon
