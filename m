Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3483DC47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C54C205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgD3UEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:04:14 -0400
Received: from ms.lwn.net ([45.79.88.28]:57920 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgD3UEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:04:13 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 58A696E3;
        Thu, 30 Apr 2020 20:04:13 +0000 (UTC)
Date:   Thu, 30 Apr 2020 14:04:12 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     linux-doc@vger.kernel.org, hubcap@omnibond.com,
        martin@omnibond.com, devel@lists.orangefs.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] docs: filesystems: fix `make htmldocs` warning
Message-ID: <20200430140412.7d4c692d@lwn.net>
In-Reply-To: <07d33cf9937c89519bafc9210a98dab42579e681.camel@massaru.org>
References: <20200430190737.80950-1-vitor@massaru.org>
        <20200430134704.236c612b@lwn.net>
        <07d33cf9937c89519bafc9210a98dab42579e681.camel@massaru.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 16:57:24 -0300
Vitor Massaru Iha <vitor@massaru.org> wrote:

> Sorry about that. I searched but I didn't find the documentation tree.
> Could you point me to the git url?

The MAINTAINERS file is always the place to look for such things:

> T:	git git://git.lwn.net/linux.git docs-next

jon
