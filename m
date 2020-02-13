Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04052C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D2B222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581632214;
	bh=+e9m+76mrO7jSP59SV1EVgOykezXV6XmGHrQP0YjdCQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZTlL4DebYBs4kT4hIsjHlNOcvmIuYwzsGNWsTpRLeBr7yaA1sAUhyPFVjsv2ZaRZK
	 j0k+aHenXOOOShKgbVnC1gwnVMLgAEoRUIIn3NbwR1mGgf6Tfa6J0OIzDhDSjkGova
	 Zvh8Jol4HK/f4q05/j3g6uZ10Lj+mFz7CJxSVdfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgBMWQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:16:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgBMWQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:16:53 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A5382073A;
        Thu, 13 Feb 2020 22:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581632213;
        bh=+e9m+76mrO7jSP59SV1EVgOykezXV6XmGHrQP0YjdCQ=;
        h=From:To:Cc:Subject:Date:From;
        b=b0aRASeFB4AC2mh8lrZzpEP6rm0YIteFAHN7v9RhWRfSFAhcX31YbtHsSIkCNLNZV
         hZV8DNxDEgNkIGrJz1rGLlsTs+Aqq1z62dn4D4EdJfccw6U3kadJ/vyLSWBN5Em022
         2gB177LSA+V2+VGVTIzfos8xGtLiLfyjiGTISFBY=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] tracing: synth_event_trace fixes
Date:   Thu, 13 Feb 2020 16:16:42 -0600
Message-Id: <cover.1581630377.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Sorry, it took me some time to get a 32-bit x86 system up and running
here in order to build and test things on i386.  These patches pass
both selftests and the synth_event_gen_test testing, although the bug
where (null) prints after every integer field in the trace output is
still there and is there even before these or yesterday's patches - I
have a suspicion it's been there for awhile but nobody looked at
synthetic event trace output on i386.  In any case, I'm going to
continue looking into that - it's a weird situation where nothing gets
put in the final %s in the format string on i386 so shows as (null),
even though it looks like it's there.  Anyway..

Here are 3 bugfix patches, the first of which fixes the bug seen by
the test robot, and the other two are patches that fix a couple things
I noticed when doing the first patch.

The previous patch I sent, changing u64 to long for the test robot bug
did fix that problem too, but on i386 systems that would reduce every
field to 32 bits, which isn't what we want either.  The new patch
doesn't change the code in synth_event_trace() - it still uses u64
just like synth_event_trace_array() which takes an array of u64.
Without any further information such as a format string, I don't know
of a better way to deal with the varargs version, other than require
it get passed what it expects, u64 params.

The second patch adds the same endianness fix as for
trace_event_raw_event_synth(), and the last one just adds back a
missing check fot synth_event_trace() and synth_event_trace_array().

Thanks,

Tom

The following changes since commit 359c92c02bfae1a6f1e8e37c298e518fd256642c:

  Merge tag 'dax-fixes-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm (2020-02-11 16:52:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-event-gen-fixes2-v1

Tom Zanussi (3):
  tracing: Make sure synth_event_trace() example always uses u64
  tracing: Make synth_event trace functions endian-correct
  tracing: Check that number of vals matches number of synth  event
    fields

 kernel/trace/synth_event_gen_test.c | 34 +++++++++----------
 kernel/trace/trace_events_hist.c    | 68 ++++++++++++++++++++++++++++++++++---
 2 files changed, 81 insertions(+), 21 deletions(-)

-- 
2.14.1

