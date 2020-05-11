Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905CBC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A87820801
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBJfdwv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgEKLBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:01:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57835 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728209AbgEKLBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589194899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O4XZdKi10BPE8hXljNPQKlDFXXtBAToj+e/VOZfbERA=;
        b=SBJfdwv0JBMPBTxL2NwB/06BSO0N9+B/beRsrsqYchElPorzvJrBVmGy55dH203shoUvEJ
        d8CYhDow/2IBl5c/l5sGW252wahQQdAGwgqPHD/ZYi0d1m0td6wpuXpWSdgJtwOeyX/fOa
        S0krBDUfdh6XNmii/2/dUskR5BJEZnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-93o9sHwmN4CiUFwVvLFFxg-1; Mon, 11 May 2020 07:01:35 -0400
X-MC-Unique: 93o9sHwmN4CiUFwVvLFFxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA1058014C0;
        Mon, 11 May 2020 11:01:32 +0000 (UTC)
Received: from krava (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id ADF939CB9;
        Mon, 11 May 2020 11:01:28 +0000 (UTC)
Date:   Mon, 11 May 2020 13:01:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        qiangqing.zhang@nxp.com, irogers@google.com, robin.murphy@arm.com,
        zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v3 02/12] perf jevents: Add support for system events
 tables
Message-ID: <20200511110127.GB2986380@krava>
References: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
 <1588852671-61996-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588852671-61996-3-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 07:57:41PM +0800, John Garry wrote:

SNIP

>  
> +static bool is_sys_dir(char *fname)
> +{
> +	char *pos;
> +
> +	while (true) {
> +		pos = strchr(fname, '/');

would strrchr be faster? also I thought there's something like
basename function that could be usable in here?

jirka

> +
> +		if (!pos) {
> +			if (!strcmp(fname, "sys"))
> +				return true;
> +			return false;
> +		}
> +
> +		fname = pos + 1;
> +	}
> +
> +	return false;
> +}

