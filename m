Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D60C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273D62072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7jv4l+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCEPwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:52:42 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35088 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgCEPwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:52:41 -0500
Received: by mail-pj1-f65.google.com with SMTP id s8so2701695pjq.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 07:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6f/ifzGRwDmJk/xhVW7g/o8n4zzlT5iV8pc0ZDfsM68=;
        b=N7jv4l+X0swqok91/RGX+4fn2Do/MFOk3yOT9u6oNCzoFu8gnkQzgl8LGgbPlxBYLK
         cOwngB7GUkWkY6RtvqtziSCtOnX5VqDg6y0bPx9RyxYcdCwVhIGggSlLYA78QTg1WzlH
         x6uJw0DKbNbEey5SpQqWUORZPnnvQudx/aCsO/6WlSZqoXzT/E6RvIdaiOPzDS2U/u5C
         1GZGqO/cg2pt+0e79GvrDKshtduCmL+jvwxvh9bpVZqFbby9OL03aLyGb3rdsmyAQvuC
         irovQXZU9IDnLUPN15P1lSMWEeWmOR5XCM2IAEIqzMPbtNd8WWV3mroNUxaP5Rf1MQ33
         xCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6f/ifzGRwDmJk/xhVW7g/o8n4zzlT5iV8pc0ZDfsM68=;
        b=guXAQjIh6FTHI3ukM40dQrATPNXy+CoCKRW9HW2MBpilUFiWOs0jBaHg3KKXCnQY9c
         O4RugKo1T/6wG/LEazPZyeVRJKFa06ilowCZrUXHmaaiVYUb0TJNk6NxgP+ROazBpnhq
         SuLESvcuzsX7mYRzX5+B9RRM+uw1LlFH+yuSIoQ32LpdQ4ZfX0gwySYK482e2cZdI599
         Kk72aEhW5Bkoyez12oOQvEx4Brxjqpcgvr4g8BKd+3/ULl2Ia97dgHY6CplJfFIyqy2M
         HHbVnW/fNaBCzlgSNRg0fT+gQz2H3r+gXxmhm8IBCBWnfMBugJxcGDJlwZpKd5OrETL/
         mfBw==
X-Gm-Message-State: ANhLgQ0TYcmhPaCB+vPHUw99kBbG93YsC7ZUgC7eSpdI9dTw+jQjS65F
        fCQLGMvqmOo08MX65I/LogY=
X-Google-Smtp-Source: ADFU+vtuhkZgtjxWpOLlgLP5MAaK/Ag8e47IooOM6ZvoEXV0CEuz6M8yHO7S7p/USRv4bu8y0Xh6jQ==
X-Received: by 2002:a17:90b:3551:: with SMTP id lt17mr9186707pjb.135.1583423560594;
        Thu, 05 Mar 2020 07:52:40 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x70sm23598861pgd.37.2020.03.05.07.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Mar 2020 07:52:39 -0800 (PST)
Date:   Thu, 5 Mar 2020 07:52:38 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     madhuparnabhowmik10@gmail.com
Cc:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        Amol Grover <frextrite@gmail.com>
Subject: Re: [PATCH] Default enable RCU list lockdep debugging with PROVE_RCU
Message-ID: <20200305155238.GA8669@roeck-us.net>
References: <20200228092451.10455-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228092451.10455-1-madhuparnabhowmik10@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 02:54:51PM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> This patch default enables CONFIG_PROVE_RCU_LIST option with
> CONFIG_PROVE_RCU for RCU list lockdep debugging.
> 
> With this change, RCU list lockdep debugging will be default
> enabled in CONFIG_PROVE_RCU=y kernels.
> 
> Most of the RCU users (in core kernel/, drivers/, and net/
> subsystem) have already been modified to include lockdep
> expressions hence RCU list debugging can be enabled by
> default.
> 
> However, there are still chances of enountering
> false-positive lockdep splats because not everything is converted,
> in case RCU list primitives are used in non-RCU read-side critical
> section but under the protection of a lock. It would be okay to
> have a few false-positives, as long as bugs are identified, since this
> patch only affects debugging kernels.
> 
> Co-developed-by: Amol Grover <frextrite@gmail.com>
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Who is going to fix the fallout ?

fs/btrfs/block-group.c:2011 RCU-list traversed in non-reader section!!
kernel/kprobes.c:329 RCU-list traversed in non-reader section!!
net/ipv4/ipmr.c:136 RCU-list traversed in non-reader section!!

This is just from my boot tests. I'll keep PROVE_RCU enabled for the
time being, but unless the noise is addressed I'll have to disable it
because otherwise the real problems disappear in the noise.

Guenter
