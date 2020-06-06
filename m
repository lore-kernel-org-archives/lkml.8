Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C02C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 00:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942B9207DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 00:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591404056;
	bh=ynPm+R5qnJUv1qWnzWuVetQRM4x1+bzYVuZrX3Nswu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lY0lep76Z4Q65dmlaGSLsjvk8TFb0ns+3FtdgNke2FK5JfTsNcznTngm/oIft3zHT
	 Br6WjZ9S1pwZSgeh0RG7VcwI2N37kDwVtbsWyML2r8kF+GP8iLoJ/zlPHhLnOuN8q3
	 cX6Fxa3HOFzfWd04DQKGAMz0MdQU8OcOdVpx9WTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgFFAkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 20:40:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgFFAky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 20:40:54 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE955207D8;
        Sat,  6 Jun 2020 00:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591404054;
        bh=ynPm+R5qnJUv1qWnzWuVetQRM4x1+bzYVuZrX3Nswu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JplcRKJjmOTh/iK9VknGih2SYLbfIm3CmGr4e+e9KLgLmuDIgsNxZsqDHdvHoOsOE
         Ox3D7UlV5ps2wWSjrOT/7FPcRoEuKieD044plvgEKB4VbPhj54Z76eKGl1oG3brDBG
         l9S7BksB14fjwO6KFExp6W6eQf2GLCq3y/6HN6Og=
Date:   Fri, 5 Jun 2020 17:40:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Relocate execve() sanity checks
Message-Id: <20200605174053.eea9557878d81024d2519e47@linux-foundation.org>
In-Reply-To: <20200605160013.3954297-1-keescook@chromium.org>
References: <20200605160013.3954297-1-keescook@chromium.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Jun 2020 09:00:10 -0700 Kees Cook <keescook@chromium.org> wrote:

> While looking at the code paths for the proposed O_MAYEXEC flag, I saw
> some things that looked like they should be fixed up.
> 
>   exec: Change uselib(2) IS_SREG() failure to EACCES
> 	This just regularizes the return code on uselib(2).
> 
>   exec: Move S_ISREG() check earlier
> 	This moves the S_ISREG() check even earlier than it was already.
> 
>   exec: Move path_noexec() check earlier
> 	This adds the path_noexec() check to the same place as the
> 	S_ISREG() check.

Thanks.

These don't seem super-urgent and they aren't super-reviewed, so I
suggest we hold them off until the next cycle?
