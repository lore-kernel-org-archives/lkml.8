Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74243C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C02920786
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592396154;
	bh=eTIu+JBzaERIp07e9iPTpVh8C+E7/qfsfgoKNKYyCHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YqkP40ttPzE6BAdLA5lbldQ4YVAFyZw4CQ4Ufuya/BSj57irauz0I6IXvr8dyA4XW
	 AP4Gj3vjOmSZrYvl+sevRl6pqdGeZadBu0XJbPYfUp8WpjnscoIpGH6A7j01rfSDEV
	 Y423rOzkkJd0ljtSs7chslywO2Ga+UQ9iOCnkGNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgFQMPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFQMPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:15:52 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F2DC20776;
        Wed, 17 Jun 2020 12:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592396152;
        bh=eTIu+JBzaERIp07e9iPTpVh8C+E7/qfsfgoKNKYyCHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmrSdN7kohpP+c8wmW42SrPXtgpP5FlrWeaE588MMOVzmNHrh+LhhIZZO8JdKX2Vs
         csyaTyJEYdBcti6Pe8FIMWm+fkJ8BLLY/b9qcoo7QA/Co2NLj0cW/jcqoOdbGNZU3V
         B0DEUd/QS07Tcu/ZcB/PJ7U98ECYK41In425fryM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0597F40AFD; Wed, 17 Jun 2020 09:15:50 -0300 (-03)
Date:   Wed, 17 Jun 2020 09:15:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] perf pmu: Improve CPU core PMU HW event list
 ordering
Message-ID: <20200617121549.GA31085@kernel.org>
References: <1592384514-119954-1-git-send-email-john.garry@huawei.com>
 <1592384514-119954-3-git-send-email-john.garry@huawei.com>
 <CAM9d7cgqJzQJ7GfL6Q3VgARd1=rrkRYqOqSivZww-LOo+DvKFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgqJzQJ7GfL6Q3VgARd1=rrkRYqOqSivZww-LOo+DvKFA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 17, 2020 at 08:31:02PM +0900, Namhyung Kim escreveu:
> On Wed, Jun 17, 2020 at 6:06 PM John Garry <john.garry@huawei.com> wrote:
> >
> > For perf list, the CPU core PMU HW event ordering is such that not all
> > events may will be listed adjacent - consider this example:
> >   cstate_pkg/c6-residency/                           [Kernel PMU event]
> >   cstate_pkg/c7-residency/                           [Kernel PMU event]
> >
> > Signed-off-by: John Garry <john.garry@huawei.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks a lot, applied.

- Arnaldo
