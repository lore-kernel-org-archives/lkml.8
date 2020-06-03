Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCE1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5530020678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="W+i4FzBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgFCMCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:02:55 -0400
Received: from mail.efficios.com ([167.114.26.124]:40482 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgFCMCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:02:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 880F02BB2C4;
        Wed,  3 Jun 2020 08:02:30 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id r4H48SY884UJ; Wed,  3 Jun 2020 08:02:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1E87D2BAFE5;
        Wed,  3 Jun 2020 08:02:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1E87D2BAFE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1591185750;
        bh=+JKPy8/uTulfEKGfTa48iFeivNq9W046I9r49e09eUQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=W+i4FzBG6FaeGRj1qjA0mh/fgtIJIpBs6kM5tDLuyGZPPXFlg+4269AvVYw0paMuH
         NwgGZZ3nKkpFdflm/6SC9W43bFhORw8B1BeIV7rxr9lU748kTBoNN7lCNQd2ZNldAU
         PEIeX/4zBWwQJ0voSluU+anjpCdt5mLeTANE/pLhpRR8kjR6MlqysUFLM9wAdWdYcC
         0kAnfkEVrXLCZ5NzcRahk9a+eoXXGbx+6YhP6pn/vn9EBXOUdl1iiOE5t2qzSWtf1v
         6kSeW27DZMe7LpfaoAtDtw+bJOZVHUcWIyAE/0BCUbRyg9D9YMuycT9TdUKu2wWVP/
         keTgvqWaC6f+A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4_rRzo5zUasU; Wed,  3 Jun 2020 08:02:30 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 0E7732BADF5;
        Wed,  3 Jun 2020 08:02:30 -0400 (EDT)
Date:   Wed, 3 Jun 2020 08:02:29 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev@lists.lttng.org,
        diamon-discuss@lists.linuxfoundation.org,
        linux-trace-users@vger.kernel.org, lwn@lwn.net,
        linux-kernel@vger.kernel.org
Message-ID: <683437825.51033.1591185749972.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.12.1 and 2.11.4 (Linux kernel tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Index: z3mfQAh1bM5mt5rP3eYWZhqbj4/DQA==
Thread-Topic: LTTng-modules 2.12.1 and 2.11.4 (Linux kernel tracer)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a release announcement of the LTTng kernel tracer for both
maintained LTTng stable branches. The main change integrated within
the new versions 2.12.1 and 2.11.4 is support for the newly released
5.7 Linux kernel.

If you followed the news lately [1], you will notice that LTTng had to
work-around a change which un-exports kallsyms symbols, making those
inaccessible to GPL modules, which was integrated within Linux 5.7. As a
matter of fact, LTTng happens to use kallsyms in some cases to access
symbols otherwise not visible to GPL kernel modules.

Just to underline the amount of effort that was put into trying to do
the right thing, here is an explanation of the alternative approaches
that were attempted before going for a work-around using kprobes
(taken from commit message of lttng-modules
commit a65765406b0 "Unbreak LTTng for kernel 5.7"):

    Linux commit 0bd476e6c67190b5eb7b6e105c8db8ff61103281 ("kallsyms:
    unexport kallsyms_lookup_name() and kallsyms_on_each_symbol()") breaks
    LTTng-modules by removing symbols used by the LTTng-modules out-of-tree
    tracer.
    
    I pointed this out when the change was originally considered before the
    5.7 merge window. This generated some discussion but it did not lead to
    any concrete proposal to fix the issue. [2]
    
    The commit has been merged in the 5.7 merge window. At that point, as
    maintainer of LTTng, I immediately raised a flag about this issue,
    proposing an alternative approach to solve this: expose the few symbols
    needed by LTTng to GPL modules. This was NACKed on the ground that the
    Linux kernel cannot export GPL symbols when there are no in-tree
    users. [3]
    
    Steven Rostedt has shown interest in merging LTTng-modules upstream.
    LTTng-modules being LGPL, this is very much doable. I have prepared a
    tree of LTTng-modules "for upstreaming" and sent it to him privately so
    he can review it. Even if in an ideal scenario LTTng-modules is merged
    for the following merge window, it leaves LTTng-modules broken on the
    5.7 kernel.
    
    In order to ensure that the LTTng-modules kernel tracer continues working
    for my end users on kernels 5.7 onwards, as a very last resort, this is
    with great reluctance that I created this fix for LTTng modules. It
    basically uses kprobes to lookup the kallsyms_lookup_name symbol, and
    continues using kallsyms_lookup_name as before.

Steven Rostedt has started looking into lttng-modules, but currently lacks time
to look into it further. Understandably, this 15 years old project is larger than
he initially expected. Let's hope we receive concrete feedback on how we can
improve LTTng to make it acceptable for integration into Linux.

Thanks,

Mathieu

[1] https://lwn.net/Articles/817988/
[2] https://lore.kernel.org/r/20200302192811.n6o5645rsib44vco@localhost
[3] https://lore.kernel.org/r/20200409193543.18115-1-mathieu.desnoyers@efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
