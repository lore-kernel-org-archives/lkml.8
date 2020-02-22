Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3967C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 07:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8297208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 07:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582355833;
	bh=rquXggSO5rdCvbw3bu7MM0yqPIWyWVqYfs/ET6of2gw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Xqvy3K/a7qRdQ1kbELn1qvOcW4NW0Y3xvjlFDo8nyRoeDZNDQgeYPW58MF5eWwods
	 bSxizqPAqnAUj5//ObxQ4d7+VOOd90LSmrxQjzpxopjsXVaEe0CTgyrCgkHYaxHrDr
	 NgQfH/+dZ7izN2YJAL3Dgk+EfEgwzD8meNZ17OIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgBVHQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 02:16:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgBVHQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 02:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description;
        bh=mFEqFqymAvME5G5W7AmH2bon8VFqmjzCdm3adlAcf+U=; b=NoR84TKN7Rndg7cE0Z167YoO1z
        xZdmBp8Ezv0tqRCFaKI9X1J6mZjhjwYbxItwpitRChzu/fIzBVYPrfMU76fGsdkIZ8/hHW8wrtfqX
        U1vn+t1Ub9OrydxuP3f5W72uv6OSjl9lMUBo0r1gqZJEGgP6YUucdwpKZyOXXwvgwwNlLsaydk1j3
        XJtL+g1WtYaz+ix8/tR0b9Fq7PDEobRTCd3vzh/eGn2Ymb7Sw9UgP78QaC4OHLC438//bpplkWhI4
        6XE5kiNuE42wow6fVfvYKMNnxjxqjsE8Z36ZX3MX39a96RSMRUPM9ay+19HpPa5kJdoqTJ7/BwdFr
        VLp5FGJQ==;
Received: from [80.156.29.194] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5P1s-0003Wd-8Q; Sat, 22 Feb 2020 07:16:48 +0000
Date:   Sat, 22 Feb 2020 08:16:44 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Fix for sphinx setup message
Message-ID: <20200222081644.4ce926a0@kernel.org>
In-Reply-To: <MWHPR13MB0895675B302AF38BB1D141BBFD120@MWHPR13MB0895.namprd13.prod.outlook.com>
References: <MWHPR13MB0895675B302AF38BB1D141BBFD120@MWHPR13MB0895.namprd13.prod.outlook.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

Em Fri, 21 Feb 2020 22:15:36 +0000
"Bird, Tim" <Tim.Bird@sony.com> escreveu:

> (Resend: Sorry for the dup.  I forgot to include the maintainers, and I had the LKML
> address wrong.) 
> 
> I was trying to set up my machine to do some documentation work, 
> and I had some problems with the sphinx install.  I figured out how to work
> around the issue, but I have a question about how to add the information
> to scripts/sphinx-pre-install (or whether it should go somewhere else).
> 
> Detailed messages below, but the TLl;DR is that I got the message:
> -------
> You should run:
> 
>     sudo apt-get install dvipng fonts-noto-cjk latexmk librsvg2-bin texlive-xetex
>     /usr/bin/virtualenv sphinx_1.7.9
>     . sphinx_1.7.9/bin/activate
>     pip install -r ./Documentation/sphinx/requirements.txt
>     ...
> ------
> 
> The pip install step didn't work, and I found that I needed to have everything
> based on python3 instead.  When I replaced:
>     /usr/bin/virtualenv sphinx_1.7.9
> with
>     /usr/bin/virtualenv -p python3 sphinx_1.7.9
> everything worked.
> 
> This message is coming from scripts/sphinx-pre-install (I believe on line 708).
> 
> Should I go ahead and submit a patch to add '-p python3' to that line?
> 
> Are there any downsides to enforcing that the virtualenv used for the
> documentation build use python3 only?

Actually, the script tries to detect if python3 is installed. Currently, it
does it by seeking for a python3 variant of virtualenv. If it finds, it
changes the recommendation accordingly. The actual code with does that is
this one:

	my $virtualenv = findprog("virtualenv-3");
	$virtualenv = findprog("virtualenv-3.5") if (!$virtualenv);
	$virtualenv = findprog("virtualenv") if (!$virtualenv);
	$virtualenv = "virtualenv" if (!$virtualenv);

This works fine on older Fedora distros (and probably CentOS/RHEL), where
there is a python3 variant of virtualenv. On Ubuntu (and Fedora 31), it
will just use virtualenv.

So, perhaps if we add something like this (untested):

	my $python = findprog("python3");

	if ($python)
		$virtualenv = "$virtualenv -p $python";

it would make the trick. Please notice, however, that this could cause
troubles with some distros that might have a version of virtualenv that
won't work with the above. So, perhaps we should add something like the
above inside give_debian_hints(), and either ensure that other Debian and 
Ubuntu LTS versions will work with such change, or add some checks for the
Ubuntu/Debian versions where we know this works.

Note: the version of the distribution (and its name) is already stored
at the global var $system_release.

Cheers,
Mauro
