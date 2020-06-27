Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D55CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 12:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E526220CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 12:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593262461;
	bh=9MZ6ywmhGJVbDll82Z9YO9SH6QgiDqbnm5pUay+L81g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dEFQhBpJ//HP0THjk69muUVtjr9wg++9s6cShOVuNLKCgpySZMn/ZGKxGk4+u8Rwz
	 HUxTCQtMNsqc9w7bgYBsEjDG13uRI4iGk0bFh/n666rv9pqjNAblU4X1FeYbZALFLT
	 4roFaXJR261VKZwbLTl+hSwJIikKLV1whYt2Vj94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgF0MsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 08:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbgF0MsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 08:48:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEBE221548;
        Sat, 27 Jun 2020 12:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593262104;
        bh=9MZ6ywmhGJVbDll82Z9YO9SH6QgiDqbnm5pUay+L81g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y9ra0v0rKPF6HdNG3XTPsTxSQT3XTD99XqrD+1184izI4IO23xUNBYjcKd4s8QY26
         JzH0J8x2Cxaf10PNhb3nYlvrZsJha6psiw25ACrjZOevomANxYvJbPq0xWR10ttjTR
         pbDf1D2FgMtJChHRHVWJ6RhkyNbRiCpehTKwrfMo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 95F30405FF; Sat, 27 Jun 2020 09:48:21 -0300 (-03)
Date:   Sat, 27 Jun 2020 09:48:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC 00/10] perf tools: Add support to reuse metric
Message-ID: <20200627124821.GF29008@kernel.org>
References: <20200626194720.2915044-1-jolsa@kernel.org>
 <20200626212522.GF818054@tassilo.jf.intel.com>
 <CAP-5=fVMs4Ok3=gYmzheNTzbBUGGHbCr0cpJSm9TV45aeZb4Ng@mail.gmail.com>
 <20200626215759.GG818054@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626215759.GG818054@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 26, 2020 at 02:57:59PM -0700, Andi Kleen escreveu:
> > The name could be a metric or an event, the logic for each is quite
> 
> I would say collisions are unlikely. Event names follow quite structured
> patterns.

And when introducing a new metric the build process can detect that
clash and fail.
 
> > different. You could look up an event and when it fails assume it was
> > a metric, but I like the simplicity of this approach.
 
> I don't think it's simpler for the user.

Agreed.
 
> > Maybe this
> > change could be adopted more widely with something like "perf stat -e
> > metric:IPC -a -I 1000" rather than the current "perf stat -M IPC -a -I
> > 1000".
> 
> I thought about just adding metrics to -e, without metric: of course.

Ditto.

- Arnaldo
