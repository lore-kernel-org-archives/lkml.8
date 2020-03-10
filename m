Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A42BC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDB22468C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijzjfY87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCJLpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:45:10 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35525 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgCJLpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:45:10 -0400
Received: by mail-qk1-f194.google.com with SMTP id d8so7910206qka.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 04:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JFUcdzOUencsCKId/ctBPwQiHSHHBRg97HyGLAkaW4E=;
        b=ijzjfY879xd5ao57WpwaANRMaCpaYDMaEpB29Q+QPTBgwItb+0yR12YExXxydmWku6
         GD2IcA0blDbhvaLkR/D9I/zJi7jATnknUN5Gu57O3o8B6HGyt7utmhgnbrmAW4mYpctu
         bIa9ovc2UvhTdaYtuSp7NgpDvKv0JHvbOkYhP3M9UmWbF1vhjP3V8pW0xV/iOOyBXs0r
         kRfIkbFhZcqI6vsL4HnDlfRHF15o+Ipho+C40hyc2kmoKKV1I3CN7cz3eQtK1p+/Ccm/
         n4h//ORgHOuxkXMDKj2faxGuHwjdncXVdNazEA/LIhQhHamEEj3g1frdZ31ivEukcnrM
         HjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JFUcdzOUencsCKId/ctBPwQiHSHHBRg97HyGLAkaW4E=;
        b=tgUZg6q38wdWn7bVjTOEOqQK6IwhRsAnf8FUOY59K1rGqc3Sm65UZf7MME3zcZ5nQu
         Sck76adhPqMQMj0vvFP++c5TkcWuq5EsrHdmt6wXANWVWtYBZzPdUFil7cy5dRCHEXnd
         Bl/4efUDfUkdp4hfRkmRFLI91WbqETAmo7g35BkOd/GJiJDvpTQ06dac989RpML9fwgA
         fVjP0TtcBZZUCqrk/ovWbk90WpFWro7lhJdStUltu61GTL/ogrSw3GFkKd0ea6nU61Sk
         A8GWIcgXinn88W6vD9jWPeowLVStFfqUyqvm4Zbv1KJrY7bPh/3vdkdOqqKmX6oDQH+p
         XzXQ==
X-Gm-Message-State: ANhLgQ0cBkOO/nEGj96DOEwt/SgF9+/iPc/BOcPclXyUzMVtRoPP/smx
        NOtDCaeA0X5GJ5La+G+SU9c=
X-Google-Smtp-Source: ADFU+vscKo8xuu/DwFLFjKLU/u+/KK3pvCK7+CEPE3KsX6WkzzshJxugxbuhzxTkPNUs8k79BelGew==
X-Received: by 2002:a37:6852:: with SMTP id d79mr10937577qkc.304.1583840707653;
        Tue, 10 Mar 2020 04:45:07 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h9sm23852287qtq.61.2020.03.10.04.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 04:45:06 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF4DA40009; Tue, 10 Mar 2020 08:45:03 -0300 (-03)
Date:   Tue, 10 Mar 2020 08:45:03 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v5 0/5] perf cs-etm: Fix synthesizing instruction samples
Message-ID: <20200310114503.GA25299@kernel.org>
References: <20200219021811.20067-1-leo.yan@linaro.org>
 <20200310054305.GA21545@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310054305.GA21545@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 10, 2020 at 01:43:05PM +0800, Leo Yan escreveu:
> Hi Arnaldo,
> 
> On Wed, Feb 19, 2020 at 10:18:06AM +0800, Leo Yan wrote:
> > This patch series is to address issues for synthesizing instruction
> > samples, especially when the instruction sample period is small enough,
> > the current logic cannot synthesize multiple instruction samples within
> > one instruction range packet.
> > 
> > Patch 0001 is to swap packets for instruction samples, so this allow
> > option '--itrace=iNNN' can work well.
> > 
> > Patch 0002 avoids to reset the last branches for every instruction
> > sample; if reset the last branches for every time generating sample, the
> > later samples in the same range packet cannot use the last branches
> > anymore.
> > 
> > Patch 0003 is the fixing for handling different instruction periods,
> > especially for small sample period.
> > 
> > Patch 0004 is an optimization for copying last branches; it only copies
> > last branches once if the instruction samples share the same last
> > branches.
> > 
> > Patch 0005 is a minor fix for unsigned variable comparison to zero.
> > 
> > This patch set has been rebased on the latest perf/core branch; and
> > verified on Juno board with below commands:
> > 
> >   # perf script --itrace=i2
> >   # perf script --itrace=i2il16
> >   # perf inject --itrace=i2il16 -i perf.data -o perf.data.new
> >   # perf inject --itrace=i100il16 -i perf.data -o perf.data.new
> 
> Could you pick up this patch set?  I confirmed this patch set can
> cleanly apply on top of the latest mainline kernel (5.6-rc5).
> 
> Or if you want me to resend this patch set, please feel free let me
> know.  Thanks!

Thanks, all build tested on x86 and arm64 (with CORESIGHT=1, etc), applied.

- Arnaldo
