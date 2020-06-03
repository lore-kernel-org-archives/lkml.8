Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5A1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7EC2068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591175743;
	bh=zEsxwfRIv6BHg3ZiFueCDxPNQo1lm3dm4VsCJKMvT4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ipGB0DroJUMJUiRVYdQvb/v00F8nTjyOQkZvpXAki2D56Y6ohUPdNNP1eCE/jSgYV
	 Ej6xgmipeySUNeg5CnfUlo7nv2+JXa4lebSaSg/S2shwIVV/jyCKNU13DS9brSMcPx
	 c9gXJSeVa1N9xTx5NP321XufjA/5UMdey+CcYRjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgFCJPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgFCJPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:15:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3040FC05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 02:15:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so1485556wru.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 02:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mwc3ZexQv1BQCIyLF810tRXJ05J59ALeCn9xJog8DSk=;
        b=AL3Ra2X4A/kvjmkLqqiHbOLDHLr2cepfcVdtsEcRnSL2Bkk7RIRfns0FmZpJAsYI3J
         XUf3/3rr8W1BTdrcgtf+d3e2prgueOlEnIWqxsdiZp+W2sBXt/euU95gxX621RJcVybP
         qsammWILeExjhRmiynLL0S5snrBqgtzk5txciQMRYz+/9NBzKe0foUWqAvEnl1NWlhxC
         pTEYA/zf3r9MWW00ko8iRPf6g+ZQDQ8HXeuGB01z5otjBKoTMGa5s8TXMw2BaeY/Rcrg
         gOf25D9zzF3is4+1aEdyWk312KCVS7P5imu1KroQcvq2LSTIknYBPdIWNLBkDWTc2wxS
         yRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Mwc3ZexQv1BQCIyLF810tRXJ05J59ALeCn9xJog8DSk=;
        b=AILHOKR2xAkkWQyH1aKpBz7BEViH9q4GyDWnQGyigLQ5RzWdAASyUhRCgU9g+DhrPi
         ElkkyVuOonj/wqkQCccehl8sjiD0MStgLcsaRthR5TBF1Rd2BV7WnI8/IQYTRtWSRoto
         4MYI1JAxncUcdwSDW30Zzu/6Xa+HEWBWKHMORNV6h0qASZ5gNEJIceZ6x+TsxUTkZHq9
         HBSrxAXs/GwrPSyDhS/gk6XxR1tRYsAMogmbj3O5KHwARxYB4oaLv0xvPthXEffDgzVc
         9Xl9/w/YDtGdDkubokuxwiB9I2EcON4xc8RgdYisVAabwIKRcLOrssv6ACAUQKwdKhZD
         nirQ==
X-Gm-Message-State: AOAM533kKbgRiUuimuSvblNbypdw2hzY4H3Ngib1mVbTtrYWe69bknlB
        f7EoXi61ro+FMhX3lKKNXf0=
X-Google-Smtp-Source: ABdhPJwxUTaE2KdNw7Dcl1oe2+BGRbpUAAWMxmoIrtmJK2nJHg717Z1nq0BmFKPc7UogRD7X3ZntcQ==
X-Received: by 2002:a5d:4fc4:: with SMTP id h4mr29283400wrw.49.1591175740911;
        Wed, 03 Jun 2020 02:15:40 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c16sm2391972wrx.4.2020.06.03.02.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 02:15:39 -0700 (PDT)
Date:   Wed, 3 Jun 2020 11:15:38 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, geert@linux-m68k.org,
        wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL rcu/urgent] Fix printk format warning
Message-ID: <20200603091538.GA1360377@gmail.com>
References: <20200602155631.GA1638@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602155631.GA1638@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> Hello!
> 
> This pull request contains a single commit that fixes a printk() format
> error that appears on 32-bit architectures.  This could be argued to
> be a minor bug, but it is a regression from this week's merge window,
> and is in code that is never used in production.  Therefore the risk of
> adding this late in process is quite low, more than worth it to fix the
> irritation/confusion that the bug can cause.
> 
> And a big "Thank you!!!" to Geert (CCed) for bringing this to my
> attention, as it has slipped through the cracks earlier.
> 
> The following changes since commit b1fcf9b83c4149c63d1e0c699e85f93cbe28e211:
> 
>   rcu: Provide __rcu_is_watching() (2020-05-19 15:51:21 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent-for-mingo
> 
> for you to fetch changes up to b3e2d20973db3ec87a6dd2fee0c88d3c2e7c2f61:
> 
>   rcuperf: Fix printk format warning (2020-06-02 08:41:37 -0700)
> 
> ----------------------------------------------------------------
> Kefeng Wang (1):
>       rcuperf: Fix printk format warning
> 
>  kernel/rcu/rcuperf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Pulled into tip:core/urgent, thanks Paul!

	Ingo
