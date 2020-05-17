Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E66C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 02:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345C2204EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 02:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bW5p1lim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgEQCkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 22:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgEQCkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 22:40:09 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B1C05BD09
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 19:40:08 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x77so3067538pfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 19:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DQ7b10CExQtYq9ez/1sImqvzsTVJs9wfSvWwWE1m+zg=;
        b=bW5p1limV5v31ZEEUmeY80kPntKeAP7HeTDpzq0pJU+hfaLfTwsI5yetINIu44YNQ4
         snELtQQy2ES70Hvlzy5NGA1e2Vll6u48YlTY0+Jj47MitzVgDBJHZ/k/jcQlNILqn1Cc
         rJJD6QDtv+5OQCka5Eyr0n6VANGZDd85j6Bo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DQ7b10CExQtYq9ez/1sImqvzsTVJs9wfSvWwWE1m+zg=;
        b=Rsx3NoN6y06T/yAYq2R2miaNJXNsYYzkAEIs6n6zaLBYx1hPEryysv+83Uhn1di5Tm
         vlnA1bxsOi5z3PepEtY8ezcivH7l1EOhZL2WcoIGMfuyJB62b1dmEOxf4hmTnuJraNXr
         VlLDgiVrbn5SExEiPM0KI4o4vSw9bBGlTPn7E4gTV59EdgqgaVlrhUAo3ojnnuWe+1a2
         aJtcobQQnzhHSTv83Obh0g3uSk4UBpZaw+C5KIvyrZOmuSUcseLqctILJOhz5QubNTvo
         MXuOEbNty7uKGUbeUOaTGO5ehqKbJpdauEKuDBc2U3QCNORIrs8gBjJV5yDYW9rwZsXM
         cqtQ==
X-Gm-Message-State: AOAM5319GwjMxTVF52HPaELr6fioJM4YtpXtU6CJ3sePIowpQr5Ur+xc
        hV5S8F2T6csK4EW/IV/ZYxTndg==
X-Google-Smtp-Source: ABdhPJz1ff8Ew1NkzLgoebMXiLgxHRi+QB4XZRAQD23Z+ssqKwPQfvyFa8mCs6ThD962ynyNyBZzKQ==
X-Received: by 2002:aa7:93ac:: with SMTP id x12mr2880478pff.143.1589683207980;
        Sat, 16 May 2020 19:40:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cm14sm4881606pjb.31.2020.05.16.19.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 19:40:07 -0700 (PDT)
Date:   Sat, 16 May 2020 19:40:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        peterz@infradead.org, mingo@kernel.org, patrick.bellasi@arm.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        Jisheng.Zhang@synaptics.com, bigeasy@linutronix.de,
        pmladek@suse.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        wangle6@huawei.com
Subject: Re: [PATCH v2 2/4] sysctl: Move some boundary constants form
 sysctl.c to sysctl_vals
Message-ID: <202005161940.B8DF981@keescook>
References: <1589619315-65827-1-git-send-email-nixiaoming@huawei.com>
 <1589619315-65827-3-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589619315-65827-3-git-send-email-nixiaoming@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 04:55:13PM +0800, Xiaoming Ni wrote:
> Some boundary (.extra1 .extra2) constants (E.g: neg_one two) in
> sysctl.c are used in multiple features. Move these variables to
> sysctl_vals to avoid adding duplicate variables when cleaning up
> sysctls table.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
