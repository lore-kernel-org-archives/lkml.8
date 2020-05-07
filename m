Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F808C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB632078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588840777;
	bh=Ld4HmaMz+uu6ugfeoP8TBmKNgDCsNouPkgsc7oqJvJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qra04XMgiUe9X+0x2iHh91SgIUEzaZAONE6qNb5sWX0tzw8kXg8bf21FEHm77ij0G
	 2FtvVpQTOJX5QHMhkQek/6HJ+fGEHfvlmU8/ln5MD63CJ+PlYKWZO035FbIrP04HuY
	 M394qv66yWwOIxbsc0XF3ggbnfFBYtQKfrlbDXp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgEGIjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgEGIje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:39:34 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F3782080D;
        Thu,  7 May 2020 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588840774;
        bh=Ld4HmaMz+uu6ugfeoP8TBmKNgDCsNouPkgsc7oqJvJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ro9/oIOy26gDdLHjpEUoFtciNshEP2GerzmgbWkGIanFXpQygbI2/v8W6P3WCmgyy
         7Kr7vpMASvV958hsQEWu3oTRmchj+Ts2GFYBk2xWWCVepWBbLyZKBdzQ0rQ2GEjw1n
         ALYvEew8+AvUNXKIKXDXpWcgpWnYLJsD2/+bcOoc=
Date:   Thu, 7 May 2020 09:39:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [PATCH] kgdb: Fix spurious true from in_dbg_master()
Message-ID: <20200507083929.GC28215@willie-the-truck>
References: <20200506164223.2875760-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506164223.2875760-1-daniel.thompson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 05:42:23PM +0100, Daniel Thompson wrote:
> Currently there is a small window where a badly timed migration could
> cause in_dbg_master() to spuriously return true. Specifically if we
> migrate to a new core after reading the processor id and the previous
> core takes a breakpoint then we will evaluate true if we read
> kgdb_active before we get the IPI to bring us to halt.
> 
> Fix this by checking irqs_disabled() first. Interrupts are always
> disabled when we are executing the kgdb trap so this is an acceptable
> prerequisite. This also allows us to replace raw_smp_processor_id()
> with smp_processor_id() since the short circuit logic will prevent
> warnings from PREEMPT_DEBUG.
> 
> Fixes: dcc7871128e9 ("kgdb: core changes to support kdb")
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  include/linux/kgdb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index b072aeb1fd78..4d6fe87fd38f 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -323,7 +323,7 @@ extern void gdbstub_exit(int status);
>  extern int			kgdb_single_step;
>  extern atomic_t			kgdb_active;
>  #define in_dbg_master() \
> -	(raw_smp_processor_id() == atomic_read(&kgdb_active))
> +	(irqs_disabled() && (smp_processor_id() == atomic_read(&kgdb_active)))
>  extern bool dbg_is_early;
>  extern void __init dbg_late_init(void);
>  extern void kgdb_panic(const char *msg);

Cheers, Daniel. I assume you'll route this one via the kgdb tree? I can
live with the "small window" in the arm64 for-next/core branch ;)

Will
