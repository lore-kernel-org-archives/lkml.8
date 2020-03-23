Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4995FC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2025B2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWsIwpW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgCWI7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:59:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34324 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgCWI7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:59:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id z15so15900387wrl.1;
        Mon, 23 Mar 2020 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cv2aeEJfwnUzLe5JF/ujRuRG3gMEfGNxnoV+cV3aiMk=;
        b=EWsIwpW8ZBvCLDgWmhA51kIpxyG28s59yqg6EK1rLUzsKRM7y/RJGJ/cDl6XKyjjgY
         0N5AhCQKxwIhwAyM+StyIrEfxC+xG4SCqLKeZ1q0GBJ2aWX+oTNlYY1uuHvYBWc3aaEe
         tJyaEsJfMCYoYzTE7eeGW0VScCiTxuj20Ni9zsPVceIZPRxJoGLMYIC4ICMMxCT7nnRs
         wckM9Xuv9SQ21N4Ymcc1qBxQNb+94fDTIOM2GXimIDRiAn66NcqPNeW9Wk8Ou+ZEfkEu
         Oyo77BUMsVTs4x5NPTI7e+uwX3MkefqFc5+t9vj/xDCeIMAkTNEQ60K1dJi9hasd6gAC
         zghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cv2aeEJfwnUzLe5JF/ujRuRG3gMEfGNxnoV+cV3aiMk=;
        b=BzggvDcymyk1gOOI22fb2YXATLfkFX4b0h/m0Ucy8WJulpUaa4lIGPB/k04/bPxkQB
         z+GXScFmienCmcTMkV+EE0AHzjzawwe+7kvj/EU8psjvl6PH8C8GVBX2rJjh7ARfUjzx
         dQgYjQqOksMzL6/LPeYl2/D1ZyQCCMtsYoaXyk7z8O6DaCDOwFx1fjeSCyr0dB3WlDaM
         8ROyAqZ6oeheiPrEu6Wd/ieKpJtApLxLOiZL24wkC1mnbEdYj7V9EksB1q2Vc9xSibzr
         KEnTwa+4dLKdSyApt8JxXwxw3eaT7b9R1zBJ9x1ReAwwbDhs5WZIB/X3Fmv/JwvAdayJ
         yJbg==
X-Gm-Message-State: ANhLgQ2O8lyUyR2t5UIhpJv0AcYhmlO4tZtrlJqoMcuEhsboRUeHbAml
        6GzCN66A7snS2pOSCWPCkDg=
X-Google-Smtp-Source: ADFU+vvK6wTv5CjtK8sndnrZiEPRpcmTNUSrFGQYU0JyN/p29HR3npPMrTYeH8Kv/nuElJrGnLoP6w==
X-Received: by 2002:a5d:488c:: with SMTP id g12mr29192019wrq.67.1584953990111;
        Mon, 23 Mar 2020 01:59:50 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id f12sm20805138wmh.4.2020.03.23.01.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 01:59:49 -0700 (PDT)
Date:   Mon, 23 Mar 2020 09:59:43 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Update maintainers for new
 Documentaion/litmus-tests/
Message-ID: <20200323085943.GA10674@andrea>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <20200323015735.236279-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323015735.236279-4-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 09:57:35PM -0400, Joel Fernandes (Google) wrote:
> Also add me as Reviewer for LKMM. Previously a patch to do this was
> Acked but somewhere along the line got lost. Add myself in this patch.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

For the entire series:

Acked-by: Andrea Parri <parri.andrea@gmail.com>

Thanks,
  Andrea


> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc1d18cb5d186..fc38b181fdff9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9699,6 +9699,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
>  M:	"Paul E. McKenney" <paulmck@kernel.org>
>  R:	Akira Yokosawa <akiyks@gmail.com>
>  R:	Daniel Lustig <dlustig@nvidia.com>
> +R:	Joel Fernandes <joel@joelfernandes.org>
>  L:	linux-kernel@vger.kernel.org
>  L:	linux-arch@vger.kernel.org
>  S:	Supported
> @@ -9709,6 +9710,7 @@ F:	Documentation/atomic_t.txt
>  F:	Documentation/core-api/atomic_ops.rst
>  F:	Documentation/core-api/refcount-vs-atomic.rst
>  F:	Documentation/memory-barriers.txt
> +F:	Documentation/litmus-tests/
>  
>  LIS3LV02D ACCELEROMETER DRIVER
>  M:	Eric Piel <eric.piel@tremplin-utc.net>
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 
