Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A064C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2AD206F9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgDUDmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 23:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgDUDmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 23:42:55 -0400
X-Greylist: delayed 3185 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Apr 2020 20:42:55 PDT
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13770C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 20:42:55 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQjo9-007Hot-Ua; Tue, 21 Apr 2020 03:42:50 +0000
Date:   Tue, 21 Apr 2020 04:42:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, glider@google.com,
        adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        sunhaoyl@outlook.com
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in
 fill_thread_core_info()
Message-ID: <20200421034249.GB23230@ZenIV.linux.org.uk>
References: <20200419100848.63472-1-glider@google.com>
 <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
 <202004201540.01C8F82B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004201540.01C8F82B@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 03:41:40PM -0700, Kees Cook wrote:
> On Mon, Apr 20, 2020 at 03:33:52PM -0700, Andrew Morton wrote:
> > On Sun, 19 Apr 2020 12:08:48 +0200 glider@google.com wrote:
> > 
> > > KMSAN reported uninitialized data being written to disk when dumping
> > > core. As a result, several kilobytes of kmalloc memory may be written to
> > > the core file and then read by a non-privileged user.
> 
> Ewww. That's been there for 12 years. Did something change in
> regset_size() or regset->get()? Do you know what leaves the hole?

Not lately and I would also like to hear the details; which regset it is?
Should be reasonably easy to find - just memset() the damn thing to something
recognizable, do whatever triggers that KMSAN report and look at that
resulting coredump.

