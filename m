Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1409DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A582084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590537398;
	bh=/DKvn5V5jBjY3r1PoVZmSHTrG73P5YgmTXg6zzEjUPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oqv3qIdBql4cwyOKM/7SQhUDkpVnjLv71PzW9K7LPSWUD2r6XYHRg1POZ2AcUfhaL
	 lfkY1pHwvY4zFhWUieOi6PwzYNh3nng+aC96BojIdCFJdGChZv+DanusGo8vewrWCa
	 urbATWlM1vbaT5P+cdythkR3O4xHxowJ6aIleqgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgEZX4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 19:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgEZX4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 19:56:37 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8705E20700;
        Tue, 26 May 2020 23:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590537397;
        bh=/DKvn5V5jBjY3r1PoVZmSHTrG73P5YgmTXg6zzEjUPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mnHfvHrQGI0quIO/bAjTmnh3ekBzp0xd/cb/YQLlpj18jKTzf+UoTHCYS+zo1oCkr
         LU7GWxj6KvSiPs5GRX8QKjhiUerC8TC77qz0sNd67JuHLwttYOzlNZvY/EbvqrV9Oj
         J+/ERs1nRxQ61FkMO8Bc/WiaDps+9LtdZ4sJCRtE=
Date:   Wed, 27 May 2020 01:56:34 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 1/7] sched: Fix smp_call_function_single_async()
 usage for ILB
Message-ID: <20200526235632.GA8942@lenoir>
References: <20200526161057.531933155@infradead.org>
 <20200526161907.778543557@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526161907.778543557@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 06:10:58PM +0200, Peter Zijlstra wrote:
> The recent commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> got smp_call_function_single_async() subtly wrong. Even though it will
> return -EBUSY when trying to re-use a csd, that condition is not
> atomic and still requires external serialization.
> 
> The change in kick_ilb() got this wrong.
> 
> While on first reading kick_ilb() has an atomic test-and-set that
> appears to serialize the use, the matching 'release' is not in the
> right place to actually guarantee this serialization.
> 
> Rework the nohz_idle_balance() trigger so that the release is in the
> IPI callback and thus guarantees the required serialization for the
> CSD.
> 
> Fixes: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks very good! Thanks!

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
