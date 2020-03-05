Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D99C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BA4207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583444065;
	bh=IlGxCo+3Eu420GZyWp84Ltnm/C3wZdDdgPLWI4ZtJOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hvIHd2bTaPIs/pEtxha4DMfeT6ByPgrH0kV7r2pcBypxwgGqaxknV1VU8ynJ/uZVD
	 oCduKww+2UfdTYXfKAUWqptkr5jEDkL2E8r14KUOog7OCldkaUURsVhQKwzYrQCfj5
	 5De9SGeB9AV3ntTO+bczx0dUeY+69qoHFMtR6U4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgCEVeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:34:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbgCEVeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:34:24 -0500
Received: from coco.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A417F20728;
        Thu,  5 Mar 2020 21:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583444063;
        bh=IlGxCo+3Eu420GZyWp84Ltnm/C3wZdDdgPLWI4ZtJOo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e1YXpkQepYP5f+HafW//7Je967kcdVYeqvoupSSIaZUrc1aKzrfRENakXJU8OmR0S
         1kn6Geug/qUNt46YbkNWW8xLnCqLFlKsouexXNZZNBivk63o4iI/dJrENO+oKWZWVd
         yJcKx4NQ2MKxCQhrfHAHgaeXn6Us8xZj1U6RGFl8=
Date:   Thu, 5 Mar 2020 22:34:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Markus Heiser <markus.heiser@darmarit.de>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>, Jonathan Corbet <corbet@lwn.net>,
        "tbird20d@gmail.com" <tbird20d@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/sphinx-pre-install: add '-p python3' to
 virtualenv
Message-ID: <20200305223416.6a0fdedc@coco.lan>
In-Reply-To: <c491adf3-ae49-fefc-ea6d-32b75f4f9ca9@darmarit.de>
References: <1582594481-23221-1-git-send-email-tim.bird@sony.com>
        <20200302130911.05a7e465@lwn.net>
        <MWHPR13MB0895EFDA9EBF7740875E661CFDE40@MWHPR13MB0895.namprd13.prod.outlook.com>
        <20200304064214.64341a49@onda.lan>
        <31a69fe7-c08d-9381-a111-5f522a4c9ffd@darmarit.de>
        <20200304093138.6aced5a0@coco.lan>
        <c491adf3-ae49-fefc-ea6d-32b75f4f9ca9@darmarit.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 4 Mar 2020 10:20:34 +0100
Markus Heiser <markus.heiser@darmarit.de> escreveu:

> 
> Am 04.03.20 um 09:31 schrieb Mauro Carvalho Chehab:
> > Em Wed, 4 Mar 2020 07:20:48 +0100
> > Markus Heiser <markus.heiser@darmarit.de> escreveu:
> >> With py3 the recommended way to install virtual environments is::
> >>
> >>     python3 -m venv sphinx-env
> >>
> >> This (python3) is what worked for me on RHEL/CentOS (dnf),
> >> archlinux and debian/ubuntu (tested from 16.04 up to 20.04).
> > 
> > Hmm... from:
> > 
> > 	https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/
> > 
> > This works since Python version 3.3. It sounds doable to use it.
> > 
> > Yet, if we'll be switching to this method, the script should check if
> > the version is 3.3 or newer. The logic inside get_sphinx_fname() would
> > also require some changes, as it won't need to install anymore the
> > virtualenv program for Python >= 3.3.
> 
> I guess you can ignore 3.2 and downwards
> 
>    https://en.wikipedia.org/wiki/History_of_Python#Table_of_versions
> 
> Support for py2.7 and >=py3.3 should match nearly all use cases / distributions 
> we support.
> 
> BTW: starting scripts with:
> 
> -m <module-name>
>      Searches sys.path for the named module and runs the
>      corresponding .py file as a script.
> 
> is mostly more robust.  The option exists also in py2.  From py3.3 on
> a subset of virtualenv is built-in, so you can run '-m venv' ot of the
> box.

I did some tests... as everything with python, it is not so simple...
The thing is that "-mvenv" requires a python module called "ensurepip".

On Fedora, openSuse and archlinux, this is installed together with
python3, but Debian maintainers had a different idea about how to package it.
There, ensurepip is inside a python3-venv-3.x (where x is 5, 6 or 7 -
depending on the Ubuntu/Debian version, and if backports repository is
been used or not).

There is a package python3-venv too, with installs the right package,
together with some unneeded stuff (pyvenv, with is a deprecated script). 

Yet, installing python3-venv seems to be a reliable way to install
the proper package without having to deal with more fragile heuristics.

I'm working on some patches that should hopefully add support for
using "python3 -mvenv", but testing it is not trivial, as I want
to ensure that it won't cause troubles on other distros. So, I'm
installing a myriad of distros with lxc, in order to test how the
script will actually work with some different environments.

Thanks,
Mauro
