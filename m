Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76E1C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D492084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578991164;
	bh=ibooc4ilG3fQgevj3cmSZM514xfAkkxvVViw+scuzd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sMSK5k1+w4EidQrzfCFiGzpkSlsPuvxEUCp1GRcOfZbWaAuMzo7K2g/cHb8uMqJLZ
	 5lvIXzd/kZA9QJ4i/NkUtojd71ErWv37c71LeNe8zyiMPgRqyJKipv6ynbCGhPY+vK
	 NRwaav4S/cnZAoM7R68S4c3Esxp8CxKEgO635Tzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgANIjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:39:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbgANIjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:39:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB4E5207FF;
        Tue, 14 Jan 2020 08:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578991162;
        bh=ibooc4ilG3fQgevj3cmSZM514xfAkkxvVViw+scuzd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sggS8/ihqlAuR3aPWn/m+ljuNPPLtoNjrFFh/UGju4ln9fyab22LGQxrv2kwiaAwB
         PG4oC0DU1UFok5Yz6pQTuv57zUJ0LjbnpA2NOc87n746rbsj10M6tWQWF0jcuuNmwD
         V31FHgL5H+1y0isdM9D7E5JHTV4Vm4ihdVJ+J9K0=
Date:   Tue, 14 Jan 2020 09:39:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wchenbt@cse.ust.hk
Cc:     linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        jslaby@suse.com, nico@fluxnic.net, textshell@uchuujin.de
Subject: Re: KASAN: use-after-free Read in vc_do_resize; KASAN:
 use-after-free Read in screen_glyph_unicode;
Message-ID: <20200114083919.GB1113529@kroah.com>
References: <e250a4c2e373d33d4cdade677cacbeb6.squirrel@imail.cse.ust.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e250a4c2e373d33d4cdade677cacbeb6.squirrel@imail.cse.ust.hk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 03:16:36PM +0800, wchenbt@cse.ust.hk wrote:
> Dear Linux kernel developers,
> 
> I found the crash "KASAN: use-after-free Read in vc_do_resize" and "KASAN:
> use-after-free Read in screen_glyph_unicode" when running syzkaller, hope
> it’s unknown:
> 
> Linux version: 1c163f4c7b3f Linux 5.0
> Branch: drivers/tty/vt/vt.c

"Branch" is a filename?

And 5.0 is almost a year old, please use a more modern kernel, like 5.4
at the very least.

And patches are the best way to fix syzbot issues, if you can still
reproduce this, sending a patch is the best way to get it fixed.

thanks,

greg k-h
