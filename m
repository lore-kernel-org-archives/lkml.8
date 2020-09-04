Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D71DC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A7B7206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599215790;
	bh=oXkqbmPZIX9iH+h/LcRhtbJ74XmeSlkuteH+e+7Nnt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2bFburrWQBGN/ul4PvFHYGGKFpIu5FDzWbk7/FwvVbjJ+XVvoMxiOHk02P5mfCF6S
	 97Q7AAIoVJ5F5keePzm8OLs+gswZJ/v6EYHR9ZzoNcuSY1d/TX15a1z4wHUHHQvK6u
	 /S5o1cAk1dkQAEIXd9vyf6J3U6/v4dHO7NmhpYak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgIDKg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730072AbgIDKfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:35:21 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0312A206D4;
        Fri,  4 Sep 2020 10:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599215720;
        bh=oXkqbmPZIX9iH+h/LcRhtbJ74XmeSlkuteH+e+7Nnt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MgT8OdziQqIvhKq7TGvSWxjG3uUWAN9+u6QgCTgfmaYMSXMb9Qq69pWx+yNuayUzJ
         48tVbzB88le4lslhO0XQeyJ57X60lXHUSLsXMUfq2ivb0guYL7khK7aMP4uOOEtz2d
         IPXZCb7qP+tyWb8Cr76VCpKLD/Pa66XMqSrxUems=
Date:   Fri, 4 Sep 2020 12:35:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Changki Kim <changki.kim@samsung.com>, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        changbin.du@intel.com, masahiroy@kernel.org, rd.dunlap@gmail.com,
        krzk@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: printk: Add process name information to printk() output.
Message-ID: <20200904103541.GB2693206@kroah.com>
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com>
 <20200904082438.20707-1-changki.kim@samsung.com>
 <874kod6fgh.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kod6fgh.fsf@jogness.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 11:53:42AM +0206, John Ogness wrote:
> On 2020-09-04, Changki Kim <changki.kim@samsung.com> wrote:
> > Printk() meesages are the most basic and useful debug method.
> > However, additional information needs in multi-processor.
> > If we add messages with processor id and process name, we can find
> > a problem only with messages when the problem occurs with H/W IP or CPU.
> > This is very useful in narrowing down the scope of the problems.
> 
> [...]
> 
> > diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> > index e6302da041f9..fcefe9516606 100644
> > --- a/kernel/printk/printk_ringbuffer.h
> > +++ b/kernel/printk/printk_ringbuffer.h
> > @@ -21,6 +22,12 @@ struct printk_info {
> >  	u8	flags:5;	/* internal record flags */
> >  	u8	level:3;	/* syslog level */
> >  	u32	caller_id;	/* thread id or processor id */
> > +#ifdef CONFIG_PRINTK_PROCESS
> > +	int	pid;			/* process id */
> > +	u8	cpu_id;			/* processor id */
> > +	u8	in_interrupt;		/* interrupt conext */
> > +	char process[TASK_COMM_LEN];	/* process name */
> > +#endif
> >  };
> 
> I can understand the desire to have more information with messages. But
> IMHO adding it to the ringbuffer descriptor is the wrong place for
> it. The descriptor should really be limited to data that the printk
> subsystem needs for _itself_. With respect to LOG_CONT, I think we can
> agree that @caller_id is not enough. But there has been discussions [0]
> of having @caller_id provide a better context representation.
> 
> If we want to support adding more meta information to messages, I would
> prefer that the information is either prepended directly to the message
> text string or appended to the dictionary text string. We could even go
> so far as providing a boot argument where a list of information could be
> specified, what should be automatically added to the text/dict strings
> of each message. That would not require any ringbuffer changes and would
> allow new types of information to be added later.
> 
> Something like:
> 
>     printk.format=ts,cpu,comm,pid,in_atomic
> 
> John Ogness
> 
> [0] https://lkml.kernel.org/r/20200719143527.GA566@jagdpanzerIV.localdomain

Ah, finally a good use of the "dictionary" that we all can agree makes
sense :)

This does seem like a better solution overall, thanks.

greg k-h
