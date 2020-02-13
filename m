Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC16C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA1D20848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExoXMje/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgBMXgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 18:36:17 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38929 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBMXgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 18:36:17 -0500
Received: by mail-il1-f193.google.com with SMTP id f70so6510011ill.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 15:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Md1eUu8OWhB/P7rhE2J8cFuF6aXI0xuxNEtHD4szxMM=;
        b=ExoXMje/6sB4KqU3uCi8GernVZA9XztuXLb2OVo+O+A09yW+QPawYWPF2C1rkZFlJc
         MO2ojEyqIpgctXhm/ruJKjXLl9xobxZO54ffJEYiQ57OGBM5YNIpEdgs/FuD2+HfP/ZS
         mWTQYiSFFp9o7HxXlt0BQpC1hsCX4LlmnZ9+E/vGQaLlLZqSEad06kYpSinpxLhShXjs
         4vbDZpd99QEEChJQKLFftTitwCLcfb5wcTq1y6pfp+uNehPp9P8R71uZ+TrPL1FkRlI1
         383ukTKy2q3TpKOSkCLZAOeVw57r6EAWNmLcRPuHv0DdesKIacwpSjqvKlOAU9me7z8V
         FIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Md1eUu8OWhB/P7rhE2J8cFuF6aXI0xuxNEtHD4szxMM=;
        b=nIGciM1eVFqEud7jLB2paUMPlXthYoWkBs6CSCnbE6LrLT5JDFS/F46xrFG/OMRl75
         8OXGI/UEwNK0TzgFcgAUrPAh/gWD8QnvaXpl4VYEfSEm6hqPpYkMH0T0dH28b4E0KRiF
         ciOgpWHfiqlaImQ0xqacKZZmQbReFmrhRrmXjGYO0PewNAB4K3EriTJYE3kNaXN4epKP
         iZoIBZqhzE5ILXQUdbZtz0jmE0qRC/g02tLPVE4H1RdpgFsy43cAsjcgkhE118JSGEAx
         oSuCulpzDjlVQoQgpNFbUi+FMDkA54NRJ5Swv48aaH0+fUG+HX8Jf2pXG6OFHNiJG1tc
         8LuA==
X-Gm-Message-State: APjAAAV49xRsTtj1hba+uc8M8+M25NayvgzLzOowjrQ7/tOVI+Kid8sx
        L8C/BsjeVqScgl0DDI4ZUmsDzaSp
X-Google-Smtp-Source: APXvYqxm9X73CDx76V81EWvIYH9NmDRQjiPKUVWAaFDRuYOC1q6tox9ZmAfRBqmWAsIHWWDqsu1PKQ==
X-Received: by 2002:a92:8ccc:: with SMTP id s73mr434021ill.4.1581636976736;
        Thu, 13 Feb 2020 15:36:16 -0800 (PST)
Received: from tzanussi-mobl ([2601:246:3:ceb0:a094:31eb:1de2:f8b])
        by smtp.googlemail.com with ESMTPSA id x62sm1334834ill.86.2020.02.13.15.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 15:36:15 -0800 (PST)
Message-ID: <1581636974.2374.2.camel@gmail.com>
Subject: Re: [PATCH 0/3] tracing: synth_event_trace fixes
From:   Tom Zanussi <tzanussi@gmail.com>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Feb 2020 17:36:14 -0600
In-Reply-To: <cover.1581630377.git.zanussi@kernel.org>
References: <cover.1581630377.git.zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

I apparently tested the wrong patches, and while I think patch 1 and 3
are ok, I'm seeing a problem with patch 2 (then endian changes).  Will
send a v2 as soon as I can.

Tom

On Thu, 2020-02-13 at 16:16 -0600, Tom Zanussi wrote:
> Hi Steve,
> 
> Sorry, it took me some time to get a 32-bit x86 system up and running
> here in order to build and test things on i386.  These patches pass
> both selftests and the synth_event_gen_test testing, although the bug
> where (null) prints after every integer field in the trace output is
> still there and is there even before these or yesterday's patches - I
> have a suspicion it's been there for awhile but nobody looked at
> synthetic event trace output on i386.  In any case, I'm going to
> continue looking into that - it's a weird situation where nothing
> gets
> put in the final %s in the format string on i386 so shows as (null),
> even though it looks like it's there.  Anyway..
> 
> Here are 3 bugfix patches, the first of which fixes the bug seen by
> the test robot, and the other two are patches that fix a couple
> things
> I noticed when doing the first patch.
> 
> The previous patch I sent, changing u64 to long for the test robot
> bug
> did fix that problem too, but on i386 systems that would reduce every
> field to 32 bits, which isn't what we want either.  The new patch
> doesn't change the code in synth_event_trace() - it still uses u64
> just like synth_event_trace_array() which takes an array of u64.
> Without any further information such as a format string, I don't know
> of a better way to deal with the varargs version, other than require
> it get passed what it expects, u64 params.
> 
> The second patch adds the same endianness fix as for
> trace_event_raw_event_synth(), and the last one just adds back a
> missing check fot synth_event_trace() and synth_event_trace_array().
> 
> Thanks,
> 
> Tom
> 
> The following changes since commit
> 359c92c02bfae1a6f1e8e37c298e518fd256642c:
> 
>   Merge tag 'dax-fixes-5.6-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm (2020-02-
> 11 16:52:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-
> trace.git ftrace/synth-event-gen-fixes2-v1
> 
> Tom Zanussi (3):
>   tracing: Make sure synth_event_trace() example always uses u64
>   tracing: Make synth_event trace functions endian-correct
>   tracing: Check that number of vals matches number of synth  event
>     fields
> 
>  kernel/trace/synth_event_gen_test.c | 34 +++++++++----------
>  kernel/trace/trace_events_hist.c    | 68
> ++++++++++++++++++++++++++++++++++---
>  2 files changed, 81 insertions(+), 21 deletions(-)
> 
