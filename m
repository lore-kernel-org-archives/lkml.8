Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3686C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF4D2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbgGUXEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgGUXEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:04:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2DBC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 16:04:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jy1JC-00HUkp-Vd; Tue, 21 Jul 2020 23:04:27 +0000
Date:   Wed, 22 Jul 2020 00:04:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xtensa: fix access check in csum_and_copy_from_user
Message-ID: <20200721230426.GC2786714@ZenIV.linux.org.uk>
References: <20200721220035.32584-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721220035.32584-1-jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 03:00:35PM -0700, Max Filippov wrote:
> Commit d341659f470b ("xtensa: switch to providing
> csum_and_copy_from_user()") introduced access check, but incorrectly
> tested dst instead of src.
> Fix access_ok argument in csum_and_copy_from_user.

Applied, with apologies...  Which tree do you want it to go through?
I'm dropping it into vfs.git#fixes, will send to Linus unless you
prefer it to go some other way...
