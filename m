Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AECFC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 03:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257602073E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 03:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4OeRzCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgDLDva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 23:51:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27954 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726633AbgDLDva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 23:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586663489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RMwbDDi8hNBOcv1tz+d1jrwNOMd0TGdpILpc5QVi8wc=;
        b=P4OeRzCoYz+uBvKFFyehoOn8AMxX0lFidxQOE6Pe6zQf0wXiSnGeLKIIc+aMw8Tq/Ohds2
        xgx6eYAlFj9uFzM9jW7cbUGMGsm/wfF/8kXLEEUuefjh3RdEekg1q6g+7UXlvdv1PKXDuD
        p7OCT8Wh5H9QQZdmJG+knIHckY2d3OY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-mEBUeA-zP26Vpyef_LPECQ-1; Sat, 11 Apr 2020 23:51:25 -0400
X-MC-Unique: mEBUeA-zP26Vpyef_LPECQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 205E5107ACC7;
        Sun, 12 Apr 2020 03:51:23 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81A855D9C9;
        Sun, 12 Apr 2020 03:51:16 +0000 (UTC)
Date:   Sun, 12 Apr 2020 11:51:11 +0800
From:   Dave Young <dyoung@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [GIT PULL 0/9] EFI fixes for v5.7-rc
Message-ID: <20200412035111.GA10163@dhcp-128-65.nay.redhat.com>
References: <20200409130434.6736-1-ardb@kernel.org>
 <20200409190109.GB45598@mit.edu>
 <CAMj1kXGiA3PAybR7r9tatL7WV5iU7B1OQxQok3d-JmRnhX1TnA@mail.gmail.com>
 <20200409201632.GC45598@mit.edu>
 <CAMj1kXFqKGSqm_y+ht4mmmu10TrhSyiTG8V3PxRYGodpZ=xNFQ@mail.gmail.com>
 <20200409235716.GF45598@mit.edu>
 <CAMj1kXH4VtNcJugpG_UR10ewGiOApTiw=C3FsuyAQQyg67Q8Aw@mail.gmail.com>
 <20200410135442.GA6772@dhcp-128-65.nay.redhat.com>
 <20200411194351.GQ45598@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411194351.GQ45598@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/20 at 03:43pm, Theodore Y. Ts'o wrote:
> On Fri, Apr 10, 2020 at 09:54:42PM +0800, Dave Young wrote:
> > 
> > The runtime cleanup looks a very good one, but I also missed that,
> > userspace kexec-tools will break with the efi setup_data changes. But
> > kexec_file_load will just work with the cleanup applied.
> 
> Hmmm, I wonder if there could be some kselftest or kunit tests that
> would make it easier to pick up these sorts of regressions earlier?

I thought about that before, but did not go with any actual actions.
kexec test needs a system reboot, Kdump is even harder to test, that is
the reason I hesitated about.

But since the breakage happens here and there frequently, it is time to
try it.  I think I will play with it, but I might be slow because of
other things,  welcome to post patches if anyone is interested :)

Thanks
Dave

