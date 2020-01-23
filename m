Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC92AC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A820F207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579821926;
	bh=wEeDKzLrdYAJ/fBHeU2h2gwQKPjX4vFELabN5Y7XPIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WTCD8lCLL+RIdABYNSNEa+Whs+1AHm6WHcJZf12ND4mHLNH6LC6CeD9XwelUIQ4za
	 8MS5FpkI9tBn7A1RiNeYxr4KkHip55SAYvFDFvzn71t6xqBsOfJYB2AthnFL8ZdxlZ
	 u+wfYtJ4i2y4OWJHRxFtKOZVBTe9jYDBbjO47df8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgAWXZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:25:25 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39645 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgAWXZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 18:25:25 -0500
Received: by mail-pj1-f66.google.com with SMTP id e11so192591pjt.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 15:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Edd2Wi9CD7RrglB/fQLlFZdfwFT64T8pCBM8AIxpxRQ=;
        b=Rejig7sl+v5cTLadH95ckrE/rFk85vPl4HWBUDko2L/5EgxUF57mdzjOxn0IHrV5T7
         7/G0B4lZkCpwbCp079KN5/1C8qItxdlKvyh+c8C6aFyU+YQ0KTwYp7SjALNUivYlTBan
         886eaYPN8cN+q7DOovP28CAcVu+M7VUZXW0jqyNdj12A8WJmuARiwM/5aehPLeHVaYpt
         dCy4VcL5tN24Yx4nvlrvHm/k2dH5yjf5nuBLKmJUUMiprCoa9Fr1RJGPdhbYk1FVHHwC
         y3c102SFPLNukper2GMznVAYO0NK3tPHlXv4adEJrzQeNb+dQ6OL5Bp0mvs4Q98RJmaz
         L/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Edd2Wi9CD7RrglB/fQLlFZdfwFT64T8pCBM8AIxpxRQ=;
        b=OTFPcO0T8l0JQ6HJ5orzF2gAYTytm/axMdEB6bJxBIOtu+z7fBwJxvL4bUbDtogLX1
         v0/yikH89rtYZEQaPOgsFzaSh5Dw9I2D3Du1zvvFllky6ZIol8ubxrguZ+hpLFCGhCSp
         k8xPZvU7PnmRpi88ZCaDQgpkk7j515s+ZPWNeUOq/k2p7FuaFyGA14FpyWXO2858AVwm
         jsentCzhn50kVBH0Ptb3VHz7dJ9/m6isOfJu+SrXbLHSrxWeZYH2M2XfTZKHd1IJpeEZ
         rZ1/jQIs/23tSnIA2QdrQcYcSYvEXIlgPGjAbisysJ/QsNhr5eWULi6iKjj0EQZyV5Ac
         bDgQ==
X-Gm-Message-State: APjAAAV7zQkiWD37Ft4F1TR4wM0GfC8+KutVZqUHxsYF6EA2esxC46J/
        3ojttnACqvK33/Fe6iMW730=
X-Google-Smtp-Source: APXvYqzzMftVoUgjQhJK1vpYFxX8dzEdoEPnGYUIRR0hhgmGNOftifj/eEYiWjAZwRWQiuBSTOsCLQ==
X-Received: by 2002:a17:902:d688:: with SMTP id v8mr585163ply.238.1579821924459;
        Thu, 23 Jan 2020 15:25:24 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id a16sm4007742pgb.5.2020.01.23.15.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:25:23 -0800 (PST)
Date:   Thu, 23 Jan 2020 15:25:21 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] zram: do not set ZRAM_IDLE bit for idlepage writeback in
 writeback_store()
Message-ID: <20200123232521.GA175683@google.com>
References: <20200121113557.11608-1-zbestahu@gmail.com>
 <20200123022305.GF249784@google.com>
 <20200123103936.000044ba.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123103936.000044ba.zbestahu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 10:39:36AM +0800, Yue Hu wrote:
> On Wed, 22 Jan 2020 18:23:05 -0800
> Minchan Kim <minchan@kernel.org> wrote:
> 
> > On Tue, Jan 21, 2020 at 07:35:57PM +0800, Yue Hu wrote:
> > > From: Yue Hu <huyue2@yulong.com>
> > > 
> > > Currently, we will call zram_set_flag() to set ZRAM_IDLE bit even for
> > > idlepage writeback. That is pointless. Let's set it only for hugepage mode.  
> > 
> > Could you be more specific? What do you see the problem with that?
> 
> If current writeback mode is idle, ZRAM_IDLE bit will be check firstly for this
> slot. Then go to call zram_set_flag(, , ZRAM_IDLE) if it's marked as ZRAM_IDLE.
> So, it's duplicated setting, am i right? 

As I wrote down in the description, it aims for the race with hugepage writeback.
Without it, there is no way to detect the slot is reallocated and marked
with huge again but it's new data so zram could free the page
unintentionally.
