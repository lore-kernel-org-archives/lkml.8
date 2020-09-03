Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFD8C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 457B1208C7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599158494;
	bh=PoJPlIjkQQqOh7B7VUeiQr6YNDucA1m5l8Tu0BIkUZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZawpFPoq2OH6FqB+7Gkiii4zLsy9bd4/kkBzfSGunvJT8k0LW51bp8yVjKMTbjxIT
	 KLvNlPoS1D/0Jo3Ky3K61aZJlPYXf8ZfiyV8w4lzIsvDLkry8r4gvDveYY7C7UOP3n
	 lI9SGjJNoz/HQ3SZoARCrydlW3UGqUQAn/oDappE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgICSlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:41:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbgICSl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:41:27 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EBA920709;
        Thu,  3 Sep 2020 18:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599158486;
        bh=PoJPlIjkQQqOh7B7VUeiQr6YNDucA1m5l8Tu0BIkUZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GL5YmbnqD8tCnAk5VyrcGqHcKLnKNuqcTkVnnb3h4C0yXbNX9LGTHHi3cp+W0l14w
         0x5BB8D0poVfV32mRlC+OIg0GevqP12n5OGEHwGUl2vHbBevVjb+k2Xw6OcT81hTL2
         +KORyxoirZUtgSdxI0pcgsvx+wmgVtWqm9YO2Exw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EF36340D3D; Thu,  3 Sep 2020 15:41:23 -0300 (-03)
Date:   Thu, 3 Sep 2020 15:41:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        William Cohen <wcohen@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH] perf jevents: Fix suspicious code in fixregex()
Message-ID: <20200903184123.GB3495158@kernel.org>
References: <20200903152510.489233-1-namhyung@kernel.org>
 <CAP-5=fULG7CbwB0vOBkStsRV5j7=XX_F0x+fzK7KHyqp-9Y0_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fULG7CbwB0vOBkStsRV5j7=XX_F0x+fzK7KHyqp-9Y0_g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 03, 2020 at 10:47:39AM -0700, Ian Rogers escreveu:
> On Thu, Sep 3, 2020 at 8:25 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > The new string should have enough space for the original string and
> > the back slashes IMHO.

> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Kajol Jain <kjain@linux.ibm.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Definitely looks like the right fix. I'm surprised this hasn't shown
> up in sanitizer testing.

Yeap, good catch! Namyung you forgot to add the Fixes tag + Cc the patch
author that introduced that bug, I did it:

Cc: William Cohen <wcohen@redhat.com>
Fixes: fbc2844e84038ce3 ("perf vendor events: Use more flexible pattern matching for CPU identification for mapfile.csv"

Please consider doing it next time :-)

Thanks a lot!

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/pmu-events/jevents.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> > index fa86c5f997cc..fc9c158bfa13 100644
> > --- a/tools/perf/pmu-events/jevents.c
> > +++ b/tools/perf/pmu-events/jevents.c
> > @@ -137,7 +137,7 @@ static char *fixregex(char *s)
> >                 return s;
> >
> >         /* allocate space for a new string */
> > -       fixed = (char *) malloc(len + 1);
> > +       fixed = (char *) malloc(len + esc_count + 1);
> >         if (!fixed)
> >                 return NULL;
> >
> > --
> > 2.28.0.402.g5ffc5be6b7-goog
> >

-- 

- Arnaldo
