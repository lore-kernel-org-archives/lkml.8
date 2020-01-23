Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403D7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155F124673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgAWJTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:19:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:48096 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgAWJTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:19:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 01:19:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,353,1574150400"; 
   d="scan'208";a="245336174"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by orsmga002.jf.intel.com with ESMTP; 23 Jan 2020 01:19:44 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf/core: fix mlock accounting in perf_mmap()
In-Reply-To: <79CAEE07-57BC-4915-A812-DD99AAF1B809@fb.com>
References: <20200117234503.1324050-1-songliubraving@fb.com> <87blqybknz.fsf@ashishki-desk.ger.corp.intel.com> <79CAEE07-57BC-4915-A812-DD99AAF1B809@fb.com>
Date:   Thu, 23 Jan 2020 11:19:44 +0200
Message-ID: <875zh2bkcv.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Liu <songliubraving@fb.com> writes:

>> On Jan 20, 2020, at 12:24 AM, Alexander Shishkin <alexander.shishkin@linux.intel.com> wrote:
>> 
>> Song Liu <songliubraving@fb.com> writes:
>> 
>>> sysctl_perf_event_mlock and user->locked_vm can change value
>>> independently, so we can't guarantee:
>>> 
>>>    user->locked_vm <= user_lock_limit
>> 
>> This means: if the sysctl got sufficiently decreased, so that the
>> existing locked_vm exceeds it, we need to deal with the overflow, right?
>
> Reducing sysctl is one way to generate the overflow. Another way is to 
> call setrlimit() from user space to allow bigger user->locked_vm. 

You mean RLIMIT_MEMLOCK? That's a limit on mm->pinned_vm. Doesn't affect
user->locked_vm.

Regards,
--
Alex
