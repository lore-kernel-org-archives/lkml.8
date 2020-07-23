Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FE7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7C2207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgGWFRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 01:17:46 -0400
Received: from foss.arm.com ([217.140.110.172]:39158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgGWFRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 01:17:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4B98D6E;
        Wed, 22 Jul 2020 22:17:45 -0700 (PDT)
Received: from [10.163.85.73] (unknown [10.163.85.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C13DC3F718;
        Wed, 22 Jul 2020 22:17:43 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] doc/vm: fix typo in the hugetlb admin
 documentation
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org
References: <20200723032248.24772-1-bhe@redhat.com>
 <20200723032248.24772-4-bhe@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <da5d1d65-32ff-dd27-af4b-159e48eaa763@arm.com>
Date:   Thu, 23 Jul 2020 10:47:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200723032248.24772-4-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/23/2020 08:52 AM, Baoquan He wrote:
> Change 'pecify' to 'Specify'.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  Documentation/admin-guide/mm/hugetlbpage.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index 015a5f7d7854..f7b1c7462991 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -131,7 +131,7 @@ hugepages
>  	parameter is preceded by an invalid hugepagesz parameter, it will
>  	be ignored.
>  default_hugepagesz
> -	pecify the default huge page size.  This parameter can
> +	Specify the default huge page size.  This parameter can
>  	only be specified once on the command line.  default_hugepagesz can
>  	optionally be followed by the hugepages parameter to preallocate a
>  	specific number of huge pages of default size.  The number of default
> 

This does not apply on 5.8-rc6 and the original typo seems to be missing
there as well. This section was introduced recently with following commit.

 282f4214384e ("hugetlbfs: clean up command line processing")
