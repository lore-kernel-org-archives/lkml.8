Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A36C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C0A5207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596020930;
	bh=qpkQt7O/lilrkZLtnzRagKgCqMR1TKJtQco0k6DLtFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y2Hi7EWLCzOpf2xTns+i5jkrp9ICPf4GrdSvW2qGVU/P8JQgFq2re5yWjaKtqx6M2
	 Hu415tqSOYQtik3qrdoHEYC1Q1wt5Ure5gCEmm9GRoRDiO0Pu1oRbplyCUPJj+acDr
	 p/cwwM1zdUJRAtZkttCQc90f7rgLzk+3LeK7C+7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgG2LIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2LIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 07:08:48 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AAC52076E;
        Wed, 29 Jul 2020 11:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596020928;
        bh=qpkQt7O/lilrkZLtnzRagKgCqMR1TKJtQco0k6DLtFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8v4q+0rPBk2KtJkmPvkucvAwFhwKI6U6+QJ/XJZnXsTvqkU0EeZscCk3795AW4DJ
         XCX7hgxtyGuzEhNsoSUh2/cUZzs4rGbqG5zdG1tXUmKou3scMxcfUH0Tnpt0kPxNMe
         tIlkRIdfFHK+ZBsQSw14S0iKEi12uhO38KKUvlHM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6C97940E57; Wed, 29 Jul 2020 08:08:45 -0300 (-03)
Date:   Wed, 29 Jul 2020 08:08:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
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
Subject: Re: [PATCH 16/19] perf metric: Make compute_single function more
 precise
Message-ID: <20200729110845.GD40195@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200719181320.785305-17-jolsa@kernel.org>
 <20200728123629.GW40195@kernel.org>
 <CAP-5=fWAC4DkKiPzKvAiVpMDFWvf3HPZ5=tiSUbJ50w+kjXhfg@mail.gmail.com>
 <8fbc4b4f-1886-0ab6-ee83-cdb0f2caefc9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fbc4b4f-1886-0ab6-ee83-cdb0f2caefc9@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 29, 2020 at 01:47:01AM +0530, kajoljain escreveu:
> 
> 
> On 7/28/20 10:56 PM, Ian Rogers wrote:
> > On Tue, Jul 28, 2020 at 5:36 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> >>
> >> Em Sun, Jul 19, 2020 at 08:13:17PM +0200, Jiri Olsa escreveu:
> >>> So far compute_single function relies on the fact, that
> >>> there's only single metric defined within evlist in all
> >>> tests. In following patch we will add test for metric
> >>> group, so we need to be able to compute metric by given
> >>> name.
> >>>
> >>> Adding the name argument to compute_single and iterating
> >>> evlist and evsel's expression to find the given metric.
> >>
> >> Applied, thanks.
> >>
> >> Ian, Kajol, I didn't notice your Acked-by or Reviewed-by, like for the
> >> other patches, can you check?
> > 
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> 
> Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Thanks, updated the patch with both tags,

- Arnaldo
