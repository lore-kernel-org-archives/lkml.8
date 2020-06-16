Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D420CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 04:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8EF1207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 04:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgFPEm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 00:42:26 -0400
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:46622 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725306AbgFPEm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 00:42:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 1AC321260;
        Tue, 16 Jun 2020 04:42:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: song81_2704b2626dfc
X-Filterd-Recvd-Size: 2406
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue, 16 Jun 2020 04:42:23 +0000 (UTC)
Message-ID: <4c9323077204a22683cd3ed92fea303a1a8b67fc.camel@perches.com>
Subject: Re: [PATCH][next] scsi: fnic: Replace vmalloc() + memset() with
 vzalloc() and use array_size()
From:   Joe Perches <joe@perches.com>
To:     "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
        "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date:   Mon, 15 Jun 2020 21:42:22 -0700
In-Reply-To: <873653F8-8FBB-4A9B-9380-B476674ECADE@cisco.com>
References: <20200615225428.GA14959@embeddedor>
         <873653F8-8FBB-4A9B-9380-B476674ECADE@cisco.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-16 at 00:19 +0000, Satish Kharat (satishkh) wrote:
> Reviewed-by: Satish Kharat <satishkh@cisco.com>
> ﻿
> 
> On 6/15/20, 3:49 PM, "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
>     Use vzalloc() instead of the vmalloc() and memset. Also, use array_size()
>     instead of the open-coded version.
>     
>     This issue was found with the help of Coccinelle and, audited and fixed
>     manually.
>     
>     Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
>     Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>     ---
>      drivers/scsi/fnic/fnic_trace.c | 16 ++++------------
>      1 file changed, 4 insertions(+), 12 deletions(-)
>     
>     diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
[]
>     @@ -488,7 +488,7 @@ int fnic_trace_buf_init(void)
>      	}
>      
>      	fnic_trace_entries.page_offset =
>     -		vmalloc(array_size(fnic_max_trace_entries,
>     +		vzalloc(array_size(fnic_max_trace_entries,
>      				   sizeof(unsigned long)));

Perhaps better as
		kvcalloc(fnic_max_trace_entries, sizeof(unsigned long),
			 GFP_KERNEL);


