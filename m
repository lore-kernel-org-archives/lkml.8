Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B610C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECBE20772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSGL31M6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgCYMTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:19:17 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43209 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCYMTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:19:16 -0400
Received: by mail-qv1-f66.google.com with SMTP id c28so867653qvb.10;
        Wed, 25 Mar 2020 05:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DTxawltzS1lPKLYzoK32IEBrxWYB6OQX2yr97kcmDt4=;
        b=sSGL31M6tJ0mLuBcNqL0/LgdW3qvr2foVy7LYat3NFS6fSaBtX0GoEDfPEoJLF+YUn
         +ZF7S1vBplmTJq2EQYqU+715X81ciPHMvc0ku14oiWGKbPeMO9rEfRwoyoIi8lnl8w0o
         DoyvFwgIo4229KEH+OedZb1dplvsWjKg00vGFTaPktfz2PR7oTAKyodJCAxk0kOXhC0q
         0L+hGsnw/2t2oIZ6wJbDqEqlAAqseHGkUdoPt5O+MFSUmOMEAKaay8Sqg8lZmlWFH9xv
         qO6fGAplBcSr/a6tVSpnff0D8H/09FtkyE8ixSyZSis7M4VvlkZiUjn/676vxzz0axv6
         srew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DTxawltzS1lPKLYzoK32IEBrxWYB6OQX2yr97kcmDt4=;
        b=gjKEv9V22cnngD3mxACCQn+IIPk9KUeuTJZxIFg4R1cOUczL66j9MjI42O9qeKhmt0
         7BNA36w61620JgfITPtCuVzrjB8oPBKODuRBTg2AfzPdNOmROVtIAqQuNF8ndq8oLZVt
         0k+/C3aKlehsKGrEMlCN33csFBUdRBDUlxcBh/FQRlSDl8X/KAKlc4OTU/MErkNh6Da8
         PIFq4P9QMGptM7k+kJ1oDx3NHaX1++tvXIPE9CtovnkTuIRnZqnaGthf+N5Vorv677OU
         SVzAXqmPBdE6ZRrAJh899ppnEaqYD+VCvNwEzCTm5vblQIzt/oLEiWm9HvTDkaBhT8pd
         bJ4A==
X-Gm-Message-State: ANhLgQ10y7fmg0E2htHNU4Cva+Vobq8f6N8cCP1hmblrl7qZk1MpHz31
        mjHkLi4D5fF4WfRQxgY0Z0Y=
X-Google-Smtp-Source: ADFU+vsN9xBU/hFmbIUCX3uv7JwvoAfJiQnQZGisUcE1wSw2QznC7uiLpX0zgzLAdJ12LU8ttEuYOQ==
X-Received: by 2002:a0c:e7c7:: with SMTP id c7mr2785480qvo.188.1585138754958;
        Wed, 25 Mar 2020 05:19:14 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id c27sm5459843qkk.0.2020.03.25.05.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 05:19:14 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5AEFA40F77; Wed, 25 Mar 2020 09:19:12 -0300 (-03)
Date:   Wed, 25 Mar 2020 09:19:12 -0300
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, kan.liang@linux.intel.com,
        zhe.he@windriver.com, dzickus@redhat.com, jstancek@redhat.com,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH V2] perf cpumap: Fix snprintf overflow check
Message-ID: <20200325121912.GJ9917@kernel.org>
References: <20200324070319.10901-1-christophe.jaillet@wanadoo.fr>
 <20200324125001.GA21569@kernel.org>
 <75a8e792-dc9e-6169-4dd2-8758967c50e2@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75a8e792-dc9e-6169-4dd2-8758967c50e2@wanadoo.fr>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 24, 2020 at 03:44:15PM +0100, Christophe JAILLET escreveu:
> Le 24/03/2020 à 13:50, Arnaldo Carvalho de Melo a écrit :
> > Em Tue, Mar 24, 2020 at 08:03:19AM +0100, Christophe JAILLET escreveu:
> > > 'snprintf' returns the number of characters which would be generated for
> > > the given input.
> > > 
> > > If the returned value is *greater than* or equal to the buffer size, it
> > > means that the output has been truncated.
> > > 
> > > Fix the overflow test accordingling.
> >                                    y
> > 
> > You forgot to CC David and add this to your patch, which I did:
> > 
> > Suggested-by: David Laight <David.Laight@ACULAB.COM>
> > 
> > Ok?
> 
> No problem for me.
> 
> The to: and cc: list are (at least should be :)) the ones given by
> get_maintainer, and I was not aware of the 'Suggested-by' tag.

Sure, that is the starting point, but if someone participates in the
discussion and provides suggestions, comments, then it is sensible to
add them to the CC list in follow up patches.
 
> BTW, thanks for fixing the typo in the description.

Part of my job as a maintainer :-)

- Arnaldo
 
> CJ
> 
> 
> > - Arnaldo
> > > Fixes: 7780c25bae59f ("perf tools: Allow ability to map cpus to nodes easily")
> > > Fixes: 92a7e1278005b ("perf cpumap: Add cpu__max_present_cpu()")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > V2: keep snprintf
> > >      modifiy the tests for truncated output
> > >      Update subject and description
> > > ---
> > >   tools/perf/util/cpumap.c | 10 +++++-----
> > >   1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> > > index 983b7388f22b..dc5c5e6fc502 100644
> > > --- a/tools/perf/util/cpumap.c
> > > +++ b/tools/perf/util/cpumap.c
> > > @@ -317,7 +317,7 @@ static void set_max_cpu_num(void)
> > >   	/* get the highest possible cpu number for a sparse allocation */
> > >   	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/possible", mnt);
> > > -	if (ret == PATH_MAX) {
> > > +	if (ret >= PATH_MAX) {
> > >   		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
> > >   		goto out;
> > >   	}
> > > @@ -328,7 +328,7 @@ static void set_max_cpu_num(void)
> > >   	/* get the highest present cpu number for a sparse allocation */
> > >   	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/present", mnt);
> > > -	if (ret == PATH_MAX) {
> > > +	if (ret >= PATH_MAX) {
> > >   		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
> > >   		goto out;
> > >   	}
> > > @@ -356,7 +356,7 @@ static void set_max_node_num(void)
> > >   	/* get the highest possible cpu number for a sparse allocation */
> > >   	ret = snprintf(path, PATH_MAX, "%s/devices/system/node/possible", mnt);
> > > -	if (ret == PATH_MAX) {
> > > +	if (ret >= PATH_MAX) {
> > >   		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
> > >   		goto out;
> > >   	}
> > > @@ -441,7 +441,7 @@ int cpu__setup_cpunode_map(void)
> > >   		return 0;
> > >   	n = snprintf(path, PATH_MAX, "%s/devices/system/node", mnt);
> > > -	if (n == PATH_MAX) {
> > > +	if (n >= PATH_MAX) {
> > >   		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
> > >   		return -1;
> > >   	}
> > > @@ -456,7 +456,7 @@ int cpu__setup_cpunode_map(void)
> > >   			continue;
> > >   		n = snprintf(buf, PATH_MAX, "%s/%s", path, dent1->d_name);
> > > -		if (n == PATH_MAX) {
> > > +		if (n >= PATH_MAX) {
> > >   			pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
> > >   			continue;
> > >   		}
> > > -- 
> > > 2.20.1
> > > 
> 

-- 

- Arnaldo
