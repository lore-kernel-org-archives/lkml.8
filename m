Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B28C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB7C20757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gssMYD3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389656AbgDBQAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:00:55 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33062 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389294AbgDBQAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:00:54 -0400
Received: by mail-qv1-f67.google.com with SMTP id p19so1940774qve.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vKSTzD5dMKe9JHrU8ejHD98lW61dePVyTdM4k9M5OSQ=;
        b=gssMYD3taQrgq42MSopWQLhxwn+NVZvrDC8e9+8k14Gb0ulm9JFGt8qVUpaqmvbeck
         epY2+iK7j28ukl79wFOo5MO6tEuHdnfqZVp78zzQjw7NZato5d8hujjdEd9ibLnYOJCz
         bLCwF7NZnoZailFJXB/p6Ps/CgAibOrGsA4YVtwnPKNZA/3dRBGTfW3mrBtjYapNNQbk
         OsTrrXA11UtGjbtmqd1h1b9m0uN8igLTZZU8Ao6hp0yG/yJNj3qctPmgoCK9kJjUTe+o
         E3qy6rDDhEXmzdgg9L3vnxatJ91ftOBS9Je03YiPfWSzKgxIcjyagsnbhFq7QzUfONeD
         CnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vKSTzD5dMKe9JHrU8ejHD98lW61dePVyTdM4k9M5OSQ=;
        b=ai+vw+lpoDtVKM/giBEhiEdQt/p0GfcWLbxZqT7L9dFx9kkpFFttrSn0mWPRtLKLqC
         Ma8qZ0b8S5XJEf000slBvOdLzCPoO3WF9HUJI44ZeCd7YIlySo/KHHO4GeTxfGlOzaM9
         Y2liooFhLbRMJsO/XAMBPQsO4BEMCzzOP1Oz+Ug5AyJdqYR4rVgovytLdHUzeK/48D9s
         JYtOSNVe4CuXQ1gpJlPvW+0nz2FoKh9gJeWF2xqRts2qWF4qZS/Fm8/ovaGcaCc628Cn
         ComOYp2Fde4sOf7JQir+AMoaHyo6uHEB69+uIgqX/s46r+ilpoUDdxr23gqH+lKXqYQ/
         lNZw==
X-Gm-Message-State: AGi0PuYrn65WOMajr1EdlD9UAeXlK7zbo+GOEx+No64r4vzen8+S9D7/
        uJz9FLWO/X57vAmPQ2KDsil16T4B++w=
X-Google-Smtp-Source: APiQypJuZCnyPTKHV3Xm5aX1YvvSGF0C/iRW2RHjQQhe+b5D++0AUS/he4eZnDknZdAv4GO1z3j4VQ==
X-Received: by 2002:a0c:e610:: with SMTP id z16mr4003834qvm.49.1585843252420;
        Thu, 02 Apr 2020 09:00:52 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id q7sm3736077qkn.118.2020.04.02.09.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 09:00:51 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C255D409A3; Thu,  2 Apr 2020 13:00:49 -0300 (-03)
Date:   Thu, 2 Apr 2020 13:00:49 -0300
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH V4 00/17] Stitch LBR call stack (Perf Tools)
Message-ID: <20200402160049.GE8736@kernel.org>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
 <20200323111311.GH1534489@krava>
 <e2887d1f-e963-66b4-f0cb-fa23986565a2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2887d1f-e963-66b4-f0cb-fa23986565a2@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 02, 2020 at 11:34:18AM -0400, Liang, Kan escreveu:
> 
> 
> On 3/23/2020 7:13 AM, Jiri Olsa wrote:
> > On Thu, Mar 19, 2020 at 01:25:00PM -0700, kan.liang@linux.intel.com wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > Changes since V3:
> > > - There is no dependency among the 'capabilities'. If perf fails to read
> > >    one, it should not impact others. Continue to parse the rest of caps.
> > >    (Patch 1)
> > > - Use list_for_each_entry() to replace perf_pmu__scan_caps() (Patch 1 &
> > >    2)
> > > - Combine the declaration plus assignment when possible (Patch 1 & 2)
> > > - Add check for script/report/c2c.. (Patch 13, 14 & 16)
> > 
> > it's all black magic to me, but looks ok ;-)
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> 
> Thanks Jirka.
> 
> Hi Arnaldo,
> 
> Any comments for the series?

I need to test it, hope to do it soon, but I'm a bit backlogged, sorry.

- Arnaldo
