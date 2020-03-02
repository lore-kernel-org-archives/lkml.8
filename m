Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F281FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F6A20842
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJY60AId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgCBS1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:27:18 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43890 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBS1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:27:18 -0500
Received: by mail-qt1-f195.google.com with SMTP id v22so694227qtp.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 10:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AWwDkiCd/ctqkBTPM4wpothOhW3ATtEOMhU4tACy/gU=;
        b=NJY60AIdhxPtQBDb4ShyRUWtzDICgnaRki5JXb4eTypSmDkE3/MMesL1vzoH3AEb76
         mCj+TX2IgcF7HDHwReJ/MOZmA/WHuIAoqDLBnQKnVD+ziS3GFBXe3XVX3ySXhHAsA3bE
         oNZhJNhmnr8HhtrGdOuuheS8RiRQSyAb2jnzV8jF/eoQwn7Bmab8eplQfCOGk5JNvgHq
         HaVBpPWZusCYAlENNz7AA/mgVeW2XCaWUHL7JeOS8FZ3aqg1wRA3ZbO0aMliC6pnFShX
         jcBFBH9LBTxUZzHlmX9N9cuRVhWOsOrRyQgW4c16tXQBEuC+8lBLfa7P3VYHKRqnl5Ia
         l11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AWwDkiCd/ctqkBTPM4wpothOhW3ATtEOMhU4tACy/gU=;
        b=jouJTFcLm3aDUoXaoUos5y7kSaTu1DGLmoRcd8Eujh7nPyDbwaAcNPESHkVoQGjHY/
         XGaJ/uOrrJfWn8jzuxYNHKG/0vcoj0Kx8XOsnpYH8IlbaA8j8Mnq8o3J8oqdjisgzZ7D
         TcNk44uJqlz4QZyQwTxT478BvpFL3Dk8tOYJDnstc/jij/QhFzYRodB5MuW0uyeCI4MB
         KB6iaHZ/L+F3O6NY8NsWHDVdOq6+HnFpJvtw74G1Py/rs6RIukYSZca3DeoP65Qg7zn9
         wgRALXVAMUL7ueNixrW1TuVi7jJg+yzPcHMmV9PlR3QC1cFgVtS9zeU9ob2T09Ol2s+J
         0Row==
X-Gm-Message-State: ANhLgQ3XnQ2KoYIa7UE4FveWf63rnF0wS4qJ+iV4rdPsuiEktYgJlygI
        QnAPsJjRCy2D2BXL9b73Cry2cm/R7bQ=
X-Google-Smtp-Source: ADFU+vvq99P5/qq8Hro8o7kIp2H1TBhv9xV621DHdB0YfBTPRF0XivuL8OpKl4cJvoSVSzmD+G/tPg==
X-Received: by 2002:ac8:3430:: with SMTP id u45mr957445qtb.381.1583173636543;
        Mon, 02 Mar 2020 10:27:16 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x184sm6426337qkb.128.2020.03.02.10.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 10:27:15 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EF4D7403AD; Mon,  2 Mar 2020 15:27:13 -0300 (-03)
Date:   Mon, 2 Mar 2020 15:27:13 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf parse-events: Use asprintf() instead of strncpy()
 for tracepoints
Message-ID: <20200302182713.GA10335@kernel.org>
References: <20200302145535.GA28183@kernel.org>
 <20200302152741.GA263077@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302152741.GA263077@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 02, 2020 at 04:27:41PM +0100, Jiri Olsa escreveu:
> On Mon, Mar 02, 2020 at 11:55:35AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> >       |          ^~~~~~
> >   CC       /tmp/build/perf/util/call-path.o
> > 
> > So I replaced it with asprintf to make the code shorter, use a bit less
> > memory and deal with the above problem, ok?
> > 
> > - Arnaldo
> > 
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index c01ba6f8fdad..a14995835d85 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -257,21 +257,15 @@ struct tracepoint_path *tracepoint_id_to_path(u64 config)
> >  				path = zalloc(sizeof(*path));
> >  				if (!path)
> >  					return NULL;
> > -				path->system = malloc(MAX_EVENT_LENGTH);
> > -				if (!path->system) {
> > +				if (asprintf(&path->system, "%.*s", MAX_EVENT_LENGTH, sys_dirent->d_name) < 0) {
> >  					free(path);
> >  					return NULL;
> >  				}
> > -				path->name = malloc(MAX_EVENT_LENGTH);
> > -				if (!path->name) {
> > +				if (asprintf(&path->name, "%.*s", MAX_EVENT_LENGTH, evt_dirent->d_name) < 0) {
> >  					zfree(&path->system);
> >  					free(path);
> >  					return NULL;
> >  				}
> > -				strncpy(path->system, sys_dirent->d_name,
> > -					MAX_EVENT_LENGTH);
> > -				strncpy(path->name, evt_dirent->d_name,
> > -					MAX_EVENT_LENGTH);
> 
> looks good to me, and we can probably remove MAX_EVENT_LENGTH as well?

I left it there, we can remove it if the need arises, this code is not
that exercised from what I could look.

- Arnaldo
