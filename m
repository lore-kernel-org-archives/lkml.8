Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3232C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F4A221E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598448740;
	bh=N7hZxylonpulq+kvN5bIqiP/e2mXO2Jt1hFduoiS2vk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FQjJxBGKTFmHlcL2KqSRLY5FDdantnMO9rTorKE7F6ZqrquiOJtLa7mW+4SsWoSRH
	 puHfGSPX+85nIGJrkmzDn7W7zlqoEMpFod0gEcHNytFZ4voUoGJDD2tPCfKJHdc3sX
	 GHhzmKFsRA4o5KPivOBTeAJPwITFSGSlAXIk7GX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgHZNcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:32:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730288AbgHZNb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:31:57 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97A0621741;
        Wed, 26 Aug 2020 13:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598448716;
        bh=N7hZxylonpulq+kvN5bIqiP/e2mXO2Jt1hFduoiS2vk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HHHbW4O+lFudLOGG8w10yrHscW841Md6gaw0W5oaXoZM0peA8oJAYZJza+fpfjTek
         I8e+fqSVTuGp3U9k4VGGuUeYAwzpaVI0jkaJwC4DQb+5m3+jra3hoNLkYd+ElQ8Dbm
         b4xlH4UAyzGHgp7yjTOR593NTzAvN7l44aXcTst4=
Date:   Wed, 26 Aug 2020 15:31:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] docs: trace: ring-buffer-design.rst: use the new SPDX
 tag
Message-ID: <20200826153152.54ce996a@coco.lan>
In-Reply-To: <20200826064733.33c22a2c@lwn.net>
References: <290d101bee434e54acec13778c67c77802fbc953.1598426895.git.mchehab+huawei@kernel.org>
        <20200826064733.33c22a2c@lwn.net>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 26 Aug 2020 06:47:33 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 26 Aug 2020 09:28:24 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > SPDX v3.10 gained support for GFDL-1.2 with no invariant sections:
> > 
> > 	https://spdx.org/licenses/GFDL-1.2-invariants-only.html
> > 
> > Let's use it, instead of keeping a license text for this file.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/trace/ring-buffer-design.rst | 26 +---------------------
> >  1 file changed, 1 insertion(+), 25 deletions(-)  
> 
> [CC expanded]
> 
> If we're going to do this, I think we should also add GFDL to the right
> place in the LICENSES directory - deprecated/ or at best dual/.  But even
> SPDX (https://spdx.org/licenses/GFDL-1.2.html) says this license is
> deprecated.

Right. I'll send a separate patch adding it to deprecated/
together with GFDL-1.1-no-invariants-or-later, which is used
at the media uAPI documentation. There, GFDL 1.1 is used both
together with GPL (dual licensed is required for new files) and 
alone (for the legacy document files).

> 
> Beyond that, https://spdx.org/licenses/GFDL-1.2-invariants-only.html seems
> to disagree with your interpretation; it seems you would want 
> GFDL-1.2-only-no-invariants ?

Thanks for reviewing! Yeah, indeed I mangled this one. It
should be, instead:

	GFDL-1.2-no-invariants-only

https://spdx.org/licenses/GFDL-1.2-no-invariants-only.html

I'll send a second version fix it.

Thanks,
Mauro
