Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9B9C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA19218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTX3qZbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgEHMrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:47:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29635 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729578AbgEHMrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588942061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=scLEqBSEllA/rWbrO6NS8p6P9loIqw6BnJNugdMi+eA=;
        b=BTX3qZbTH+QtFr8upuhFr+MjiTJREQX+CkuYleZ4No22mzMYGuygzfxqSApugan3fAWVPn
        elsZrAKG1e9W9C+ntLXqh9H9ipq00hyM1Jdz1FXRZ00n1XHnHVym9J7MGgxaYH1szynJjP
        OZVfpJOcG3xqSIei/WpOSvYulKHxeJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-amwZP0r1MEyVfmBB0iyacA-1; Fri, 08 May 2020 08:47:36 -0400
X-MC-Unique: amwZP0r1MEyVfmBB0iyacA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4516080183C;
        Fri,  8 May 2020 12:47:34 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 21623707A6;
        Fri,  8 May 2020 12:47:22 +0000 (UTC)
Date:   Fri, 8 May 2020 08:47:19 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Tso Ted <tytso@mit.edu>, Adrian Bunk <bunk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Jeff Mahoney <jeffm@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Jessica Yu <jeyu@suse.de>, Takashi Iwai <tiwai@suse.de>,
        Ann Davis <AnDavis@suse.com>,
        Richard Palethorpe <rpalethorpe@suse.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        keescook@chromium.org, akpm@linux-foundation.org, cai@lca.pw,
        rdunlap@infradead.org
Subject: Re: [PATCH v2] kernel: add panic_on_taint
Message-ID: <20200508124719.GB367616@optiplex-lnx>
References: <20200507180631.308441-1-aquini@redhat.com>
 <20200507182257.GX11244@42.do-not-panic.com>
 <20200507184307.GF205881@optiplex-lnx>
 <20200507184705.GG205881@optiplex-lnx>
 <20200507203340.GZ11244@42.do-not-panic.com>
 <20200507220606.GK205881@optiplex-lnx>
 <20200507222558.GA11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507222558.GA11244@42.do-not-panic.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 10:25:58PM +0000, Luis Chamberlain wrote:
> On Thu, May 07, 2020 at 06:06:06PM -0400, Rafael Aquini wrote:
> > On Thu, May 07, 2020 at 08:33:40PM +0000, Luis Chamberlain wrote:
> > > I *think* that a cmdline route to enable this would likely remove the
> > > need for the kernel config for this. But even with Vlastimil's work
> > > merged, I think we'd want yet-another value to enable / disable this
> > > feature. Do we need yet-another-taint flag to tell us that this feature
> > > was enabled?
> > >
> > 
> > I guess it makes sense to get rid of the sysctl interface for
> > proc_on_taint, and only keep it as a cmdline option. 
> 
> That would be easier to support and k3eps this simple.
> 
> > But the real issue seems to be, regardless we go with a cmdline-only option
> > or not, the ability of proc_taint() to set any arbitrary taint flag 
> > other than just marking the kernel with TAINT_USER. 
> 
> I think we would have no other option but to add a new TAINT flag so
> that we know that the taint flag was modified by a user. Perhaps just
> re-using TAINT_USER when proc_taint() would suffice.
>

We might not need an extra taint flag if, perhaps, we could make these
two features mutually exclusive. The idea here is that bitmasks added 
via panic_on_taint get filtered out in proc_taint(), so a malicious 
user couldn't exploit the latter interface to easily panic the system,
when the first one is also in use. 
 
-- Rafael

