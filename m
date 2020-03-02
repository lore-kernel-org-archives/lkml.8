Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C52C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB512072A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgCBSnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:43:01 -0500
Received: from ms.lwn.net ([45.79.88.28]:57964 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbgCBSnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:43:01 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 19AE02E4;
        Mon,  2 Mar 2020 18:43:01 +0000 (UTC)
Date:   Mon, 2 Mar 2020 11:43:00 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pragat Pandya <pragat.pandya@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v2 0/2] Documentation: Add files to driver-api manual
Message-ID: <20200302114300.34875f69@lwn.net>
In-Reply-To: <20200302183105.27628-1-pragat.pandya@gmail.com>
References: <20200302104501.0f9987bb@lwn.net>
        <20200302183105.27628-1-pragat.pandya@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Mar 2020 00:01:03 +0530
Pragat Pandya <pragat.pandya@gmail.com> wrote:

> This patchset adds following two rst files under
> Documentation/driver-api and references these both in Sphinx TOC Tree in
> Documentation/driver-api/index.rst
>  -io-mapping.rst
>  -io_ordering.rst
> 
> v2: 
>  -Provide more descriptive subject lines
>  -The document did not belong to top level so moved it to driver-api
>   manual
> 
> Pragat Pandya (2):
>   Documentation: Add io-mapping.rst to driver-api manual
>   Documentation: Add io_ordering.rst to driver-api manual
> 
>  Documentation/driver-api/index.rst       |  2 +
>  Documentation/driver-api/io-mapping.rst  | 97 ++++++++++++++++++++++++
>  Documentation/driver-api/io_ordering.rst | 51 +++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 Documentation/driver-api/io-mapping.rst
>  create mode 100644 Documentation/driver-api/io_ordering.rst

OK, we're getting closer.  This series, though, leaves the old files in
place.  You should rename them over, rather than simply creating new files.

Thanks,

jon
