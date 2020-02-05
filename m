Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EA0C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A9F20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpL5Z4PG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBERas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:30:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36542 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBERar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:30:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so3778554wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 09:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BA/wxTBKBRtXyBJptwlCXymjnHMIAT83JNQdcmKZ7GY=;
        b=UpL5Z4PGv5IbifOCXJmA3EvKU8pwWTuibgFkCYerfZ0RWYMWJsc8jdRFKSdHulhrWW
         0q5QFjVXGqO8N3azYMUT6BuQ70iIsYooSH0EN3NCB1U+uAl0UOubOv/x84pOWUnwZOfz
         nqLUdyrNpbx9UQKrlex68a8wL6FXpMdsVOp2ImierJGNMKjy/XyENBdZuZ87OyOllEPm
         3OBBBIUFzK0S2Bmis4vn5z0G3ksW8K0PQM62ik+UqemshCq2wrtaGg6nGM95ryq0m1oV
         bjtOm73AnLl8o+WYQlLgbQBG72NiEnexJulDQcDQhqCPvLnUWDJPV8Z2q1LLoi5XlXbF
         6avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BA/wxTBKBRtXyBJptwlCXymjnHMIAT83JNQdcmKZ7GY=;
        b=sJjfdFvgBe8F6iTAO3lslR+o7Ss/IOE8tqOccjhO47CTz2FLM6kL/bEqjJ7CYXF/dK
         byRluTwndKH7+I4hlo//cMLofjgY/YV1IMCtfdRH0ubIOPRVr3YOOXj2yCccY4axN1ac
         +kxCcaS87nXROwK1yNpDZzMjXeG/EUCqZSEE3Ql0Qx5P9v4y8saEQUe59f1cA1+RUV/s
         zw5+Tn+jJNabIA1jJqrCV/dQwW3N3HgEOIN84L6q9ILuNwIaY5i0W40MibisyhLpXd4C
         Ash+kI9hdxWWwc5mSuDrVhOeK3LjwBOvLjBbRv1Bk29AJ65AnffN+DLzvTQc3c+TU+Pe
         ra7w==
X-Gm-Message-State: APjAAAWhfSBttd9nwEQN0w+TJ3gYmCuUD9wP093+MskmzjOf2isBHh0Y
        4Uh+pWyUd8SZsA6RxOTFXaoveQ==
X-Google-Smtp-Source: APXvYqye1mYri+CUv+WS55ZmHdq9oGdILOb6XRaB+Cltp8xHrBe9SWrvZi+EHPv63nSK5VzAySrxaw==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr31507302wrn.254.1580923844315;
        Wed, 05 Feb 2020 09:30:44 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d13sm651699wrc.3.2020.02.05.09.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 09:30:43 -0800 (PST)
Date:   Wed, 5 Feb 2020 17:30:42 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Anatoly Pugachev <matorola@gmail.com>, sparclinux@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] kdb: Fix compiling on architectures w/out
 DBG_MAX_REG_NUM defined
Message-ID: <20200205173042.chqij5i53mncfzar@holly.lan>
References: <20200204141219.1.Ief3f3a7edbbd76165901b14813e90381c290786d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204141219.1.Ief3f3a7edbbd76165901b14813e90381c290786d@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 02:12:25PM -0800, Douglas Anderson wrote:
> In commit bbfceba15f8d ("kdb: Get rid of confusing diag msg from "rd"
> if current task has no regs") I tried to clean things up by using "if"
> instead of "#ifdef".  Turns out we really need "#ifdef" since not all
> architectures define some of the structures that the code is referring
> to.
> 
> Let's switch to #ifdef again, but at least avoid using it inside of
> the function.
> 
> Fixes: bbfceba15f8d ("kdb: Get rid of confusing diag msg from "rd" if current task has no regs")
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Thanks for being so quick with this (especially when if I had been less
delinquent with linux-next it might have been spotted sooner).


> ---
> I don't have a sparc64 compiler but I'm pretty sure this should work.
> Testing appreciated.

I've just add sparc64 into my pre-release testing (although I have had to
turn off a bunch of additional compiler warnings in order to do so).


>  kernel/debug/kdb/kdb_main.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index b22292b649c4..c84e61747267 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -1833,6 +1833,16 @@ static int kdb_go(int argc, const char **argv)
>  /*
>   * kdb_rd - This function implements the 'rd' command.
>   */
> +
> +/* Fallback to Linux showregs() if we don't have DBG_MAX_REG_NUM */
> +#if DBG_MAX_REG_NUM <= 0
> +static int kdb_rd(int argc, const char **argv)
> +{
> +	if (!kdb_check_regs())
> +		kdb_dumpregs(kdb_current_regs);
> +	return 0;
> +}
> +#else

The original kdb_rd (and kdb_rm which still exists in this file) place
the #if inside the function and users > 0 so the common case was
covered at the top and the fallback at the bottom.

Why change style when re-introducing this code?


Daniel.
