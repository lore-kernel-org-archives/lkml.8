Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB8BC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C020120736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgDXRe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726813AbgDXRe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:34:27 -0400
X-Greylist: delayed 292 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Apr 2020 10:34:27 PDT
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E22C09B047;
        Fri, 24 Apr 2020 10:34:27 -0700 (PDT)
Received: from [87.115.41.34] (port=58114 helo=slartibartfast.quignogs.org.uk)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <peter@bikeshed.quignogs.org.uk>)
        id 1jS2DU-0008N6-Ag; Fri, 24 Apr 2020 18:34:24 +0100
From:   Peter Lister <peter@bikeshed.quignogs.org.uk>
Subject: Re: [PATCH v2 08/29] docs: filesystems: convert configfs.txt to ReST
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>, linux-usb@vger.kernel.org
References: <cover.1587487612.git.mchehab+huawei@kernel.org>
 <278a9befc98b49ea866c9b687d070c70cde20628.1587487612.git.mchehab+huawei@kernel.org>
X-Mozilla-News-Host: news://nntp.lore.kernel.org
Message-ID: <31da15f2-7755-3e56-d05c-1e3f388e0933@bikeshed.quignogs.org.uk>
Date:   Fri, 24 Apr 2020 18:34:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <278a9befc98b49ea866c9b687d070c70cde20628.1587487612.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -configfs - Userspace-driven kernel object configuration.
> +=======================================================
> +Configfs - Userspace-driven Kernel oOject Configuration
> +=======================================================

Typo, presumably intended to be Object, not oOject?

Why amend capitalisation as part of converting to REST? Normal 
Linux/Unix convention is lower case for things like filesystems.

> -IMPORTANT: drop_item() is void, and as such cannot fail.  When rmdir(2)
> -is called, configfs WILL remove the item from the filesystem tree
> -(assuming that it has no children to keep it busy).  The subsystem is
> -responsible for responding to this.  If the subsystem has references to
> -the item in other threads, the memory is safe.  It may take some time
> -for the item to actually disappear from the subsystem's usage.  But it
> -is gone from configfs.
> +.. Important::
> +
> +   drop_item() is void, and as such cannot fail.  When rmdir(2)
> +   is called, configfs WILL remove the item from the filesystem tree
> +   (assuming that it has no children to keep it busy).  The subsystem is
> +   responsible for responding to this.  If the subsystem has references to
> +   the item in other threads, the memory is safe.  It may take some time
> +   for the item to actually disappear from the subsystem's usage.  But it
> +   is gone from configfs.

Using a  REST admonition is probably OK but, again, why change case?

The original author used shouting caps for IMPORTANT. A change can be 
argued for consistency or if there is an established preference for 
style. But, if so, that's a style patch, not a conversion.
