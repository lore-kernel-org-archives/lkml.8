Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA516C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D69E20714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="O0zD/ign"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbgFOTlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgFOTlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:41:02 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B54C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:41:01 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p18so12390287eds.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4s29RXI4DZmoz7Uu9spIoKDjM10KzT1NJ7eoQ6iGuKQ=;
        b=O0zD/ignX49ZyEfuD6nUnsJTM4Z2o6FY8NMNsDmSNfe6aQVWNrOXTRTPjuGCOQ7uCB
         k9fwQ/N07Of5R++0Wqywf7IkNDOTgpQYrKqFq25Z4tEh9kpSx0iQG8sB0skjvtknQbe8
         LAlKIYFmc59bA3kzhgA6+V+U1gaq//XY0YNfP9M1mcKrtpnepdygD4ppBX7FT2nrwDnH
         SQHjoOUEzTNzr7VSEmdqRr8gky5IcYTdj1QWaJduNkBbFQDElcSFHxEf5PNUM5ITYStm
         7DRJEHhlCSLXRKelwGOwYMezexaBwP1VefdC3djrn0BKXNFFcPnyNgUmAm3/YL88FCYy
         QPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4s29RXI4DZmoz7Uu9spIoKDjM10KzT1NJ7eoQ6iGuKQ=;
        b=YGLTLccEvXf1uxSPbt8BX9ao2VLIL/19spN+e1ZrgdTiIveynjcg9bbRJ/HzE8E6lV
         IAs9bJQi/cWj1Tm5bD8XbFxPIKxQw65LmzMsH73VaM/L1yqUqwFCko8lAhzWNCPYO+yB
         V8cuXmpu2y+gd6FhWbHlptAAPRrPchIyVMExAZ9X+7j5/3J8IqY1a+2ylYjE8staZKuk
         ZsMcReKJxagQyuH3Sh4cvIQq+wYjgXTFdwv7xwjSCZsdDWrk0y6aCHITcmubAm4Rm1M3
         Ft5RAuyY05tQMQjiLT+Ip9HLrMjUO1cBv2R0WwRKjmnF/9mkaWow1HTY4FPV97XDWd3u
         JuCQ==
X-Gm-Message-State: AOAM530a4MxgwVXZzyScu2Spf9MqKAFBme6RI64xj3xxgO9m8znlpKBi
        Cj6ruvp2sYlsB0HCcEW6+PUy+hTYAnU7sVM+SuLBJg==
X-Google-Smtp-Source: ABdhPJw7gZGRCrEp8Uckb0OtIxiFQkW6W0bIFXefK59EdVk9QlmbMAZVSR15quYWqkF3RICuTtvR0uovNicOGRMtPBI=
X-Received: by 2002:a50:c359:: with SMTP id q25mr26045616edb.123.1592250060573;
 Mon, 15 Jun 2020 12:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200615124407.32596-1-vaibhav@linux.ibm.com> <20200615124407.32596-3-vaibhav@linux.ibm.com>
 <20200615125552.GI14668@zn.tnic>
In-Reply-To: <20200615125552.GI14668@zn.tnic>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 15 Jun 2020 12:40:49 -0700
Message-ID: <CAPcyv4gmAk=mRCVQCgdSEN9JQ9b+C_u0xug-knZpQmGNL_ywxA@mail.gmail.com>
Subject: Re: [PATCH v13 2/6] seq_buf: Export seq_buf_printf
To:     Borislav Petkov <bp@alien8.de>
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 5:56 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jun 15, 2020 at 06:14:03PM +0530, Vaibhav Jain wrote:
> > 'seq_buf' provides a very useful abstraction for writing to a string
> > buffer without needing to worry about it over-flowing. However even
> > though the API has been stable for couple of years now its still not
> > exported to kernel loadable modules limiting its usage.
> >
> > Hence this patch proposes update to 'seq_buf.c' to mark
> > seq_buf_printf() which is part of the seq_buf API to be exported to
> > kernel loadable GPL modules. This symbol will be used in later parts
> > of this patch-set to simplify content creation for a sysfs attribute.
> >
> > Cc: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
> > Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > ---
> > Changelog:
> >
> > v12..v13:
> > * None
> >
> > v11..v12:
> > * None
>
> Can you please resend your patchset once a week like everyone else and
> not flood inboxes with it?

Hi Boris,

I gave Vaibhav some long shot hope that his series could be included
in my libnvdimm pull request for -rc1. Save for a last minute clang
report that I misread as a gcc warning, I likely would have included.
This spin is looking to address the last of the comments I had and
something I would consider for -rc2. So, in this case the resends were
requested by me and I'll take the grumbles on Vaibhav's behalf.
