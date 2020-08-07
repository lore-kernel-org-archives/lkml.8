Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E22C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 283B822CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgHGQXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgHGQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:23:11 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E788C061756;
        Fri,  7 Aug 2020 09:23:11 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4597-00BE3G-Tq; Fri, 07 Aug 2020 16:23:05 +0000
Date:   Fri, 7 Aug 2020 17:23:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: srvfs: file system for posting open file descriptors into fs
 namespace
Message-ID: <20200807162305.GT1236603@ZenIV.linux.org.uk>
References: <55ef0e9a-fb70-7c4a-e945-4d521180221c@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55ef0e9a-fb70-7c4a-e945-4d521180221c@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 01:09:30PM +0200, Enrico Weigelt, metux IT consult wrote:
> Hello folks,
> 
> 
> here's the first version of my "srvfs" implementation - a synthentic
> filesystem which allows a process to "publish" an open file descriptor
> into the file system, so other processes can continue from there, with
> whatever state the fd is already in.
> 
> This is a concept from Plan9. The main purpose is allowing applications
> "dialing" some connection, do initial handshakes (eg. authentication)
> and then publish the connection to other applications, that now can now
> make use of the already dialed connection.

Yeah, but...  Linux open() always gets a new struct file instance; how
do you work around that?  Some variant of ->atomic_open() API change?
Details, please.
