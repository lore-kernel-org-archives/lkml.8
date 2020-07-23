Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE5DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA79B207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOBQS8sA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgGWF5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 01:57:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30886 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725773AbgGWF5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 01:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595483860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fAqp5ib2PZP/lFXYC06EwZltjuh1DbpFYhRZzc7f8qI=;
        b=BOBQS8sAUq3D39pl5Rzh+Ew3AgpwRO/2199eXz+8z9ihiRbvTRnQn9yKtE3qm4EBCEubyR
        DVIT5AHbV0Ve0YSTPH6KQJT+MADoZTVkNxkEjCwgJAUOzsmyjYBwlcppZUOvykaglPIAtM
        tXUsl+g6sKTr2LgnHeHCPyP9M/0CoEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-y1KKTRwlPpWc1T8yLVzkQQ-1; Thu, 23 Jul 2020 01:57:39 -0400
X-MC-Unique: y1KKTRwlPpWc1T8yLVzkQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A00D1800C64;
        Thu, 23 Jul 2020 05:57:37 +0000 (UTC)
Received: from localhost (ovpn-13-53.pek2.redhat.com [10.72.13.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52D7A60C05;
        Thu, 23 Jul 2020 05:57:33 +0000 (UTC)
Date:   Thu, 23 Jul 2020 13:57:31 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 3/4] doc/vm: fix typo in the hugetlb admin
 documentation
Message-ID: <20200723055731.GP32539@MiWiFi-R3L-srv>
References: <20200723032248.24772-1-bhe@redhat.com>
 <20200723032248.24772-4-bhe@redhat.com>
 <da5d1d65-32ff-dd27-af4b-159e48eaa763@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da5d1d65-32ff-dd27-af4b-159e48eaa763@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/20 at 10:47am, Anshuman Khandual wrote:
> 
> 
> On 07/23/2020 08:52 AM, Baoquan He wrote:
> > Change 'pecify' to 'Specify'.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > ---
> >  Documentation/admin-guide/mm/hugetlbpage.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> > index 015a5f7d7854..f7b1c7462991 100644
> > --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> > +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> > @@ -131,7 +131,7 @@ hugepages
> >  	parameter is preceded by an invalid hugepagesz parameter, it will
> >  	be ignored.
> >  default_hugepagesz
> > -	pecify the default huge page size.  This parameter can
> > +	Specify the default huge page size.  This parameter can
> >  	only be specified once on the command line.  default_hugepagesz can
> >  	optionally be followed by the hugepages parameter to preallocate a
> >  	specific number of huge pages of default size.  The number of default
> > 
> 
> This does not apply on 5.8-rc6 and the original typo seems to be missing
> there as well. This section was introduced recently with following commit.
> 
>  282f4214384e ("hugetlbfs: clean up command line processing")

Thanks a lot for reviewing. This patchset is based on the latest
next/master branch, seems below commit introduced the typo which is
later than commit 282f4214384e, it haven't been merged into mainline
tree.

commit 72a3e3e25a5142284c6bc76ecf170c2a18dcdf6e
Author: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Tue Jun 23 09:09:06 2020 +0200

    docs: hugetlbpage.rst: fix some warnings

