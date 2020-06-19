Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5369C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9BF20771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLUC48eA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbgFSN0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgFSN0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:26:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7CEC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:26:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so9710865wrc.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EDl06g4tI7RUg4Oea7vYlL/mQwT19V4CjRtIu35w2Zs=;
        b=QLUC48eAWY3hijmku8GpuBCuKGMbRGGYnsCvnSOMwCSReiU4gDckvhQ0mon/l8lK/8
         demq2lvGDTinTcrmwzXSzSMooLCanOrZY5bnL4kpHqRxswAMMY0u7CoALWURUENrULgN
         UnEh58Or9livqzI2yxoJtbcVzmnzwA//5M3auAd+RtH3HKRwaG12KUWy+IZgTFSP5UHc
         xtv0yV7b0GCoTn4J7Rx/4pYxh1H6XW5yil/MsUTROGIWdlrSuRcbUQa5MaBvwoqWT18V
         208bMswjw8Tz8GLkzrsnhVFROipwdtTnbmaiuiNfrXSSkD/AGVWneSktvOq4Qfv+d7G/
         spgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EDl06g4tI7RUg4Oea7vYlL/mQwT19V4CjRtIu35w2Zs=;
        b=KTt6zu23+EcJSEmTysC6GMWDgBd+mgV+4ZLu9bWhESrdE+Rja726+NTJPDrI4dpTQW
         eMQEOc+gby5BPG5witOys7wdDYRi5LMF9dMv88bH5NYkefvqHpzzcW7s69kJpDmAbrFv
         H06i1sM39XUmWD3B1+Nlzx6OljMxKyw064YkZ3cGeXLndg0rsON8SkMkEh4JsG+EM7kX
         hv1LPxc95MN4YVNKNrO9ZGhfB7XCk/SVS+qJJlx71nbVq/lQDwhRPLfLUIl6yYa19FIr
         sb9VZRIPzvXoTzVfkm5taRyCjV3+EPtysPBFmNo7mksHxxnX+Iask7lxYaJO8mMdU/ww
         6Y9A==
X-Gm-Message-State: AOAM5301muInfYRKwccjnn0+Rxv8Rl5pqk07zTW89QE2styt8NOgA6w2
        Go56mkRLAyeBQzwVBgXuVoUXXw==
X-Google-Smtp-Source: ABdhPJxnbuGZHxhaFkC20h6Lj9zI284RFEXrueAkWZLrV5n8WksPkz86OBiz1yA1TokXrXfksJVcRA==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr4100659wrs.393.1592573193795;
        Fri, 19 Jun 2020 06:26:33 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id u12sm7506265wrq.90.2020.06.19.06.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 06:26:32 -0700 (PDT)
Date:   Fri, 19 Jun 2020 15:26:27 +0200
From:   Marco Elver <elver@google.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] kcsan: Improve small stylistic detail in compiler-clang.h
Message-ID: <20200619132627.GD222848@elver.google.com>
References: <20200619125721.15946-1-sedat.dilek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619125721.15946-1-sedat.dilek@gmail.com>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 02:57PM +0200, Sedat Dilek wrote:
> Commit 5cbaefe9743bf14c9d3106db0cc19f8cb0a3ca22
> ("kcsan: Improve various small stylistic details")
> 
> ...forgot to improve a stylistic detail that was already done at
> another place in compiler-clang.h file.
> 
> Fixes: 5cbaefe9743b ("kcsan: Improve various small stylistic details")
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---
>  include/linux/compiler-clang.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index ee37256ec8bd..c47141b185fe 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -25,7 +25,7 @@
>  #endif
>  
>  #if __has_feature(thread_sanitizer)
> -/* emulate gcc's __SANITIZE_THREAD__ flag */
> +/* Emulate GCC's __SANITIZE_THREAD__ flag */

Yeah, it's inconsistent, but if you look at the rest of the file, none
of it looks particularly pretty.

This change isn't really affecting KCSAN, but is a stylistic change
confined to compiler-clang.h: while we're here, we could just bunch a
couple of them into one patch and make it "compiler-clang.h: Improve
comments style" or something.

1. These sentences probably want a '.' at the end.

2. Make all comments start with a capital letter, and punctuate
   correctly.

3. Multi-line comments should have the first line just '/*' and the
   second line starts the text.

Thanks,
-- Marco
