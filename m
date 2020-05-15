Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E71C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D740820643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nye9VDAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgEOIE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726694AbgEOIEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:04:25 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA23C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:04:24 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j21so621379pgb.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LC42tQWSVKcPTd0vfct9nXEP5yPluiMsV+/dal56l40=;
        b=nye9VDABcDWL9gKYaE40k1ONvXp/eBIpP0OHIwwaZ+eKb4bOiLnjaYBbq56KRBcgdG
         /x/Vu5n5nDX/ojuh95Ko0Zhr0LPhSoHkx44TbRdq3mejTC1sIWroMupPgsKqafO/mvle
         e/ZfFneXBldriWjrwMroEVj5pMpOhNo6FH0a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LC42tQWSVKcPTd0vfct9nXEP5yPluiMsV+/dal56l40=;
        b=C8SSTnYm9cKzALpOkDv5XQDrz45Pb9euKAgE9DMhmTfF70lI74rhuQWR9ZWhmeym9y
         YeGfsov47LUaQR7uYwi92JxqWx+7lY3gb2f6OCCWBFtyu+Qnmmut43PO/7kzgMkf+4H4
         r8/pmLpft8bNzq6Pvk3oDoyz2cG8uyCaEHZMpEwyzSl8yAcnQduiRO1+Rm23zVEl4Vfw
         UcGcB7EQU+KYQDbijr0LYt9WLwy80lw3HSYcn7r0cyAJVq4wWCO/7+6LWz0czf+/W61Q
         /s9XpQo6Z2gq5e0HpQeQLYTeAJMz4XWBUoRBYqnxiykFG5Y/95dcy6KrFuFVugtu95IW
         Toow==
X-Gm-Message-State: AOAM530DdtWyy40+BtDqSfEhrG5co+MbTPerb1woV1rpX78HQ+1ZsB3E
        oMLZwwGMGIaPaSVfgETQuYLyNQ==
X-Google-Smtp-Source: ABdhPJzXrdopWQZaKiXr0V4m/XkQq+2GMH38/b4FSyLAHwIGW63nncfVYJvxNIvccBvhCbUdH+pjww==
X-Received: by 2002:a63:1f62:: with SMTP id q34mr1949396pgm.197.1589529863766;
        Fri, 15 May 2020 01:04:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h64sm1302263pfe.42.2020.05.15.01.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 01:04:22 -0700 (PDT)
Date:   Fri, 15 May 2020 01:04:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        mingo@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, bauerman@linux.ibm.com,
        gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
        dvyukov@google.com, svens@stackframe.org, joel@joelfernandes.org,
        tglx@linutronix.de, Jisheng.Zhang@synaptics.com, pmladek@suse.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, wangle6@huawei.com
Subject: Re: [PATCH 1/4] hung_task: Move hung_task sysctl interface to
 hung_task_sysctl.c
Message-ID: <202005150103.6DD6F07@keescook>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-2-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589517224-123928-2-git-send-email-nixiaoming@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 12:33:41PM +0800, Xiaoming Ni wrote:
> Move hung_task sysctl interface to hung_task_sysctl.c.
> Use register_sysctl() to register the sysctl interface to avoid
> merge conflicts when different features modify sysctl.c at the same time.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> ---
>  include/linux/sched/sysctl.h |  8 +----
>  kernel/Makefile              |  4 ++-
>  kernel/hung_task.c           |  6 ++--
>  kernel/hung_task.h           | 21 ++++++++++++
>  kernel/hung_task_sysctl.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++

Why a separate file? That ends up needing changes to Makefile, the
creation of a new header file, etc. Why not just put it all into
hung_task.c directly?

-Kees

-- 
Kees Cook
