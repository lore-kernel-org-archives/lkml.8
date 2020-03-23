Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2ECC10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F9520736
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584946020;
	bh=QVu8pshIueptnWq5DfqM6RzxSosOhQobX0EIxgS3+tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dsiso4SDaCANp+G2zf0/24PIMzjHVKS0R2G9dLmZVksOHR0RYkT5wbGnrDFtENDaD
	 IktDNl4Sh2lzTeKDqgvAv7woG3S7AMrvmwfVZMm8Y9OmQKknMuJVI/EdPPw/WdrxB2
	 noXPYj+UBWtZ4tloqxDbE3OPe/Tfsn6JJAqxWSGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgCWGqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 02:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgCWGqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 02:46:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD349206C3;
        Mon, 23 Mar 2020 06:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584945978;
        bh=QVu8pshIueptnWq5DfqM6RzxSosOhQobX0EIxgS3+tQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sg8XDyy4bcIQo1pyPyqPapbTCtdpkBGhe24qXskcUHOQyR0SSLHYFii9c7vHA42wD
         4gH/ZOtKuB+tlLvlim6F/ixD6DJcDlaP/XOywmFN7/l+bMl5hcrAkeWI8Ng1Ej+HIS
         kyiKn/0xeufQekgSdb0CRfGToPH8fiCfVl9iU3sk=
Date:   Mon, 23 Mar 2020 07:46:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     jslaby@suse.com, slyfox@gentoo.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, rei4dan@gmail.com,
        Dave Tian <dave.jing.tian@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: UBSAN: Undefined behaviour in drivers/tty/vt/keyboard.c
Message-ID: <20200323064616.GB129571@kroah.com>
References: <CAEAjamv3wT4aqF0y1_PHG_=cbzH-ATsP6TiV5Zt5Qc+ACVnOPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEAjamv3wT4aqF0y1_PHG_=cbzH-ATsP6TiV5Zt5Qc+ACVnOPw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 11:34:01PM -0400, Kyungtae Kim wrote:
> We report a bug (in linux-5.5.11) found by FuzzUSB (modified version
> of syzkaller)
> 
> Seems the variable "npadch" has a very large value (i.e., 333333333)
> as a result of multiple executions of the function "k_ascii" (keyboard.c:888)
> while the variable "base" has 10.
> So their multiplication at line 888 in "k_ascii" will become
> larger than the max of type int, causing such an integer overflow.
> 
> I believe this can be solved by checking for overflow ahead of operations
> e.g., using check_mul_overflow().
> 
> kernel config: https://kt0755.github.io/etc/config_v5.5.11

Great, can you send a patch for this?

thanks,

greg k-h
