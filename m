Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65085C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43026206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XRtuwHdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgHLNzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgHLNzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:55:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6B9C061384
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 06:55:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a26so2382382ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 06:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZcIucU/ldxd0dbDYM4XtjXVSKv642KUcN/yZSDiGto=;
        b=XRtuwHdxJqOzPIFxerMkyp8hhNxNJMsP2AwEx7trHlV+heDqTH77rrr6fEaAGI5sq8
         gvZQXMiSqqMWj9SIJNysFAtJVN2JUflQ+Ggha4iGRaHB9eBRRtdYycXaP1afY2gc/1Gi
         blQ5bCn2ECUSS5OJ+iE2oN8giTALSTWteYRUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZcIucU/ldxd0dbDYM4XtjXVSKv642KUcN/yZSDiGto=;
        b=f5vDEDJcKmKD1C2mc9f+902VhPJwgscftpahPRAz7VMQ53kXDXnI4cuTv9fhXpbYhi
         xX0p05Fz/DksMLtG77eCLi+twy+KAI2y4rhjdA1cttBap2ypfB1+vkX5SLSV9eGLJzCu
         CwbgpBmWkqgLZwbJjmzu+gsdVSfRDE2U0qBWYhf+4W0QTgtl4T7ixnNg/xsN/1GDGQ4J
         OWqxXU2Uq7SH0X9YGkTQyXaLnK2Vc9mzj0zgRgx3pdRJ4MSMFZH8fIHqrxYkKKOceTg7
         kQYHlCaQlu6vc9ExBZyEk8u1mmpEh5eraBOiBcYfMRSh2m7aX1DFWWmIAGYowEV+6XpP
         Zevw==
X-Gm-Message-State: AOAM531jsY7a1sZKcIGIWCPk7H3E/hCNEFG3QB0tmnuq9WUBVdKMPhWW
        FV882oWaAJWYlQuyylgV6+VGM2tOevMzRxSFy0esuL18nGBAVQ==
X-Google-Smtp-Source: ABdhPJzUNNYA8k0uex8jfqOZllA0O05gwHDjFPq3AxWJVK67L46SkPySElUc7Ev1MgfSUw2yHyZXngaRqwl8Tu3X5vM=
X-Received: by 2002:a17:907:405f:: with SMTP id ns23mr30169147ejb.511.1597240501997;
 Wed, 12 Aug 2020 06:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <20200812101405.brquf7xxt2q22dd3@ws.net.home> <CAJfpegs4gzvJMBz=su8KgXXxX41tv8tVhO88Eap9pDeHRaSDPA@mail.gmail.com>
 <133508.1597239193@warthog.procyon.org.uk>
In-Reply-To: <133508.1597239193@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 15:54:50 +0200
Message-ID: <CAJfpegv9pCXoAeGzq6KBH-R1q9OODqJMFpNfKryLPN-oNygjJw@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     David Howells <dhowells@redhat.com>
Cc:     Karel Zak <kzak@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 3:33 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > You said yourself, that what's really needed is e.g. consistent
> > snapshot of a complete mount tree topology.  And to get the complete
> > topology FSINFO_ATTR_MOUNT_TOPOLOGY and FSINFO_ATTR_MOUNT_CHILDREN are
> > needed for *each* individual mount.
>
> That's not entirely true.
>
> FSINFO_ATTR_MOUNT_ALL can be used instead of FSINFO_ATTR_MOUNT_CHILDREN if you
> want to scan an entire subtree in one go.  It returns the same record type.
>
> The result from ALL/CHILDREN includes sufficient information to build the
> tree.  That only requires the parent ID.  All the rest of the information
> TOPOLOGY exposes is to do with propagation.
>
> Now, granted, I didn't include all of the topology info in the records
> returned by ALL/CHILDREN because I don't expect it to change very often.  But
> you can check the event counter supplied with each record to see if it might
> have changed - and then call TOPOLOGY on the ones that changed.

IDGI, you have all these interfaces but how will they be used?

E.g. one wants to build a consistent topology together with
propagation and attributes.   That would start with
FSINFO_ATTR_MOUNT_ALL, then iterate the given mounts calling
FSINFO_ATTR_MOUNT_INFO and FSINFO_ATTR_MOUNT_TOPOLOGY for each.  Then
when done, check the subtree notification counter with
FSINFO_ATTR_MOUNT_INFO on the top one  to see if anything has changed
in the meantime.  If it has, the whole process needs to be restarted
to see which has been changed (unless notification is also enabled).
How does the atomicity of FSINFO_ATTR_MOUNT_ALL help with that?  The
same could be done with just FSINFO_ATTR_MOUNT_CHILDREN.

And more importantly does level of consistency matter at all?  There's
no such thing for directory trees, why are mount trees different in
this respect?

> Text interfaces are also a PITA, especially when you may get multiple pieces
> of information returned in one buffer and especially when you throw in
> character escaping.  Of course, we can do it - and we do do it all over - but
> that doesn't make it efficient.

Agreed.  The format of text interfaces matters very much.

Thanks,
Miklos
