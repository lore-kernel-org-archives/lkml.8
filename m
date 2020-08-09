Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7651C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 13:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A55206B5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 13:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vql8XQd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgHINXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 09:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgHINXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 09:23:32 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78446C061756;
        Sun,  9 Aug 2020 06:23:30 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so11770835wmc.0;
        Sun, 09 Aug 2020 06:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mxMscfuXuobUmy56FdXlbUpvqiI08kAsY5msIXsz5Sw=;
        b=Vql8XQd+S3jie+Kt82kw40pkO+vrxECY05AQZrEBkMYK15ZkIrjXV1F7eEmoqRdHn1
         lD33nhNGSyPicrLb5SCl+wBceKvqIAtIKmlt3TGNVbj7ZkyVWbIKa9aUXdl1VeWaXQOT
         UngpvwNhJ/ctEywfppmBQ9APfuqiojyTPG6zaL1FCTBg/LZ9rlL1QnKm7aIeIpXztJiG
         0qkQaqA5Z6xj3YJKEI745573NetMX8xVkuZjqdxEZPthym4dXV6HlX/b3Q0IwxpdTFnz
         +lq3MyAFanyt5AVfF7s3zMv8hvLU2wp3bkMUqvnDLfoHM5kjBPuov9D9aFyB33ImO2c2
         1gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mxMscfuXuobUmy56FdXlbUpvqiI08kAsY5msIXsz5Sw=;
        b=rvEfvuCEBOtPsmmn12L09P4dJ1Kfzgm8za/HgvW56Z3MnGe5vR2DaZJ/dhk3UHTtLp
         PhtEOSj5O2oJCjZKt8Zf/DvEghwyob+3A8SMg5gOMi0BFhwyY4dAqni85vfMR7rASccc
         uGKG4EhPWYORlcTHJOP31FlogWMW68B5EKA2pjoGmA0P6au+S90gQ8c1G9xslRRnQ9xG
         5hqQkMhz+PYLmRvEGwIL20f7kGaGwGkug9cQ9FJ2OagTiBNkBF9YJb5koKkopnS6cUiG
         WM+7FgWXu1fjAJBDKYNDBYOT4mE7htMTdhME7+3bzEg80e6/Za6e/q7Pk+HAXdIYVLSi
         ZkLw==
X-Gm-Message-State: AOAM531G3NKtDn80Inx7kGjXXZZrYt2pJDpBOk/TxaB8lhtU2CAmCRH0
        Eo2cTVmUP0DW4EHUhUVuXXbpc6cRuoI=
X-Google-Smtp-Source: ABdhPJwiI8ekWORZPzcPGgKK1fVAwnHjIGLSLDh1YUHm59tAanDToqjHJDCtlVw4yURY48LbP+3BiA==
X-Received: by 2002:a1c:2b04:: with SMTP id r4mr20000224wmr.76.1596979408960;
        Sun, 09 Aug 2020 06:23:28 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id z66sm17579993wme.16.2020.08.09.06.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 06:23:27 -0700 (PDT)
Date:   Sun, 9 Aug 2020 15:23:27 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Documentation: build failure with sphinx >= 3.0.0: exception: cannot
 import name 'c_funcptr_sig_re' from 'sphinx.domains.c' (was: Re: Kernel
 build failed ...SPHINX extension error)
Message-ID: <20200809132327.GA145573@eldamar.local>
References: <20200408113705.GB1924@ArchLinux>
 <20200408132505.52e595bc@lwn.net>
 <20200408233450.GA14923@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408233450.GA14923@debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 
On Thu, Apr 09, 2020 at 05:04:54AM +0530, Bhaskar Chowdhury wrote:
> On 13:25 Wed 08 Apr 2020, Jonathan Corbet wrote:
> > On Wed, 8 Apr 2020 17:07:05 +0530
> > Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
> > 
> > > Extension error:
> > > Could not import extension cdomain (exception: cannot import name
> > > 'c_funcptr_sig_re' from 'sphinx.domains.c'
> > > (/usr/lib/python3.8/site-packages/sphinx/domains/c.py))
> > > Apr 08 16:48:46 enabling CJK for LaTeX builder
> > > Apr 08 16:48:46   CC      kernel/power/poweroff.o
> > > make[1]: *** [Documentation/Makefile:81: htmldocs] Error 2
> > > make: *** [Makefile:1549: htmldocs] Error 2
> > > make: *** Waiting for unfinished jobs....
> > 
> > This is weird, to say the least.  But I think the "python3.8" in the
> > message above says everything you need to know.  If you're running with
> > an unreleased version of Python, it's not entirely surprising that you
> > might run into trouble with a complex package.
> > 
> > jon
> 
> Thank you Jon...will investigate more and keep your suggestion in mind.

The problem is actually related to changes happening in Sphinx 3.0.0.
There is the followign issue filled upstream:

https://github.com/sphinx-doc/sphinx/issues/7421

'c_funcptr_sig_re' was removed upstream in sphinx v3.0.0b1 and so the
kernel documentation build fails. This is reproducible with a recent
sphinx version (in attached case it is 3.2.0):

$ make PYTHON=python3 xmldocs
  SPHINX  xmldocs --> file:///home/build/linux/Documentation/output/xml
make[2]: Nothing to be done for 'xml'.
Running Sphinx v3.2.0

Extension error:
Could not import extension cdomain (exception: cannot import name 'c_funcptr_sig_re' from 'sphinx.domains.c' (/usr/lib/python3/dist-packages/sphinx/domains/c.py))
make[1]: *** [Documentation/Makefile:115: xmldocs] Error 2
make: *** [Makefile:1655: xmldocs] Error 2

Distribution reports related to this issue:
https://bugs.debian.org/963636
https://bugs.archlinux.org/task/66178
https://bugs.archlinux.org/task/66156

Regards,
Salvatore
