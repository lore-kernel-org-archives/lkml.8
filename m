Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3F1C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7124C20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580476439;
	bh=RO7FRaDSTqL5YuQ+qtLeV+CgOOABQ+cef/L65j1W+z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GuVIsGuVAYmVXdhMFzBU2uoIP06dH5ur8mXiRpRG51Y+optxgGxZZ0zriwwyBy5/V
	 sQWMHxweMIYNlcnjrDIAaD2xXhrOvDmp8fdl+nHbli03tA+Jn1QLgxWLrqQ309dsrW
	 y2AYV+3CPkdT9C7IegRWBknpnxR/Jx0BtwvTW0dU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgAaNN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:13:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728599AbgAaNN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:13:58 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9183205F4;
        Fri, 31 Jan 2020 13:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580476437;
        bh=RO7FRaDSTqL5YuQ+qtLeV+CgOOABQ+cef/L65j1W+z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1jQdkMBX6EteJ15tJD+vPvOPNUhlGJmnad9/wLKnSjE/xzHY3Y7Ii6P0YDns/T7G2
         anVPmFpYAjP4RX/weWsHAOp8q8t2IdhzR37Ryvcl6FP15fRnRtfXgcCARGgYXP0l+f
         95d7psfDj6ryba7qX+3rAgXQbauZaXuciDuf+lyE=
Date:   Fri, 31 Jan 2020 13:13:53 +0000
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     dave@stgolabs.net, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH RFC locktorture] Print ratio of acquisitions, not failures
Message-ID: <20200131131353.GB4555@willie-the-truck>
References: <20200123172707.GA24441@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123172707.GA24441@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 09:27:07AM -0800, Paul E. McKenney wrote:
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index 99475a6..687c1d8 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -696,10 +696,10 @@ static void __torture_print_stats(char *page,
>  		if (statp[i].n_lock_fail)
>  			fail = true;
>  		sum += statp[i].n_lock_acquired;
> -		if (max < statp[i].n_lock_fail)
> -			max = statp[i].n_lock_fail;
> -		if (min > statp[i].n_lock_fail)
> -			min = statp[i].n_lock_fail;
> +		if (max < statp[i].n_lock_acquired)
> +			max = statp[i].n_lock_acquired;
> +		if (min > statp[i].n_lock_acquired)
> +			min = statp[i].n_lock_acquired;
>  	}
>  	page += sprintf(page,
>  			"%s:  Total: %lld  Max/Min: %ld/%ld %s  Fail: %d %s\n",

Acked-by: Will Deacon <will@kernel.org>

Will

