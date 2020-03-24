Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1389DC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D556820786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVcaIPLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgCXKsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:48:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46426 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727095AbgCXKsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585046934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qSOri34BE3PtZf/E2VZCmCknPEbvXiWhBYN0uUrx2Fk=;
        b=CVcaIPLkVuc+4NUKUdr5HwJWGUqSwXWwT3k6po59A4FU3l9UtFQIwslVgcwcQCSc7CibN1
        Lh8Zb83zYOxQCh9dpDo4vl+8q7xonWWaL582uvm8+ylHKz0xKKUPFqwCwGkZ8P+r06YEUO
        eIt+vj651kApaGnlx4fPAmxXsgT0csA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-nMIzL1KCNAKbGY_b8S1UXQ-1; Tue, 24 Mar 2020 06:48:51 -0400
X-MC-Unique: nMIzL1KCNAKbGY_b8S1UXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D203D107ACC4;
        Tue, 24 Mar 2020 10:48:49 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6672019C6A;
        Tue, 24 Mar 2020 10:48:48 +0000 (UTC)
Date:   Tue, 24 Mar 2020 11:48:43 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH] perf dso: Fix dso comparison
Message-ID: <20200324104843.GS1534489@krava>
References: <20200324042424.68366-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324042424.68366-1-ravi.bangoria@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 09:54:24AM +0530, Ravi Bangoria wrote:
> Perf gets dso details from two different sources. 1st, from builid
> headers in perf.data and 2nd from MMAP2 samples. Dso from buildid
> header does not have dso_id detail. And dso from MMAP2 samples does
> not have buildid information. If detail of the same dso is present
> at both the places, filename is common.
> 
> Previously, __dsos__findnew_link_by_longname_id() used to compare only
> long or short names, but Commit 0e3149f86b99 ("perf dso: Move dso_id
> from 'struct map' to 'struct dso'") also added a dso_id comparison.
> Because of that, now perf is creating two different dso objects of the
> same file, one from buildid header (with dso_id but without buildid)
> and second from MMAP2 sample (with buildid but without dso_id).
> 
> This is causing issues with archive, buildid-list etc subcommands. Fix
> this by comparing dso_id only when it's present. And incase dso is
> present in 'dsos' list without dso_id, inject dso_id detail as well.
> 
> Before:
> 
>   $ sudo ./perf buildid-list -H
>   0000000000000000000000000000000000000000 /usr/bin/ls
>   0000000000000000000000000000000000000000 /usr/lib64/ld-2.30.so
>   0000000000000000000000000000000000000000 /usr/lib64/libc-2.30.so
> 
>   $ ./perf archive
>   perf archive: no build-ids found
> 
> After:
> 
>   $ ./perf buildid-list -H
>   b6b1291d0cead046ed0fa5734037fa87a579adee /usr/bin/ls
>   641f0c90cfa15779352f12c0ec3c7a2b2b6f41e8 /usr/lib64/ld-2.30.so
>   675ace3ca07a0b863df01f461a7b0984c65c8b37 /usr/lib64/libc-2.30.so
> 
>   $ ./perf archive
>   Now please run:
> 
>   $ tar xvf perf.data.tar.bz2 -C ~/.debug
> 
>   wherever you need to run 'perf report' on.
> 
> Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

looks good, do we need to add the dso_id check to sort__dso_cmp?

thanks,
jirka

