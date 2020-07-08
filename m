Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A1BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE5F20738
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejQ9mmgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgGHDZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 23:25:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37355 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728061AbgGHDZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594178753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ImYyFHBCtoxsDXPMkKVzU97Whuo4av4Ssn/c4LXhV7Y=;
        b=ejQ9mmgt8IEX5NOPu3Qmd8lbs1JpTuh3macUUQH1zarsw3FfiWsua3yBoR5BTLpCKF+H0C
        xOU+ANzSIaqag4lvN128uzBux+waUwrHottqNo3nlJ2XQ6z1h9RBAZxuuhzrPnKDSKis+c
        fSr+n48GuXzEwvqW/mV79u/woByz0M8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-QO8slQYkNTi64yrVfnd5fQ-1; Tue, 07 Jul 2020 23:25:51 -0400
X-MC-Unique: QO8slQYkNTi64yrVfnd5fQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D92F800D5C;
        Wed,  8 Jul 2020 03:25:49 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-110.pek2.redhat.com [10.72.12.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 774F473FDD;
        Wed,  8 Jul 2020 03:25:46 +0000 (UTC)
Date:   Wed, 8 Jul 2020 11:25:42 +0800
From:   Dave Young <dyoung@redhat.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     bhe@redhat.com, vgoyal@redhat.com, corbet@lwn.net,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: kdump
Message-ID: <20200708032542.GB10532@dhcp-128-65.nay.redhat.com>
References: <20200627103151.71942-1-grandmaster@al2klimov.de>
 <20200701075803.GB3878@dhcp-128-65.nay.redhat.com>
 <1de76ef5-e447-2274-c45a-3b0356bd63ae@al2klimov.de>
 <20200708031704.GA10532@dhcp-128-65.nay.redhat.com>
 <8479acd3-5e35-4b64-5b2a-ad6549a62e4b@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8479acd3-5e35-4b64-5b2a-ad6549a62e4b@al2klimov.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/20 at 05:20am, Alexander A. Klimov wrote:
> 
> 
> Am 08.07.20 um 05:17 schrieb Dave Young:
> > On 07/01/20 at 07:33pm, Alexander A. Klimov wrote:
> > > 
> > > 
> > > Am 01.07.20 um 09:58 schrieb Dave Young:
> > > > On 06/27/20 at 12:31pm, Alexander A. Klimov wrote:
> > > > > Rationale:
> > > > > Reduces attack surface on kernel devs opening the links for MITM
> > > > > as HTTPS traffic is much harder to manipulate.
> > > > > 
> > > > > Deterministic algorithm:
> > > > > For each file:
> > > > >     If not .svg:
> > > > >       For each line:
> > > > >         If doesn't contain `\bxmlns\b`:
> > > > >           For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> > > > >             If both the HTTP and HTTPS versions
> > > > >             return 200 OK and serve the same content:
> > > > >               Replace HTTP with HTTPS.
> > > > > 
> > > > > Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> > > > > ---
> > > > >    If there are any URLs to be removed completely or at least not HTTPSified:
> > > > >    Just clearly say so and I'll *undo my change*.
> > > > >    See also https://lkml.org/lkml/2020/6/27/64
> > > > > 
> > > > >    If there are any valid, but yet not changed URLs:
> > > > >    See https://lkml.org/lkml/2020/6/26/837
> > > > > 
> > > > >    Documentation/admin-guide/kdump/kdump.rst | 10 +++++-----
> > > > >    1 file changed, 5 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> > > > > index 2da65fef2a1c..8cfa35f777f5 100644
> > > > > --- a/Documentation/admin-guide/kdump/kdump.rst
> > > > > +++ b/Documentation/admin-guide/kdump/kdump.rst
> > > > > @@ -65,20 +65,20 @@ Install kexec-tools
> > > > >    2) Download the kexec-tools user-space package from the following URL:
> > > > > -http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools.tar.gz
> > > > > +https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools.tar.gz
> > > > >    This is a symlink to the latest version.
> > > > >    The latest kexec-tools git tree is available at:
> > > > >    - git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> > > > > -- http://www.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> > > > > +- https://www.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> > > > >    There is also a gitweb interface available at
> > > > > -http://www.kernel.org/git/?p=utils/kernel/kexec/kexec-tools.git
> > > > > +https://www.kernel.org/git/?p=utils/kernel/kexec/kexec-tools.git
> > > > >    More information about kexec-tools can be found at
> > > > > -http://horms.net/projects/kexec/
> > > > > +https://horms.net/projects/kexec/
> > > > >    3) Unpack the tarball with the tar command, as follows::
> > > > > @@ -511,7 +511,7 @@ dump kernel.
> > > > >    You can also use the Crash utility to analyze dump files in Kdump
> > > > >    format. Crash is available on Dave Anderson's site at the following URL:
> > > > > -   http://people.redhat.com/~anderson/
> > > > > +   https://people.redhat.com/~anderson/
> > > > 
> > > > Would you mind to update above url as well?
> > > I'll update all of the URLs not changed yet, but (please) not in this patch
> > > round.
> > > 
> > > See also https://lkml.org/lkml/2020/6/26/837
> > 
> > If this series can be taken soon then we can wait and submit a patch
> > later.
> > 
> > Or just drop this one from your series, I can submit another one to take
> > the https and crash url together later.
> > 
> > Either works.
> Or (if you don't apply as-is) I'll just cover patched+non-patched together
> in round II.

Also good if you will post another round. feel free to add for either
this one or the potential updated one:

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

> 
> > 
> > > 
> > > > 
> > > > Dave have moved it to below url instead:
> > > > https://crash-utility.github.io/
> > > > 
> > > > Thanks
> > > > Dave
> > > > 
> > > 
> > 
> 

