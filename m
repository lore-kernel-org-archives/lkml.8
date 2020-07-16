Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E00C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7512320663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cXE2TeIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGPDag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgGPDaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:30:35 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F00C061755;
        Wed, 15 Jul 2020 20:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=aD++24wBmVuc2EotWw1YQ1q68FR+577+Zt1OtHbnPF0=; b=cXE2TeItmlXQARqBs2DUWaNIp0
        6wBQCYB1RKIOFrBosBUFM6IN0gZ186A3iZhorlNLxt+W7L+3eBrpU/a7O6NS9qLtWs9slSYRlVbdI
        tNcYeXyu4sTxRNBUQJBNlbHUdvzqGPEM09/a3BQKydA/cqssMETV/+6w5wS1rZK+Si3QnoRjruhXK
        jXyQQjRiqYBJNr9W9gzX/5+BF9OpDOSDbWHYIo/6B7nBMycQIbPoQmBTbhtzHPIa5rPks+DTKfMeI
        l+K2Boh2B0QJ21W22w30ffc0ZwPs06qY3z/lMpgJhXrSKCaMunlZuQ1rDBQQ0aheDguwOg8iZuVIk
        mNnC6qDQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvubN-0008De-Vq; Thu, 16 Jul 2020 03:30:30 +0000
Subject: Re: [PATCH 2/2] debugfs: Add access restriction option
To:     Peter Enderborg <peter.enderborg@sony.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
 <20200715152529.11223-1-peter.enderborg@sony.com>
 <20200715152529.11223-3-peter.enderborg@sony.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b453a7d9-6620-2a28-205e-1a11bbcb5abd@infradead.org>
Date:   Wed, 15 Jul 2020 20:30:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200715152529.11223-3-peter.enderborg@sony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/15/20 8:25 AM, Peter Enderborg wrote:
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 9ad9210d70a1..aec81f38bfce 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -476,6 +476,38 @@ config DEBUG_FS
>  
>  	  If unsure, say N.
>  
> +choice
> +	prompt "Debugfs default access"
> +	depends on DEBUG_FS
> +	default DEBUG_FS_ALLOW_ALL
> +	help
> +	  This select the default access restricions for debugfs.

	       selects                   restrictions
                 
> +	  It can be overridden with kernel command line option
> +	  debugfs=[on,no-mount,off] The restrictions apply for API access

	                      ,off]. The

> +	  and filesystem registration. .
> +
> +config DEBUG_FS_ALLOW_ALL
> +       bool "Access normal"
> +       help
> +	  No restrictions applies. Both API and filesystem registration

	                  apply.

> +	  is on. This is the normal default operation.
> +
> +config DEBUG_FS_DISALLOW_MOUNT
> +       bool "Do not register debugfs as filesystem"
> +       help
> +	 The API is open but filesystem not loaded. Client can still do
> +	 their work and readed with debug tools that does not need

	            and read                    that do not need

> +	 debugfs filesystem.
> +
> +config DEBUG_FS_ALLOW_NONE
> +       bool "No access"
> +       help
> +	  Access is off. Clients get EPERM when trying to create nodes in

	                             -EPERM

> +	  debugfs tree and debugfs is not registred as an filesystem.

	                                  registered as a filesystem.


> +	  Client can then back-off or continue without debugfs access.
> +
> +endchoice


Also, in many places in this Kconfig file, the indentation needs to be
fixed.  Some lines use spaces instead of one tab for indentation.
Help text (under "help") should be indented with one tab + 2 spaces.


-- 
~Randy

