Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A70BC2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0514D20714
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbgCaWt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:49:59 -0400
Received: from ms.lwn.net ([45.79.88.28]:44686 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729153AbgCaWt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:49:58 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F1393537;
        Tue, 31 Mar 2020 22:49:57 +0000 (UTC)
Date:   Tue, 31 Mar 2020 16:49:56 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 0/2] Documentation: Convert sysfs-pci to ReST
Message-ID: <20200331164956.0e10b87e@lwn.net>
In-Reply-To: <cover.1585693146.git.vitor@massaru.org>
References: <cover.1585693146.git.vitor@massaru.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 19:28:55 -0300
Vitor Massaru Iha <vitor@massaru.org> wrote:

> Vitor Massaru Iha (2):
>   Documentation: filesystems: Convert sysfs-pci to ReST
>   Documentation: filesystems: remove whitespaces
> 
>  .../{sysfs-pci.txt => sysfs-pci.rst}          | 44 ++++++++++---------
>  1 file changed, 24 insertions(+), 20 deletions(-)
>  rename Documentation/filesystems/{sysfs-pci.txt => sysfs-pci.rst} (81%)

Thanks for working on the documentation!  I do have a few comments...

The purpose for including a cover letter on a patch series is to explain
what the series as a whole is trying to accomplish.  Without that, it's
not all the helpful.

In this case, there is no real need for a series; just clean up that
trailing whitespace while doing the conversion.  (It *is* normally good
practice to separate such conversions from other changes, but that
particular change is trivial enough that you should just do it while
you're there).

When you convert a file to RST, you need to add it to the index.rst file
as well so that it can be a part of the documentation build.

Thanks,

jon
