Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA6EC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DB720781
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJucyTOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgCWLN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:13:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44917 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727987AbgCWLNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 07:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584962005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NCmXawmYuf5VWEh8lGzw2WgL+h/ea8QCTg2+xsH1QMU=;
        b=NJucyTOLQkDMlBIUuFYJafCva2H2arhPRzXlmYp1YtP67SEkxOMPYGlzRiuzZE365K0Oex
        xXYJMgCIUNCWQ44Pj2xv1vevdaiXCuUFCRYMPGoLjL9SGZFd1gSiVmSR/qy4gVP/fRlErm
        81bI1JTVEVh0Wto5PoQ9tYjEi6Ib04U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-P5ngEpTwNESZv-Js55MK4A-1; Mon, 23 Mar 2020 07:13:21 -0400
X-MC-Unique: P5ngEpTwNESZv-Js55MK4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67443477;
        Mon, 23 Mar 2020 11:13:18 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE6F788859;
        Mon, 23 Mar 2020 11:13:13 +0000 (UTC)
Date:   Mon, 23 Mar 2020 12:13:11 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V4 00/17] Stitch LBR call stack (Perf Tools)
Message-ID: <20200323111311.GH1534489@krava>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319202517.23423-1-kan.liang@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 01:25:00PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Changes since V3:
> - There is no dependency among the 'capabilities'. If perf fails to read
>   one, it should not impact others. Continue to parse the rest of caps.
>   (Patch 1)
> - Use list_for_each_entry() to replace perf_pmu__scan_caps() (Patch 1 &
>   2)
> - Combine the declaration plus assignment when possible (Patch 1 & 2)
> - Add check for script/report/c2c.. (Patch 13, 14 & 16)

it's all black magic to me, but looks ok ;-)

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

