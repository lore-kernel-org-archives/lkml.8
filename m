Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C93CC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB36222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EfQDyeEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbgBUSVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:21:24 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33542 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBUSVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:21:23 -0500
Received: by mail-il1-f193.google.com with SMTP id s18so2415999iln.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 10:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G+cK2mC91PpoKPuuQapIOX9FR9b5Qc4ESPnNis4hpgk=;
        b=EfQDyeEgUQ+Qrg3DR0QoNoIzub5X+GGPRyCL4wxAaHasogsRptEb4Bd3oZsiAj8JJ7
         lZn/hkEDEXRyzUqAvCl8cr2JD5Etvb+cmEs2s2Cad1bwkk9ILLelnGoUv4F+/saa00vv
         gqwYX4mkB0NB72J6Qn96FnMf9CGb77Rf7KzjqNz+zrg3cOV3eZQakrvLwdYV9z7bZzYO
         +RdslPjKKhdH8UD7/xTT4KTldsxXYQouOP/G+Fd35reI8X69P35eURChBNjaWhGNwKVx
         6IGayzQZ/e/Cpo5wAsHckqVGWuTzf1BXh4Mma+S0NgI9/YX5hK5XBkzCUJ2+ZUe3ael4
         6PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G+cK2mC91PpoKPuuQapIOX9FR9b5Qc4ESPnNis4hpgk=;
        b=Opyd6qjcbJakgOjpzyCy3x6DVPH8RuT2cvRoFPKsTBFH1oZDZzaYh2hwG4953K/vfA
         cankzZuwqlsFmnSro/OYm6wG8x/9oKqLY+5PZbQ0hY3bdi40ZF7QQZuUa5va9boLKo+4
         DiEjWuBi525cnErKu5VTaaxLOqAaIgojLfWI0wfJbT36LO/eljzT6cDJs8uSLVMRMpxD
         fd3NdnnlfOLAOnO0j3qF4eFuuMceQ/V+R04tZR3nLCV/iCL+8A9+oGGgraUnv7/x/6np
         EeN1F/CeWayJIRGSpnoD6+CVRx3ibaQQgWxVCG6bVVnWWmOq4A1KJcozkhjxRdxtsDgN
         8V5A==
X-Gm-Message-State: APjAAAXH9Gwki9onOZ+4u/UMUHZGW0LO6HEWnOWb9D0Rgmy04CgiRS+O
        TGYmKu6bfScWcIM3AWa2IVIIYQ==
X-Google-Smtp-Source: APXvYqzTx1bJI3NV1Je5vKEqfQz6Se6Ip4sz6bG67kElIeHlfVsBUh/m8L5U5SI49Ara8F0hgbMlPQ==
X-Received: by 2002:a92:d18a:: with SMTP id z10mr39526131ilz.48.1582309281689;
        Fri, 21 Feb 2020 10:21:21 -0800 (PST)
Received: from google.com ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id f16sm1147037ilq.16.2020.02.21.10.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 10:21:20 -0800 (PST)
Date:   Fri, 21 Feb 2020 11:21:19 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Raul Rangel <rrangel@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5] Add a "nosymfollow" mount option.
Message-ID: <20200221182119.GA89482@google.com>
References: <20200204215014.257377-1-zwisler@google.com>
 <CAHQZ30BgsCodGofui2kLwtpgzmpqcDnaWpS4hYf7Z+mGgwxWQw@mail.gmail.com>
 <CAGRrVHwQimihNNVs434jNGF3BL5_Qov+1eYqBYKPCecQ0yjxpw@mail.gmail.com>
 <CAGRrVHyzX4zOpO2nniv42BHOCbyCdPV9U7GE3FVhjzeFonb0bQ@mail.gmail.com>
 <20200205032110.GR8731@bombadil.infradead.org>
 <20200205034500.x3omkziqwu3g5gpx@yavin>
 <CAGRrVHxRdLMx5axcB1Fyea8RZhfd-EO3TTpQtOvpOP0yxnAsbQ@mail.gmail.com>
 <20200213154642.GA38197@google.com>
 <20200221012142.4onrcfjtyghg237d@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221012142.4onrcfjtyghg237d@yavin.dot.cyphar.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 12:21:42PM +1100, Aleksa Sarai wrote:
> On 2020-02-13, Ross Zwisler <zwisler@google.com> wrote:
> > On Thu, Feb 06, 2020 at 12:10:45PM -0700, Ross Zwisler wrote:
<>
> > > As far as I can tell, SB_SUBMOUNT doesn't actually have any dependence on
> > > MS_SUBMOUNT. Nothing ever sets or checks MS_SUBMOUNT from within the kernel,
> > > and whether or not it's set from userspace has no bearing on how SB_SUBMOUNT
> > > is used.  SB_SUBMOUNT is set independently inside of the kernel in
> > > vfs_submount().
> > > 
> > > I agree that their association seems to be historical, introduced in this
> > > commit from David Howells:
> > > 
> > > e462ec50cb5fa VFS: Differentiate mount flags (MS_*) from internal superblock flags
> > > 
> > > In that commit message David notes:
> > > 
> > >      (1) Some MS_* flags get translated to MNT_* flags (such as MS_NODEV ->
> > >          MNT_NODEV) without passing this on to the filesystem, but some
> > >          filesystems set such flags anyway.
> > > 
> > > I think this is sort of what we are trying to do with MS_NOSYMFOLLOW: have a
> > > userspace flag that translates to MNT_NOSYMFOLLOW, but which doesn't need an
> > > associated SB_* flag.  Is it okay to reclaim the bit currently owned by
> > > MS_SUBMOUNT and use it for MS_NOSYMFOLLOW.
> > > 
> > > A second option would be to choose one of the unused MS_* values from the
> > > middle of the range, such as 256 or 512.  Looking back as far as git will let
> > > me, I don't think that these flags have been used for MS_* values at least
> > > since v2.6.12:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/fs.h?id=1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
> > > 
> > > I think maybe these used to be S_WRITE and S_APPEND, which weren't filesystem
> > > mount flags?
> > > 
> > > https://sites.uclouvain.be/SystInfo/usr/include/sys/mount.h.html
> > > 
> > > A third option would be to create this flag using the new mount system:
> > > 
> > > https://lwn.net/Articles/753473/
> > > https://lwn.net/Articles/759499/
> > > 
> > > My main concern with this option is that for Chrome OS we'd like to be able to
> > > backport whatever solution we come up with to a variety of older kernels, and
> > > if we go with the new mount system this would require us to backport the
> > > entire new mount system to those kernels, which I think is infeasible.  
> > > 
> > > David, what are your thoughts on this?  Of these three options for supporting
> > > a new MS_NOSYMFOLLOW flag:
> > > 
> > > 1) reclaim the bit currently used by MS_SUBMOUNT
> > > 2) use a smaller unused value for the flag, 256 or 512
> > > 3) implement the new flag only in the new mount system
> > > 
> > > do you think either #1 or #2 are workable?  If so, which would you prefer?
> > 
> > Gentle ping on this - do either of the options using the existing mount API
> > seem possible?  Would it be useful for me to send out example patches in one
> > of those directions?  Or is it out of the question, and I should spend my time
> > on making patches using the new mount system?  Thanks!
> 
> I think (1) or (2) sound reasonable, but I'm not really the right person
> to ask.

Cool, I appreciate the feedback. :)  I'll go ahead and implement #2 and send
it out, along with example man page updates.
