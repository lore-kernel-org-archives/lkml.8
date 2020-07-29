Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3A3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE5B2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K70+QIBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgG2Uw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Uw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:52:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423ADC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:52:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id c10so898551pjn.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FYYNYC1JI+3c7PMAXIAqnBSfW64jRIPrERoK0UyjHJw=;
        b=K70+QIBF7bjH402KT3/Gg25N38aoogOWePxYtbSb7mfR9KEciMxR6zcBNnxoPp3kCU
         bzGAMy+p46E0ipO94wqJtAhqDB8924SKqVQhlhrfCOfVqxztwVZX+xOzNJ4zLlxf8Ji4
         aHxMSdSUwfR8lHYb+s++irZHb1sd59oOG/79s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FYYNYC1JI+3c7PMAXIAqnBSfW64jRIPrERoK0UyjHJw=;
        b=rSgYNqRGjvyRDEnsu8Nky0oORblYFLglM1QX9vaQT8aiLL50sbOEGPLc1aSBRD6eh3
         rlByhL3j4B44uwTGO7Qp1L6IHTAhQd+wEM5PWjEjjA6QoDAUMcLWZeUo4WTSDe2Vtrq8
         7F4N1JdK3FR6eUklL+5RwzGmygif5GuOBo7MfHSO6gTZdUatExS32KYTiIwcy6I7KKWn
         0uW/SoV+tSurKvNVi7rYCCPleP8wrYOYbevmkPvTY4LA5nqWTRrufctg1bd1ZPoIi5iu
         LFdvg6lGWWZhubR0bFSqlIZKxKHYTlcTR4lKIke9ppb6miLnifXYUMM9vpMNwKWi6Sci
         TmUA==
X-Gm-Message-State: AOAM531wmUvtgjFmdNgj2ufiHm5DZkEOnM9Q731vqdc8Shpei/DaaU/W
        kjDFAlsBSMnf95ls4P0jKIZhTw==
X-Google-Smtp-Source: ABdhPJxd1pS467gxa4pCsqcfHhRlTS9PTJMzHfGkXdiWUZtMNIcWvAyZRL6al+aHfpiNQzkRLSl97g==
X-Received: by 2002:a17:90a:cf:: with SMTP id v15mr346379pjd.14.1596055978816;
        Wed, 29 Jul 2020 13:52:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a17sm3251985pgw.60.2020.07.29.13.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 13:52:57 -0700 (PDT)
Date:   Wed, 29 Jul 2020 13:52:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     peterz@infradead.org, Xiaoming Ni <nixiaoming@huawei.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Paul Moore <paul@paul-moore.com>, edumazet@google.com,
        paulmck@kernel.org, shakeelb@google.com,
        James Morris <jamorris@linux.microsoft.com>,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC][PATCH] locking/refcount: Provide __refcount API to obtain
 the old value
Message-ID: <202007291352.8775B08DA@keescook>
References: <20200729111120.GA2638@hirez.programming.kicks-ass.net>
 <20200721195132.GJ10769@hirez.programming.kicks-ass.net>
 <202006142054.C00B3E9C9@keescook>
 <20200612183450.4189588-1-keescook@chromium.org>
 <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com>
 <544539.1595328664@warthog.procyon.org.uk>
 <202007211144.A68C31D@keescook>
 <3211866.1595933798@warthog.procyon.org.uk>
 <4041520.1596055297@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4041520.1596055297@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 09:41:37PM +0100, David Howells wrote:
> peterz@infradead.org wrote:
> 
> > I'm not entirely sure what you mean with interpret, provided you don't
> > trigger a refcount fail, the number will be just what you expect and
> > would get from refcount_read(). If you do trigger a fail, you'll get a
> > negative value.
> 
> That's fine.  I seem to remember talk about the possibility that the number
> wouldn't necessarily bottom out at zero - for instance if it was arranged such
> that the overflow flag was set on an overflow or underflow so that it could be
> trapped on (using INTO or TRAPV, for example).

The trap is an internal detail. The saturation value will be negative,
though.

-- 
Kees Cook
