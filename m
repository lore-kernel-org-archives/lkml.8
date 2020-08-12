Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E2BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60F4204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9hfzQ9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgHLHbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHLHbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:31:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3BCC06174A;
        Wed, 12 Aug 2020 00:31:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l2so1047421wrc.7;
        Wed, 12 Aug 2020 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4e8LjBCl2NQsSY2Ieb8yGOTThne6bO4GNHi9v6KpsZU=;
        b=o9hfzQ9DMuT4OhRd6DHNjgf6ZaXhZDzMEnw0W2A/HnVTVC24J289PI77HN2ddGmnKf
         Xs1JDkOAxUZW9tUyL+7OlLo8eLTgHaG68MzOVDOMD3uLtncMx6BF9phGjT1YJmPcnNuM
         QuNUGJieNhA1enx7MVRAB5n+NsgD8NyCqiENPBKD6r9DUWET+0yctuo+BIAfrc8bGYDi
         ZZb0yuj3MtoGJQ3goSn+ccamp8VbjGYvo21LTTw5Niexyfry4MWTX3CBOYkGDuByqZZ/
         az8/3X0M71X62kIxzlLBh2KVBUcCNyFFd4WWwz0ZWF4viuv8tuPfqucMIeMMxaVjM6MG
         f3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4e8LjBCl2NQsSY2Ieb8yGOTThne6bO4GNHi9v6KpsZU=;
        b=ZWZlwISxjJ5vogXzzRx3nJG6PNNmP5MOTRrIDAutxbTDMqGXNuMQPZ97f1CRsgXhjp
         Q1y3ScKH4FdV7LOKNwwQDmJLVh4Hc2j9cpwvnQIeTHtAA7P8FKjhsXGqL5wH/5d6/3nI
         akLALJrDsS9juh8vuQJ91pAAwfTN0sofhFc4A85yLuaD3j/KxjtvhDLWEMzT3yEYPYkE
         HsYU9jEkgWgXueXvZeO8nvXKzDtt+FbTqAi4dHcRaukd257yV9YXh3/8Rjo8c6tRtiDE
         BYesS1jGlYJv22OBZQWmMnWo+Cd8M7vNDPNaTj4siAXMbW3f0tDB3BtoR7KTRjRYpveC
         uQpA==
X-Gm-Message-State: AOAM533Gcx/oVAqKhkxmdjNbFl+Bk5ij4Dp9EoMwwQKOeBaoREP0tb1V
        1ZrOEsT5pSfwM6FC3QKg8dA=
X-Google-Smtp-Source: ABdhPJxlF9bqPRf1Hz8ZxAVB+9PbNoh7NXwf9mH9JFlqqJcu5qtYOgPs5eodLMsS3MHdgI6M7hyxwg==
X-Received: by 2002:adf:bb0a:: with SMTP id r10mr8836809wrg.23.1597217462044;
        Wed, 12 Aug 2020 00:31:02 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id z127sm2335238wme.44.2020.08.12.00.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 00:31:00 -0700 (PDT)
Date:   Wed, 12 Aug 2020 09:30:59 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>,
        jforbes@fedoraproject.org, markus.heiser@darmarit.de
Subject: Re: Documentation: build failure with sphinx >= 3.0.0: exception:
 cannot import name 'c_funcptr_sig_re' from 'sphinx.domains.c'
Message-ID: <20200812073059.GA509953@eldamar.local>
References: <20200408113705.GB1924@ArchLinux>
 <20200408132505.52e595bc@lwn.net>
 <20200408233450.GA14923@debian>
 <20200809132327.GA145573@eldamar.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809132327.GA145573@eldamar.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 09, 2020 at 03:23:27PM +0200, Salvatore Bonaccorso wrote:
> Hi 
> On Thu, Apr 09, 2020 at 05:04:54AM +0530, Bhaskar Chowdhury wrote:
> > On 13:25 Wed 08 Apr 2020, Jonathan Corbet wrote:
> > > On Wed, 8 Apr 2020 17:07:05 +0530
> > > Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
> > > 
> > > > Extension error:
> > > > Could not import extension cdomain (exception: cannot import name
> > > > 'c_funcptr_sig_re' from 'sphinx.domains.c'
> > > > (/usr/lib/python3.8/site-packages/sphinx/domains/c.py))
> > > > Apr 08 16:48:46 enabling CJK for LaTeX builder
> > > > Apr 08 16:48:46   CC      kernel/power/poweroff.o
> > > > make[1]: *** [Documentation/Makefile:81: htmldocs] Error 2
> > > > make: *** [Makefile:1549: htmldocs] Error 2
> > > > make: *** Waiting for unfinished jobs....
> > > 
> > > This is weird, to say the least.  But I think the "python3.8" in the
> > > message above says everything you need to know.  If you're running with
> > > an unreleased version of Python, it's not entirely surprising that you
> > > might run into trouble with a complex package.
> > > 
> > > jon
> > 
> > Thank you Jon...will investigate more and keep your suggestion in mind.
> 
> The problem is actually related to changes happening in Sphinx 3.0.0.
> There is the followign issue filled upstream:
> 
> https://github.com/sphinx-doc/sphinx/issues/7421
> 
> 'c_funcptr_sig_re' was removed upstream in sphinx v3.0.0b1 and so the
> kernel documentation build fails. This is reproducible with a recent
> sphinx version (in attached case it is 3.2.0):
> 
> $ make PYTHON=python3 xmldocs
>   SPHINX  xmldocs --> file:///home/build/linux/Documentation/output/xml
> make[2]: Nothing to be done for 'xml'.
> Running Sphinx v3.2.0
> 
> Extension error:
> Could not import extension cdomain (exception: cannot import name 'c_funcptr_sig_re' from 'sphinx.domains.c' (/usr/lib/python3/dist-packages/sphinx/domains/c.py))
> make[1]: *** [Documentation/Makefile:115: xmldocs] Error 2
> make: *** [Makefile:1655: xmldocs] Error 2
> 
> Distribution reports related to this issue:
> https://bugs.debian.org/963636
> https://bugs.archlinux.org/task/66178
> https://bugs.archlinux.org/task/66156

As a workaround to make the documentation build again (but known that
parts of the documentation will be broken), we could drop the cdomain
extension.

Regards,
Salvatore

From 9e81028c7e5f8f33f67a768b9c306536fd8e688f Mon Sep 17 00:00:00 2001
From: Salvatore Bonaccorso <carnil@debian.org>
Date: Wed, 12 Aug 2020 09:11:51 +0200
Subject: [PATCH] Documentation: Drop use of 'cdomain' sphinx extension module

'c_funcptr_sig_re' was removed upstream in sphinx v3.0.0b1 and so the
kernel documentation build fails sphinx 3.x.

As a (temporary) workaround to make the documentation build, the
'cdomain' sphinx extension can be removed from the Documentation build
configuration file, although some parts using the feature will be
broken.

https://github.com/sphinx-doc/sphinx/issues/7421 describes the
workaround.

Cc: Markus Heiser <markus.heiser@darmarit.de>
Cc: Justin M. Forbes <jforbes@fedoraproject.org>
Link: https://lore.kernel.org/linux-doc/20200809132327.GA145573@eldamar.local/
Link: https://bugs.archlinux.org/task/66178
Link: https://bugs.archlinux.org/task/66156
Link: https://bugs.debian.org/963636
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 Documentation/conf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index c503188880d9..b5b2be8eec22 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -36,7 +36,7 @@ needs_sphinx = '1.3'
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain',
+extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel' ]
 
-- 
2.28.0

