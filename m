Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A609DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DED0207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599792900;
	bh=DrVuFsBCahhtdl03QKKgdhi8mZ5kWubj68AVuK3jZpM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JqcN+G7ohF8H8b2nhwGM8iholAFL2qa8iWEG90mBk3qgn4jInVAh273h8r9ApngYK
	 lOJSqi7tpdwyQPabKtlnNiLoDBceXGq5KxWEwg/YA2mZYI/dGzCQcjiFotgxbNW3GL
	 TDVKh1Yc59BsM/AMd4v5dCIXnzWx9nZWesgxzGdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgIKCy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 22:54:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34758 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKCy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 22:54:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id l15so119317wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 19:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h35IaWSy2+4hYPjKOTEp0K3qPfXXYMgfr7j8QMDFOzA=;
        b=NpvFb+i39xyekBkPZjcdLnSo+aWaH4FlBo9dTOF4mMdJTfz5rUlpPEMvBh3ODmC+Dx
         D3XwhMDHLJkNHHRe7vGK+4LSfo5020ZmN7I0dILgaaVcrRA3rja5pWLO5XZZkQvgVDrM
         OHZ+Ifm5dv6zDkNSvXAZZTvd6QaWyC+/xAQCvv9APj8T0mW8hSxoeFYA1Vj61Ean3vCn
         bcpiE4a4cuoDPSXnlJzy4pQ98EgKGwN8D8qouJaXNWUOR6QFnRT+RLOFCQe/HV/qgw9k
         r0aD5VHfBps5rc8LHoYBX0JlnF91gIlRa4fdiwC71eoPDiduVfLK6OhbBvZUHLwOfb3n
         +C8w==
X-Gm-Message-State: AOAM533Vv0bj9duTMauhlM1AGKZDFJQF8y8nCoZ37dgwumT101mNVz2h
        Nlg+neVo1iQXTIAXL03PTbTUZ+WlJwWOPalh8Do=
X-Google-Smtp-Source: ABdhPJxUTX4WaQN/pf5GhrFUPQwWvf3P3dyRbMBvavlGjtmWfWReuHKEyCeM5cRDpbqe/S+1QtzVr+fqHyVse1yTD7o=
X-Received: by 2002:a1c:6341:: with SMTP id x62mr2923420wmb.70.1599792896030;
 Thu, 10 Sep 2020 19:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200908044228.61197-1-namhyung@kernel.org> <20200910155736.jadhmqvnqquammpn@two.firstfloor.org>
 <CAP-5=fUp90QrY+HcetpgZJeUn2fSqndRCZ8f1m=rFcEwO7ZZew@mail.gmail.com>
In-Reply-To: <CAP-5=fUp90QrY+HcetpgZJeUn2fSqndRCZ8f1m=rFcEwO7ZZew@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 11 Sep 2020 11:54:45 +0900
Message-ID: <CAM9d7cgxrhBfNbFKg6HfMV4SXPe9G1nE6Fy6Uj=Bb5h9LOGUoA@mail.gmail.com>
Subject: Re: [PATCHSET 0/4] perf stat: Add --multiply-cgroup option
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <andi@firstfloor.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Fri, Sep 11, 2020 at 2:11 AM Ian Rogers <irogers@google.com> wrote:
> Just to throw in some 2c worth. A nice thing about Namhyung's approach
> is that it can apply for metrics, events and pfm-events. It would be
> nice if there were a single option for specifying these, perhaps we
> can figure one out.

Right!  Thanks for sharing your opinion. :)

>
> One thought that came to mind based on Namhyung's multiply name was
> and assuming a cgroup could be a modifier:
>
> perf record -e cycles:G1
>
> there could be equivalent to a new syntax of lists and multiplies of:
>
> perf record -e [cycles]*[:G1]
>
> This would allow expressions like:
>
> perf record -e [{instructions,cycles},branches]*[:u,:k]
>
> which would be equivalent to (showing the effect on sibling groups):
>
> perf record -e {instructions:u,cycles:u},branches:u,{instructions:k,cycles:k},branches:k
>
> Adding in cgroups makes a longer list of events:
>
> perf record -e [{instructions,cycles},branches]*[:u,:k]*[:G1,:G2]
>
> becomes:
>
> perf record -e {instructions:u:G1,cycles:u:G1},branches:u:G1,{instructions:k:G1,cycles:k:G1},branches:k:G1,{instructions:u:G2,cycles:u:G2},branches:u:G2,{instructions:k:G2,cycles:k:G2},branches:k:G2
>
> This is somewhat similar to Arnaldo's proposal but trying to make
> things a bit more generic, avoiding overloading the use of sibling
> groups, .. Perhaps there is a syntax that others prefer or could be
> borrowed from a familiar source like a programming language.

Yes, but this is like a radical change.  This would be nice to deal
with repetition in the event list.  But I guess mostly we only use a
small number of events (beside the cgroups)...

>
> I think for Namhyung's sake it is important not to get too distracted
> by desires for better syntax, as this change makes a benefit in a way
> that works with the existing flags. If it is accepted, the man pages
> need to be updated.

Right.  I wonder whether they're gonna take the new option
(maybe --for-each-cgroup ?) or not regardless of the syntax change.

Thanks
Namhyung
