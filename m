Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF340C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 02:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE9A206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 02:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vq/A/08d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgEQCoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 22:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgEQCob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 22:44:31 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401E2C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 19:44:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n11so2979842pgl.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 19:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uq35MuQh3BQE+DEOjJ7MGVBKpzrL1FTb+VJBwvU0AHk=;
        b=Vq/A/08d+NZoCgyOliCZLorADWTSYNvj6xapzwZHoaC6teYOP2FUgFGAwp5kRgXP2U
         WebvMdP05Dt0Wf7N0hXDc6ZKwwhmU09sLVqoQVqPMpBWnfO2K/RTcxN3/czYC+W7b4cf
         ar7NC7/fE6rN9MVdNtAyE95jwARW0VlxM+x1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uq35MuQh3BQE+DEOjJ7MGVBKpzrL1FTb+VJBwvU0AHk=;
        b=e8DJTXEXuL68Nr1dauDb61P9IGEvcOYDVpAhSsfWWxEEVSEEFMoByd/RdN5dRWboDB
         s5tCcxH5FeryZvBXtzhwPlQ3uaXBf36NFiFrrFSM3M0rwiMNQziasf5s8pAT0206IwRH
         W5imytyrClOVtMBWtU1lDL11Zl5E9PQThiXgU4fnbZINTbwkURXwp26jVUZDk2RVkatA
         eVWYynoPcUaBnhA7Zq7VaGg0TuTDrMgkyUaHlYSyuiRJ5LjGKDF8PinYhErIW6kqT2OJ
         2bYPbA94c7+P0PePwosTBQWPsRmZta77P5KVBvWgL/VkjiySMKNwxA2f1qSrLihyJIsW
         TGng==
X-Gm-Message-State: AOAM533XpOMtBaSHBg96qDqMSg2W6cXfh+uY/I4olS4E9qllKOC//jVk
        yB9Ddz7Cw5z2h6kq2wRHkTWDsk3oP1g=
X-Google-Smtp-Source: ABdhPJy3BU6dz6uT5khRoyvolBvyM5FsmNt5nbdXI6CfaDE94Hq4l+4J14lStQnkWTOViSRy0+5V0g==
X-Received: by 2002:aa7:8ad6:: with SMTP id b22mr6394643pfd.251.1589683469828;
        Sat, 16 May 2020 19:44:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x13sm5153898pfn.200.2020.05.16.19.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 19:44:29 -0700 (PDT)
Date:   Sat, 16 May 2020 19:44:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        peterz@infradead.org, mingo@kernel.org, patrick.bellasi@arm.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        Jisheng.Zhang@synaptics.com, bigeasy@linutronix.de,
        pmladek@suse.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        wangle6@huawei.com
Subject: Re: [PATCH v2 1/4] sysctl: Add register_sysctl_init() interface
Message-ID: <202005161944.CD304B5@keescook>
References: <1589619315-65827-1-git-send-email-nixiaoming@huawei.com>
 <1589619315-65827-2-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589619315-65827-2-git-send-email-nixiaoming@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 04:55:12PM +0800, Xiaoming Ni wrote:
> In order to eliminate the duplicate code for registering the sysctl
> interface during the initialization of each feature, add the
> register_sysctl_init() interface
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
