Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13712C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 03:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA692071C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 03:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgEAD6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 23:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgEAD6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 23:58:22 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9B2C035494;
        Thu, 30 Apr 2020 20:58:22 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUMoe-00FaSo-R2; Fri, 01 May 2020 03:58:21 +0000
Date:   Fri, 1 May 2020 04:58:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pipe: read/write_iter() handler should check for
 IOCB_NOWAIT
Message-ID: <20200501035820.GH23230@ZenIV.linux.org.uk>
References: <273d8294-2508-a4c2-f96e-a6a394f94166@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <273d8294-2508-a4c2-f96e-a6a394f94166@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 10:24:46AM -0600, Jens Axboe wrote:
> Pipe read/write only checks for the file O_NONBLOCK flag, but we should
> also check for IOCB_NOWAIT for whether or not we should handle this read
> or write in a non-blocking fashion. If we don't, then we will block on
> data or space for iocbs that explicitly asked for non-blocking
> operation. This messes up callers that explicitly ask for non-blocking
> operations.

Why does io_uring allow setting IOCB_NOWAIT without FMODE_NOWAIT, anyway?
