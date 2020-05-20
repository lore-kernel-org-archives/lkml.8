Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA088C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90398207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCckvJsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgETKzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:55:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49537 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726452AbgETKzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589972141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VPP6imn8dIHXtl9aUo/2wzhJL2b1S+AcxW918UD68uM=;
        b=eCckvJsDvM7cecqKAGKjLx210VM4au5fgzkr2B8n8yKc9JO/ad0snup0louOBBpSGXhTx3
        MT/IpuiH7PJBqgRU4ehsfqcqp6xCywg6HYcpiM2uCD8FcjiVenlB5xkkuCmDOA5X1xfFf/
        mNQr32pf1SrqoQfMBq5fyUAi/9/i6Iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-ITGw2Y86NyyS_-8LH46qdA-1; Wed, 20 May 2020 06:55:38 -0400
X-MC-Unique: ITGw2Y86NyyS_-8LH46qdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EB191005512;
        Wed, 20 May 2020 10:55:36 +0000 (UTC)
Received: from krava (unknown [10.40.193.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id B26CB61547;
        Wed, 20 May 2020 10:55:34 +0000 (UTC)
Date:   Wed, 20 May 2020 12:55:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] perf: support enable and disable commands in stat
 and record modes
Message-ID: <20200520105533.GC157452@krava>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
 <f7ef424f-da30-4bf4-3ffd-c1704ed06df0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7ef424f-da30-4bf4-3ffd-c1704ed06df0@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 11:08:43AM +0300, Alexey Budankov wrote:
> Hi,
> 
> Is there anything else that could be done from my side to move this forward?

sorry I did not get to this yet.. will check

jirka

