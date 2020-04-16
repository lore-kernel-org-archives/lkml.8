Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A78C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A9621927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfWDV60h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506851AbgDPPy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2506841AbgDPPyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:54:22 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED225C061A0C;
        Thu, 16 Apr 2020 08:54:21 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id da9so2246783qvb.3;
        Thu, 16 Apr 2020 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=06igGIcA/H4ph8vvfbTG6rW0CuRmF7Et2FUQ0fy+gEM=;
        b=DfWDV60hyZMIyGS0zblXGs2jigtxTirnH7OvPNmvDmU4eEssi/kaFlj1hOPIe0ZPxv
         aeWqJLp6b0S7hOwRXOF5zvji5IWS4j+CCvmwXkncfxw0EhoqZKAIH0RWANCrCdT3XNMK
         efRpthmeCFQ5+bkJAIDv+vLjS1f6s1VoGRNsCXI6I9onRuSAwWsZwi7LpZFFHbJo1hVA
         9FuqxDE45uhFUfwA5Qq03RqhWVP5SctfeNAcASifSHFQhT6FoifvUn/P4KKJ77CpArdt
         PWQkmr3ZsPCjfA1+IiAVDR7Smr7utPfiZCuAwAmM4LZAThyIcqseEltkHhrUnNcFHpUE
         E02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=06igGIcA/H4ph8vvfbTG6rW0CuRmF7Et2FUQ0fy+gEM=;
        b=Ub2aRgHzdBSOslk6VxvLmJZE2kOO08buq8sEZURFC7yeMz++gjKRM475PPDouUPU37
         b5GBWOMWKB4sWklfmqDC0kwpNZgsHSZ5g9teN++JiHktbr6M68Q3oakCguQOQ7JVhmUk
         UrpIvytBRu4XPqkuJD7fawrvc9E1W5KwTZovkSQO7m2Jj7oY0c8ON6bynN9UOVYfZis2
         0Qfl9LmfTuMaM9rUJsaRsQ/RHEhWrlkDBhneln9HzsZTwoUWqKjNTH1lBvO0ht5Dbtwi
         0byG6DLmr9HOcZXGlg+x17LTrDQcZFyF2d12u/jXksvLmYQBhku5wRXpJFoLcdeHH6jz
         6YbA==
X-Gm-Message-State: AGi0PubeMkGgvDwtl6apJZsyuNPCoFb6b+BpUWgotY8mPkv8AaOYdLcA
        Kp/aEmdoIrIIm4j256CtiLwcY3zMS3Y=
X-Google-Smtp-Source: APiQypKL4DlMArGAv/3DiI025InEC28GZ34i4YaFvPQLxlkkQR3N8qR9VobjJ5bgiUDD1KmgLJULgw==
X-Received: by 2002:a0c:b790:: with SMTP id l16mr10618122qve.244.1587052461177;
        Thu, 16 Apr 2020 08:54:21 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y21sm14861483qka.37.2020.04.16.08.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:54:20 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EDD57409A3; Thu, 16 Apr 2020 12:54:17 -0300 (-03)
Date:   Thu, 16 Apr 2020 12:54:17 -0300
To:     Daniel Stone <daniels@collabora.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH 11/15] tools headers UAPI: Update tools's copy of drm.h
 headers
Message-ID: <20200416155417.GF2650@kernel.org>
References: <20200414164854.26026-1-acme@kernel.org>
 <20200414164854.26026-12-acme@kernel.org>
 <dc0b22308659f29d6b9e237d353ca651d34d183b.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc0b22308659f29d6b9e237d353ca651d34d183b.camel@collabora.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 14, 2020 at 05:56:59PM +0100, Daniel Stone escreveu:
> On Tue, 2020-04-14 at 13:48 -0300, Arnaldo Carvalho de Melo wrote:
> > Picking the changes from:
> > 
> >   455e00f1412f ("drm: Add getfb2 ioctl")
> > 
> > Silencing these perf build warnings:
> > 
> >   Warning: Kernel ABI header at 'tools/include/uapi/drm/drm.h'
> > differs from latest version at 'include/uapi/drm/drm.h'
> >   diff -u tools/include/uapi/drm/drm.h include/uapi/drm/drm.h
> > 
> > Now 'perf trace' and other code that might use the
> > tools/perf/trace/beauty autogenerated tables will be able to
> > translate
> > this new ioctl code into a string:
> > 
> >   [...]
> 
> Acked-by: Daniel Stone <daniels@collabora.com>

Thanks!

- Arnaldo
