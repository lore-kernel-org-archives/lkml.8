Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91388C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD2520733
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgELKkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:40:37 -0400
Received: from foss.arm.com ([217.140.110.172]:52048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729229AbgELKkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:40:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B58071FB;
        Tue, 12 May 2020 03:40:36 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 810FA3F71E;
        Tue, 12 May 2020 03:40:35 -0700 (PDT)
Date:   Tue, 12 May 2020 11:40:30 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI/IORT: Fix PMCG node always look for a single ID
 mapping.
Message-ID: <20200512104030.GA11555@e121166-lin.cambridge.arm.com>
References: <1589228576-18053-1-git-send-email-tuanphan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589228576-18053-1-git-send-email-tuanphan@os.amperecomputing.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 01:22:56PM -0700, Tuan Phan wrote:
> PMCG node can have zero ID mapping if its overflow interrupt
> is wire based. The code to parse PMCG node can not assume it will
> have a single ID mapping.
> 
> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
> ---
>  drivers/acpi/arm64/iort.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index ed3d2d1..72444e1 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -441,7 +441,9 @@ static int iort_get_id_mapping_index(struct acpi_iort_node *node)
>  
>  		return smmu->id_mapping_index;
>  	case ACPI_IORT_NODE_PMCG:
> -		return 0;
> +		if (node->mapping_count)
> +			return 0;

Check struct acpi_iort_pmcg->overflow_gsiv to be coherent with SMMUv3
code.

Lorenzo

> +		return -EINVAL;
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 2.7.4
> 
