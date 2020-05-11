Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CDDC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9458E20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589223661;
	bh=PvdKEGsipmrx4D03jNv7tvPaZh5l7RzD7G9RdrqGFFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=goabvIzN3oNAu1Wr9WN8P9lDaWxb/Ssbr0CViyblSu5kph0ANPly1wk/R7GqIRAZn
	 Fk2yypCC3pIl1lQtPAp0bWmv4aQe3OP00iaEoSUkUGBDe++edPf7/dDJuZQVRiLLJz
	 AjRkJFLUZfVOJLhHxHc2o+bW5P7EAz6HqlmueclY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbgEKTBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731341AbgEKTA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:00:56 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E09820752;
        Mon, 11 May 2020 19:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589223656;
        bh=PvdKEGsipmrx4D03jNv7tvPaZh5l7RzD7G9RdrqGFFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/pfmXIBUwhfb+Os5O+v1+GVZBDK+ZTs5awbIB1Je4Pn5W3GySpKkQWVSu6Bm+nFY
         Smsu46qlmqDnAqSr80ieYs8M7t+jqX4sK0qlKByV1b3RQT56X1R2aN0sMwY9vGkeIM
         1ZdsPUao9aNgwugA9DR1GfUTy/KndmZEvK58rKBc=
Date:   Mon, 11 May 2020 14:05:28 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Arnaldo Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: Replace zero-length array with
 flexible-array
Message-ID: <20200511190528.GA15810@embeddedor>
References: <20200507190615.GA15677@embeddedor>
 <20200511154812.GD5377@kernel.org>
 <20200511172620.GA14618@embeddedor>
 <AA4613D1-106B-4B4D-9470-EBEA2A527DC7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AA4613D1-106B-4B4D-9470-EBEA2A527DC7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 03:48:55PM -0300, Arnaldo Melo wrote:
> >> 
> >> Can you split this into a kernel part and tools/ one? Also this is
> >not
> >> really just for "perf script", so please adjust the subject line too
> >:-)
> >> 
> >
> >Sure thing. :)
> >
> >Is that OK if I use "perf: " for the tools part and "perf/x86: " for
> >the
> >kernel part?
> 
> perf tools: Summary
> 
> Since it touches multiple perf tools, 
> 
> perf script: If it was only about 'perf script'

OK. I've got it.

Thanks
--
Gustavo
