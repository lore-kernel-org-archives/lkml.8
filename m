Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510FAC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2664021739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583351593;
	bh=0lTNiqZihmhD7dU5xCTNqpQeoONQroZErkdsf+IQ3/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WaO/WgmdNri2wskdIBfm0eGoSE0bWumrn4fFtOTvgHuwYhoSIDmDrAoMH+S6hk5Jm
	 s9nMRT/Yf6hpMkUjpopwJlpl2gReE2/YD5L3K36AtRlV6JBnmUJwWv/O1MatGn+FUj
	 1o38gqBkduSkQZDTWoQ0r28S0g8W/VWJWNEwvo2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgCDTxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:53:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbgCDTxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 14:53:11 -0500
Received: from coco.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75F6521556;
        Wed,  4 Mar 2020 19:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583351590;
        bh=0lTNiqZihmhD7dU5xCTNqpQeoONQroZErkdsf+IQ3/Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bkbUz2MGPto95211PrLHnmVLW09hqCkKIoImnDXStIZdoPSH+iXesJndKimBINClM
         14U6bHtjKEJRVSLW++vtxwlnlzx0bpYrVIwGeHv2sI24xDaFuseQlNp1/remEX/8HA
         bpBCBeXx1Xl2SdoAmct30hoL33ahPlRePrwEC3l4=
Date:   Wed, 4 Mar 2020 20:53:05 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "tbird20d@gmail.com" <tbird20d@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/sphinx-pre-install: add '-p python3' to
 virtualenv
Message-ID: <20200304205252.51bac986@coco.lan>
In-Reply-To: <MWHPR13MB08952CDE2E8F16781B704C18FDE50@MWHPR13MB0895.namprd13.prod.outlook.com>
References: <1582594481-23221-1-git-send-email-tim.bird@sony.com>
        <20200302130911.05a7e465@lwn.net>
        <MWHPR13MB0895EFDA9EBF7740875E661CFDE40@MWHPR13MB0895.namprd13.prod.outlook.com>
        <20200303130152.461c3494@lwn.net>
        <MWHPR13MB08952CDE2E8F16781B704C18FDE50@MWHPR13MB0895.namprd13.prod.outlook.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 4 Mar 2020 17:25:41 +0000
"Bird, Tim" <Tim.Bird@sony.com> escreveu:

> > -----Original Message-----
> > From: Jonathan Corbet <corbet@lwn.net>
> > 
> > On Tue, 3 Mar 2020 17:07:48 +0000
> > "Bird, Tim" <Tim.Bird@sony.com> wrote:
> >   
> > > The less fragile approach would have been to just
> > > always add the '-p python3' option to the virtualenv setup hint,
> > > but Mauro seemed to want something more fine-tuned.  
> > 
> > At some point I think we'll want to say that Python 2 just isn't supported
> > anymore.  After all, the language itself isn't supported anymore.  Perhaps
> > it's time to add a warning somewhere.  
> 
> Probably.  IMHO always adding the 'p python3' would have been the
> first vestiges of such a hint, but maybe it should be more explicit.
> A more explicit statement of "watch out if your default python
> interpreter is python2" would have probably shortened some of 
> my setup time.

A warning like that makes sense to me.

> Ubuntu 16.04 and Ubuntu 18.04 both include python3, but have
> /usr/bin/python default to python2.  So, while the package recommendations
> from the script were good (and sufficient), the virtualenv hint was somewhat
> lacking.

And if you try to change the Ubuntu default to python3, some things break 
there (I did that last month using alternates on Ubuntu 19.10 - had to 
revert back to python2).

> And, just for full disclosure, I wish there was a way to mark this type of fix
> with a obsolescence  flag so it could be removed later.  This is the type of
> thing that gets put into a script as a workaround for a transition period, but
> keeps being run 10 years later when it's no longer relevant.  Heck, the whole
> virtualenv recommendation might be irrelevant in the next version of Ubuntu
> (but maybe the script already figures that out.)

Actually, virtualenv support was added later ;-)

The script supports both virtualenv and distro package install, although
the current default is to use virtualenv. You can force it to recommend the
distro package with:

	$ ./scripts/sphinx-pre-install --no-virtualenv
	Detected OS: Fedora release 30 (Thirty).

	ERROR: please install "python-sphinx", otherwise, build won't work.
	Warning: better to also install "sphinx_rtd_theme".
	You should run:

		sudo dnf install -y python3-sphinx python3-sphinx_rtd_theme

	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 721.

The main reason why virtualenv is the default is that we need to
ensure a certain minimal version (nowadays, it is recommended at least 1.7.9). 
If one is using a LTS distro, the distro-package could be older than that.

With virtualenv, it is easier to fulfill the minimal version (and the
recommended one). You may even have multiple Sphinx versions, with is
quite useful when trying to identify if the html and/or pdf output
is doing the right thing with different toolchain versions.

Thanks,
Mauro
