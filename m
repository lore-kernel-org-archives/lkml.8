Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7C9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BB7206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUy8bnrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388800AbgDBNlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:41:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33178 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388789AbgDBNlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585834894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/oVw4N3RX7AqqhXoCKDenOkATBkVL6kEbt2OGEusJko=;
        b=FUy8bnrAze+6DpodtJ6wJzVkHmo6cgxDIF5QdjI2QSaNka72RE45ctcoLoSRodz23FN8KO
        ITwCp+6dhKpMn+Ow3FsmgsZKbs/1l0eqSF4syvl6PR7DSIiGkzI+fjiRNiZmr5aYqs7O56
        gOZPWPOgf85m0dnR5RtBnTN4Y9W47fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-pXfLwjvLOSO3mAhB4cy9rQ-1; Thu, 02 Apr 2020 09:41:30 -0400
X-MC-Unique: pXfLwjvLOSO3mAhB4cy9rQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E499801E78;
        Thu,  2 Apr 2020 13:41:28 +0000 (UTC)
Received: from krava (unknown [10.40.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86260A63CF;
        Thu,  2 Apr 2020 13:41:20 +0000 (UTC)
Date:   Thu, 2 Apr 2020 15:41:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/5] perf bench: add event synthesis benchmark
Message-ID: <20200402134117.GK2518490@krava>
References: <20200401233945.133550-1-irogers@google.com>
 <20200401233945.133550-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401233945.133550-2-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:39:41PM -0700, Ian Rogers wrote:
> Event synthesis may occur at the start or end (tail) of a perf command.
> In system-wide mode it can scan every process in /proc, which may add
> seconds of latency before event recording. Add a new benchmark that
> times how long event synthesis takes with and without data synthesis.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

awesome, please put the command line example in changelog

jirka

