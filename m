Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81346C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 04:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528A3206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 04:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgANEji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 23:39:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33226 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgANEji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 23:39:38 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irDzA-007liS-Hx; Tue, 14 Jan 2020 04:39:24 +0000
Date:   Tue, 14 Jan 2020 04:39:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        stable <stable@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>, dev@opencontainers.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 0/1] mount: universally disallow mounting over
 symlinks
Message-ID: <20200114043924.GV8904@ZenIV.linux.org.uk>
References: <20200103014901.GC8904@ZenIV.linux.org.uk>
 <20200108031314.GE8904@ZenIV.linux.org.uk>
 <CAHk-=wgQ3yOBuK8mxpnntD8cfX-+10ba81f86BYg8MhvwpvOMg@mail.gmail.com>
 <20200108213444.GF8904@ZenIV.linux.org.uk>
 <CAHk-=wiq11+thoe60qhsSHk_nbRF2TRL1Wnf6eHcYObjhJmsww@mail.gmail.com>
 <20200110041523.GK8904@ZenIV.linux.org.uk>
 <979cf680b0fbdce515293a3449d564690cde6a3f.camel@themaw.net>
 <20200112213352.GP8904@ZenIV.linux.org.uk>
 <800d36a0dccd43f1b61cab6332a6252ab9aab73c.camel@themaw.net>
 <19fa114ef619057c0d14dc1a587d0ae9ad67dc6d.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19fa114ef619057c0d14dc1a587d0ae9ad67dc6d.camel@themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 08:25:19AM +0800, Ian Kent wrote:

> This isn't right.
> 
> There's actually nothing stopping a user from using a direct map
> entry that's a multi-mount without an actual mount at its root.
> So there could be directories created under these, it's just not
> usually done.
> 
> I'm pretty sure I don't check and disallow this.

IDGI...  How the hell will that work in v5?  Who will set _any_
traps outside the one in root in that scenario?  autofs_lookup()
won't (there it's conditional upon indirect mount).  Neither
will autofs_dir_mkdir() (conditional upon version being less
than 5).  Who will, then?

Confused...
