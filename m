Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FA0C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D57206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r6bzeb1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgDURYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgDURYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:24:07 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81552C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:24:06 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id e2so9274135eje.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1W3PglCbU+VRJOx26t9wE7ivGuB2QpnMU2YOdNm+Jzg=;
        b=r6bzeb1Q5G0VunXAHq8mF0eYNzq3cn0foazV3UN4f9FJQVmHm52Mqw/AXxheXIrTKO
         22yvilhk7u6SflG2fv3IjC4uuJCLhii+qTxMRXI/z2qYYYuijaMmPO4+AJLPAzE6bS/M
         ber1yR/AlbVzENt2BPDZQ2zNBSF55LtDX0SPGsge1CUbuhiwNlIp7mVATRssrypgV9GQ
         UdrtKoLXzxN7WwUIYr3N2AC9tUrSZLuA1gSa/R9JPHJEUl9nSp+T4ADPmVlUAjKEDM5L
         r3YFpAk133SAfYjaA+49ilfgw/a6v69xm3sKtxaSJRmu7+uUY2NAMxKYSamuQIm/As/Y
         nW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1W3PglCbU+VRJOx26t9wE7ivGuB2QpnMU2YOdNm+Jzg=;
        b=NSHjXi6XuX6WFdIpwXVnU7AmgzDj3pl3VKM8W3Q4OCCaN3pqyuusIQPaHBeVSqQkam
         0al8jNGYl+oONVqVe8yZ4ZJlXeLhvwIlWq5VTYLAQLqqabnKSnxyozP57t7s6u3mLom6
         X5lQn4IKbzFHS4F+SGZX7wi6WSs5GGUlZ3fpTgOsPkPG/QlfirPxCESOcDY7lqkC67Ti
         nzM8QTS6NQObMCnjrdjbBKdr/CmLVDT6nspLlTxI1ec+egOENe9nHMn2qoM6E8+SP16A
         uxFtZ7ReVZZ2Ph0IExt62MIFA5P8c7JGJzC55noz1F1Q040hdB0ZclkbaRX40Q45MnCu
         ZzyQ==
X-Gm-Message-State: AGi0PuaDcwf5UrbJhKLTAducEPdwNWU7H5kKRconG4LOAyGU/7okCkK7
        8rkMzd9/qUG0zXnHx7/GYNZpEsyOsrUcdRa8LHJNcw==
X-Google-Smtp-Source: APiQypL13LdRmQ1m2Z66qNUe0XHNSa5D8tNS1JsnYDeuhkI6hxd1Kjbs4h40veMRno5tls0HrbBJ/q72mmsriss1Izg=
X-Received: by 2002:a17:906:2792:: with SMTP id j18mr17137875ejc.215.1587489845147;
 Tue, 21 Apr 2020 10:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200415201420.15958-1-mike.leach@linaro.org> <20200417021113.GB5426@leoy-ThinkPad-X240s>
 <CANLsYkzx_DeXcJ_dBju_OWWRiREAqzG6opeQAuXf5gTsdgZtQQ@mail.gmail.com>
In-Reply-To: <CANLsYkzx_DeXcJ_dBju_OWWRiREAqzG6opeQAuXf5gTsdgZtQQ@mail.gmail.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 21 Apr 2020 18:23:54 +0100
Message-ID: <CAJ9a7Vj-P_b46nVpzWumWQ3TshWa08dNOvoZ7Uaq8Vn2WiL11w@mail.gmail.com>
Subject: Re: [PATCH] perf: cs-etm: Update to build with latest opencsd version.
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Mathieu, Leo.

Agreed - I'll fix up to use only the latest

Thanks

Mike

On Tue, 21 Apr 2020 at 17:52, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Thu, 16 Apr 2020 at 20:11, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > Hi Mike,
> >
> > On Wed, Apr 15, 2020 at 09:14:20PM +0100, Mike Leach wrote:
> > > OpenCSD version v0.14.0 adds in a new output element. This is represented
> > > by a new value in the generic element type enum, which must be added to
> > > the handling code in perf cs-etm-decoder to prevent build errors due to
> > > build options on the perf project.
> > >
> > > This element is not currently used by the perf decoder.
> > >
> > > Tested on Linux 5.7-rc1.
> > >
> > > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > > ---
> > >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > index cd92a99eb89d..da4737cbc2ab 100644
> > > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > @@ -564,6 +564,10 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> > >               resp = cs_etm_decoder__set_tid(etmq, packet_queue,
> > >                                              elem, trace_chan_id);
> > >               break;
> > > +     /* Unused packet types */
> > > +#if OCSD_VER_NUM >= 0x0E00
> > > +     case OCSD_GEN_TRC_ELEM_I_RANGE_NOPATH:
> > > +#endif
> >
> > I don't think use macros to distinguish OpenCSD version number is a
> > good idea, this will get more and more code to checking version number
> > if later have more these kinds improvement and finally it's hard to
> > maintain.
>
> I agree.
>
> >
> > Sugget just simply add the new case for
> > OCSD_GEN_TRC_ELEM_I_RANGE_NOPATH, considering if user uses an old version
> > OpenCSD and doesn't output this new element, the new added case doesn't
> > introduce issue for old OpenCSD lib.
> >
> > Futhermore, suggest to change the code in
> > tools/build/feature/test-libopencsd.c, so can reflect the kernel 5.7
> > to require OpenCSD v0.14.0 or later version when build perf.
>
> As Leo pointed out, I think we should just continue dealing with new
> versions of the library in test-libopencsd.c.
>
> >
> > Thanks,
> > Leo
> >
> > >       case OCSD_GEN_TRC_ELEM_ADDR_NACC:
> > >       case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
> > >       case OCSD_GEN_TRC_ELEM_ADDR_UNKNOWN:
> > > --
> > > 2.17.1
> > >
> > > _______________________________________________
> > > CoreSight mailing list
> > > CoreSight@lists.linaro.org
> > > https://lists.linaro.org/mailman/listinfo/coresight



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
