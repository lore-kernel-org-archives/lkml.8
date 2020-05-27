Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D836C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D7A220873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jK+3u8gz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390679AbgE0PzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390663AbgE0PzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:55:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA7BC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8xrIhDlIclhuFcqK5PRfwDksN1V3DbW5RDvwy1wQ9Ew=; b=jK+3u8gz/vaf9KvIxc6RpzgF2X
        hrcfW+klGLluvqpKhL4qEC3V/HU7rUTDUsu0JhmM0nd1/zDrXL+KytM6+OXKDkPDXfk7mIR/aFHVW
        GRd5prqBgteWLGiwfjZecLusE3teAjo+VeJec5JYbGMtb/BIIWjepsH1K6fPVebpsXzinBRxuf/fG
        7wh3SeH6mUCpI/ZBVakDM8wd80LgJ5z7vSxdbi8gBvgHBxkXKNy9HM4WXiI1ffWCEmGTOOoYyp1ty
        5ME5sHg+ENhLsCx+TZ8dbmS9el1TDAhFektU5QKsSZh5GpHSJfQ5xOJKeI3mgMoWnwC1/fSQ4/kKe
        /eZJcgcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdyO6-00040I-Ry; Wed, 27 May 2020 15:54:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B80A307994;
        Wed, 27 May 2020 17:54:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 444522024369D; Wed, 27 May 2020 17:54:36 +0200 (CEST)
Date:   Wed, 27 May 2020 17:54:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 00/15] perf/x86: Add perf text poke events
Message-ID: <20200527155436.GA706460@hirez.programming.kicks-ass.net>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
 <bee04840-143c-18bb-df82-5aa58d70730e@intel.com>
 <20200520014001.GF28228@kernel.org>
 <20200520155634.GQ317569@hirez.programming.kicks-ass.net>
 <20200527154716.GC16490@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527154716.GC16490@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:47:16PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 20, 2020 at 05:56:34PM +0200, Peter Zijlstra escreveu:
> > On Tue, May 19, 2020 at 10:40:01PM -0300, Arnaldo Carvalho de Melo wrote:
> > > PeterZ, from what we discussed for the next merge Window, perhaps we
> > > should route the kernel bits via the tip tree while I will push the
> > > tooling bits on my 5.8 merge request to Linus, Ok?
> > 
> > Sure, I can take the kernel bits. Thanks!
> 
> So, I'm going thru the userpace bits and stopped at the patch copying
> include/uapi/linux/perf_events.h to
> tools/include/uapi/linux/perf_events.h to get the text_poke
> perf_event_attr bit, looked at tip/ and this hasn't landed there yet,
> any issues with the kernel bits?

Nah, I was waiting on the 0day robot, but its broken *again* :-(

Let me go move things along manually.
