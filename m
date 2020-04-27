Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E8C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E01F8206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZPK65Zw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgD0KK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:10:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23073 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726604AbgD0KK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587982254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m7ij3TpJb3uGCEgGWjSeLFAAO0ly9M3+SZFe0oGk1GE=;
        b=ZZPK65Zw206Vog+wyszJd/dgPN7Bm5XIb5YAZ4DfBOb0AfjPouv4W2GtniWvioxbWQ7Bxr
        B8Vrezw1XZ0TNMLLCUFVxTOvyzft6+PY118G/T2du07UbjxVDAGeT+5il7ds2ytRtoPR0J
        l58NjhMHQJtM83tH6XTRZJINlEEz4NM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-NcqFo0GGMkejqYJv1QwCAw-1; Mon, 27 Apr 2020 06:10:50 -0400
X-MC-Unique: NcqFo0GGMkejqYJv1QwCAw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D08A3107ACCA;
        Mon, 27 Apr 2020 10:10:48 +0000 (UTC)
Received: from krava (unknown [10.40.195.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B02EB5D9DA;
        Mon, 27 Apr 2020 10:10:46 +0000 (UTC)
Date:   Mon, 27 Apr 2020 12:10:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 0/7] perf: Stream comparison
Message-ID: <20200427101044.GA1457790@krava>
References: <20200420010451.24405-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420010451.24405-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 09:04:44AM +0800, Jin Yao wrote:

SNIP

>               compute_flag div.c:25                   compute_flag div.c:25
>               compute_flag div.c:22                   compute_flag div.c:22
>                       main div.c:40                           main div.c:40
>                       main div.c:40                           main div.c:40
>                       main div.c:39                           main div.c:39*
> 
> [ Hot chains in old perf data only ]
> 
> hot chain 1:
>              cycles: 2, hits: 4.08%
>          --------------------------
>                       main div.c:42
>               compute_flag div.c:28
> 
> [ Hot chains in new perf data only ]
> 
> hot chain 1:
>                                                     cycles: 36, hits: 3.36%
>                                                  --------------------------
>                                                   __random_r random_r.c:357
>                                                       __random random.c:293
>                                                       __random random.c:293
>                                                       __random random.c:291
>                                                       __random random.c:291
>                                                       __random random.c:291
>                                                       __random random.c:288
>                                                              rand rand.c:27
>                                                              rand rand.c:26
>                                                                    rand@plt
>                                                                    rand@plt
>                                                       compute_flag div.c:25
>                                                       compute_flag div.c:22
>                                                               main div.c:40
>                                                               main div.c:40
> 
> Now we can see, following streams pair is moved to another section
> "[ Hot chains in old perf data but source line changed (*) in new perf data ]"
> 
>             cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
>         ---------------------------              --------------------------
>                       main div.c:39                           main div.c:39*
>                       main div.c:44                           main div.c:44
> 


so I tried following:

  # ./perf record -e cycles:u -b ./perf bench sched pipe
  # ./perf record -e cycles:u -b ./perf bench sched pipe
  # ./perf diff -f --stream --before $PWD --after $PWD >out 2>&1

and the out file looks like this:

  [ Matched hot chains between old perf data and new perf data ]

  [ Hot chains in old perf data but source line changed (*) in new perf data ]

  [ Hot chains in old perf data only ]

  hot chain 1:
               cycles: 0, hits: 4.20%
           --------------------------
                   0xffffffff89c00163

  hot chain 2:
               cycles: 0, hits: 4.11%
           --------------------------
                   0xffffffff89c00163

  hot chain 3:
               cycles: 0, hits: 8.22%
           --------------------------
                   0xffffffff89c00163

  hot chain 4:
               cycles: 0, hits: 5.54%
           --------------------------
                   0xffffffff89c00163

  hot chain 5:
               cycles: 0, hits: 6.10%
           --------------------------
                   0xffffffff89c00163

  [ Hot chains in new perf data only ]

  hot chain 1:
                                                       cycles: 0, hits: 5.21%
                                                   --------------------------
                                                           0xffffffff89c00163

  hot chain 2:
                                                       cycles: 0, hits: 4.79%
                                                   --------------------------
                                                           0xffffffff89c00163

  hot chain 3:
                                                       cycles: 0, hits: 5.44%
                                                   --------------------------
                                                           0xffffffff89c00163

  hot chain 4:
                                                       cycles: 0, hits: 5.50%
                                                   --------------------------
                                                           0xffffffff89c00163

  hot chain 5:
                                                       cycles: 0, hits: 7.14%
                                                   --------------------------
                                                           0xffffffff89c00163


I'd expected more common paths, from what I can see from 'perf report --branch-history'
on bpth perf.data and perf.data.old

jirka

