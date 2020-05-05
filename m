Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB09CC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B05206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aZRjcMSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgEEVaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 17:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728853AbgEEVaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 17:30:09 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8D8C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 14:30:09 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u22so1356531plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AYOhvViGtfOYUpiUVO6St0IFegyeJIOeiAmdAI4TNGQ=;
        b=aZRjcMSGm6tpJdp5dwhoA4BnTL577pukRa7mQxkssp3Sui1VOiL8Cg5ituwtaTjV63
         puUEc6X0vUmy9Ut2Ru4iG7PiSQeUG9f5uPgZ7vStJgQ5nKW+uovurKtQKfkKF/xcGUEi
         lexkvpQCX0AhebneUv6ca46cPDFaGMd+VR3ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AYOhvViGtfOYUpiUVO6St0IFegyeJIOeiAmdAI4TNGQ=;
        b=U0bzVxtbhqevLZ36eM3ByG43QfqvGMLqUw6PCSWH4llKyzc+DXZybW35Z6i882Be9D
         A39dwua1aySYa7bHH7kLBTmASp1w3ChiuPSIvtf8rOnC4J6r/xPF3j6U8eku0X2X0gHx
         gyv4468eEKEQI0cQEYlQMZb9laM8BWkJ74ftvghzhqN6jbyMjgVT2KzWDbvTy5ls8a+u
         HGexJOLqYHAmDy+13bSco9Sew7MvQ279uqBO3ZYEocyNReHp96ahAZoMtCdLuKbO3a2z
         2m6dpKwMr5+lro1hRymR1boY9PRuASv7P1ZE/i1AuxVdByedcJAPu/uyIhJd4ggSEt6T
         4kGw==
X-Gm-Message-State: AGi0PuZKFkKaje2Ak1Gu+qYmTVpXdwQF04Ovd5wgyMyw7rMpUnwRpgDb
        eHz1GVevgE002rjg4hOwljiXKg==
X-Google-Smtp-Source: APiQypK3WcjO6U2JPoW88Je3vxrfxgNXgBI2d3GGp00OAegb5kl+6AC9gnF876wanQj3MCGBJKiezw==
X-Received: by 2002:a17:902:a98c:: with SMTP id bh12mr4905381plb.176.1588714209118;
        Tue, 05 May 2020 14:30:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o1sm2883000pjs.35.2020.05.05.14.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 14:30:08 -0700 (PDT)
Date:   Tue, 5 May 2020 14:30:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7/7] exec: Rename flush_old_exec begin_new_exec
Message-ID: <202005051430.6ED1CC450@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87a72mi2rq.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a72mi2rq.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 02:46:01PM -0500, Eric W. Biederman wrote:
> 
> There is and has been for a very long time been a lot more going on in
> flush_old_exec than just flushing the old state.  After the movement
> of code from setup_new_exec there is a whole lot more going on than
> just flushing the old executables state.
> 
> Rename flush_old_exec to begin_new_exec to more accurately reflect
> what this function does.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
