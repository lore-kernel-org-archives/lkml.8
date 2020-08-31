Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC93C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 19:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFCF2100A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 19:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598901657;
	bh=gZtRElBlIkTkKjny9lAT11wYTcgum1ipgdXOa4pL5qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NIvDWbeWnoV8SX3j47Q2SXZIGhyg/t5+Ya7NIR+oxesKf/DcHq/vYpUEcxn0uRKrg
	 87kxxdx7XjRlzUZFSwTaYvwhx8RLu7ZJlC7UU9jOhO6JUojV8aZ98BKYQFM9YuI6mq
	 Adokz59Pw+UDE7e0IrzlNw2ODezx+WBJF2rAIPIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgHaTUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 15:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgHaTUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 15:20:55 -0400
Received: from X1 (unknown [65.49.58.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D99820FC3;
        Mon, 31 Aug 2020 19:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598901653;
        bh=gZtRElBlIkTkKjny9lAT11wYTcgum1ipgdXOa4pL5qs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p+M2tjvUfpO4dqGrGR52PplNvObL9ffg8gJg7MwjRXELO08GhxSMd/4ZUX8kYu537
         sFR/OUH3w/KoqAWwoXV6UJUToA/rmoiGdfPVSX+Kiw6PHdIdBd1OqfdeyFV+NfmgFs
         OcsDSbXnXGcKzKpbxk+MZFgOCSABTpoUdIRCdv9Y=
Date:   Mon, 31 Aug 2020 12:20:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roger Pau Monne <roger.pau@citrix.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ira Weiny <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-nvdimm@lists.01.org>, <xen-devel@lists.xenproject.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v4 1/2] memremap: rename MEMORY_DEVICE_DEVDAX to
 MEMORY_DEVICE_GENERIC
Message-Id: <20200831122051.95d3e558477024819672f4f9@linux-foundation.org>
In-Reply-To: <20200811094447.31208-2-roger.pau@citrix.com>
References: <20200811094447.31208-1-roger.pau@citrix.com>
        <20200811094447.31208-2-roger.pau@citrix.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020 11:44:46 +0200 Roger Pau Monne <roger.pau@citrix.com> wrote:

> This is in preparation for the logic behind MEMORY_DEVICE_DEVDAX also
> being used by non DAX devices.

Acked-by: Andrew Morton <akpm@linux-foundation.org>.

Please add it to the Xen tree when appropriate.

(I'm not sure what David means by "separate type", but we can do that
later if desired.  Dan is taking a taking a bit of downtime).
