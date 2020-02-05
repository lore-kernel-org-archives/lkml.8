Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5641FC35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 07:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB532082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 07:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvknTrFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgBEHby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 02:31:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37237 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727937AbgBEHby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 02:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580887913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p+vHVfvg9RS9GtRD1GA/N0DOI6G5HQHabXxVzxzzhJ8=;
        b=SvknTrFWmlAc8toVPIr/iJyDP3yicjClo8Rbcta5q25hQsw78VgkCMXnI5meeRW10BVZVe
        mT1e5fcIYNCzV6il3Hi7wguLVXqYX5QHzeFeOwvSEDnuQalsJMOJc2z3gMm+dazw6Y08Os
        FyhUWOxfMm1s9y7hOsGyEZy7NVvDxmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-VdY2oLuUMzuHW3iPGAZQ4g-1; Wed, 05 Feb 2020 02:31:51 -0500
X-MC-Unique: VdY2oLuUMzuHW3iPGAZQ4g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31C2C189F760;
        Wed,  5 Feb 2020 07:31:50 +0000 (UTC)
Received: from localhost (ovpn-12-97.pek2.redhat.com [10.72.12.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4457E5C1B2;
        Wed,  5 Feb 2020 07:31:47 +0000 (UTC)
Date:   Wed, 5 Feb 2020 15:31:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Airlie <airlied@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, dyoung@redhat.com
Subject: Re: mgag200 fails kdump kernel booting
Message-ID: <20200205073144.GA8965@MiWiFi-R3L-srv>
References: <20190626081522.GX24419@MiWiFi-R3L-srv>
 <20190626082907.GY24419@MiWiFi-R3L-srv>
 <CAMwc25oeskFG4bbrb3rwotqi1a5z4wYsGW=Qs_XJmhX_vAdNfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMwc25oeskFG4bbrb3rwotqi1a5z4wYsGW=Qs_XJmhX_vAdNfQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave, Lyude,

On 07/02/19 at 06:51am, David Airlie wrote:
> On Wed, Jun 26, 2019 at 6:29 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 06/26/19 at 04:15pm, Baoquan He wrote:
> > > Hi Dave,
> > >
> > > We met an kdump kernel boot failure on a lenovo system. Kdump kernel
> > > failed to boot, but just reset to firmware to reboot system. And nothing
> > > is printed out.
> > >
> > > The machine is a big server, with 6T memory and many cpu, its graphic
> > > driver module is mgag200.
> > >
> > > When added 'earlyprintk=ttyS0' into kernel command line, it printed
> > > out only one line to console during kdump kernel booting:
> > >      KASLR disabled: 'nokaslr' on cmdline.
> > >
> > > Then reset to firmware to reboot system.
> > >
> > > By further code debugging, the failure happened in
> > > arch/x86/boot/compressed/misc.c, during kernel decompressing stage. It's
> > > triggered by the vga printing. As you can see, in __putstr() of
> > > arch/x86/boot/compressed/misc.c, the code checks if earlyprintk= is
> > > specified, and print out to the target. And no matter if earlyprintk= is
> > > added or not, it will print to VGA. And printing to VGA caused it to
> > > reset to firmware. That's why we see nothing when didn't specify
> > > earlyprintk=, but see only one line of printing about the 'KASLR
> > > disabled'.
> >
> > Here I mean:
> > That's why we see nothing when didn't specify earlyprintk=, but see only
> > one line of printing about the 'KASLR disabled' message when
> > earlyprintk=ttyS0 added.
> 
> Just to clarify, the original kernel is booted with mgag200 turned
> off, then kexec works, but if the original kernel loads mgag200, the
> kexec kernels resets hard when the VGA is used to write stuff out.
> 
> This *might* be fixable in the controlled kexec case, but having an
> mgag200 shutdown path that tries to put the gpu back into a state
> where VGA doesn't die, but for the uncontrolled kexec it'll still be a
> problem, since once the gpu is up and running and VGA is disabled, it
> doesn't expect to see anymore VGA transactions.

Now we have got other two bug reports on different systems, finally
figured out it's the same issue as this after debugging. And adding
'nomodeset' can work around it.

With the help from our QA, tried to get more systems with mgag200,
seems not all of them have this issue, some of them with mgag200 can
jump to kdump well after panic.

Any suggestion about how to proceed? I can experiment. Or if you would
like to have a look when convenient, I can get one system to you to
check. Or, can we just use 'nomodeset' as work around and hold this
issue for the time being?

Appreciate if any suggestion or idea.

> 
> Dave.
> >
> > >
> > > To confirm it's caused by VGA printing, I blacklist the mgag200 by
> > > writting it into /etc/modprobe.d/blacklist.conf. The kdump kernel can
> > > boot up successfully. And add 'nomodeset' can also make it work. So it's
> > > for sure mgag driver or related code have something wrong when booting
> > > code tries to re-init it.
> > >
> > > This is the only case we ever see, tend to pursuit fix in mgag200 driver
> > > side. Any idea or suggestion? We have two machines to be able to
> > > reproduce it stablly.
> > >
> > > Thanks
> > > Baoquan

