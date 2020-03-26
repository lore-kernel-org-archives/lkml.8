Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8681C2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9827620714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgCZTgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:36:52 -0400
Received: from haggis.mythic-beasts.com ([46.235.224.141]:35573 "EHLO
        haggis.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:36:52 -0400
Received: from [87.115.226.141] (port=56442 helo=slartibartfast.quignogs.org.uk)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <peter@bikeshed.quignogs.org.uk>)
        id 1jHYJ6-0008Dp-Ou; Thu, 26 Mar 2020 19:36:48 +0000
Subject: Re: [PATCH v2 1/1] A compact idiom to add code examples in kerneldoc
 comments.
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
References: <20200311133027.2c77f348@lwn.net>
 <20200326191628.10052-1-peter@bikeshed.quignogs.org.uk>
 <20200326191628.10052-2-peter@bikeshed.quignogs.org.uk>
 <20200326192947.GM22483@bombadil.infradead.org>
From:   Peter Lister <peter@bikeshed.quignogs.org.uk>
Organization: Quignogs! (Bikeshed)
Message-ID: <21ff28e5-25a7-0d8d-b8c3-b1cd37310ae4@bikeshed.quignogs.org.uk>
Date:   Thu, 26 Mar 2020 19:36:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326192947.GM22483@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-BlackCat-Spam-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops. Fair points, well made.

v3 on its way...

Peter

