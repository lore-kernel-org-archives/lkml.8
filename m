Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD85C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F09246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582815182;
	bh=KGvsumz72+3o9oMZeKII0/m6zTL3KEnZcyan0b2EWEA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=DLuzE9lFjx1pv8urs9UMTy+DfBRn5LGwST8/fcMMr0HuABsFqV5vhfTrJ5iADCTum
	 iNP2ej7tgXS0BJU5yW/jnEC83WaPXa7n6iY7mn5XWMZDv0mM9CT3xOWmgxWzkEvGeY
	 7sLAFzL5pvkW3VDo0cyqyjKn1A8mgsdW2tbqJSQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbgB0OxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:53:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:58400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbgB0OxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:53:01 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A929A24650;
        Thu, 27 Feb 2020 14:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582815180;
        bh=KGvsumz72+3o9oMZeKII0/m6zTL3KEnZcyan0b2EWEA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g29LOw6eQp6K2rEwAwfa1Vki6NM1TCN5KRAEshq9sZiR3yIpk55rUUMLOHfUbWR+d
         g9kOI5YprpWAkNk2NRYbIe2LuZx7s4LKze3rF3p8c+A9lzzHI9Wy6TDXEty9A5C+2A
         VQn3bvN1aO7fvVRrPee0idDx1Jfoq/tEgvT24o7o=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2F1DA3521A4D; Thu, 27 Feb 2020 06:53:00 -0800 (PST)
Date:   Thu, 27 Feb 2020 06:53:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] locktorture.c: fix if-statement empty body warnings
Message-ID: <20200227145300.GG2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <06d89556-777e-ba59-1d55-12f11cba9668@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06d89556-777e-ba59-1d55-12f11cba9668@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 09:09:19PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> When using -Wextra, gcc complains about torture_preempt_schedule()
> when its definition is empty (i.e., when CONFIG_PREEMPTION is not
> set/enabled).  Fix these warnings by adding an empty do-while block
> for that macro when CONFIG_PREEMPTION is not set.
> Fixes these build warnings:
> 
> ../kernel/locking/locktorture.c:119:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> ../kernel/locking/locktorture.c:166:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> ../kernel/locking/locktorture.c:337:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> ../kernel/locking/locktorture.c:490:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> ../kernel/locking/locktorture.c:528:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> ../kernel/locking/locktorture.c:553:29: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> 
> I have verified that there is no object code change (with gcc 7.5.0).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Queued for v5.8, thank you very much!

							Thanx, Paul

> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> ---
>  include/linux/torture.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200225.orig/include/linux/torture.h
> +++ linux-next-20200225/include/linux/torture.h
> @@ -89,7 +89,7 @@ void _torture_stop_kthread(char *m, stru
>  #ifdef CONFIG_PREEMPTION
>  #define torture_preempt_schedule() preempt_schedule()
>  #else
> -#define torture_preempt_schedule()
> +#define torture_preempt_schedule()	do { } while (0)
>  #endif
>  
>  #endif /* __LINUX_TORTURE_H */
> 
