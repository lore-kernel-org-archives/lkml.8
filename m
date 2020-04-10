Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE530C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDE020857
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDJQSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:18:04 -0400
Received: from ms.lwn.net ([45.79.88.28]:38010 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgDJQSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 12:18:04 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2A262728;
        Fri, 10 Apr 2020 16:18:04 +0000 (UTC)
Date:   Fri, 10 Apr 2020 10:18:03 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Cristian Souza <cristianmsbr@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs: admin-guide: Clarify sentences
Message-ID: <20200410101803.5116f7e5@lwn.net>
In-Reply-To: <20200409194637.GA141700@darkstar>
References: <20200408144653.GA123268@darkstar>
        <20200409181311.GW21484@bombadil.infradead.org>
        <20200409194637.GA141700@darkstar>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Apr 2020 16:46:37 -0300
Cristian Souza <cristianmsbr@gmail.com> wrote:

> Removal of unnecessary sentences, identification of authors at the top of the file,
> and correction of the number of characters per line.
> 
> Signed-off-by: Cristian Souza <cristianmsbr@gmail.com>
> ---
>  Documentation/admin-guide/init.rst | 57 +++++++++++++++---------------
>  1 file changed, 28 insertions(+), 29 deletions(-)

So this says "v2", but it's a reply to another "v2", so it's really a new
version, right?

In situations like this, please:

 - Change the version number!
 - Add a comment under the "---" line saying what changed
 - Post the patch standalone, rather than a reply in an existing thread.

Thanks,

jon
