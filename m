Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C80EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BFC208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoCN6iey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgCXNUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:20:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41662 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728944AbgCXNUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585056040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uaf+2nvsr079qUtSJT/PHHW1Z1966sz+OnxMbdGWfpc=;
        b=QoCN6ieyMiPLVkeVHX+TM/k+QrK8mM/kmN0A/RF/73whHzr/yIaQaIgNNA3fnc0cJHpGJM
        PXtFAotjBcMNxkngUnMkqfGVaO5k4S6zckBeBb6FYiOtMymR0wmp0ShSd1Kdk57+oVONjE
        V71a4v7LRDHYRYYz6W4I9nhbnR+bm0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-ip3rLC2ANfyXi1NNU5MfKw-1; Tue, 24 Mar 2020 09:20:37 -0400
X-MC-Unique: ip3rLC2ANfyXi1NNU5MfKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEA26800D54;
        Tue, 24 Mar 2020 13:20:35 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7EAE94B31;
        Tue, 24 Mar 2020 13:20:30 +0000 (UTC)
Date:   Tue, 24 Mar 2020 14:20:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH] perf dso: Fix dso comparison
Message-ID: <20200324132025.GW1534489@krava>
References: <20200324042424.68366-1-ravi.bangoria@linux.ibm.com>
 <20200324104843.GS1534489@krava>
 <20200324130052.GB21569@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324130052.GB21569@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 10:00:52AM -0300, Arnaldo Carvalho de Melo wrote:
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
> > > 
> > > Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > 
> > looks good, do we need to add the dso_id check to sort__dso_cmp?
> 
> Jiri:
> 
> Humm, you mean sort__dso_cmp() -> _sort__dso_cmp() should consider the
> dso_id and not just its name? Humm, when "dso" sort key is used that
> means just the short_name (or long_name, if verbose), if we use the ID
> for "dso" then we need to somehow show the id in the output, otherwise
> we'd have multiple lines with the same DSO name, when multiple versions
> exist... Perhaps we should do a first pass, figure out if there are DSOs
> with the same name/different IDs and mark them for showing the ID to
> differentiate them on the output? But this is something that should be
> dealt with in a separece cset, I think.

true, also Ravi pointed out in the other answer,
it depends on what we want.. compare the name or
different binaries with same name

> 
> With that in mind, can I add your Acked-by for this patch, with my
> changes described below?

yep,

Acked-by: Jiri Olsa <jolsa@redhat.com>

jirka

> 
> Ravi:
> 
> I'm applying it with the changes below, to keep namespacing consistency, ok?
> 
> - Arnaldo
> 
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index 5c5bfa2538a9..939471731ea6 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -26,7 +26,7 @@ static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
>  	return 0;
>  }
>  
> -static bool is_empty_dso_id(struct dso_id *id)
> +static bool dso_id__empty(struct dso_id *id)
>  {
>  	if (!id)
>  		return true;
> @@ -34,7 +34,7 @@ static bool is_empty_dso_id(struct dso_id *id)
>  	return !id->maj && !id->min && !id->ino && !id->ino_generation;
>  }
>  
> -static void inject_dso_id(struct dso *dso, struct dso_id *id)
> +static void dso__inject_id(struct dso *dso, struct dso_id *id)
>  {
>  	dso->id.maj = id->maj;
>  	dso->id.min = id->min;
> @@ -48,7 +48,7 @@ static int dso_id__cmp(struct dso_id *a, struct dso_id *b)
>  	 * The second is always dso->id, so zeroes if not set, assume passing
>  	 * NULL for a means a zeroed id
>  	 */
> -	if (is_empty_dso_id(a) || is_empty_dso_id(b))
> +	if (dso_id__empty(a) || dso_id__empty(b))
>  		return 0;
>  
>  	return __dso_id__cmp(a, b);
> @@ -266,8 +266,8 @@ static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struc
>  {
>  	struct dso *dso = __dsos__find_id(dsos, name, id, false);
>  
> -	if (dso && is_empty_dso_id(&dso->id) && !is_empty_dso_id(id))
> -		inject_dso_id(dso, id);
> +	if (dso && dso_id__empty(&dso->id) && !dso_id__empty(id))
> +		dso__inject_id(dso, id);
>  
>  	return dso ? dso : __dsos__addnew_id(dsos, name, id);
>  }
> 

