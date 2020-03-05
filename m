Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBF2C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F1820728
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583443643;
	bh=1mpkhEjowOTj06SYF9CKH8R/sxtlQaKStbLZ59s7558=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KApReZRTqXEE3dk6TG3CZBFH5f4tOHngneKKnNI+nOITy+wKwzUfkhzvvLjgaQDP9
	 vUlRdvOQh2o7gDa4hrUX/Mt1N8jhXEJx+vk6hM4KZfwRfKCuWrrSNB24P2Bq2Ri5lk
	 rHTiAWbWT5FW1svfZLN0P2mMdfRgtfFU6ez4oOS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCEV1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:27:22 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43577 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCEV1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:27:22 -0500
Received: by mail-qv1-f67.google.com with SMTP id eb12so3128618qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 13:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9K4pNKxCAagBBMJm2ftqWB6E4IhmeUAZc+AwmoD+QfY=;
        b=OV9REuI3f16c9bO8tfKOSIbk8GH0XUI6o5hykP4CQ1y5UTlQ1bYfBN2IVlStbuBpxp
         ofdc7ZRECsoKSXc2h78qsz+O3GbmLn7tlv/IRRCoOVIBi6xuyS+B3sqPjmyP473nScea
         xwvxhvo+VmC09agCoZphQAh33K2CmJ0NSnRQFP35BQT9KhdmU1OduV4JLiqwK887EpIn
         M0Q0N/8iu3Vlov6Qaum3ya+zC5QrbAFdEqbkzLk6Owg7WpCaHmCmajfqTg+Wj7BeftB8
         8ExBOkQYMaMmGqrDK4mR7kTAGbJ5nqDa5Is862HlLjVNhwrCTLHqNWuXBq28rW15fGwF
         RcCA==
X-Gm-Message-State: ANhLgQ35ZszhvMKoU9MRGGXqusbof0sHJQhAHy3jJfhMHrT3/paZ+Z1U
        2pIkDOOjhjIAVfgBtohTPHs9brT48NQ=
X-Google-Smtp-Source: ADFU+vtmbrAIZLCWQQliGk6t/24DTq4EYksoC7ftXffZQK+Uv/TSUaTzVdWp328mFA1Y5/ccH86T6g==
X-Received: by 2002:a0c:a910:: with SMTP id y16mr244117qva.139.1583443641107;
        Thu, 05 Mar 2020 13:27:21 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::b9df])
        by smtp.gmail.com with ESMTPSA id i91sm16814609qtd.70.2020.03.05.13.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 13:27:20 -0800 (PST)
Date:   Thu, 5 Mar 2020 16:27:18 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [RESEND PATCH] percpu_ref: Fix comment regarding percpu_ref_init
 flags
Message-ID: <20200305212718.GA79730@dennisz-mbp.dhcp.thefacebook.com>
References: <20200221231607.12782-1-ira.weiny@intel.com>
 <20200221235627.GA59628@dennisz-mbp.dhcp.thefacebook.com>
 <20200222004656.GA459391@carbon.DHCP.thefacebook.com>
 <20200223143222.GA29607@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223143222.GA29607@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 06:32:23AM -0800, Ira Weiny wrote:
> 
> [snip]
> 
> > > > diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
> > > > index 4f6c6ebbbbde..48d7fcff70b6 100644
> > > > --- a/lib/percpu-refcount.c
> > > > +++ b/lib/percpu-refcount.c
> > > > @@ -50,9 +50,9 @@ static unsigned long __percpu *percpu_count_ptr(struct percpu_ref *ref)
> > > >   * @flags: PERCPU_REF_INIT_* flags
> > > >   * @gfp: allocation mask to use
> > > >   *
> > > > - * Initializes @ref.  If @flags is zero, @ref starts in percpu mode with a
> > > > - * refcount of 1; analagous to atomic_long_set(ref, 1).  See the
> > > > - * definitions of PERCPU_REF_INIT_* flags for flag behaviors.
> > > > + * Initializes @ref.  If @flags is zero or PERCPU_REF_ALLOW_REINIT, @ref starts
> > > > + * in percpu mode with a refcount of 1; analagous to atomic_long_set(ref, 1).
> > > > + * See the definitions of PERCPU_REF_INIT_* flags for flag behaviors.
> > > 
> > > Yeah. Prior we had both PERCPU_REF_INIT_ATOMIC and PERCPU_REF_INIT_DEAD
> > > with the latter implying the former. So 0 meant percpu and the others
> > > meant atomic. With PERCPU_REF_ALLOW_REINIT, it's probably easier to
> > > understand by saying if neither PERCPU_REF_INIT_ATOMIC or
> > > PERCPU_REF_INIT_DEAD is set, it starts out in percpu mode which is
> > > mentioned in the comments where the flags are defined.  It's not great
> > > having implied flags, but it's worked so far.
> > > 
> > > Also, it's not quite analagous to atomic_long_set(ref, 1) as there is a
> > > bias to prevent prematurely hitting 0.
> > > 
> > > I can take this and massage the wording a bit.
> > 
> > Hello Ira! Hello Dennis!
> > 
> > Yeah, I'd simple say that it starts in the percpu mode, except the case when
> > PERCPU_REF_INIT_ATOMIC is set, then (atomic mode, 1) and
> > PERCPU_REF_INIT_DEAD is set, then (atomic mode, 0).
> > 
> > PERCPU_REF_ALLOW_REINIT actually doesn't affect the initial state.
> > 
> 
> Thanks for the clarification.  Dennis let me know if you want me to resubmit
> the patch.
> 
> Thanks!
> Ira
> 

Sorry for the delay. I've applied it to for-5.7.

Thanks,
Dennis
