Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D72C35666
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 14:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5111F206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 14:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgBWOcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 09:32:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:56097 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgBWOcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 09:32:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 06:32:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,476,1574150400"; 
   d="scan'208";a="437447468"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga006.fm.intel.com with ESMTP; 23 Feb 2020 06:32:23 -0800
Date:   Sun, 23 Feb 2020 06:32:23 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [RESEND PATCH] percpu_ref: Fix comment regarding percpu_ref_init
 flags
Message-ID: <20200223143222.GA29607@iweiny-DESK2.sc.intel.com>
References: <20200221231607.12782-1-ira.weiny@intel.com>
 <20200221235627.GA59628@dennisz-mbp.dhcp.thefacebook.com>
 <20200222004656.GA459391@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222004656.GA459391@carbon.DHCP.thefacebook.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[snip]

> > > diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
> > > index 4f6c6ebbbbde..48d7fcff70b6 100644
> > > --- a/lib/percpu-refcount.c
> > > +++ b/lib/percpu-refcount.c
> > > @@ -50,9 +50,9 @@ static unsigned long __percpu *percpu_count_ptr(struct percpu_ref *ref)
> > >   * @flags: PERCPU_REF_INIT_* flags
> > >   * @gfp: allocation mask to use
> > >   *
> > > - * Initializes @ref.  If @flags is zero, @ref starts in percpu mode with a
> > > - * refcount of 1; analagous to atomic_long_set(ref, 1).  See the
> > > - * definitions of PERCPU_REF_INIT_* flags for flag behaviors.
> > > + * Initializes @ref.  If @flags is zero or PERCPU_REF_ALLOW_REINIT, @ref starts
> > > + * in percpu mode with a refcount of 1; analagous to atomic_long_set(ref, 1).
> > > + * See the definitions of PERCPU_REF_INIT_* flags for flag behaviors.
> > 
> > Yeah. Prior we had both PERCPU_REF_INIT_ATOMIC and PERCPU_REF_INIT_DEAD
> > with the latter implying the former. So 0 meant percpu and the others
> > meant atomic. With PERCPU_REF_ALLOW_REINIT, it's probably easier to
> > understand by saying if neither PERCPU_REF_INIT_ATOMIC or
> > PERCPU_REF_INIT_DEAD is set, it starts out in percpu mode which is
> > mentioned in the comments where the flags are defined.  It's not great
> > having implied flags, but it's worked so far.
> > 
> > Also, it's not quite analagous to atomic_long_set(ref, 1) as there is a
> > bias to prevent prematurely hitting 0.
> > 
> > I can take this and massage the wording a bit.
> 
> Hello Ira! Hello Dennis!
> 
> Yeah, I'd simple say that it starts in the percpu mode, except the case when
> PERCPU_REF_INIT_ATOMIC is set, then (atomic mode, 1) and
> PERCPU_REF_INIT_DEAD is set, then (atomic mode, 0).
> 
> PERCPU_REF_ALLOW_REINIT actually doesn't affect the initial state.
> 

Thanks for the clarification.  Dennis let me know if you want me to resubmit
the patch.

Thanks!
Ira

