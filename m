Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F50EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2318720B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+cALHaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgDQVyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728202AbgDQVyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:54:06 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E29C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:54:06 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x8so2144471qtp.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fbRYSjnFHgrJijO18Dq7PBQwjz3wu/QQdb70LbuYkT0=;
        b=m+cALHaSRGFc9gA6TXpOD491JlByBoXsu/qlrTDbpRtZUhrd39+cbkBHxBtqAfQcbW
         aUrWk9QuKf20EDzHy/CGUp36d/28khjyFathi+wBykAmENEQma6JtTKx5sHJSDQeOn17
         mAuquV5OyQYZvfvwJXokZgEbhjyZq31CPrEXXbY0hmiEgT9P+0DB6rK0OUuNcKBMDqTu
         kmHGaWtr2Rm1xsyHCuOZA0Amb3te2zmaV8GjCDwFDSIfNmtG/c5DMD0r6xy3MuLqZh7f
         CocoQjrtk++M/Tcsi4OGi7w60tOnVy6eIfEdyhx3fJBF/PWXhhmqs9z+8s8up1dxTVJH
         ExUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fbRYSjnFHgrJijO18Dq7PBQwjz3wu/QQdb70LbuYkT0=;
        b=a4mQFhIAKjMwCXLiBYhpdZI3XFCzc+DV4HiGx4sy4p7axWAJvN1dCwGwiIUafUH1NI
         yTufJ2dTDMbcELcCRC/i90yb3E+Cdk5b89P/TCRfGaCUrPdbedA659of1WTiDIQufoBB
         io2Y0qeuVM+JBVSrro7a9lVhxMye1nfueXrM6IGdgzZPr8bZK84iau6XSUlFQzP0bkAs
         MH/P7iKx98ymdxavoistFYhcPzsKN0jy/gBCrDUBgsn2KiLSTfodBmH/9M3Eye62E32k
         n6/2r9B+vZR3BOZhfrRnbuCDr/2P06yKp+hzwh3LnIrZGZJsKStfrJbBYO9/B4+1oDm4
         RrZQ==
X-Gm-Message-State: AGi0PubVwXTz305Fpuu738wC/+jp93MF2umGorJtSHVuj+Q0LUJTMcOz
        CvuCCHZGbdOWOtFv6ej3S1A=
X-Google-Smtp-Source: APiQypK3FrJvg4jNITle9d5Fk3q6CPNvLrqhPDfULZ5Hn3S32mv8Nvs6innrCdjBtiA0ik1oyWQmTQ==
X-Received: by 2002:ac8:1943:: with SMTP id g3mr4144269qtk.323.1587160445521;
        Fri, 17 Apr 2020 14:54:05 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y132sm18062530qka.19.2020.04.17.14.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 14:54:04 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BCAFA409A3; Fri, 17 Apr 2020 18:54:02 -0300 (-03)
Date:   Fri, 17 Apr 2020 18:54:02 -0300
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V4 00/17] Stitch LBR call stack (Perf Tools)
Message-ID: <20200417215402.GC21512@kernel.org>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
 <20200417174803.GA21512@kernel.org>
 <2b34783b-85d1-6d30-d9e1-f550f8b6e9c0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b34783b-85d1-6d30-d9e1-f550f8b6e9c0@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 17, 2020 at 05:47:49PM -0400, Liang, Kan escreveu:
> 
> 
> On 4/17/2020 1:48 PM, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Mar 19, 2020 at 01:25:00PM -0700, kan.liang@linux.intel.com escreveu:
> > > For a simple test case tchain_edit with 43 depth of call stacks.
> > > perf record --call-graph lbr -- ./tchain_edit
> > > perf report --stitch-lbr

> > > Without --stitch-lbr, perf report only display 32 depth of call stacks.
> > > With --stitch-lbr, perf report can display all 43 depth of call stacks.
> > > The depth of call stacks increase 34.3%.

> > > Correspondingly, the processing time of perf report increases 39%,
> > > Without --stitch-lbr:                           11.0 sec
> > > With --stitch-lbr:                              15.3 sec

> > Next time provide the full test proggie, I had to expand those ... to
> > reproduce your results,

> Sure, I will do so in the future.

> > all I have is in perf/core, some patches are
> > still to be processed, will continue later, have to stop now, see:

> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?id=13cfba6b741ff

> > For my testing, looks really great!

> Thanks for the testing. :)

My pleasure.

BTW everything is in there by now.

- Arnaldo
