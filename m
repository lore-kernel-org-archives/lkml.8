Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0469C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF0D206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZ3kYYT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbgELKaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:30:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36303 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729405AbgELKaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589279404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qeMpxyuCBk1PKFh88yBlzyQNQ4vtmt44jKTGWUe0hIg=;
        b=aZ3kYYT0Ex1Kpcnhyb1huyoGBQoVs3MdbyMWj1FcEb2eU7c5YrCjRppXry7K1+tKCuwzBF
        cTObJwzYIoDKOzFl7k6iOccPhC2BI/w3RBAJgR+TppU6fjHJk6uR8T5NLJa9hjbFDAXhPw
        OZa8WDLllT16Hm1Kx0CB520p/wY8loc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-BmrRBb8pO0yQS-nRqrmBhg-1; Tue, 12 May 2020 06:30:00 -0400
X-MC-Unique: BmrRBb8pO0yQS-nRqrmBhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6596835B40;
        Tue, 12 May 2020 10:29:58 +0000 (UTC)
Received: from krava (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7EF1C5D9DD;
        Tue, 12 May 2020 10:29:52 +0000 (UTC)
Date:   Tue, 12 May 2020 12:29:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, will@kernel.org,
        Andi Kleen <ak@linux.intel.com>, linuxarm@huawei.com,
        LKML <linux-kernel@vger.kernel.org>, qiangqing.zhang@nxp.com,
        robin.murphy@arm.com, zhangshaokun@hisilicon.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC v3 02/12] perf jevents: Add support for system events
 tables
Message-ID: <20200512102951.GA3141346@krava>
References: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
 <1588852671-61996-3-git-send-email-john.garry@huawei.com>
 <20200511110137.GC2986380@krava>
 <9f4ea413-325f-98b4-eb4c-e47aead4f455@huawei.com>
 <CAP-5=fWHipkL6Uq1vMaz-51ETPWajofDXd6RTBMr00pcyooo_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWHipkL6Uq1vMaz-51ETPWajofDXd6RTBMr00pcyooo_g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:21:00AM -0700, Ian Rogers wrote:

SNIP

> >  >> +           fprintf(outfp, "\n\t{\n\t\t.table = %s,\n\t},",
> >  >> +                   sys_event_table->name);
> >  >> +   }
> >  >> +   fprintf(outfp, "\n\t{\n\t\t.table = 0\n\t},");
> >  >
> >  > this will add extra tabs:
> >  >
> >  >          {
> >  >                  .table = 0
> >  >          },
> >  >
> >  > while the rest of the file starts items without any indent
> >  >
> >
> > I'll ensure the indent is the same.
> >
> > BTW, is there anything to be said for removing the empty map feature
> > (and always breaking the perf build instead)? I guess that it was just
> > an early feature for dealing with unstable JSONs.
> 
> +1
> I'd very much like it if JSON parse errors and the like didn't result
> in an empty map but failed the build. I think ideally we could also

yep, that seems like good approach to me

> validate metric expressions using expr.y. If we include expr.y into
> jevents then is there any need to parse the metric expression at
> runtime? Could we just generate C code from jevents with a list of
> events (aka ids) for programming and a dedicated print function for
> each metric. The events would still be symbolic and checked at
> runtime, but the expressions being C code could yield compile time
> errors.

nice idea.. not sure we are able to do that with just expr.y code,
like to generate specific C code for metric, but I'd like to see
patches for that ;-)

but we would still need expr.y int perf code for custom user metrics,
so it still needs to stay anyway

jirka

