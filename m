Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34B4C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61F52070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUqMmoTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgCSS5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:57:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45613 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgCSS5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:57:55 -0400
Received: by mail-qt1-f195.google.com with SMTP id z8so2785580qto.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 11:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dbgVMuKCiO3qWse9+PzAJr6r1pcmJULnvZTcPi3Vczk=;
        b=jUqMmoTvX5iDOwcJ2qe/yIr3BWveIjPqhQ5bgBB5CBoL/0bj5Ijkg6LbQAyLOoJAjR
         ESl0EjLcrgjRclSptOIqgfCSlyiSejm5qbGinmdscd+hfc23gm1h8hhQhtSU4tw7vmAa
         nOFkOBQMp/RpVplfz9qC63rYjMgtLKL3gopso5gjSQpSjnEBcEFpRa6HsvO2Hrsj59J9
         ez1IUzpmTxK+hCybfzlM0aJunUiOXzOeiQh/uGYIOYIRzp4hUdKIuHvmOLYM98+jStwt
         Ry5+H7QOrDo7cohdB7Agihc/BM3SHCA9GrrnfTT22i+cS8oGv4qmR5l1+T+h/laZJcnt
         VZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dbgVMuKCiO3qWse9+PzAJr6r1pcmJULnvZTcPi3Vczk=;
        b=uLJTUpn6Tlqz4KVZq2XY65IKOzzGJ4/MhApQaCM5v0choPCKe4ntwREpA5H57gbSgS
         3zw0+kXAHUvfnAs1UU5QyL6jfhD+sHaqN3el4I9dhBp0jyfY86xjZBMZIhyXlIuVC0Sm
         ZieOIHYaSom6KIHhfFTuuh9phUuQ7aBx4SgqLf3Xd2TzM2z66pvnvQr1VxOwRHQ/mdWg
         5zHGLlUKa42YjW9h1r7HpmdxWY3Sh0pp55Loco0B/YPKxzzMOhhAzq4LLmCe8t9qXTAh
         u9JsAtyBWLzAnfT5Dx6Re55oU6fBZKre4sYZYFONqMUn/lygAxoE555bH4NJiRxSHgzi
         osYQ==
X-Gm-Message-State: ANhLgQ3Gp9IpCjKhFcVWq2pPVvsma6h6MHPgHajkzlEJDLjtX1S/RGK5
        H9pCb2jy+CQfAoiqhb8HwnE=
X-Google-Smtp-Source: ADFU+vv8HhdGAICqXh1uzpw9eVMKdpyRlc7xYTF4YlFmxGMC6lLWvxFZeXnqaSOJW2SzIOCxpFxLug==
X-Received: by 2002:ac8:7c9c:: with SMTP id y28mr4443898qtv.58.1584644274340;
        Thu, 19 Mar 2020 11:57:54 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 124sm2248095qkl.31.2020.03.19.11.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 11:57:53 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 05C4E40F77; Thu, 19 Mar 2020 15:57:50 -0300 (-03)
Date:   Thu, 19 Mar 2020 15:57:50 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf tools: Unify a bit the build directory output
Message-ID: <20200319185750.GE14841@kernel.org>
References: <20200318204522.1200981-1-jolsa@kernel.org>
 <20200319182514.GC14841@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319182514.GC14841@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 19, 2020 at 03:25:14PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Mar 18, 2020 at 09:45:22PM +0100, Jiri Olsa escreveu:
> > Removing the extra 'SUBDIR' line from clean and doc build
> > output. Because it's annoying.. ;-)
> > 
> > Before:
> >   $ make clean
> >   ...
> >   SUBDIR   Documentation
> >   CLEAN    Documentation
> > 
> > After:
> >   $ make clean
> >   ...
> >   CLEAN    Documentation
> 
> Thanks, applied to perf/core.

Hey, since you're annoyed, how about sending a patch to ditch this one:

make[3]: Nothing to be done for '/tmp/build/perf/plugins/libtraceevent-dynamic-list'.

? ;-)

- Arnaldo
