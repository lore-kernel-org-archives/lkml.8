Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDA3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B61206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA7vh+zR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgCXNVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:21:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37929 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgCXNVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:21:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id h14so19134306qke.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 06:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8QBITZjIR4pheuB5mAYI2KGr93iBluj8FwnRHc9ZWCY=;
        b=lA7vh+zR0j5LdbHCX7FXW60ldc6hPRFUcl6ux03aWSVFthh5H/wds/lNTLI4yWVEYP
         znYDCnk1KO3oYNSB0z5vPPb6ZRTq42broPxA01HYp84XieK5ZD7ZToBZS/lj088tb0iH
         IQYzRP7uF8vWC37NxuZr/wQw9CdhyOgVpljdsKkcwdc1+noCTfc5VGxNQuQfOLNf5EOA
         tZ2dlpJzHAgXWwhBL0fmmF1V25pJezPA9Et5ciymcv/MVUlrLNDqWObQhF0x8Bs1+KYq
         IgIIe82NVnETQnhwSLioYA1aOJem5JLjlKiHLOy90ro5mLm12/Nnc2CGS3qc+BWi0b/g
         KhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8QBITZjIR4pheuB5mAYI2KGr93iBluj8FwnRHc9ZWCY=;
        b=DIs4K/j4YsmWrd2vc9NdBwHkGoEXWI/XoEJhAqs7Kl0JqYiTVVaw89raJ9OJG45NUD
         YjniNHCoSoLXaIjiWdmpaWb6AR/t/udj9IrMl7W1kATSn49ST6BiO2kxbsXhFSt/d4Sg
         ZJq5VWgScDegagA58CjQpPIxcDnOtryWnOH7XhoZBXbxFodKp4p5uMpFiDBdcN6ltHpR
         tvXeivJQZkF3ERB6qiDTr+aeM/AF8st9epLYkogIEFviKkFJY01o4VD4Lc0vuY0V4L12
         9gtgpGcP48GIAsfH2sBvcLq2owo7JF+izwNnVcj1c5G7j4v0VndalVRSvklRwRQYuC6/
         gc/w==
X-Gm-Message-State: ANhLgQ1AYoFEjka/soTOj5PCj0pajgvFHrK9f8cJX2SMwfLqiDAxCzJb
        DSkx/4aFIbn/irEMr8Sm4Xo=
X-Google-Smtp-Source: ADFU+vuCof1/7g7lALMRZpRgYkbzzBRJX70t2Sw0boAxJmscMh0J0RbY3G8eZFv35mffkkWA8xDFUQ==
X-Received: by 2002:a37:b902:: with SMTP id j2mr26151898qkf.247.1585056078665;
        Tue, 24 Mar 2020 06:21:18 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id d2sm13080985qkf.117.2020.03.24.06.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 06:21:18 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B89FE40F77; Tue, 24 Mar 2020 10:21:15 -0300 (-03)
Date:   Tue, 24 Mar 2020 10:21:15 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH] perf dso: Fix dso comparison
Message-ID: <20200324132115.GC21569@kernel.org>
References: <20200324042424.68366-1-ravi.bangoria@linux.ibm.com>
 <20200324104843.GS1534489@krava>
 <20200324130052.GB21569@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324130052.GB21569@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 24, 2020 at 10:00:52AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Mar 24, 2020 at 11:48:43AM +0100, Jiri Olsa escreveu:
> > On Tue, Mar 24, 2020 at 09:54:24AM +0530, Ravi Bangoria wrote:
> > > Perf gets dso details from two different sources. 1st, from builid
> > > headers in perf.data and 2nd from MMAP2 samples. Dso from buildid
> > > header does not have dso_id detail. And dso from MMAP2 samples does
> > > not have buildid information. If detail of the same dso is present
> > > at both the places, filename is common.
> > > 
> > > Previously, __dsos__findnew_link_by_longname_id() used to compare only
> > > long or short names, but Commit 0e3149f86b99 ("perf dso: Move dso_id
> > > from 'struct map' to 'struct dso'") also added a dso_id comparison.
> > > Because of that, now perf is creating two different dso objects of the
> > > same file, one from buildid header (with dso_id but without buildid)
> > > and second from MMAP2 sample (with buildid but without dso_id).
> > > 
> > > This is causing issues with archive, buildid-list etc subcommands. Fix
> > > this by comparing dso_id only when it's present. And incase dso is
> > > present in 'dsos' list without dso_id, inject dso_id detail as well.
> > > 
> > > Before:
> > > 
> > >   $ sudo ./perf buildid-list -H
> > >   0000000000000000000000000000000000000000 /usr/bin/ls
> > >   0000000000000000000000000000000000000000 /usr/lib64/ld-2.30.so
> > >   0000000000000000000000000000000000000000 /usr/lib64/libc-2.30.so
> > > 
> > >   $ ./perf archive
> > >   perf archive: no build-ids found
> > > 
> > > After:
> > > 
> > >   $ ./perf buildid-list -H
> > >   b6b1291d0cead046ed0fa5734037fa87a579adee /usr/bin/ls
> > >   641f0c90cfa15779352f12c0ec3c7a2b2b6f41e8 /usr/lib64/ld-2.30.so
> > >   675ace3ca07a0b863df01f461a7b0984c65c8b37 /usr/lib64/libc-2.30.so
> > > 
> > >   $ ./perf archive
> > >   Now please run:
> > > 
> > >   $ tar xvf perf.data.tar.bz2 -C ~/.debug
> > > 
> > >   wherever you need to run 'perf report' on.

This improves the situation, but something else is still amiss:

[root@five ~]# perf buildid-list -H | grep ^000000000000 | while read -a line ; do path=${line[1]} ; nlines=$(perf buildid-list -H -i perf.data | grep $path | tee /tmp/lines | wc -l) ;[ $nlines -eq 2 ] && cat /tmp/lines ; done
641f0c90cfa15779352f12c0ec3c7a2b2b6f41e8 /usr/lib64/ld-2.30.so
0000000000000000000000000000000000000000 /usr/lib64/ld-2.30.so
d40c8da7371d8adea464ae2b099590b2c4465574 /usr/lib64/libpthread-2.30.so
0000000000000000000000000000000000000000 /usr/lib64/libpthread-2.30.so
aec38b95c2b305c9f1943b2dd988aeb58c17a5d9 /usr/lib64/libm-2.30.so
0000000000000000000000000000000000000000 /usr/lib64/libm-2.30.so
675ace3ca07a0b863df01f461a7b0984c65c8b37 /usr/lib64/libc-2.30.so
0000000000000000000000000000000000000000 /usr/lib64/libc-2.30.so
8286f22591b0be26730eea306a22a0f30475590b /usr/bin/bash
0000000000000000000000000000000000000000 /usr/bin/bash
[root@five ~]#

I.e. DSOs that have not changed:

[root@five ~]# grep libpthread /proc/*/maps | cut -d' ' -f6- | sort  | uniq -c
    690                    /usr/lib64/libpthread-2.30.so
[root@five ~]#

[root@five ~]# file /usr/lib64/libpthread-2.30.so
/usr/lib64/libpthread-2.30.so: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=d40c8da7371d8adea464ae2b099590b2c4465574, for GNU/Linux 3.2.0, not stripped
[root@five ~]#
[root@five ~]# perf buildid-list -i /usr/lib64/libpthread-2.30.so
d40c8da7371d8adea464ae2b099590b2c4465574
[root@five ~]#

Appear with/without build-id in 'perf buildid-list'.

I'm checking a bit more to see if I figure this out, I'll keep your
patch in, maybe this is a diferent issue, will combine if needed.

- Arnaldo
