Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321AAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A5D2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gVsG4nbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgH0SIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgH0SH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:07:59 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4455C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:07:58 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id j25so8894648ejk.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X3yZk4R92/MWzVrt+vnYcwH9WkmjTyPPJoHeGH+6ZfI=;
        b=gVsG4nblq60V5WQE20uNem0i8ZWEjFlXUgY1QEYqw0+8GrhUOSNTloxcWQky/H00yz
         SokChI0VSHdZVRL2uFUtsdQZb37+c4vwHyC4tKMzLrY2rtF0fdH9Ythr85tApJaSrTTu
         W1ADxHAjQTR/9o13N06/BJcK7O29NTPzgth0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X3yZk4R92/MWzVrt+vnYcwH9WkmjTyPPJoHeGH+6ZfI=;
        b=JUffPIto3la2Dab9Frg7KXfr2fo6iSgqOB9x5PYRTM+5VYN4u5PfuKIcAYycr3eOon
         8cT7cc19CJ4xdcYQRo6545ntLsDkviwf4Qe8Im4pWooQkCCBr2szIrpdUSZQcea9P4AN
         XfehDBHyM5JpGpC6dlNqR08nh8095hhbaloZZzmGKguGzG+ShDQrarsnUlp9xqhBgZ8j
         Azbt9s3cPf8SMUpom0nRJ8UJuDzZDR56LOpr1rmYL+KKcGXDTXed8BEVOyYoYRp/zT2t
         jeSobEAe7X1ndnOZyNy283UjU9fh9pii7eNmfQCXJV1UD7yVHTb9GmWNDK2zlClMFYZv
         DjPg==
X-Gm-Message-State: AOAM530ToxIBV/IOqDLrnzszL5ddXXA39Ke7BVYAgAp9b1ev4DHoc8c1
        y5lhF8vlTMyyfnaSq0LbdeJBLA==
X-Google-Smtp-Source: ABdhPJw8kfIPfi1jXBfW6zXPsvYI8am98QM4D+P7OxSLeYQRDW7CFkG7BemTRFu9usIJlHgrOTMQ8w==
X-Received: by 2002:a17:906:2e98:: with SMTP id o24mr21267780eji.229.1598551677360;
        Thu, 27 Aug 2020 11:07:57 -0700 (PDT)
Received: from [192.168.1.149] (5.186.112.31.cgn.fibianet.dk. [5.186.112.31])
        by smtp.gmail.com with ESMTPSA id u6sm2452164ejf.98.2020.08.27.11.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 11:07:56 -0700 (PDT)
Subject: Re: [PATCH] linux/kernel.h: add container_from()
To:     Allen Pais <allen.lkml@gmail.com>, torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20200827013636.149307-1-allen.lkml@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <2176d7e4-2949-e922-1988-fa5eedfc2220@rasmusvillemoes.dk>
Date:   Thu, 27 Aug 2020 20:07:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827013636.149307-1-allen.lkml@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2020 03.36, Allen Pais wrote:
> Introduce container_from() as a generic helper instead of
> sub-systems defining a private from_* API
> (Eg: from_tasklets recently introduced in
> 12cc923f1ccc: Tasklet: Introduce new initialization API)
> 
> The helper is similar to container_of() in argument order
> with the difference of naming the containing structure instead
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> of having to specify its type.
> 

> +/**
> + * container_from - cast a member of a structure out to the containing structure
> + * @ptr:	the pointer to the member.
> + * @container:	the type of the container struct.
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This seems to have been copy-pasted from container_of? Shouldn't
@container be the (local) value we're storing into? As in foo =
container_from(..., foo, ...)? Or am I misunderstanding the purpose of this?

[And I think it would read nicer if the bikeshed was called
to_container(), but don't care deeply.]

Rasmus
