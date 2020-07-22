Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9E7C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B83320714
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mce3UA+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbgGVJ4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVJ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:56:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF842C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:56:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f2so1269352wrp.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0xnQ/4hQ2Xpb1P3P7eG0JudBdmWStFiMCuMdD4rUBv8=;
        b=Mce3UA+bY7rBT9FL+oxnaddk0ue9EKfxXahp/1NiIBjGDDy/qJ/1OkOG+4y2+BO0nD
         I75Lc15Vf7mgq+pqs3h8apWlzK0eMeFZMlOlaXrts74ddZcD/LdS0GQXcVt5ef8lMS6D
         KpsOAiDvs7S6aGdhYgXTKBORSCs8UDip6SmUcswsK6JpR2M0H745/CQcxpK9FFp5VyCw
         aLRXsvLshoz537ybDpJ/ScfR8xWMj9jzh4pTl5Vc5/u3yeu+u2nDoTHH1QFmxmedOz2z
         Brsk/+l4vyO9nbVDonUKIGXn6UOw1WAy69soipR5W/EGJH0YIx/gOGreqt7QWelm66Zc
         JS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0xnQ/4hQ2Xpb1P3P7eG0JudBdmWStFiMCuMdD4rUBv8=;
        b=YJAHgodCuuAObqpeOUPv4eF72T/fTDbqjgbrN8dR5mtIUUu4cKGoF3uCCwJDvisBUl
         uSE1C3ucIaLDAYrrg9crR/UpXFHtvNJZCOESGfY0jH6z7StUwT21/X81ulP3ENBCLcym
         flOI3WDDeWVN/9xbwcw18y1brjS7qb//4RrI7AX0NokcY7qoZXlAr9mDJi0I108yjEfj
         NCUO3LsxJssHnlNnF2/ucZHhDfbE32ATQWWHVAKSl4IH+JSVmhWqSYesoja3BlAoVUJa
         RykRS9W7qpZ3T4SvshtlZF9YYPXk4vOdotVxhXBJm4RWSfQE7heFVVCAD3doHZco9SAv
         0psA==
X-Gm-Message-State: AOAM531CzGkzDtK315XYTx+j7fsid3qDEJoQW1W46VpD3v/zoIHT6GAA
        s5scWFdEdO+6EnaSpWuPkVxB7A==
X-Google-Smtp-Source: ABdhPJwARd6rDJnGgGWAfHD4Lty5BptW2nH6HgW896WzFmKMP2SqPRp1isXAIV3ddTfpCCvsd3tI0Q==
X-Received: by 2002:adf:9ed4:: with SMTP id b20mr5923702wrf.206.1595411809624;
        Wed, 22 Jul 2020 02:56:49 -0700 (PDT)
Received: from dell ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id a134sm7704101wmd.17.2020.07.22.02.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 02:56:49 -0700 (PDT)
Date:   Wed, 22 Jul 2020 10:56:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux-kernel@vger.kernel.org, phh@phh.me, stefan@agner.ch,
        b.galvani@gmail.com
Subject: Re: [PATCH] mfd: rn5t618: Fix caching of battery related registers
Message-ID: <20200722095647.GM621928@dell>
References: <20200717210002.27366-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200717210002.27366-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020, Andreas Kemnade wrote:

> Battery status changes dynamically, so the corresponding registers
> need to be considered volatile. Affected registers are:
> - fuel gauge
> - battery status
> - battery interrupt
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/rn5t618.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
