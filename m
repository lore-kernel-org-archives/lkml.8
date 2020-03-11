Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC3EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D4920750
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbgCKWVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:21:50 -0400
Received: from balrog.mythic-beasts.com ([46.235.227.24]:50643 "EHLO
        balrog.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbgCKWVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:21:49 -0400
Received: from [146.90.33.204] (port=40436 helo=slartibartfast.quignogs.org.uk)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <peter@bikeshed.quignogs.org.uk>)
        id 1jC9jT-0006iO-6N; Wed, 11 Mar 2020 22:21:47 +0000
Subject: Re: [PATCH 1/1] Reformat return value descriptions as ReST lists.
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <20200311192823.16213-1-peter@bikeshed.quignogs.org.uk>
 <20200311192823.16213-2-peter@bikeshed.quignogs.org.uk>
 <20200311203817.GT25745@shell.armlinux.org.uk>
From:   Peter Lister <peter@bikeshed.quignogs.org.uk>
Organization: Quignogs! (Bikeshed)
Message-ID: <db5f6d8f-beb0-b9bd-e47d-2a8e3dd513a2@bikeshed.quignogs.org.uk>
Date:   Wed, 11 Mar 2020 22:21:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311203817.GT25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-BlackCat-Spam-Score: 14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

> Is this really necessary?  This seems to be rather OTT, and makes the
> comment way too big IMHO.

The existing form definitely gets the formatted output wrong (I'll send 
you a screen grab if you like) and causes doc build warnings. So, yes, 
it needs fixing.

ReST makes free with blank lines round blocks and list entries, and I 
agree this makes for inelegant source annotation. I tried to retain the 
wording unchanged and present the description as just "whitespace" 
changes to make a list in the formatted output - as close as I could to 
what the author appears to intend.

If you're OK with a mild rewrite of the return value description, e.g. 
as two sentences (On success: p; q. On failure: x; y; z.), then we can 
fix the doc build and have terser source comments and a happier kerneldoc.

All the best,

Peter Lister

