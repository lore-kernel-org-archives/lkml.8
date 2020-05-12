Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C40CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 930C7206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589306360;
	bh=Ys+c/TZTFYiflkI9BNZoLJ+mGuTPDRwFqy/J0V+hdow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y4jF3sP1PZdwSTY/M2gWpFW4e/AnTo8ENTzHdofo9mWU5O3J1ggty7Bp6y+8r+XcC
	 ap4L/pRAuma0/hg+9Sra+7PVL5U5FIZXPT7jAo6xWnhVsUg3dmn10UsPLg/90H0iMW
	 SLdBLxUE64fViBtrIWVr+48muryHXHKIf9kMhx50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgELR7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgELR7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:59:19 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2882620673;
        Tue, 12 May 2020 17:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589306359;
        bh=Ys+c/TZTFYiflkI9BNZoLJ+mGuTPDRwFqy/J0V+hdow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSXRV6j2IjX8e4EycPtClnLMsd3L9LvB13U2I2XmTnxDYlQWOxvFz9cESePLlpXA7
         sznTg5A+1k3HGfelk9n/p0vM2iTd+vzi7gBK4pcYT6gQ8lpIE/zM4CyWL+ml2dLTYY
         t3DUUndYJzAkClSgGPkwBnW/CSl6rsCxj+yuHbiM=
Date:   Tue, 12 May 2020 13:03:52 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Melo <arnaldo.melo@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] perf tools: Replace zero-length array with flexible-array
Message-ID: <20200512180352.GB4897@embeddedor>
References: <20200511195643.GA9850@embeddedor>
 <0C076F02-CEB7-4DBC-8337-CCEBC0870E44@gmail.com>
 <20200512000404.GA4897@embeddedor>
 <20200512080607.GD2978@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512080607.GD2978@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 10:06:07AM +0200, Peter Zijlstra wrote:
> On Mon, May 11, 2020 at 07:04:04PM -0500, Gustavo A. R. Silva wrote:
> > On Mon, May 11, 2020 at 05:20:08PM -0300, Arnaldo Melo wrote:
> > > 
> > > Thanks, applied
> > > 
> > 
> > Thanks, Arnaldo. 
> > 
> > I wonder if could also take the other two:
> > 
> > https://lore.kernel.org/lkml/20200511200911.GA13149@embeddedor/
> > https://lore.kernel.org/lkml/20200511201227.GA14041@embeddedor/
> 
> I think I have those, but let me make sure.

Great. :)

Thanks
--
Gustavo

