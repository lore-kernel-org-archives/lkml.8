Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFE4C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A97F920768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599594835;
	bh=/d50LFwjiLHA4Aqpr8JwcrmMS8zjjCTo0VyxGdT+oNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NXjaaFFC+3G1qK4jf5rX9mpwuhQ6GVYKHu50GE6QB7EeHsCjeye1ZNPgYWu0yekFf
	 UUohKbxnCWE+n4ejiuU17r3FFaqYGUqxmN5Wxr4/vigq7JoX6JTroaqtvT777Tt5Bp
	 HCTRB0XP9BHcJAHXivTn+L5CsemaZj7JsspDU5ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgIHTxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730604AbgIHPme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:42:34 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 771D2221EB;
        Tue,  8 Sep 2020 15:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599578582;
        bh=/d50LFwjiLHA4Aqpr8JwcrmMS8zjjCTo0VyxGdT+oNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nbz4R8lbUZEHvU1gtNbMwTjBjyqKKWd1+eR+DjVSHyIHiz8IJEaGCht9DglAzqR3o
         E6anWYGrSOMLWD9BEP9a9aBgCfyNPkAbZDKZb2bUWOJWVpLMoK07D362zJMcJIPNfJ
         jyNRBh1DYhJWHiOKTomjphlyaUo/7henJOk23A0U=
Date:   Tue, 8 Sep 2020 17:23:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 04/12] x86/platform/uv: Update UV MMRs for UV5
Message-ID: <20200908152314.GD4114051@kroah.com>
References: <20200907185430.363197758@hpe.com>
 <20200907185430.782245884@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907185430.782245884@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 01:54:34PM -0500, Mike Travis wrote:
> --- linux.orig/drivers/misc/sgi-gru/grufile.c
> +++ linux/drivers/misc/sgi-gru/grufile.c
> @@ -7,7 +7,8 @@
>   * This file supports the user system call for file open, close, mmap, etc.
>   * This also incudes the driver initialization code.
>   *
> - *  Copyright (c) 2008-2014 Silicon Graphics, Inc.  All Rights Reserved.
> + * Copyright (c) 2018-2020 Hewlett Packard Enterprise Development LP
> + * Copyright (c) 2008-2017 Silicon Graphics, Inc.  All Rights Reserved.

Please drop all copyright changes from this series, as these do not look
correct at all, sorry.

You can send an add-on patch for all of that if it's really necessary,
and you get legal approval for it :)

thanks,

greg k-h
