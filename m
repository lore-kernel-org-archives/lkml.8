Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1E2C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A6020663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9iOaC9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgCLNMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:12:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35489 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgCLNMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:12:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7so3076251pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q6Q6VQm5erA6yCp5PM0NMfLn+9SyOR16cH0hI7kuurI=;
        b=A9iOaC9a829BBVLJRhs5ZhCKqDx4h7XhwzWfGolJmIhPVZUbocE8lGSqKlG54mYrQE
         Mf+QMbXMWrYkKXgh6r+JiZIgxCqtRt6uzNzULANRNFlkTdDP1UiL380jfjjEkiKRW+cz
         PpjQxVtn+E/uZdNUYgFwDRPtGPUAoITwBZ5oKT3z9KdISx7XWC5vEPk5Zo5M/MGSXYFC
         d5lhYhKBAiOqF6dB2oX0mzSfoDbjyywi4ouCKE8P0969hP2W5xKwzuNC0+tuWS1eQtrY
         aGn+YcUVz+gNv392enyhcRXAoSRNI9gsNx/kWQqrsVMtFbaySCgVt2I76R2Daco3JbC0
         Mwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q6Q6VQm5erA6yCp5PM0NMfLn+9SyOR16cH0hI7kuurI=;
        b=IL45AG/vm+1OiN8l6hl9G0xXLbQ5kHOQ5TztVSESEES9dXn8FrQ7eqG+2aLNJQ9G/i
         l10RTOf3V9gyM/qUcXTw1zWoqP5Am765VdhSSk+YPwwxa6iv5RTIJoUbg9INe9pFtQ6Q
         uDpeVMQKTqA5LC1PN9DTR4CSMDRg/w/Y+uB9nvelyHqrHsVNDy+kW8apY3TunBcXFPwd
         DsK9lD8dHgkSWHId8TPAUC0I48BmmVKDhL9pS2h7t47Fn7cxTeJxi7zHWjtwNzS+OzCj
         Jn0mN7hf1c74LjrFE02sZkggYvHqlniZ0KYT/BSg+TlUeVPKg4qhogca/VpGj0Xr6/Gr
         0Fmg==
X-Gm-Message-State: ANhLgQ1c3QRhv9IZ3SXpxTGhXJgCT9+4QhmpiPyX0nUkZx/jhRT7QZXs
        3apOZ+PuJwIWSf/nHDQgUYE=
X-Google-Smtp-Source: ADFU+vvuOO0DOpX+8j5S4B2tzl8ZCqQc4niQjBgKy3UKNtsJMqVtvxsPp1+LXgiCC7ggpJknWVjAdw==
X-Received: by 2002:a63:a746:: with SMTP id w6mr7157862pgo.76.1584018753787;
        Thu, 12 Mar 2020 06:12:33 -0700 (PDT)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id 135sm4447265pfu.207.2020.03.12.06.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Mar 2020 06:12:33 -0700 (PDT)
Date:   Thu, 12 Mar 2020 18:42:30 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: footbridge: replace setup_irq() by request_irq()
Message-ID: <20200312131230.GA7618@afzalpc>
References: <20200301122131.3902-1-afzal.mohd.ma@gmail.com>
 <20200312123432.GZ25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312123432.GZ25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Thu, Mar 12, 2020 at 12:34:32PM +0000, Russell King - ARM Linux admin wrote:

> This patch causes a build warning:

> Hence, I'm dropping this patch.
> 
> I think you need to look more carefully at the code you are modifying,
> and maybe even build test it.  Cross compilers are available from
> kernel.org.

Sorry for the sloppy approach.

i build & boot tested only using ARM multi_v7_defconfig which was
building only few of my changes, i had the cross compiler. i was trying
to rely on kbuild test robot for the other configs earlier, from the
begining instead i should have made sure that each modified code builds
w/o warning.

i am fixing it.

Regards
afzal
