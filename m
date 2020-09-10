Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8CAC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352CE2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599757019;
	bh=GIOd68aD5s2ODT6PXYS1Bo0/NkpEhMffA97SHDguaXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fSr1CqRjS5TqZBQb2hbVZ05g54Y8N0j1O7OUcDvfl2tkzxinB0OgTflDw1lpGuQYR
	 wnZvycj3kwoNIJ0cO+j1f6zoWX3VhcdRZtdBTuscsOZwLwdpBIdAunabwiDyVCXYpB
	 Fh35x1kQbA6XtFyIWUH7sOAAOmzBtmWa9OYU/3/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgIJQ4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgIJQza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:55:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7139D21D90;
        Thu, 10 Sep 2020 16:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599756389;
        bh=GIOd68aD5s2ODT6PXYS1Bo0/NkpEhMffA97SHDguaXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RF5IhkyJvKQ42gsqx2D/gQfZlHzoIpDVmcHqxvAmvjl7IWLEuZrl58dI9C+JsaGMC
         2DqpxvowGWWDtciqv5eAjQMoRQUIN/PeHNRcYWG/IPBIGMOhOjt/vGW10lbTRY3zHp
         zK/G9vaYeThaHWggcw7W4QhxUpwQzqzyRzLMXJuM=
Date:   Thu, 10 Sep 2020 18:46:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     jim.cromie@gmail.com, Petr Mladek <pmladek@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>
Subject: Re: kernel BUG at /usr/src/kernel/lib/dynamic_debug.c:267!
Message-ID: <20200910164636.GA1458062@kroah.com>
References: <CA+G9fYvg7voMNArr3nPpv_dRn10RwYos075NW_b5rFbBLZ=-8g@mail.gmail.com>
 <20200909144745.504c4cbfeea9bc298e3c6b9b@kernel.org>
 <20200909080025.GC3864@alley>
 <20200909122502.GB668220@kroah.com>
 <CAJfuBxzNFmgY=Wbz99K8QTxkBVDaJn5+gTTxUTJTtkJe7nxfsQ@mail.gmail.com>
 <20200909181251.GA1007128@kroah.com>
 <20200910082323.59e41def@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910082323.59e41def@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 08:23:23AM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Wed, 9 Sep 2020 20:12:51 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >
> > I'll go revert both patches from my tree in the morning, which should
> > clear these issues up.
> 
> I have reverted them from linux-next today.
> 

Dropped in my tree now too, thanks.

greg k-h
