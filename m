Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBADFC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B157E2070A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ej3J+NgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgCFJeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:34:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56154 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725855AbgCFJeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583487249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hp5MekiXUMJxVDsg9Aoj/GVY7QOvjRmpbHO4tIEQiUo=;
        b=Ej3J+NgEq2G05IVFWi0lkO/v/4E7SfEKeJSEXAa4EGiieRztgiNYLS98N73/i5DLW8+Ybl
        ss9yKMxWo0Kjk7Dx6C+HEgYzH4Nt2RidjcrgGwzwf5L9cJfMKLGoXoray5EmsOMowCWliv
        xCPXA1+rz5k1+sU56Wtm75sifStj9PY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-V2Ql0F42P_S3LfciviOz7w-1; Fri, 06 Mar 2020 04:34:05 -0500
X-MC-Unique: V2Ql0F42P_S3LfciviOz7w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E81F38017CC;
        Fri,  6 Mar 2020 09:34:02 +0000 (UTC)
Received: from krava (ovpn-205-205.brq.redhat.com [10.40.205.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78C8B60BF1;
        Fri,  6 Mar 2020 09:33:58 +0000 (UTC)
Date:   Fri, 6 Mar 2020 10:33:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Li <liwei391@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/3] tools: fix off-by 1 relative directory includes
Message-ID: <20200306093355.GB281906@krava>
References: <20200306071110.130202-1-irogers@google.com>
 <20200306071110.130202-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306071110.130202-2-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 11:11:08PM -0800, Ian Rogers wrote:
> This is currently working due to extra include paths in the build.

if you're fixing this, why not remove that extra include path then?

jirka

