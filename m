Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944B2C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5522495B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgEHNtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726904AbgEHNtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:49:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F38320A8B;
        Fri,  8 May 2020 13:49:46 +0000 (UTC)
Date:   Fri, 8 May 2020 09:49:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, jeyu@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de, mingo@redhat.com,
        aquini@redhat.com, cai@lca.pw, dyoung@redhat.com, bhe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, gpiccoli@canonical.com,
        pmladek@suse.com, tiwai@suse.de, schlad@suse.de,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] taint: add module firmware crash taint support
Message-ID: <20200508094923.2ab9014a@gandalf.local.home>
In-Reply-To: <20200508101604.GF185537@smile.fi.intel.com>
References: <20200508021438.4373-1-mcgrof@kernel.org>
        <20200508101604.GF185537@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 13:16:04 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > +++ b/include/trace/events/module.h
> > @@ -26,7 +26,8 @@ struct module;
> >  	{ (1UL << TAINT_OOT_MODULE),		"O" },		\
> >  	{ (1UL << TAINT_FORCED_MODULE),		"F" },		\
> >  	{ (1UL << TAINT_CRAP),			"C" },		\
> > -	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" })
> > +	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" },		\
> > +	{ (1UL << TAINT_FIRMWARE_CRASH),	"Q" })  
> 
> Perhaps split out the closing parenthesis to avoid changing additional line in
> the future?

I don't think that will make a difference, as the last line must not
contain a comma. New updates will still add additional line changes just to
insert a comma before adding a new flag.

-- Steve

> 
> >  TRACE_EVENT(module_load,  

