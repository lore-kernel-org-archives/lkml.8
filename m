Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8E7C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C7D2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584702926;
	bh=Lz45XJSItgomZBBzuFY63Z+gO2y+DDRrUTRwkA9EJWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UK3sr1dD4BWxmboSEU0wWJW1gqMqXEALnTO+3E2FsLx+jCM+VwE9aXM01EpY9qQyt
	 er6XOBSq7N1bEgWIw3l98CbYJY0d1smYHYEyhEnUcNYJ/TXr2iwgAnUN2OkfxqAbx1
	 PHgW7T+IyNNUDbW5rGpp4MqiOmBL+loHWt5NL5r4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgCTLPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 07:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgCTLPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:15:25 -0400
Received: from coco.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4432B2072D;
        Fri, 20 Mar 2020 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584702924;
        bh=Lz45XJSItgomZBBzuFY63Z+gO2y+DDRrUTRwkA9EJWU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YNR/CgONHssU8a+7sVlGdWb/nmqlD7Zi5m5ourV+TvhXQu6Ejle2jVoxsMJFFipmb
         dLY2La9YIOsfHwlvVSAToPjhSL/Icj5hcjrNqjrWWjQDip3gUjGtnw0NlFnFb9aGcu
         buGSmgpSZDfPmdCa4VU6s7U1kpsiWDVIxbbvx5ro=
Date:   Fri, 20 Mar 2020 12:15:20 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Victor Erminpour <victor.erminpour@oracle.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Prefer 'python3' when building htmldocs
Message-ID: <20200320121505.579fb6cc@coco.lan>
In-Reply-To: <1584658842-778-1-git-send-email-victor.erminpour@oracle.com>
References: <1584658842-778-1-git-send-email-victor.erminpour@oracle.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 19 Mar 2020 16:00:42 -0700
Victor Erminpour <victor.erminpour@oracle.com> escreveu:

> Prefer 'python3' and 'sphinx-build-3' when building htmldocs.
> Building htmldocs fails on systems that don't have 'python'
> and 'sphinx-build' installed, but do have 'python3' and
> 'sphinx-build-3' available.
> 
> Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
> ---
>  Documentation/Makefile | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index d77bb607aea4..00c400523e15 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -11,6 +11,7 @@ endif
>  
>  # You can set these variables from the command line.
>  SPHINXBUILD   = sphinx-build
> +SPHINXBUILD3  = sphinx-build-3

This will very likely break on some distros. For example, Fedora 31 with a
venv configured environment won't have a "sphinx-build-3" program. 

I have already a patchset addressing this. I'm testing it on several
different distros and versions.

My plan is to submit the patch series for it after the merge window. If you
want to do a sneak pick, there's a version of the patch series on my
experimental tree (probably not the latest version):

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=random_doc_fixes


>  SPHINXOPTS    =
>  SPHINXDIRS    = .
>  _SPHINXDIRS   = $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst))
> @@ -61,11 +62,23 @@ loop_cmd = $(echo-cmd) $(cmd_$(1)) || exit;
>  # $5 reST source folder relative to $(srctree)/$(src),
>  #    e.g. "media" for the linux-tv book-set at ./Documentation/media
>  
> +HAVE_PYTHON3 := $(shell if which $(PYTHON3) >/dev/null 2>&1; then echo 1; else echo 0; fi)
> +HAVE_SPHINX3 := $(shell if which $(SPHINXBUILD3) >/dev/null 2>&1; then echo 1; else echo 0; fi)
> +PYTHON_BIN = $(PYTHON)
> +
> +# If we have both python3 and sphinx-build-3,
> +# prefer python3 over python.
> +ifeq ($(HAVE_PYTHON3),1)
> +    ifeq ($(HAVE_SPHINX3),1)
> +        PYTHON_BIN = $(PYTHON3)
> +    endif
> +endif
> +
>  quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>        cmd_sphinx = $(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/media $2 && \
>  	PYTHONDONTWRITEBYTECODE=1 \
>  	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
> -	$(PYTHON) $(srctree)/scripts/jobserver-exec \
> +	$(PYTHON_BIN) $(srctree)/scripts/jobserver-exec \
>  	$(SHELL) $(srctree)/Documentation/sphinx/parallel-wrapper.sh \
>  	$(SPHINXBUILD) \
>  	-b $2 \



Thanks,
Mauro
