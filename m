Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5E2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A64208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGTBKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgGTBKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:10:05 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D855C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:10:05 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxKJd-00GEh6-6x; Mon, 20 Jul 2020 01:10:01 +0000
Date:   Mon, 20 Jul 2020 02:10:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Kevin Buettner <kevinb@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] copy_xstate_to_kernel: Fix typo which caused GDB
 regression
Message-ID: <20200720011001.GL2786714@ZenIV.linux.org.uk>
References: <20200718002003.6e0a2aef@f32-m1.lan>
 <CAPM=9tzJt5W8YpyBpyr0Xk3OwgA8iEOKe_zOtJSM3FThp38K4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tzJt5W8YpyBpyr0Xk3OwgA8iEOKe_zOtJSM3FThp38K4w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 09:40:14AM +1000, Dave Airlie wrote:
> Just adding Linus, as Al is oft distracted.

Already in vfs.git#fixes, actually:
commit 8d95867c8610c515ffab2913b2cb19b2c7f7f6c1
Author: Kevin Buettner <kevinb@redhat.com>
Date:   Sat Jul 18 00:20:03 2020 -0700

    copy_xstate_to_kernel: Fix typo which caused GDB regression
    
    This commit fixes a regression encountered while running the
    gdb.base/corefile.exp test in GDB's test suite.
    
    In my testing, the typo prevented the sw_reserved field of struct
    fxregs_state from being output to the kernel XSAVES area.  Thus the
    correct mask corresponding to XCR0 was not present in the core file
    for GDB to interrogate, resulting in the following behavior:
    
    [kev@f32-1 gdb]$ ./gdb -q testsuite/outputs/gdb.base/corefile/corefile testsuite/outputs/gdb.base/corefile/corefile.core
    Reading symbols from testsuite/outputs/gdb.base/corefile/corefile...
    [New LWP 232880]
    
    warning: Unexpected size of section `.reg-xstate/232880' in core file.
    
    With the typo fixed, the test works again as expected.
    
    Fixes: 9e46365459331 ("copy_xstate_to_kernel(): don't leave parts of destination uninitialized")
    Signed-off-by: Kevin Buettner <kevinb@redhat.com>
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
