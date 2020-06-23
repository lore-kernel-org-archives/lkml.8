Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEEEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C3D207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCY1Cunk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387650AbgFWVut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbgFWVur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:50:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68871C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:50:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so258307wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=suGZrNrDj7Adau/CI2R6KqtvMJT93s3LDs+c/oNZKS4=;
        b=PCY1CunkWft59s2Br320d2hsHrdBYpCr51bzncnRqHhamHb620CBD8eqNB3fIkaYVF
         19YShfEfno3uzDDYEEFjfmWHwmnkNSX8TSmJqPOXZ0ZDNWY9hq6i/A2gvtV6PNEXh7yl
         2QeUPX6krZsOQ6eG0eM6VPz9AIvPE2WoN2nfDSEn/l8f0x+y59u3KjE29Ab0Imq+F7xu
         g1N6wS+1jwoxlVDQKpuG8VjbPxUu8xPTcPhYN9Ao9lmi5EE42TdOpKJI3AUaeDepFJYK
         6JhuuHwwWk3roxKFOafS2xwWTdW3JZQPdHN2JccVJ24QHADMoArguoxmQN3xqJUutM/+
         CWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=suGZrNrDj7Adau/CI2R6KqtvMJT93s3LDs+c/oNZKS4=;
        b=oCSsLWPvh3+v98FQ1eDKzX4bmr6ekv00uvHoOJwhVseePYzke/5Ryu8tZG4upqZamQ
         445Rqise0EYjqQA3rztqadkDSoblDuP3IsufZnhH6XthaGR2j8uSTU1f6Me7Ni9ZSSQT
         1xb7Cp9OrDXVF/+bkxgc8ToPMMZHUNpXAxKTloC8Y3zqJV9rbo2+chABdaOQ3X6NPsot
         wBwYllyASmmoe96CnboUkNnpQLNlMfOqz7X/56IcqR9AGKPmjqs1bipD94emqe0fdxKS
         Mlh+eZyzhsJ8brZPVbvjnfXpUfBhXfm+WFO/E9viqwIobQSUpwVGdkQxAAE6S4uVuBLA
         vngg==
X-Gm-Message-State: AOAM531O0I1WuvR1+MYZPuQ0f5Nl4oEqe8wPwv3dUQEl3pI71bXvOBUl
        cug/DkTnsHeYXtlhCX5oEg==
X-Google-Smtp-Source: ABdhPJzbi8kJYCHxuDa1LVSpS4wqGaGDPl1ZTe5yQH2mdaZmgEWKkh1wdEeRCqt5RA8TfLhxpN0vtA==
X-Received: by 2002:a05:600c:2116:: with SMTP id u22mr11585848wml.82.1592949045101;
        Tue, 23 Jun 2020 14:50:45 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.162])
        by smtp.gmail.com with ESMTPSA id k185sm2156332wmk.47.2020.06.23.14.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 14:50:44 -0700 (PDT)
Date:   Wed, 24 Jun 2020 00:50:42 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: process '/usr/bin/rsync' started with executable stack
Message-ID: <20200623215042.GA43266@localhost.localdomain>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
 <202006231131.AD0A7F5F@keescook>
 <alpine.DEB.2.22.1.446.2006231430280.3892@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.1.446.2006231430280.3892@trent.utfs.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:33:50PM -0700, Christian Kujau wrote:
> On Tue, 23 Jun 2020, Kees Cook wrote:
> > > $ checksec --format=json --extended --file=`which rsync` | jq
> > > {
> > >   "/usr/bin/rsync": {
> > >     "relro": "full",
> > >     "canary": "yes",
> > >     "nx": "no",
> > ^^^^^^^^^^^^^^^^^^
> > 
> > It is, indeed, marked executable, it seems. What distro is this?
> 
> Arch Linux (x86-64) with 5.6.5.a-1-hardened[0], running in a Xen DomU.

BTW this bug was exactly the one described in the changelog:
compiling assembly brings executable stack by default:

	$ git-show 73faaab26d7db19ae6e04396a6e9d6372ed8e4ad
	commit 73faaab26d7db19ae6e04396a6e9d6372ed8e4ad

	    Pass --noexecstack to assembler.

	--- a/Makefile.in
	+++ b/Makefile.in
	@@ -135,7 +135,7 @@ simd-checksum-x86_64.o: simd-checksum-x86_64.cpp
	        $(CXX) -I. $(CXXFLAGS) $(CPPFLAGS) -c -o $@ $(srcdir)/simd-checksum-x86_64.cpp

	 lib/md5-asm-x86_64.o: lib/md5-asm-x86_64.S config.h lib/md-defines.h
	-       $(CC) -I. -c -o $@ $(srcdir)/lib/md5-asm-x86_64.S
	+       $(CC) -I. -Wa,--noexecstack -c -o $@ $(srcdir)/lib/md5-asm-x86_64.S
