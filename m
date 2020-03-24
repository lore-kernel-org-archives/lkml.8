Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AB8C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35B62070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYEhOfKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgCXNA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:00:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34703 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbgCXNA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:00:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id i6so9971121qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ba16nWV/RV0Cz2u6692GPI7pcBz0klhTBLMRiyR006I=;
        b=aYEhOfKLN9ZhHQ6qsF9yRQZbJdp5qLE6VG/WiV3IMktT7OZPKVXM4Q7M3pciHMlbSL
         3JGlbyRaN3t3ec9VtNhmOhV7tCzs9JA6xcIykANFuiBzbMUjFmB/yGtCDkMQoUvqklXc
         uiHcBoMS9SYRf02XIqS6bfwC4FWM41w2FnuqP5ra6ZFTR9hoHzaktczDd2ZFIqf+mtjt
         ldsu613xA9ggzR77Me71NwapMzx3YvN1xOWPf/Lfs4cZdV6kXFljQtq+rbQYjBaOSh/8
         36RrSz77/xdGKBCUyKAqBkQLCCH8DmwS8GH2ZvuXwnZxXgE7rFeG46vkmxhEguIgu2B6
         A2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ba16nWV/RV0Cz2u6692GPI7pcBz0klhTBLMRiyR006I=;
        b=QmbfdEEGrKBBREwk2G+CEdDsXfYkkXI5fANvWtNdw2D7qwD2CuZMC/ABUNA3fonBFR
         VoSLT586CCi5gY2GBMWcKDoi6erWa2MjYVMxXwed/Nf6eT+gzxw5bIF+akd1Idvqvrid
         gOeLdnvd6/s8WHtjQB2SbVVNSGYP2zxEuV54I2Mv8Sj025IXhsZ9YfKCDNAUTrBb8XgV
         4/la1Uuoaix+u6CcQGCDa3Mo7sIR9mheTShe+UOZhPU7kATlGocI4JZ9qK7FbsjqhbzH
         brwOgQ1a9DuCDW+TVgKtkQO78y2rvDaudeOwPDncyA/ukrvTsFnWcuWivPcjxZxBxnbe
         Ki5Q==
X-Gm-Message-State: ANhLgQ35iV7K013QmaI277CvL2VrzNUOk5W8HOpwlbmxQUJ26aUUwvMJ
        zyj6uG636zTLIKIwXqtVmGx1n5rd
X-Google-Smtp-Source: ADFU+vssnynhn++cNNMUV7zMf7W/sRDKPz52gbWnkNK/KGmmnLAFjL1oHpk3EK6r8vhqjLxGnz+5WA==
X-Received: by 2002:a05:620a:129b:: with SMTP id w27mr935841qki.140.1585054855657;
        Tue, 24 Mar 2020 06:00:55 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id d9sm13397723qth.34.2020.03.24.06.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 06:00:54 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 883D840F77; Tue, 24 Mar 2020 10:00:52 -0300 (-03)
Date:   Tue, 24 Mar 2020 10:00:52 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH] perf dso: Fix dso comparison
Message-ID: <20200324130052.GB21569@kernel.org>
References: <20200324042424.68366-1-ravi.bangoria@linux.ibm.com>
 <20200324104843.GS1534489@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324104843.GS1534489@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 24, 2020 at 11:48:43AM +0100, Jiri Olsa escreveu:
