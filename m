Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE18FC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C8320757
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgEFNwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728717AbgEFNwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:52:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF5D20752;
        Wed,  6 May 2020 13:52:41 +0000 (UTC)
Date:   Wed, 6 May 2020 09:52:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>, jmorris@namei.org,
        sashal@kernel.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] pstore/platform: pass max_reason to kmesg dump
Message-ID: <20200506095239.11a76a76@gandalf.local.home>
In-Reply-To: <202005051444.14B6686@keescook>
References: <20200505154510.93506-1-pasha.tatashin@soleen.com>
        <20200505154510.93506-3-pasha.tatashin@soleen.com>
        <202005051444.14B6686@keescook>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020 14:59:37 -0700
Kees Cook <keescook@chromium.org> wrote:

> > @@ -97,6 +97,8 @@ struct pstore_record {
> >   * @read_mutex:	serializes @open, @read, @close, and @erase callbacks
> >   * @flags:	bitfield of frontends the backend can accept writes for
> >   * @data:	backend-private pointer passed back during callbacks
> > + * @max_reason: Used when PSTORE_FLAGS_DMESG is set. Contains the
> > + *              kmsg_dump_reason enum value.  
> 
> Nit: please move this above @data since it has a @flags dependency.
> 
> >   *
> >   * Callbacks:
> >   *
> > @@ -180,6 +182,7 @@ struct pstore_info {
> >  
> >  	int		flags;
> >  	void		*data;
> > +	int		max_reason;

Not to mention that moving max_reason above data will fill in the hole left
by a 32 bit int, followed by a 64 bit pointer.

-- Steve


> >  
> >  	int		(*open)(struct pstore_info *psi);
> >  	int		(*close)(struct pstore_info *psi);
