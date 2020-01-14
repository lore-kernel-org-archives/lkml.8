Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6276AC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379D020678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaQmMXSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgANPG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:06:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36166 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANPG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:06:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so12519392wru.3;
        Tue, 14 Jan 2020 07:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1LO+o2liqei6dOj4tGd2yyWf59KLYzNggmwA3IlFMvg=;
        b=VaQmMXSeGJjA5ZfjvqpKmYtlwdf6Euog7KwKOqwpaKdNgl4qxhZXUDWxgZhFeFlh76
         6XbwBqkhmlDlNq2FO02wfrvLWEMGnaM6A6YXiAcbih9JmaDpUH5q3hQIMJKOiTQbR5Dx
         J1731CLg0tfFTJ+0+9VJScXTx1MgwbOceUGEp6OnNe3nPpF9wwz6EiWfb/UdtLxYEiK1
         DB+YTkj0oROCBXEVcnx6a9wf9gH4k2tutyDO30MsYlcLpJeiSNHjUze8eXOy1013k6VZ
         pBQ/JTuJw6E4GTo32rxtvMFMGnURC1/azsNspW7lAMUiTBCZOl3I2aP27XWxBWGS+wG4
         3eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1LO+o2liqei6dOj4tGd2yyWf59KLYzNggmwA3IlFMvg=;
        b=Od+V0Tcf3iBXY0Z9gLPwwwIS0GmQsH7lNA1XyhEMC1pSdNmdQhIaljHvOAYJFWX3sC
         EdPGI8/Gnxb7MhTjACTynjxIaaoVWUh3LJnLRm1Qzjr3kD8NBlzRB2FuRGk3IHuCsgiI
         yk776SIugdR+2mtdyUlrAuYbai7nFo7r+rK2XUX5yQiQk6sO3WS35zL4IekOPti536YR
         Cge7zvXIifqQvTY6K3PfCq0M+AqWboNK+7qBv/QV7QhA3dLIvNdUGGDcq5eBpqNh8TFk
         MmHswhCx/793MuDMQPcr950KONHtZ5AcgNae1rfxCegWrcryjSJnwlltWe4c6hWU2/S9
         d5vQ==
X-Gm-Message-State: APjAAAXBqZyg2hCTLMnhR3sYRBEx4hZlutZPzZsWVOLkMkf5bG889J59
        hEXot4vauaTS3bJO00lPkVM=
X-Google-Smtp-Source: APXvYqzVuGEDmJd7nEVOmzbMFhwmZKqUffjufxViIM3/GgxAoq/HIv3D0/dxucVGqCV5re3Nn97LVg==
X-Received: by 2002:adf:f606:: with SMTP id t6mr24938904wrp.85.1579014415886;
        Tue, 14 Jan 2020 07:06:55 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id c17sm19929654wrr.87.2020.01.14.07.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:06:54 -0800 (PST)
Date:   Tue, 14 Jan 2020 16:06:52 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: sun8i: a83t: Fix incorrect clk and reset
 macros for EMAC device
Message-ID: <20200114150652.GA32269@Red>
References: <20200114094252.8908-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114094252.8908-1-wens@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 05:42:52PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> When the raw numbers used for clk and reset indices in the EMAC device
> node were converted to the new macros, the order of the clk and reset
> properties was overlooked, and thus the incorrect macros were used.
> This results in the EMAC being non-responsive, as well as an oops due
> to incorrect usage of the reset control.
> 
> Correct the macro types, and also reorder the clk and reset properties
> to match all the other device nodes.
> 
> Fixes: 765866edb16a ("ARM: dts: sunxi: Use macros for references to CCU clocks")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> Error on my part. Hope no one was affected for too long.
> 

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>

I saw this today and with this patch the board is back normal.

Thanks
