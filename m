Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FFBC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A27F20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582549143;
	bh=M2xeY1+mvMxQnvZnq455N6I7n/0gOHkUPQT/TqrHN2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X1mBeldM6h2UpbO39MLQAqOXRCDpQh4igmwafEOeunOHAdwMnFTCybLgWZFgX1/FJ
	 PVUybpgMJbAhBUT3ciVxT8Vgk8wal92rTfpNTcU8F+OKFvAJVT5TbGG7vb2sn65DzB
	 /BtdFuP1J+q2K0mo6EnHg0nPO33jzJSBZVp4QIY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgBXM7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:59:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgBXM7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:59:01 -0500
Received: from localhost (95-141-97-180.as16211.net [95.141.97.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B0B62080D;
        Mon, 24 Feb 2020 12:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582549141;
        bh=M2xeY1+mvMxQnvZnq455N6I7n/0gOHkUPQT/TqrHN2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZAzkcyIwqTdoxeKhWy+NrmerxuxnEvglDRlBl0lFTczGkfSkvj1QXM7IFvNEtf/M
         i64Jk+hf8SYbj681bqaY9VNWar0+mxK7gc9U/z6GxF7dXkU28xl4bOQ9pF1ODfr2x9
         w+efVIcOCPIaen4ndWZ0zy+eHUJhS01fIsM+Zo4k=
Date:   Mon, 24 Feb 2020 13:58:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ppdev: Distribute switch variables for initialization
Message-ID: <20200224125858.GA700557@kroah.com>
References: <20200220062311.69121-1-keescook@chromium.org>
 <20200224123412.bo6e5yfjtinqzhle@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200224123412.bo6e5yfjtinqzhle@debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 12:34:12PM +0000, Sudip Mukherjee wrote:
> On Wed, Feb 19, 2020 at 10:23:11PM -0800, Kees Cook wrote:
> > Variables declared in a switch statement before any case statements
> > cannot be automatically initialized with compiler instrumentation (as
> > they are not part of any execution flow). With GCC's proposed automatic
> > stack variable initialization feature, this triggers a warning (and they
> > don't get initialized). Clang's automatic stack variable initialization
> > (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
> > doesn't initialize such variables[1]. Note that these warnings (or silent
> > skipping) happen before the dead-store elimination optimization phase,
> > so even when the automatic initializations are later elided in favor of
> > direct initializations, the warnings remain.
> > 
> > To avoid these problems, move such variables into the "case" where
> > they're used or lift them up into the main function body.
> > 
> > drivers/char/ppdev.c: In function ‘pp_do_ioctl’:
> > drivers/char/ppdev.c:516:25: warning: statement will never be executed [-Wswitch-unreachable]
> >   516 |   struct ieee1284_info *info;
> >       |                         ^~~~
> > 
> > [1] https://bugs.llvm.org/show_bug.cgi?id=44916
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> 
> Greg, Can you please take it in your tree...

Already taken :)
