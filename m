Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4EFC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037CF214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLUUJgpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCBUVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:21:05 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45262 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBUVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:21:05 -0500
Received: by mail-qv1-f66.google.com with SMTP id r8so528768qvs.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 12:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f7xtQ2i1qQ4MseVbEz/NaU36jHuoRJkabZ6aciq74v4=;
        b=TLUUJgpVt9rxnlfQfiL513rKIsohc8VYcTpLLycgzl40zajr8thm2JrsSlUAgvSIvV
         pg2wosfhC0WFFx/YFDwsI/tmBt0VLt3r4/XYrgwpwAci2ZThxIjZoIDhUSX4IlV/WskQ
         g6hAHkcvk4lftAu7IZsF5neWW0yNU5wpAfxxM0vVIFdZzpCeqfUr22QucYg0QHjXVSLN
         C8qDpVAQfSHnCrBooSd0jarrETOXWtG+KUmNdDeLMQcOjkNhcYhYH32JY7O6ODHjFIb0
         wpLH9nIBN0f1/aPf7PMyHgYWZllDMk9O0yLrVaP2mKWCvJ6bLZG1kBvevT25jGnRbLWB
         +Bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f7xtQ2i1qQ4MseVbEz/NaU36jHuoRJkabZ6aciq74v4=;
        b=YfiuZgzFj1qgzQJKMTrqeJ+l9GEyJmjPElhJXi8tbM6Y0XzAuTCSZ4qHHVxHoHn8mn
         j6IuNSELyrHUgk+wjR9dQdGXy5SlEU77NG6NJJ17x8hqyn6hfAmDoQeBSVophsLE8XER
         VfzHO4MTp/fkkiHcrAgQCEprtsSCqWHyQqcmxfw34sbe504OpnN4hb8TsIZzCC9+iBNY
         VMpPNl8ppsFoNWy3AQyFthBOZWURcBomFD+SwTeBgRW/yFklo4vtd/4Zoy8iLuvIP7uu
         YWnuzKWkwEqFLwBUF9r4eiORsjpCuvfnh5CKBqjetOrSgx75TyoMEnh+q6XhqtZViSyL
         eqaA==
X-Gm-Message-State: ANhLgQ3pzX7XY6ZvDr9EEYnPalPdaZSVS2ppey4wi+UpJeH0hA+Tctmb
        581XuaAivQDpDAe+cEVA1gc=
X-Google-Smtp-Source: ADFU+vubgwJJcDfBaXSsqIWmG79X0Yrhg5BjQ6tXw/dP6Ht+LGeNkXZhKRMNJAcpNv9ZRYVcYGnJOw==
X-Received: by 2002:a05:6214:a62:: with SMTP id ef2mr1065779qvb.109.1583180464068;
        Mon, 02 Mar 2020 12:21:04 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id r5sm10839407qtn.25.2020.03.02.12.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 12:21:03 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 55884403AD; Mon,  2 Mar 2020 17:21:01 -0300 (-03)
Date:   Mon, 2 Mar 2020 17:21:01 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf symbols: Don't try to find a vmlinux file when
 looking for kernel modules
Message-ID: <20200302202101.GE10335@kernel.org>
References: <20200302191007.GD10335@kernel.org>
 <20200302200249.GA9761@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302200249.GA9761@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 02, 2020 at 09:02:49PM +0100, Jiri Olsa escreveu:
> On Mon, Mar 02, 2020 at 04:10:07PM -0300, Arnaldo Carvalho de Melo wrote:
> > The dso->kernel value is now set to everything that is in
> > machine->kmaps, but that was being used to decide if vmlinux lookup is
> > needed, which ended up making that lookup be made for kernel modules,
> > that now have dso->kernel set, leading to these kinds of warnings when
> > running on a machine with compressed kernel modules, like fedora:31:
> >     
> >   [root@five ~]# perf record -F 10000 -a sleep 2
> >   [ perf record: Woken up 1 times to write data ]
> >   lzma: fopen failed on vmlinux: 'No such file or directory'
> >   lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
> >   lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
> >   lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
> >   lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
> >   lzma: fopen failed on vmlinux: 'No such file or directory'
> >   lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
> >   lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
> >   lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
> >   lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
> >   lzma: fopen failed on vmlinux: 'No such file or directory'
> >   lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
> >   lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
> >   lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
> >   lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
> >   lzma: fopen failed on vmlinux: 'No such file or directory'
> >   lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
> >   lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
> >   lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
> >   lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
> >   lzma: fopen failed on vmlinux: 'No such file or directory'
> >   lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
> >   lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
> >   lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
> >   lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
> >   [ perf record: Captured and wrote 1.024 MB perf.data (1366 samples) ]
> >   [root@five ~]#
> > 
> > This happens when collecting the buildid, when we find samples for
> > kernel modules, fix it by checking if the looked up DSO is a kernel
> > module by other means.
> > 
> > Fixes: 02213cec64bb ("perf maps: Mark module DSOs with kernel type")
> 
> ok, I couldn't see that because kcore took over the modules,
> for some reason you don't have it enabled on your system?

Humm, maybe you don't have a reachable vmlinux so it ends up using
/proc/kcore? I even think we should make the default... :-)
 
> because I had to disable it manualy in the code.. I think
> we should add some --no-kcore option for record
> 
> the fix is working for me:
> 
> Tested/Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, for checking!
 
> thanks,
> jirka
> 

-- 

- Arnaldo
