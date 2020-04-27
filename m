Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A83C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C592072D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMm43IJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgD0KLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:11:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32384 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726604AbgD0KLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587982262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=deJ4dz4CI5dBbedD6ppxfhZ8U/79EaOLVYZMqbXKy44=;
        b=iMm43IJpffWtTDDWgJaAxj4ATOcU/X8eU0O3VGxfgPra2U5US0svwhcoP/uDcuPr3ubFB3
        szIB7HUx4mas1T2I2gXrNL/rRZWpeZF33zcp416PR/HJ2yjqKXmh3nVzMVldMndl7lXMgu
        z1U97MT29PJWRRhOxtJe487WK6OCcLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-P4mbV9mqMQ-77aphNv1kwA-1; Mon, 27 Apr 2020 06:10:59 -0400
X-MC-Unique: P4mbV9mqMQ-77aphNv1kwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7357A107ACCA;
        Mon, 27 Apr 2020 10:10:57 +0000 (UTC)
Received: from krava (unknown [10.40.195.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50C0410013A1;
        Mon, 27 Apr 2020 10:10:55 +0000 (UTC)
Date:   Mon, 27 Apr 2020 12:10:52 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 2/7] perf util: Create streams for managing top N
 hottest callchains
Message-ID: <20200427101052.GB1457790@krava>
References: <20200420010451.24405-1-yao.jin@linux.intel.com>
 <20200420010451.24405-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420010451.24405-3-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 09:04:46AM +0800, Jin Yao wrote:
> We think the stream is a callchain which is aggregated by the LBR
> records from samples. By browsing the stream, we can understand
> the code flow.
> 
> The struct callchain_node represents one callchain and we use the
> callchain_node->hit to measure the hot level of this callchain.
> Higher is hotter.
> 
> Since in perf data file, there may be many callchains so we just
> need to focus on the top N hottest callchains. N is a user defined
> parameter or just a predefined default value.
> 
> This patch saves the top N hottest callchains in 'struct stream_node'
> type array, which is defined in a per event 'struct callchain_streams'.
> 
> So now we can get the per-event top N hottest callchains.
> 
>  v2:
>  ---
>  Use zfree in free_evsel_streams().
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/callchain.c | 122 ++++++++++++++++++++++++++++++++++++
>  tools/perf/util/callchain.h |  16 +++++
>  2 files changed, 138 insertions(+)

SNIP

could this and all the other related code moved to separated object
like streams.c or such.. I think also the stuff from patch 1 could
go there, as it's specific only to this streams code

jirka

