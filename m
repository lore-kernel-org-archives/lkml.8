Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01F3C33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59CF20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580324710;
	bh=XLVFFfVGJaj7WKQxYlzuqjirzdJF+F55f9Ukm+Bj8hg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=b7t/YZhBWsZBJX1B+phXOiA08TASSQcyJo+NbUMsZVvNp9IG8S1sy3KA+a2tln50w
	 9Sccy2lRvhkyMzPmB9eBnP5gViZ9If8PJwfWiAYUymkdZIlEt8+NW8Pm+GzamhJ3uO
	 791ZNmQJvvnrtamZybTe22mcqPhgSJfx1mWVWUms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgA2TFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:05:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727515AbgA2TFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:05:06 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E25A206D4;
        Wed, 29 Jan 2020 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580324706;
        bh=XLVFFfVGJaj7WKQxYlzuqjirzdJF+F55f9Ukm+Bj8hg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WiHjYXJE2Ikw8kE24g2s9hN7WkNvPPk0VJZBegoEWjs3Dp/U5VI3Bn+PqUwE/bu2B
         IQa91z+5mz92hxUYHUIoSYn0MipgU1nn472pjElXA24/NnU4KWATVfbaFrQRfe053O
         eEdbFPBHmT3F4UWdgiZSUsH5DpgWYYzEUSlRVDZA=
Message-ID: <1580324704.2757.3.camel@kernel.org>
Subject: Re: [PATCH v3 02/12] tracing: Add trace_get/put_event_file()
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        ndesaulniers@google.com
Date:   Wed, 29 Jan 2020 13:05:04 -0600
In-Reply-To: <20200129125255.57159f85@gandalf.local.home>
References: <cover.1579904761.git.zanussi@kernel.org>
         <ec82da7de7689bdebbb447c83d9182c05efb0ba6.1579904761.git.zanussi@kernel.org>
         <20200129125255.57159f85@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-29 at 12:52 -0500, Steven Rostedt wrote:
> On Fri, 24 Jan 2020 16:56:13 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > +/**
> > + * trace_put_event_file - Release a file from
> > trace_get_event_file()
> > + * @file: The trace event file
> > + *
> > + * If a file was retrieved using trace_get_event_file(), this
> > should
> > + * be called when it's no longer needed.  It will cancel the
> > previous
> > + * trace_array_get() called by that function, and decrement the
> > + * event's module refcount.
> > + */
> > +void trace_put_event_file(struct trace_event_file *file)
> > +{
> > +	trace_array_put(file->tr);
> > +
> > +	mutex_lock(&event_mutex);
> > +	module_put(file->event_call->mod);
> > +	mutex_unlock(&event_mutex);
> 
> I believe the trace_array_put() needs to be at the end. Otherwise, I
> believe the file could be freed before the event_mutex is taken.
> 
> I'll swap it, as I'm trying to get this into the merge window.

OK, thanks,

Tom

> 
> -- Steve
> 
> > +}
> > +EXPORT_SYMBOL_GPL(trace_put_event_file);
> > +
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> >  
> >  /* Avoid typos */
> 
> 
