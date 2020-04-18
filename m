Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F93C38A2B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 01:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABDA221EA
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 01:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgDRBBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 21:01:21 -0400
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:48134 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725949AbgDRBBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 21:01:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 7E45F1801EDC8;
        Sat, 18 Apr 2020 01:01:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: page10_627b1b350bf5d
X-Filterd-Recvd-Size: 1847
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 18 Apr 2020 01:01:16 +0000 (UTC)
Message-ID: <13a8e8efd56d00945e375760f7f065fb020287a1.camel@perches.com>
Subject: Re: [PATCH v9 3/3] MAINTAINERS: add HMM selftests
From:   Joe Perches <joe@perches.com>
To:     Ralph Campbell <rcampbell@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Date:   Fri, 17 Apr 2020 17:59:03 -0700
In-Reply-To: <20200417235458.13462-4-rcampbell@nvidia.com>
References: <20200417235458.13462-1-rcampbell@nvidia.com>
         <20200417235458.13462-4-rcampbell@nvidia.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-17 at 16:54 -0700, Ralph Campbell wrote:
> Add files for HMM selftests.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db31497..072921b7bae2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7729,6 +7729,9 @@ S:	Maintained
>  F:	Documentation/vm/hmm.rst
>  F:	include/linux/hmm*
>  F:	mm/hmm*
> +F:	include/uapi/linux/test_hmm*
> +F:	lib/test_hmm*
> +F:	tools/testing/selftests/vm/*hmm*

file patterns in alphabetic order please:

F	Documentation/vm/hmm.rst
F:	include/linux/hmm*
F:	include/uapi/linux/test_hmm*
F:	lib/test_hmm*
F:	mm/hmm*
F:	tools/testing/selftests/vm/*hmm*	

