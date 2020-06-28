Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C360EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 21:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE1C206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 21:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRnhdeR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgF1VZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 17:25:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43999 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726080AbgF1VZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 17:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593379499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BPeaP/rBP+/gml896G+0M0duTqbKlN+mB8JvlB6tEuM=;
        b=gRnhdeR8M9YLjzbbNkb1EuXm8tRulj2UzNmaMaig7WltFpVnte9NVjcdfjGUC7T3X904iX
        IszKbv3sBvkM8sZm9S6l/NUL4o8YqwIbfCSv0I/3PuopvMhzSe4NL5F/BaKD9dheAVEyzE
        t4zbgZlMnz5csmRQ3vOxlNbpo9nBb3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-NKfc7Kf1N9KEXDgoCxPwnw-1; Sun, 28 Jun 2020 17:24:55 -0400
X-MC-Unique: NKfc7Kf1N9KEXDgoCxPwnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F00E107ACCA;
        Sun, 28 Jun 2020 21:24:53 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 68E8B5D9CD;
        Sun, 28 Jun 2020 21:24:49 +0000 (UTC)
Date:   Sun, 28 Jun 2020 23:24:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 02/10] perf tools: Add struct expr_parse_data to keep
 expr value
Message-ID: <20200628212448.GI2988321@krava>
References: <20200626194720.2915044-1-jolsa@kernel.org>
 <20200626194720.2915044-3-jolsa@kernel.org>
 <CAP-5=fVdSmPEYMqGqCEwZXfj=-wg6sJLQ=kuPTLaPdKiAiqTvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVdSmPEYMqGqCEwZXfj=-wg6sJLQ=kuPTLaPdKiAiqTvg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 01:04:41PM -0700, Ian Rogers wrote:
> On Fri, Jun 26, 2020 at 12:47 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding struct expr_parse_data to keep expr value
> > instead of just simple double pointer, so we can
> > store more data for ID in following changes.
> 
> Nit, expr_parse_data sounds a bit like data that is created just at
> parse time. Perhaps id_data, for data associated with an id?

we should keep the expr prefix, expr_id_data ?

jirka

