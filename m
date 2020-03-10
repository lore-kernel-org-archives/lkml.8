Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA672C3F2D0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73C321D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgCJRel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:34:41 -0400
Received: from ms.lwn.net ([45.79.88.28]:44220 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJRel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:34:41 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F28AF537;
        Tue, 10 Mar 2020 17:34:40 +0000 (UTC)
Date:   Tue, 10 Mar 2020 11:34:40 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pragat Pandya <pragat.pandya@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v3 0/2] Documentation: Rename two txt files to rst
Message-ID: <20200310113440.43dfe391@lwn.net>
In-Reply-To: <20200303050301.5412-1-pragat.pandya@gmail.com>
References: <20200302114300.34875f69@lwn.net>
        <20200303050301.5412-1-pragat.pandya@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Mar 2020 10:32:59 +0530
Pragat Pandya <pragat.pandya@gmail.com> wrote:

> This patchset renames following two txt files to rst files and moves
> them to driver-api manual from top level.
>  -io-mapping.txt (Documentation/) -> io-mapping.rst(Documentation/driver-api/)
>  -io_ordering.txt(Documentation/) -> io_ordering.rst(Documentation/driver-api/)
> 
> v2:
>  -Provide more descriptive subject lines.
>  -Move newly generated(rather renamed) rst files to driver-api manual
>   from top level documentation.
> v3:
>  -In v2, the old files were left in place creating new rst files.
>  -Rename the target files rather than simply creating new files.
> 
Both patches applied, thanks.

jon
