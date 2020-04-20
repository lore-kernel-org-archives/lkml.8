Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B28C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A909206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVh9bMHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgDTMFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgDTMFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:05:37 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383BDC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 05:05:37 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id t3so10203531qkg.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 05:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4kJ8SlOP2vcDVKhs/hat7C/sGoGtacJd5TYlYgE4RzE=;
        b=XVh9bMHhM2Z51YhloSA2HuSu0ht3hY8WMatIPJpqQzFTfJ99VkK+kwn4pCeRXa9zAa
         j59468JQ0aZmaOpQIR48HdeK4I3wzFTlPJGgOwLrv7HIz969AJouT+q6lSzkScwea7c0
         rM8oTKHkEq/APsvCcdzZ6MslUewKeIcrQRQxw1HRs7V/9T1fs3ut283pVdkyEPloe0zs
         nuGoK6rNnVt0GXxBM80QassMg3wFi/EWRZ0/incD9bXRpZ7vgvuyXHKRF0CBkeanjjr6
         FQAHmfSrCTwSnJGmlFAm4Y0zBs18tiN+UBc3HKsuqrEo4GiTu2XXx0B0Oat5KaAePvdf
         IkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4kJ8SlOP2vcDVKhs/hat7C/sGoGtacJd5TYlYgE4RzE=;
        b=eDFZH8Jk997Nia86F44InUtvUYFaUL5ltoNqvdmq2OGHQCyCPDGdsiPg/QBMFbucVn
         Q7h/Vn8ATHQ2mJY0gc5ShwmmfMjwUFBHWbmfhsYAirM+dktP5YGTs/QHX/0Rk39yBD5G
         ioqeUG/wjNq7518xLV8xn5ErjL3SN0KEqHgK1h35YczlYjz5oBqbYZiHr2CZ9RTfGzjp
         ba0VkoAITEGOnw2xMi7u2puqb/DlQjB+FmMwbQFTagUVBTOL/rFmhGMVESRL5N+cuFmc
         Eerh1OVM3lu7r0LSs8q1jtAd3eq5B+cGiQEMHoAY8/AseDibEdF8pXi/E7cRT2eAHaNu
         Xsgg==
X-Gm-Message-State: AGi0PuY62EIb7wfYzsusDXuwGAY4dCyF4gFD1Ou/UFCR726NEzr1Lnr6
        RAIxo+vAxvUuQPpqK2Qpmhc=
X-Google-Smtp-Source: APiQypKHTQ1jTP+1a73YiOpKHdNpf05kZ33/6+Ny8z/SJfBM44XlQyr0YqPoPaNpj3PDzxQn8jr02A==
X-Received: by 2002:a37:63d4:: with SMTP id x203mr15421590qkb.391.1587384336364;
        Mon, 20 Apr 2020 05:05:36 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y9sm355508qtc.12.2020.04.20.05.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 05:05:35 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6EE28409A3; Mon, 20 Apr 2020 09:05:33 -0300 (-03)
Date:   Mon, 20 Apr 2020 09:05:33 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] perf bench: Fix div-by-zero if runtime is zero
Message-ID: <20200420120533.GA14597@kernel.org>
References: <20200417132330.119407-1-tommi.t.rantala@nokia.com>
 <20200417132330.119407-4-tommi.t.rantala@nokia.com>
 <20200420090526.GF718574@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420090526.GF718574@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 20, 2020 at 11:05:26AM +0200, Jiri Olsa escreveu:
> On Fri, Apr 17, 2020 at 04:23:29PM +0300, Tommi Rantala wrote:
> > Fix div-by-zero if runtime is zero:
> > 
> >   $ perf bench futex hash --runtime=0
> >   # Running 'futex/hash' benchmark:
> >   Run summary [PID 12090]: 4 threads, each operating on 1024 [private] futexes for 0 secs.
> >   Floating point exception (core dumped)
> > 
> > Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied,

- Arnaldo
