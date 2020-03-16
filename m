Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF54C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC4420754
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584367801;
	bh=EB7VShUPlmAf0BiLwy/4NA2pZfxn04F0sDEqYs3uYuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mjBf92tNSz17Ch1IVs1NTT1WhGnojEDsHXgM6uLHgHCDWWYxSK9JGuVfZ8Xs/E4VQ
	 /s+O2XrQy7ZUxKZZnXrdSO+1IHUOmgoxpIfXN8+e8VvwrEKKK1beT1lffYmqJx0NGZ
	 LqXBv25dCyHuL/2Yg2YYPWb1UhlDcmK8IOtFYWvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbgCPOJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731254AbgCPOJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:09:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC1EE20753;
        Mon, 16 Mar 2020 14:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584367798;
        bh=EB7VShUPlmAf0BiLwy/4NA2pZfxn04F0sDEqYs3uYuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tsEzye+Gv9NGJwbgV2b1VikBAPV92ZcbqcffX3CDpKkmIn8hqHXgdqEOI0wK+aIOH
         kFiNDAPmUo5z0sxXngZzFea5K+eroi49TRsoIwV9vtinOL9wEqXuC4/GnKPtYJ3T5M
         PIolp42B+fBPT6SN70b3R01jDo4stqCH8uzEQhtk=
Date:   Mon, 16 Mar 2020 15:07:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Petr Malat <oss@malat.biz>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        x86@kernel.org, terrelln@fb.com, clm@fb.com, keescook@chromium.org
Subject: Re: [PATCH 2/2] x86: Enable support for ZSTD-compressed kernel
Message-ID: <20200316140745.GB4041840@kroah.com>
References: <20200316135025.7579-1-oss@malat.biz>
 <20200316135025.7579-2-oss@malat.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316135025.7579-2-oss@malat.biz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:50:25PM +0100, Petr Malat wrote:
> Signed-off-by: Petr Malat <oss@malat.biz>
> ---
>  arch/x86/Kconfig                  | 1 +
>  arch/x86/boot/compressed/Makefile | 5 ++++-
>  arch/x86/boot/compressed/misc.c   | 4 ++++
>  arch/x86/include/asm/boot.h       | 4 ++--
>  4 files changed, 11 insertions(+), 3 deletions(-)

I know I don't take patches without any changelog text, maybe other
maintainers are more lax...
