Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4650BC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5162075B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4sAGTVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgIJJfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:35:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22669 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730415AbgIJJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599729763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JUvl+gMRJ2x1MlkmkDui6t4jiJBgJl6I+v3v+hf5LTE=;
        b=B4sAGTVQpoMWk7G3lWEjql1hwV6ABW6nXmQz51c7dMnuvgkq61l2KgyCceg+/WB5qbzaQk
        qSoV9krpiYqD3+8eZvAyj4scOMVc12+KIoltO84aqz1WODwtZneRuVkidLEf2nLnICR6lN
        fYM4eJH1Mn8AnYLfefwU3QUcmAiRO1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-k681bV6KMhybXN0dZm8C2Q-1; Thu, 10 Sep 2020 05:22:42 -0400
X-MC-Unique: k681bV6KMhybXN0dZm8C2Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A529805EE3;
        Thu, 10 Sep 2020 09:22:40 +0000 (UTC)
Received: from krava (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 191DD3A40;
        Thu, 10 Sep 2020 09:22:37 +0000 (UTC)
Date:   Thu, 10 Sep 2020 11:22:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 0/7] perf: Stream comparison
Message-ID: <20200910092237.GE1627030@krava>
References: <20200907041606.14500-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907041606.14500-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 12:15:59PM +0800, Jin Yao wrote:

SNIP

>                       main div.c:39
> 
> [ Hot streams in new perf data only ]
> 
> hot chain 1:
>                                                      cycles: 4, hits: 4.54%
>                                                  --------------------------
>                                                               main div.c:42
>                                                       compute_flag div.c:28
> 
> hot chain 2:
>                                                      cycles: 5, hits: 3.51%
>                                                  --------------------------
>                                                               main div.c:39
>                                                               main div.c:44
>                                                               main div.c:42
>                                                       compute_flag div.c:28
> 
>  v5:
>  ---
>  1. Remove enum stream_type
>  2. Rebase to perf/core

hi,
which commit did you base on? I can't apply on current perf/core

thanks,
jirka

