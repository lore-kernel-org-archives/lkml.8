Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD7DC1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 21:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69D22072E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 21:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584913384;
	bh=E+uYP8cz4jcHMppM+MLutOs3IM11eGS8xLvqwVnU25A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=DG2QClZ3Qh+HT9glitQAgFJ3DRpwuKCGyADuM7VbOqRk7InjuAynuJDgRAtac47yM
	 BNlBAzjWc/WsmO2sbPN/3QVEhXp8bNXSz/H4dsdiuGoKS19rTL2f5pSzkBE79FkBjF
	 rAcrV4AlRDjV5Q+LZWc1VQL1AdtUJt3WJy/Gi86c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCVVnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 17:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgCVVnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 17:43:01 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B7F32072D;
        Sun, 22 Mar 2020 21:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584913381;
        bh=E+uYP8cz4jcHMppM+MLutOs3IM11eGS8xLvqwVnU25A=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=q6W+Flzu1i6isRgyN/g+kZ3wUYlFkFnCRBoRoKHF0s75k4A3/jLhQjViPMUDGn6EW
         54zKADQV2hzBHGDsQjtcnekRIvnaQfemrN/SgYGvuKQUr46b3w7qFaEKU9hv6iZmgL
         28zqL5UjgfI6rUxbzaF9RmnvquNqQ9gnIdxZmtdA=
Date:   Sun, 22 Mar 2020 22:42:56 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Rusty Russell <rusty@rustcorp.com.au>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Nicholas Krause <xerofoify@gmail.com>,
        Duan Jiong <duanj.fnst@cn.fujitsu.com>,
        Sachin Kamat <sachin.kamat@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] err.h: remove deprecated PTR_RET for good
In-Reply-To: <20200322165702.6712-1-lukas.bulwahn@gmail.com>
Message-ID: <nycvar.YFH.7.76.2003222240500.19500@cbobk.fhfr.pm>
References: <20200322165702.6712-1-lukas.bulwahn@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Mar 2020, Lukas Bulwahn wrote:

> Initially, commit fa9ee9c4b988 ("include/linux/err.h: add a function to
> cast error-pointers to a return value") from Uwe Kleine-König introduced
> PTR_RET in 03/2011. Then, in 07/2013, commit 6e8b8726ad50 ("PTR_RET is
> now PTR_ERR_OR_ZERO") from Rusty Russell renamed PTR_RET to
> PTR_ERR_OR_ZERO, and left PTR_RET as deprecated-marked alias.
> 
> After six years since the renaming and various repeated cleanups in the
> meantime, it is time to finally remove the deprecated PTR_RET for good.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Rusty, if you are still around, Acked-by is appreciated.
> Uwe, Acked-by is appreciated.
> Kudos to Gustavo, Nicholas, Duan & Sachin for previous cleanups.
> 
> applies cleanly on current master and on next-20200320
> Jiri, please pick this trival patch for the next merge window. Thanks.

I am queuing it right away; it's been marked deprecated back in 2013, and 
it doesn't have any in-tree users anyway.

Thanks,

-- 
Jiri Kosina
SUSE Labs

