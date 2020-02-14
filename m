Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEF6C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC0C2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581721009;
	bh=U/QmWLB5jPwj3EBEuyFPQvkydx7nNulFeGjr1+ATGwE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DQUI3LWm2nTLRnwO5a3op1Kw615cYEzg/2LewZcnF15AGVYMUa/Fqrg3onf8h7aSU
	 2rsBO5zZWbNTZx+BGorLG6y63XnNxylPbrD0HQNY+EJPVujkqYAdOz1eQMWig5sbKi
	 dPym1tNQNM4GY8k6gTcTmKbWeoGrs9TCv1ZM1gAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBNW4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbgBNW4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:56:48 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF67720848;
        Fri, 14 Feb 2020 22:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581721007;
        bh=U/QmWLB5jPwj3EBEuyFPQvkydx7nNulFeGjr1+ATGwE=;
        h=From:To:Cc:Subject:Date:From;
        b=KdxKODdiIADZdHq0I1VKbihQRibKEqkKMEapxq9FFrnHI4J/NtKO5zNw+1Haj7wcl
         sD2NM2r1Tv1q9WOnEQ8x6Xhf2GWoR+iktG8Mr4THdiEdZMH85NUFEQjGDTxuf1Pu0E
         tzOkVdiHw64nCLr1kKGZZsE9WaPzix31X5Gf6wAo=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] tracing: synth_event_trace fixes
Date:   Fri, 14 Feb 2020 16:56:37 -0600
Message-Id: <cover.1581720155.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

This is v2 of this patchset.  It adds a new patch, 'tracing: Fix
number printing bug in print_synth_event()' that fixes the problem you
reported with (null) printing in the synth event trace output on
32-bit systems.  It turns out to be nothing to do with these fixes or
the new stuff in 5.6 - the problem exists in 5.5 as well and can also
cause oopses as well when reading the trace file when synthetic evens
are present.

The only other change from v1 is a change to 'tracing: Check that
number of vals matches number of synth event fields' to not directly
return -EINVAL, but only after calling __synth_event_trace_end().

I've tested on both 32-bit x86 and x86_64, both the synth module test
and selftests and everything looks ok here.

Thanks,

Tom

v1 text:

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

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-event-gen-fixes2-v2

Tom Zanussi (4):
  tracing: Make sure synth_event_trace() example always uses u64
  tracing: Make synth_event trace functions endian-correct
  tracing: Check that number of vals matches number of synth event
    fields
  tracing: Fix number printing bug in print_synth_event()

 kernel/trace/synth_event_gen_test.c |  34 ++++++------
 kernel/trace/trace_events_hist.c    | 108 +++++++++++++++++++++++++++++++++---
 2 files changed, 116 insertions(+), 26 deletions(-)

-- 
2.14.1

