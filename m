Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51DEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE752073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583254876;
	bh=M8qxYvgQXX14YLcGf+b9l7zWzEL047vLx9YwgV80qkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aJr1JCNVO1D6ZyHSSJvuhpDgcaPdbXHol3dqyTjPB6j6pwRudRdJKFScqC6VY1UoP
	 G/2xl3qh/8aY88N316Sxor8glsRAb8D6X4R4Mx7DZwP8haFXAlB0t6Zic35ke+Bpb0
	 Pe6YLlSE55qfPTDbBtfwSYD/by9zZzTg1tBWW0nQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgCCRBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:01:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgCCRBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:01:15 -0500
Received: from onda.lan (ip-109-40-2-133.web.vodafone.de [109.40.2.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D98C42073B;
        Tue,  3 Mar 2020 17:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583254874;
        bh=M8qxYvgQXX14YLcGf+b9l7zWzEL047vLx9YwgV80qkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ij4l8jdmw3wvTqvzDeg4XCG0yQ/8CNU3l6XB0WknejV9BHw7CN7/PryP49fNkSByc
         QJHqbfwsD+82fRjGFSui6SLFqGTUmMa9y3MSTYCX/5Xt+qEnNVOM9zpjk2JcERiD6d
         7jJ8XMod4+mmrSYonMkS+j+q23vqR3BUsH1n+wEk=
Date:   Tue, 3 Mar 2020 18:01:09 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 00/12] Convert some DT documentation files to ReST
Message-ID: <20200303180109.670ad7f8@onda.lan>
In-Reply-To: <CAL_JsqKsZNFDSsZJ+wzgD1Eaf0fBwZ7BeUv=32jAuE29TeRfnA@mail.gmail.com>
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
        <20200302123554.08ac0c34@lwn.net>
        <20200303080947.5f381004@onda.lan>
        <CAL_JsqKsZNFDSsZJ+wzgD1Eaf0fBwZ7BeUv=32jAuE29TeRfnA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 3 Mar 2020 10:20:25 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Tue, Mar 3, 2020 at 1:09 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Em Mon, 2 Mar 2020 12:35:54 -0700
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> >  
> > > On Mon,  2 Mar 2020 08:59:25 +0100
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > >  
> > > > While most of the devicetree stuff has its own format (with is now being
> > > > converted to YAML format), some documents there are actually
> > > > describing the DT concepts and how to contribute to it.
> > > >
> > > > IMHO, those documents would fit perfectly as part of the documentation
> > > > body, as part of the firmare documents set.
> > > >
> > > > This patch series manually converts some DT documents that, on my
> > > > opinion, would belong to it.  
> > >
> > > Did you consider putting this stuff into the firmware-guide while you were
> > > at it?  It's not a perfect fit, I guess, but it doesn't seem too awkward
> > > either.  
> >
> > I placed it just below the firmware-guide at the main index file.
> >
> > I have split thoughts about moving the files to there, though. From
> > one side, it may fit better from the PoV of organizing the documentation.
> >
> > From other side, newcomers working with DT may expect looking at the
> > text files inside Documentation/devicetree/.
> >
> > Maybe I could add an extra patch at the end of this series with the
> > move, adding a "RFC" on his title. This way, we can better discuss it,
> > and either merge the last one or not depending on the comments.  
> 
> Keep in mind that we generate a standalone DT only tree[1] with the
> documentation, dts files and headers. So things should be structured
> such that all the DT documentation could be built by itself without
> dependencies on the 'kernel documentation'. I'm not asking for that to
> be done in this series, but just don't do anything to make that
> harder. I don't *think* have, but just want to make sure that's clear.

So, I guess it is better to keep the .rst files under Documentation/devicetree,
instead of moving them to Documentation/firmware-guide.

Well, if moved, I guess it would be easy to modify the scripts that produce
the documentation to also parse something a new directory inside
Documentation/firmware-guide.

> 
> > > It also seems like it would be good to CC the devicetree folks, or at
> > > least the devicetree mailing list?  
> 
> I was wondering what happened to the cover letter on v2...
> 
> > Yeah, that would make sense. I'm using get-maintainers script to
> > prepare the c/c list, as it is simply too much work to find the
> > right maintainers by hand, for every single patch.
> >
> > I just noticed today that there's just *one entry* at MAINTAINERS
> > file for Documentation/devicetree, and that points to you:
> >
> >         DOCUMENTATION
> >         M:      Jonathan Corbet <corbet@lwn.net>
> >         L:      linux-doc@vger.kernel.org
> >         S:      Maintained
> >         F:      Documentation/
> >         F:      scripts/documentation-file-ref-check
> >         F:      scripts/kernel-doc
> >         F:      scripts/sphinx-pre-install
> >         X:      Documentation/ABI/
> >         X:      Documentation/firmware-guide/acpi/
> >         X:      Documentation/devicetree/  
> 
> You mean doesn't point to Jon as 'X' is exclude. You missed this entry:
> 
> OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> M:      Rob Herring <robh+dt@kernel.org>
> M:      Mark Rutland <mark.rutland@arm.com>
> L:      devicetree@vger.kernel.org
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> Q:      http://patchwork.ozlabs.org/project/devicetree-bindings/list/
> S:      Maintained
> F:      Documentation/devicetree/
> F:      arch/*/boot/dts/
> F:      include/dt-bindings/

Yeah, I remember I saw something like the above in the past. However,
I'm not seeing this entry at the MAINTAINERS file at next-20200303 anymore.

Did someone removed such entry?

> 
> 
> Rob
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
