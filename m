Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52D9C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9661A2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1c9Ac3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgBQO3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:29:40 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46663 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgBQO3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:29:40 -0500
Received: by mail-qk1-f195.google.com with SMTP id u124so15814039qkh.13;
        Mon, 17 Feb 2020 06:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ifhvgKgI6cTWHXPEnaAyEUDSTCBWJ+KZaGmCrBza/1c=;
        b=C1c9Ac3dO4qTNAxrehHi5Lee1eIVFDCiei2+1u8WVmCTxz3+U0Hsq3ay+xNSl8pMrS
         J2VuTVV9mR5kCb8QXP6HX9EM00EkseoO78/ijG1qDu29USrGHRPnUFfYgvDUl1kEywAm
         op+qplXMh4i34wjCpUlAgzuRFl5m3gfVGYwnHeCQK/oOE3vsz9XJtSxLBvJXkxYCdvJ9
         oUvMCUYRihGZ70hNrAvUEpbmVRn6C8ulkqRAu3c5bo+8XpcL03btqRICOrMshb7mEx50
         3czipOu3udEuoZ3QfU6WAc/IVIgAE51iwpfhfDiZW77skX7D6Fkfver0nn5SR+dHsbDa
         yPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ifhvgKgI6cTWHXPEnaAyEUDSTCBWJ+KZaGmCrBza/1c=;
        b=Z7WFxjPxtgbi23SzaEUikJe4E2q56q+7nzwy8YZU87YNj2RcAqz7laTqjRDNG3JbZ1
         BRD5dtNXWIojO18hjkKbVYl8qLM0FLQ5Fjx7dOlz/1mGCeo/6PE9R1gnRj0FFsxYVeCy
         vzN2vrA8wQ5YkCFdxtjkUsxTUf9h706661kNBzEdDCPSCg9o0zmvFMz/+Wl3Kw9t5uoL
         9GfQncskXS9x2r8T8eIg0LruQ0TfVds4ntMhuHIcSg7xky6dCrNLVMMeD7VEi8O9gXJ6
         RecUihYye0nerBI0NBOfcQfTv5tF4h6pR2v/zXE9Veow8I5WlIdD2esR126ujc2T1K/y
         mxpQ==
X-Gm-Message-State: APjAAAUeuA+XCoJbK6K6LagAUKdVCkrbRFiqeKGb+kZLKD7SNhiScGYx
        fireGP8UpsLuqMedIa4Ydks=
X-Google-Smtp-Source: APXvYqxL8R5m+lUaiW+Gfj0/xS6u9e5XVjk4kxV1EJh+wvOWiiTkELaDtZP/RTMFsR/zU/ndTOVs2Q==
X-Received: by 2002:a37:652:: with SMTP id 79mr14604728qkg.464.1581949778766;
        Mon, 17 Feb 2020 06:29:38 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id n189sm291877qke.9.2020.02.17.06.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 06:29:37 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B7F57403AD; Mon, 17 Feb 2020 11:29:35 -0300 (-03)
Date:   Mon, 17 Feb 2020 11:29:35 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH v4] perf test: Fix test trace+probe_vfs_getname.sh on s390
Message-ID: <20200217142935.GA19953@kernel.org>
References: <20200217102111.61137-1-tmricht@linux.ibm.com>
 <20200217211010.fa9c643c517c110abaa5b554@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217211010.fa9c643c517c110abaa5b554@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 17, 2020 at 09:10:10PM +0900, Masami Hiramatsu escreveu:
> On Mon, 17 Feb 2020 11:21:11 +0100
> Thomas Richter <tmricht@linux.ibm.com> wrote:
> 
> > This test places a kprobe to function getname_flags() in the kernel
> > which has the following prototype:
> > 
> >   struct filename *
> >   getname_flags(const char __user *filename, int flags, int *empty)
> > 
> > Variable filename points to a filename located in user space memory.
> > Looking at
> > commit 88903c464321c ("tracing/probe: Add ustring type for user-space string")
> > the kprobe should indicate that user space memory is accessed.
> > 
> > Output before:
> >    [root@m35lp76 perf]# ./perf test  66 67
> >    66: Use vfs_getname probe to get syscall args filenames   : FAILED!
> >    67: Check open filename arg using perf trace + vfs_getname: FAILED!
> >    [root@m35lp76 perf]#
> > 
> > Output after:
> >    [root@m35lp76 perf]# ./perf test  66 67
> >    66: Use vfs_getname probe to get syscall args filenames   : Ok
> >    67: Check open filename arg using perf trace + vfs_getname: Ok
> >    [root@m35lp76 perf]#
> > 
> > Comments from Masami Hiramatsu:
> > This bug doesn't happen on x86 or other archs on which user-address
> > space and kernel address space is same. On some arch (ppc64 in this case?)
> > user-address space is partially or completely same as kernel address space.
> > (Yes, they switch the world when running into the kernel) In this case,
> > we need to use different data access functions for each spaces.
> > That is why I introduced "ustring" type for kprobe event.
> > As far as I can see, Thomas's patch is sane. Thomas, could you show us
> > your result on your test environment?
> > Thank you
> > 
> > Comments from Thomas Richter:
> > Test results included above.
> > 
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks, I tested it successfully on x86-64, applying.

- Arnaldo
