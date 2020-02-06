Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B43C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3458C20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1ti8rvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBFTEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:04:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33545 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727698AbgBFTEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581015871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eqPIoVcEMGbnA2FeJ8SA7ZoTHkVUXEq8MW9ue55rthI=;
        b=E1ti8rvMIKwLh1TP1Jozb8++5bG1oUudhf7atbiKhVQTYDfbCWqstt8+S0IxWIAaoGEB9a
        ewLIdoYkHVj9xxKA+myFEfZSUQIQ/Eb24Xr7oKI7hOJaMmlW+RskvfvEtw2QVGoUoM5N0/
        3UAWi3d/2I8w8TdQ/JkBpx5NINJvr/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-_Rt8vjb3O06xq2lcfFv-7g-1; Thu, 06 Feb 2020 14:04:21 -0500
X-MC-Unique: _Rt8vjb3O06xq2lcfFv-7g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D16CF1835A14;
        Thu,  6 Feb 2020 19:04:19 +0000 (UTC)
Received: from krava (ovpn-204-87.brq.redhat.com [10.40.204.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA236863AB;
        Thu,  6 Feb 2020 19:04:17 +0000 (UTC)
Date:   Thu, 6 Feb 2020 20:04:12 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] perf annotate: Misc fixes / improvements
Message-ID: <20200206190412.GD1669706@krava>
References: <20200204045233.474937-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204045233.474937-1-ravi.bangoria@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 10:22:27AM +0530, Ravi Bangoria wrote:
> Few fixes / improvements related to perf annotate.
> 
> v2: https://lore.kernel.org/r/20200124080432.8065-1-ravi.bangoria@linux.ibm.com
> 
> v2->v3:
>  - [PATCH v3 2/6] New function annotation_line__exit() to clear
>    annotation_line objects.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> v1: http://lore.kernel.org/r/20200117092612.30874-1-ravi.bangoria@linux.ibm.com
> 
> v1->v2:
>  - Split [PATCH v1 1/3] into two patches.
>  - Patch 5 and patch 6 are new.
> 
> Ravi Bangoria (6):
>   perf annotate: Remove privsize from symbol__annotate() args
>   perf annotate: Simplify disasm_line allocation and freeing code
>   perf annotate: Align struct annotate_args
>   perf annotate: Fix segfault with source toggle
>   perf annotate: Make few functions static
>   perf annotate: Get rid of annotation->nr_jumps
> 
>  tools/perf/builtin-top.c     |   2 +-
>  tools/perf/ui/gtk/annotate.c |   2 +-
>  tools/perf/util/annotate.c   | 115 ++++++++++++++---------------------
>  tools/perf/util/annotate.h   |   8 +--
>  4 files changed, 49 insertions(+), 78 deletions(-)
> 
> -- 
> 2.24.1
> 

