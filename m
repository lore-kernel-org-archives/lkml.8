Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C037C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD40920769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589330400;
	bh=ZZONM3MfRLLy5PBXoTvEVButOoff7+dF22ALFXdLt2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wlupvte3BKVKYR+yNXX+RP+20yGmUnZRZwwyzvXzkP+u4w5YgNWTH/u7IBFGJpo98
	 MchvjC0HrpBdPL1myQGYss1DU681rdXNgGy+ix6O8e4e51fPEJR9Ul/OaIkf7rpcQt
	 qNIE/V/kV64wVo6SUpzu/eEOoLIpmME9HRbWLHwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbgEMAj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 20:39:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38514 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731946AbgEMAjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 20:39:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id m7so6132474plt.5;
        Tue, 12 May 2020 17:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uFKqSypxRhLNaszQ9FU/hBZK81MFbv8LrHsXvYdnkac=;
        b=ZVrDbV9qgKnN9gGLjhFInOMSdohdaRKyVB77Y4evG8EWZu0shRcJgpdEp7QfqutPXR
         8ZBfZawSLOABG+DfMUayCADnV+CoSQLc2XB8Tmvb01oMeQOj1hpvC1LhCJSdzV3cHXgT
         gdAQHC5auyQNhfCWSUyzhT0G3Msq+T9Yjqnt9fwXLww3PzZKV5BS8vzsELMT0CxQnBU0
         zf8gMOXRZdnrNn8B3ejlPOjLSfNKRxs4KWyJzqfJgsJVL5iYMW9hlBarAWr9suDi282x
         KXvBWPnLHnWwcBPaa+Z6qi6d5WsPp35CXwBgdwvUdAlnCfqB4KvcpOE8DXwvvGvTycDr
         wz3g==
X-Gm-Message-State: AGi0Puba5MOjRpgUlYmyVH26OvXVnLZbmLlO4Pqpl82Rur0LqKvPbhwL
        m4yIcdvN/jJ7v96K1FXO9DQ=
X-Google-Smtp-Source: APiQypJr5rRSiDKwiSO/nto67eapmrLp4s/LDV8LT/NHSh6XPftTcm8GM6AQNahRp6cm0AhcCcYHqA==
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr29078872pjq.184.1589330394632;
        Tue, 12 May 2020 17:39:54 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h31sm14142647pjb.33.2020.05.12.17.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 17:39:53 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0F22C4063E; Wed, 13 May 2020 00:39:53 +0000 (UTC)
Date:   Wed, 13 May 2020 00:39:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        yzaikin@google.com, tytso@mit.edu
Subject: Re: [PATCH v2] kernel: sysctl: ignore out-of-range taint bits
 introduced via kernel.tainted
Message-ID: <20200513003953.GK11244@42.do-not-panic.com>
References: <20200512223946.888020-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512223946.888020-1-aquini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 06:39:46PM -0400, Rafael Aquini wrote:
> Users with SYS_ADMIN capability can add arbitrary taint flags
> to the running kernel by writing to /proc/sys/kernel/tainted
> or issuing the command 'sysctl -w kernel.tainted=...'.
> These interface, however, are open for any integer value
> and this might an invalid set of flags being committed to
> the tainted_mask bitset.
> 
> This patch introduces a simple way for proc_taint() to ignore
> any eventual invalid bit coming from the user input before
> committing those bits to the kernel tainted_mask.
> 
> Signed-off-by: Rafael Aquini <aquini@redhat.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
