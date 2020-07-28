Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CDFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAEB2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595939527;
	bh=fjX0ZGTdFRX+/DG7aQhenMEmYFR4EB/VF/BISCFoB1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZdcUlqHkzZ0Il2fcbg5WT81JL+QybpD7GrIfq7opHM8zkVfhVEzmjsKugsqP21LdQ
	 A//J9YsXaXnaQowFLIwjeDDCYofRn7oZjSVkdvo2eF1zIkIsFrP/Q9gbNU+m5gCYte
	 e/p86Nv/W51ujkrMfqJ4ssJz2ucT7IuPAajWWG/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgG1McF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729500AbgG1McE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:32:04 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E49AD206D4;
        Tue, 28 Jul 2020 12:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595939524;
        bh=fjX0ZGTdFRX+/DG7aQhenMEmYFR4EB/VF/BISCFoB1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZhKiCR8hNZzzxOY9MGkscFcfHp8VLCtLnbIHV+hLuhEwOsESnjo0jS+gdkmV0L0xK
         817IqRcwGzVmgrGRhKm7f8nIenJvip22y2WYHAyBNJNy3NUde36otGvcgUVW4InqDA
         Gk/SucGemCYm61U0cXZNz6cSkBFxzH+75QrD4mYM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BDC5D404B1; Tue, 28 Jul 2020 09:32:01 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:32:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 09/19] perf metric: Collect referenced metrics in struct
 metric_expr
Message-ID: <20200728123201.GP40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-10-jolsa@kernel.org>
 <92070405-8993-decb-46e3-04189dddb1b6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92070405-8993-decb-46e3-04189dddb1b6@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 26, 2020 at 02:48:35PM +0530, kajoljain escreveu:
> 
> 
> On 7/19/20 11:43 PM, Jiri Olsa wrote:
> > Add referenced metrics into struct metric_expr object,
> > so they are accessible when computing the metric.
> > 
> > Storing just name and expression itself, so the metric
> > can be resolved and computed.
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Reviewed-By : Kajol Jain<kjain@linux.ibm.com>

Thanks, applied.

- Arnaldo
