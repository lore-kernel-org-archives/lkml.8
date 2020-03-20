Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74007C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E12D20754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584699691;
	bh=NZSnQDBgPuiRLwk7BUtGDRlwx1qB7pwmF0Mf3fESOQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pZientKdI8PjoOC76153AO82AXiHx9GTQs12sHtxMeR33qj+XBuvUw8ivjNqQqoer
	 3V862KStgE7MmnhKiQd1i32/2FS97KTXskbw05Yg4ZSADXYhIfl8m1OJR7W3iEjpQ3
	 TomCP3Y5b5g7mpgplu2XhgEyvx5osQQJ2GrTpF3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgCTKVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbgCTKV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:21:29 -0400
Received: from coco.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E2A020754;
        Fri, 20 Mar 2020 10:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584699688;
        bh=NZSnQDBgPuiRLwk7BUtGDRlwx1qB7pwmF0Mf3fESOQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nKvOTbu3MVtN4G+eSJLUiJm7CCaBMhoC7BCy2GzSitb7OhJr/l/sIff930JGWAYgu
         65Fl5ZH4puN2DxvNPGMtZMMsOgyli1IHdPhiXpDFxNUxS/yiEJ8eBIheSzOgaPiOON
         s/4pD2vhD5QRvjZI/90AtmXGudekcBIREPZPBQ2A=
Date:   Fri, 20 Mar 2020 11:21:22 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc: fix reference to core-api/namespaces.rst
Message-ID: <20200320112122.48244ec4@coco.lan>
In-Reply-To: <2008227.4siv4ILC15@harkonnen>
References: <20191122115337.1541-1-federico.vaga@vaga.pv.it>
        <20191122103437.59fda273@lwn.net>
        <2008227.4siv4ILC15@harkonnen>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 24 Nov 2019 18:02:02 +0100
Federico Vaga <federico.vaga@vaga.pv.it> escreveu:

> > diff --git a/Documentation/conf.py b/Documentation/conf.py
> > index 3c7bdf4cd31f..fa2bfcd6df1d 100644
> > --- a/Documentation/conf.py
> > +++ b/Documentation/conf.py
> > @@ -38,7 +38,7 @@ needs_sphinx = '1.3'
> >  # ones.
> >  extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain',
> >                'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
> > -              'maintainers_include']
> > +              'maintainers_include', 'sphinx.ext.autosectionlabel' ]
> > 

Testing today's linux-next branch. This extension caused *lots* of
warnings like this:

	Documentation/driver-api/uio-howto.rst:12: WARNING: duplicate label translations, other instance in Documentation/index.rst

The thing is that, by default, autosectionlabel uses a global namespace,
with cause lots of troubles with sections like "introduction". So, it
needs to be ensured that no duplication will happen.

Btw, I tried to setup this:

	diff --git a/Documentation/conf.py b/Documentation/conf.py
	index fa2bfcd6df1d..7eaadde98a86 100644
	--- a/Documentation/conf.py
	+++ b/Documentation/conf.py
	@@ -40,6 +40,9 @@ extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain',
	               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
	               'maintainers_include', 'sphinx.ext.autosectionlabel' ]
	 
	+# Avoid lots of warnings with autosectionlabel extension
	+autosectionlabel_prefix_document = True
	+
	 # The name of the math extension changed on Sphinx 1.4
	 if (major == 1 and minor > 3) or (major > 1):
	     extensions.append("sphinx.ext.imgmath")
	
But I still get lots of duplicated section labels inside the same file,
like this one (757 warnings):

	docs/Documentation/driver-api/parport-lowlevel.rst:815: WARNING: duplicate label driver-api/parport-lowlevel:description, other instance in Documentation/driver-api/parport-lowlevel.rst

There we have things that are similar to man pages, like this:

	parport_register_driver - register a device driver with parport
	---------------------------------------------------------------

	SYNOPSIS
	^^^^^^^^
...

	parport_unregister_driver - tell parport to forget about this driver
	--------------------------------------------------------------------

	SYNOPSIS
	^^^^^^^^

A solution would be to split all the files that are hitting this, but
I suspect that this is too much effort for too less benefit.

I would instead just revert this patch and fix it by adding a normal
explicit reference.

Another alternative would be to patch the Sphinx extension to make it
handle references on an hierarchical way, e. g. the above references
should be, instead of just "synopsis":

	parport-lowlevel / parport_register_driver - register a device driver with parport / synopsis
	parport-lowlevel / parport_unregister_driver - tell parport to forget about this driver / synopsis

Thanks,
Mauro
