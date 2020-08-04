Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EFCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D4C3207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596544335;
	bh=YvH24xqG+X8oWyJDw4omp3Ithof1ttgkXwFEqVqLjas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kKJagUcnVV7Sq53+myPmsP/1RvjAibvrl4ZSLGAnEkXKm93HtWpnSQI3eGMf+xxZo
	 mMRqMpSTkURBQ03SFH3gTkKyxFoqhgt0s7dTu1OhRLMgzIGEYktlL/w/r5w5V3TLMz
	 KSucANQnPCTYErvrfkX1G1q13y1fGXFLkBej3MSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgHDMbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbgHDMaT (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:30:19 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.178.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBE32075F;
        Tue,  4 Aug 2020 12:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596542780;
        bh=YvH24xqG+X8oWyJDw4omp3Ithof1ttgkXwFEqVqLjas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fe0ubSaYTE997FdGrNtQBcytCSRwgZXdGTXJP5fbzCxxfnlzIAPIg27MP+vbKcIHC
         WWkSVtNhRySKMzZQOj4ENcXgH0RPd7uqhjoV1EMen//oyPv8qLe8OkFz2IFi6cuu73
         CZpYBeP+vOpsNvr3meBC9oEseYRDaXYeQqP+6sow=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E5B6C40C7C; Tue,  4 Aug 2020 09:06:16 -0300 (-03)
Date:   Tue, 4 Aug 2020 09:06:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        irogers@google.com
Subject: Re: [PATCH v2] perf evsel: Don't set
 sample_regs_intr/sample_regs_user for dummy event
Message-ID: <20200804120616.GD3440834@kernel.org>
References: <20200720010013.18238-1-yao.jin@linux.intel.com>
 <20200720091748.GH760733@krava>
 <af1da971-5c60-4c17-e5d9-01430c928592@linux.intel.com>
 <20200722110810.GD981884@krava>
 <6f732f7f-7c5a-726f-5b09-2c6761f3b534@linux.intel.com>
 <dc2c18fa-85d3-84b7-8eff-53c9d1e61ce5@linux.intel.com>
 <32664190-9a2b-6ce6-3cbc-87b46c85d21e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32664190-9a2b-6ce6-3cbc-87b46c85d21e@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 04, 2020 at 10:06:56AM +0300, Adrian Hunter escreveu:
> On 29/07/20 10:23 am, Jin, Yao wrote:
> > Hi Adrian,
> > 
> > Could you help to check if following condition will break PT?
> > 
> > "(opts->sample_intr_regs && !evsel->no_aux_samples &&
> > !evsel__is_dummy_event(evsel))"
> 
> Sorry for slow response - I've been away.
> 
> This is fine.  It will not break PT.
> 
> no_aux_samples is useful for evsels that have been added by the code rather
> than requested by the user.  For old kernels PT adds sched_switch tracepoint
> to track context switches (before the current context switch event was
> added) and having auxiliary sample information unnecessarily uses up space
> in the perf buffer.
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks for checking and providing the comment, that I added as a
committer note together with your Acked-by, appreciated.

- Arnaldo
