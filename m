Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF95C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465C820857
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVn9kfmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgDWOLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726430AbgDWOLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:11:12 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456A9C08E934;
        Thu, 23 Apr 2020 07:11:12 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id b1so1264842qtt.1;
        Thu, 23 Apr 2020 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7YQT1HshLEgsy9SCtlXo8Mca6nyurxYWe8bb9ulLxP4=;
        b=RVn9kfmI7CQtGrMhopacWYGk3XMQ2L2JdJecsN5NcAz9O2B1H9QlhLKixBekRM9e4Y
         mdv9DjJlUda110hH7LnVVdg6+VkTwD+Oa8ucni0BmJZlE2PBdwK0kxo/FYEnIl+MmFUu
         8g9nkJlv5YzbCUj9rR/q5F4UuqaDaTA5BZQkRyr/38PVK7TbnAe5NtjgX2rHWqqt1mQO
         TPBPKn0uAgjUUDD/suceiAGj6tajZYQr2xt2BnYAfGv/Ejbl55LTjABBA9C+j41XqKDa
         aCDK/2NEx2p56gjFevtL9xQlJbhNKznGwbyCYQgni5My/iIB3qPAH9dKH+WrdJNADkRX
         1sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7YQT1HshLEgsy9SCtlXo8Mca6nyurxYWe8bb9ulLxP4=;
        b=jrCXcEgnXwPEUAj16RyvYJ0KLRzWzkj9WCz6JN/Qapu+Nbiwdy44rvUdUhaZDySZGz
         qDpwA+WId7Wzd9P/Ro1eN1+i2a9KRgkdC3ABTlw7ylJKPYZZopaL++qvOGThTYMRqas5
         9vWIJcWbFzEQi7KMIetQlnvKakcI2rf46AP3ak+FHVJxsLSq9cckIij/C1B8+8B00GyT
         mzcuDzMU+8aiFU5DZSLHEaLiBUSTDTcUE4pV7BFtXbQOdCH886qt8YD9mjGi5/X3kujp
         hhxwzK9f1TQ3vmKuVjzYpI4XeYMtQb0P242O6j/PII3b5395G8p4JTqfUCvM8MyzSAvm
         NUfA==
X-Gm-Message-State: AGi0PuaX0td73h/eZL0gNic2pQuiop66nEGRnhE24C9CRSZEfnMm+BC0
        StHITPP2y0bqgmI+FL2xgfZWyPU+oEw=
X-Google-Smtp-Source: APiQypJmUtX8c0xkJkOP9KqvU2DKgyyRK1Wdw+8qjXlfzuDbqYLKOvi2483kINW6fJSkjvEb2UdELQ==
X-Received: by 2002:ac8:6ec8:: with SMTP id f8mr3986583qtv.330.1587651071467;
        Thu, 23 Apr 2020 07:11:11 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id d69sm1592027qke.111.2020.04.23.07.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 07:11:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 67F32409A3; Thu, 23 Apr 2020 11:11:08 -0300 (-03)
Date:   Thu, 23 Apr 2020 11:11:08 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3] perf/record: add num-synthesize-threads option
Message-ID: <20200423141108.GH19437@kernel.org>
References: <20200422155038.9380-1-irogers@google.com>
 <20200423120957.GL1136647@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423120957.GL1136647@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 23, 2020 at 02:09:57PM +0200, Jiri Olsa escreveu:
> On Wed, Apr 22, 2020 at 08:50:38AM -0700, Ian Rogers wrote:
> > From: Stephane Eranian <eranian@google.com>
> > 
> 
> SNIP
> 
> > That is the processing is 1.49% of execution time and there is plenty to
> > make parallel. This is shown in the benchmark in this patch:
> > https://lore.kernel.org/lkml/20200415054050.31645-2-irogers@google.com/
> > Computing performance of multi threaded perf event synthesis by
> > synthesizing events on CPU 0:
> >  Number of synthesis threads: 1
> >    Average synthesis took: 127729.000 usec (+- 3372.880 usec)
> >    Average num. events: 21548.600 (+- 0.306)
> >    Average time per event 5.927 usec
> >  Number of synthesis threads: 2
> >    Average synthesis took: 88863.500 usec (+- 385.168 usec)
> >    Average num. events: 21552.800 (+- 0.327)
> >    Average time per event 4.123 usec
> >  Number of synthesis threads: 3
> >    Average synthesis took: 83257.400 usec (+- 348.617 usec)
> >    Average num. events: 21553.200 (+- 0.327)
> >    Average time per event 3.863 usec
> >  Number of synthesis threads: 4
> >    Average synthesis took: 75093.000 usec (+- 422.978 usec)
> >    Average num. events: 21554.200 (+- 0.200)
> >    Average time per event 3.484 usec
> >  Number of synthesis threads: 5
> >    Average synthesis took: 64896.600 usec (+- 353.348 usec)
> >    Average num. events: 21558.000 (+- 0.000)
> >    Average time per event 3.010 usec
> >  Number of synthesis threads: 6
> >    Average synthesis took: 59210.200 usec (+- 342.890 usec)
> >    Average num. events: 21560.000 (+- 0.000)
> >    Average time per event 2.746 usec
> >  Number of synthesis threads: 7
> >    Average synthesis took: 54093.900 usec (+- 306.247 usec)
> >    Average num. events: 21562.000 (+- 0.000)
> >    Average time per event 2.509 usec
> >  Number of synthesis threads: 8
> >    Average synthesis took: 48938.700 usec (+- 341.732 usec)
> >    Average num. events: 21564.000 (+- 0.000)
> >    Average time per event 2.269 usec
> > 
> > Where average time per synthesized event goes from 5.927 usec with 1
> > thread to 2.269 usec with 8. This isn't a linear speed up as not all of
> > synthesize code has been made parallel. If the synthesis time was about
> > 10 seconds then using 8 threads may bring this down to less than 4.
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