> On Tue, Mar 24, 2020 at 09:54:24AM +0530, Ravi Bangoria wrote:
> > Perf gets dso details from two different sources. 1st, from builid
> > headers in perf.data and 2nd from MMAP2 samples. Dso from buildid
> > header does not have dso_id detail. And dso from MMAP2 samples does
> > not have buildid information. If detail of the same dso is present
> > at both the places, filename is common.
> > 
> > Previously, __dsos__findnew_link_by_longname_id() used to compare only
> > long or short names, but Commit 0e3149f86b99 ("perf dso: Move dso_id
> > from 'struct map' to 'struct dso'") also added a dso_id comparison.
> > Because of that, now perf is creating two different dso objects of the
> > same file, one from buildid header (with dso_id but without buildid)
> > and second from MMAP2 sample (with buildid but without dso_id).
> > 
> > This is causing issues with archive, buildid-list etc subcommands. Fix
> > this by comparing dso_id only when it's present. And incase dso is
> > present in 'dsos' list without dso_id, inject dso_id detail as well.
> > 
> > Before:
> > 
> >   $ sudo ./perf buildid-list -H
> >   0000000000000000000000000000000000000000 /usr/bin/ls
> >   0000000000000000000000000000000000000000 /usr/lib64/ld-2.30.so
> >   0000000000000000000000000000000000000000 /usr/lib64/libc-2.30.so
> > 
> >   $ ./perf archive
> >   perf archive: no build-ids found
> > 
> > After:
> > 
> >   $ ./perf buildid-list -H
> >   b6b1291d0cead046ed0fa5734037fa87a579adee /usr/bin/ls
> >   641f0c90cfa15779352f12c0ec3c7a2b2b6f41e8 /usr/lib64/ld-2.30.so
> >   675ace3ca07a0b863df01f461a7b0984c65c8b37 /usr/lib64/libc-2.30.so
> > 
> >   $ ./perf archive
> >   Now please run:
> > 
> >   $ tar xvf perf.data.tar.bz2 -C ~/.debug
> > 
> >   wherever you need to run 'perf report' on.
> > 
> > Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
> looks good, do we need to add the dso_id check to sort__dso_cmp?

Jiri:

Humm, you mean sort__dso_cmp() -> _sort__dso_cmp() should consider the
dso_id and not just its name? Humm, when "dso" sort key is used that
means just the short_name (or long_name, if verbose), if we use the ID
for "dso" then we need to somehow show the id in the output, otherwise
we'd have multiple lines with the same DSO name, when multiple versions
exist... Perhaps we should do a first pass, figure out if there are DSOs
with the same name/different IDs and mark them for showing the ID to
differentiate them on the output? But this is something that should be
dealt with in a separece cset, I think.

With that in mind, can I add your Acked-by for this patch, with my
changes described below?

Ravi:

I'm applying it with the changes below, to keep namespacing consistency, ok?

- Arnaldo

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 5c5bfa2538a9..939471731ea6 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -26,7 +26,7 @@ static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
 	return 0;
 }
 
-static bool is_empty_dso_id(struct dso_id *id)
+static bool dso_id__empty(struct dso_id *id)
 {
 	if (!id)
 		return true;
@@ -34,7 +34,7 @@ static bool is_empty_dso_id(struct dso_id *id)
 	return !id->maj && !id->min && !id->ino && !id->ino_generation;
 }
 
-static void inject_dso_id(struct dso *dso, struct dso_id *id)
+static void dso__inject_id(struct dso *dso, struct dso_id *id)
 {
 	dso->id.maj = id->maj;
 	dso->id.min = id->min;
@@ -48,7 +48,7 @@ static int dso_id__cmp(struct dso_id *a, struct dso_id *b)
 	 * The second is always dso->id, so zeroes if not set, assume passing
 	 * NULL for a means a zeroed id
 	 */
-	if (is_empty_dso_id(a) || is_empty_dso_id(b))
+	if (dso_id__empty(a) || dso_id__empty(b))
 		return 0;
 
 	return __dso_id__cmp(a, b);
@@ -266,8 +266,8 @@ static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struc
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false);
 
-	if (dso && is_empty_dso_id(&dso->id) && !is_empty_dso_id(id))
-		inject_dso_id(dso, id);
+	if (dso && dso_id__empty(&dso->id) && !dso_id__empty(id))
+		dso__inject_id(dso, id);
 
 	return dso ? dso : __dsos__addnew_id(dsos, name, id);
 }
