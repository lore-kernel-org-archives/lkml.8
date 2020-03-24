Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A531EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E84920870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9qoBkIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgCXNXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:23:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27848 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727314AbgCXNXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585056188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bj+syWUGD4r3R0D86dj8Q/vshU5KZeEnX6hBzRWSMqU=;
        b=K9qoBkIGhfScewMr7UwdVb6BFgl5feuPV035X8iOcJaYDWl2TMzQwTGgQ8rtenuVYJHYlV
        6Pw8A9P0P4DTaTSr5WQbSbKwBEUWxeSjtWFAfSo2LDSYsYftviJSsTqOoFm5p3IHs5EZbA
        EeXjsfuX1EsEi5wlXZuAcP56kamFip4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-zZjfUdNlMW6kbK16N0mU5A-1; Tue, 24 Mar 2020 09:23:06 -0400
X-MC-Unique: zZjfUdNlMW6kbK16N0mU5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 415BE800D54;
        Tue, 24 Mar 2020 13:23:05 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0B7560BEE;
        Tue, 24 Mar 2020 13:23:01 +0000 (UTC)
Date:   Tue, 24 Mar 2020 14:22:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH] perf dso: Fix dso comparison
Message-ID: <20200324132258.GX1534489@krava>
References: <20200324042424.68366-1-ravi.bangoria@linux.ibm.com>
 <20200324104843.GS1534489@krava>
 <3cf2bd1b-e1c2-f82f-a06a-ce0d5e4b5eac@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cf2bd1b-e1c2-f82f-a06a-ce0d5e4b5eac@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 06:07:23PM +0530, Ravi Bangoria wrote:

SNIP

> > looks good, do we need to add the dso_id check to sort__dso_cmp?
> 
> I guess with different filename there is no need to compare dso_id.
> But for same filename, adding dso_id cmp will separate out the
> samples:
> 
> Ex, Without dso_id compare:
> 
>   $ ./perf report -s dso,dso_size -v
>     66.63%  /home/ravi/a.out                                  4096
>     33.36%  /home/ravi/Workspace/linux/tools/perf/a.out       4096
> 
>   $ ./perf report -s dso,dso_size
>     99.99%  a.out                 4096
> 
> 
> With below diff:
> 
>   -       return strcmp(dso_name_l, dso_name_r);
>   +       ret = strcmp(dso_name_l, dso_name_r);
>   +       if (ret)
>   +               return ret;
>   +       else
>   +               return dso__cmp_id(dso_l, dso_r);
> 
> 
>   $ ./perf report -s dso,dso_size
>     99.99%  a.out                 4096
>     33.36%  a.out                 4096
> 
> though, the o/p also depends which other sort keys are used along
> with dso key. Do you think this change makes sense?

the above behaviour is something I'd expect from 'dso'
sort key to do - separate out different dsos, even with
the same name

jirka

