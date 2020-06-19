Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A5BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE74206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584866;
	bh=NDAz8UpTLqhZ7FdLtUin13OJKUA0jb58xry7q7XzBH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dQRgMf+YB7EiZc4fdPZNgNc5yQfdKAInYerq0WtqtM2MJiYU9TIicGlyqKl0E7m8s
	 feDIbwj5QtAjbS8j1nmweXQapUQd3T8z5gvdDlCmOCLh4t63kBDDMnR5DEGyn+WssD
	 ItHh1smDfLkus7cvRhGG6boU1RyuvoQdkU2WE3/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395483AbgFSQlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395473AbgFSQlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:41:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DF312067D;
        Fri, 19 Jun 2020 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592584860;
        bh=NDAz8UpTLqhZ7FdLtUin13OJKUA0jb58xry7q7XzBH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDjkDw3B5JIcZbKv6txKr3ENclkaJUCLBlRM8aNligeEUA/6Oq3IWw/vMyeoKXWs8
         /FOZD6g2z8v+XN+vyZeirPXbB4gsTy9WlA8+IwjOF4rym9mOs8mcxaJDdiv/9ED9VO
         wW86p+5KR7gmK0xMSlmQUyKDdHTxRLi7+rN7vX94=
Date:   Fri, 19 Jun 2020 18:40:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Daniel Gutson <daniel@eclypsium.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
Message-ID: <20200619164056.GB2235992@kroah.com>
References: <20200618220139.GH27951@zn.tnic>
 <CAFmMkTGMAu-huTnP1aeMb_W4NddbTD_b2jhbDVKBDrkwgB97wg@mail.gmail.com>
 <20200619074053.GA32683@zn.tnic>
 <CAFmMkTGV0ZR6C=EBGQAiz1vw1vrUXSLTnH5ZbBUvfhPLg_tF6g@mail.gmail.com>
 <20200619132243.GC32683@zn.tnic>
 <CAD2FfiEr0kRWp2ut_PVqVDEVZqwESUxv=fxM9wUgi3n=ZCzPcQ@mail.gmail.com>
 <20200619134432.GE32683@zn.tnic>
 <CAD2FfiFRqwYGB50KK=aA0sU6uCALYneoyD=V4EfOsk-Ex=C+xg@mail.gmail.com>
 <20200619161026.GF32683@zn.tnic>
 <CAD2FfiGN5kdHHEz-6Oy9S-fFT35bJH0ZOfqfn5SyCG_Y2LtE_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD2FfiGN5kdHHEz-6Oy9S-fFT35bJH0ZOfqfn5SyCG_Y2LtE_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 05:33:39PM +0100, Richard Hughes wrote:
> On Fri, 19 Jun 2020 at 17:10, Borislav Petkov <bp@alien8.de> wrote:
> > - do you just want to display feature support?
> 
> Yes. I want to show the user *why* TME is not available.

So even if it is "available" that's fine, even if it is not being used?

And how can you ever tell if a BIOS disables a CPU feature, yet the chip
still has it?  That should be not seen from the OS as it really doesn't
care, it just knows if the feature is able to be used or not.

thanks,

greg k-h
