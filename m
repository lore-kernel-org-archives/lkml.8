Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63DAC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE25620724
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgDXR3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:29:38 -0400
Received: from balrog.mythic-beasts.com ([46.235.227.24]:34849 "EHLO
        balrog.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgDXR3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:29:37 -0400
Received: from [87.115.41.34] (port=58078 helo=slartibartfast.quignogs.org.uk)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <peter@bikeshed.quignogs.org.uk>)
        id 1jS28m-0006fu-JF; Fri, 24 Apr 2020 18:29:32 +0100
From:   Peter Lister <peter@bikeshed.quignogs.org.uk>
Subject: Re: [PATCH v2 08/29] docs: filesystems: convert configfs.txt to ReST
To:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Becker <jlbec@evilplan.org>, linux-usb@vger.kernel.org
References: <cover.1587487612.git.mchehab+huawei@kernel.org>
 <278a9befc98b49ea866c9b687d070c70cde20628.1587487612.git.mchehab+huawei@kernel.org>
 <20200421165534.GA16511@lst.de>
 <20200421170223.GP5820@bombadil.infradead.org>
 <20200421172337.GA18305@lst.de>
Message-ID: <894438a6-cd91-1728-a313-4bf4f8d5074d@bikeshed.quignogs.org.uk>
Date:   Fri, 24 Apr 2020 18:28:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421172337.GA18305@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2020 18:23, Christoph Hellwig wrote:
> It wasn't entirely uncommon, but that's not really the point.  The
> Problem is all the weird ".." or "::" annotations that really kill
> the flow, or things like "|copy|" that have no reason to exist.

You aren't supposed to read REST documentation files - as opposed to 
kerneldoc comments in the C source - any more than you read HTML.

[ Exactly what should or should not be in C source kerneldoc is another 
matter. ]

Developers are used to reading plain ol' text files for quick reference. 
But there is no make target to generate the text files.

Can we create a method to build text *output* files?
