Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4028EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 11:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F82D20723
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 11:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593949540;
	bh=1vDyPYB8P+w9epdFK6knYfZZJXgI1oimuZxcouCLZnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o4SMjHfwadaH3CVBlfCIGxizA3Bg6CyncGH8MpjdTfb8U5lW8KSTme5QNdLZWz8wT
	 zMDqSCXFfvgle6z6GJq1D7PQJ5UUz8c2FwF/+3jAmpqjhQWbQ0PyF6wCIBHfDdwUq2
	 L9A4NHeoKDmmhLgpIllu/f20x4/aBkmEgMSdLO+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgGELpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 07:45:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGELpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 07:45:38 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52362206B6;
        Sun,  5 Jul 2020 11:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593949538;
        bh=1vDyPYB8P+w9epdFK6knYfZZJXgI1oimuZxcouCLZnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgEEh28GtfHOApvp+2oPFQuqFen4lGbGwNelUp54OSjCgqF/afgYLpDnHQoUcR8BG
         b5sXaiFnFI9blHvXHvcgXCNoDUYwFQT+CSqpvzHAc/totY5KOJzjX34SgVTIIQ6+jC
         HSb7NP5vB0bsLkNI4tAgkgv84Kx2cp0UuZ1vObnI=
Date:   Sun, 5 Jul 2020 14:45:29 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 0/3] Documentation: arm64: eliminate duplicated words
Message-ID: <20200705114529.GE2999148@kernel.org>
References: <20200703205110.29873-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703205110.29873-1-rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 01:51:07PM -0700, Randy Dunlap wrote:
> Drop doubled words in Documentation/arm64/.
> 
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Dave Martin <Dave.Martin@arm.com>


Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> 
>  Documentation/arm64/acpi_object_usage.rst |    2 +-
>  Documentation/arm64/arm-acpi.rst          |    2 +-
>  Documentation/arm64/sve.rst               |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

-- 
Sincerely yours,
Mike.
