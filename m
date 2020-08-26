Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93CDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 900292078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XV3htLBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgHZP63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:58:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46396 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726967AbgHZP5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598457463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ybwY4Uq7LlkHfwrDNDqmZvQFiTLb0VQK1kS+vs9BLdU=;
        b=XV3htLBOoGoQf8ooCgsUXsDVfmSE7rzgYyQk1Orwytic4MTTsNZ/V2vyOog7I1RcNEc4UX
        KhjkBZHmaVoa9gbuTKp9ySgWiLuaAumkVyJWG7DsdhmXgkyrVrvbR9Pzf9lEnPI63Iyx1t
        TMRd15gMKPFByBa31NWfolkPObKrpas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-gojH5KqRMA2eZlQl697v6w-1; Wed, 26 Aug 2020 11:57:39 -0400
X-MC-Unique: gojH5KqRMA2eZlQl697v6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D6AD1DE15;
        Wed, 26 Aug 2020 15:57:37 +0000 (UTC)
Received: from krava (unknown [10.40.192.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 479B219C58;
        Wed, 26 Aug 2020 15:57:34 +0000 (UTC)
Date:   Wed, 26 Aug 2020 17:57:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf expr: Force encapsulation on expr_id_data
Message-ID: <20200826155733.GB783610@krava>
References: <20200826153055.2067780-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826153055.2067780-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 08:30:55AM -0700, Ian Rogers wrote:
> This patch resolves some undefined behavior where variables in
> expr_id_data were accessed (for debugging) without being defined. To
> better enforce the tagged union behavior, the struct is moved into
> expr.c and accessors provided. Tag values (kinds) are explicitly
> identified.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

great, thanks for doing this

Acked-by: Jiri Olsa <jolsa@redhat.com>

jirka

