Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C958BC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A593217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hz5GhptL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbgBNVwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:52:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgBNVwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=JDqW3+yJAM9jVR7Ghm5MrosXfPSkCVIcccbCU9OgNXc=; b=hz5GhptLfsT+0yQU9qc0ZIxHtb
        aSizTtgJ5Z2czFoJXkhOTyQ/H4oNTOeElCde2XyE/U1cnz6xFVxy33Q1N2p9GHvbhWpLCcfToitx2
        JNAMNKVezqs8ZKppXVRfnx6kPT1/6lBE6nQ8oPMK+rYOY9BuG/DDc+OOGeNMT8t64SvDfi6uzpg/j
        2HciwNER8HTmH7kjh7JLKzpKVeUvPAj5JbhLmKFZUXiQjYrpJY6tGl76bLD//pJpeGNeaiSYGpgg0
        +LFghr9HL0uU2ZvdVjO7dAp+3hz8sZbzhVKk2HJF0YPcMLsEyvAxvnZvhFww+4dWXxz+MToYmbPNX
        unx3dgyw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2ish-0007s9-03; Fri, 14 Feb 2020 21:52:15 +0000
Subject: Re: [PATCH] pinctrl: ingenic: Make unreachable path more robust
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <73f0c9915473d9e4b3681fb5cc55144291a43192.1581698101.git.jpoimboe@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4fe47436-85b1-ff2e-6247-c8c599fe1dd3@infradead.org>
Date:   Fri, 14 Feb 2020 13:52:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <73f0c9915473d9e4b3681fb5cc55144291a43192.1581698101.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/20 8:37 AM, Josh Poimboeuf wrote:
> In the second loop of ingenic_pinconf_set(), it annotates the switch
> default case as unreachable().  The annotation is technically correct,
> because that same case would have resulted in an early return in the
> previous loop.
> 
> However, if a bug were to get introduced later, for example if an
> additional case were added to the first loop without adjusting the
> second loop, it would result in nasty undefined behavior: most likely
> the function's generated code would fall through to the next function.
> 
> Another issue is that, while objtool normally understands unreachable()
> annotations, there's one special case where it doesn't: when the
> annotation occurs immediately after a 'ret' instruction.  That happens
> to be the case here because unreachable() is immediately before the
> return.
> 
> So change the unreachable() to BUG() so that the unreachable code, if
> ever executed, would panic instead of introducing undefined behavior.
> This also makes objtool happy.
> 
> This fixes the following objtool warning:
> 
>   drivers/pinctrl/pinctrl-ingenic.o: warning: objtool: ingenic_pinconf_set() falls through to next function ingenic_pinconf_group_set()
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/pinctrl/pinctrl-ingenic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
> index 96f04d121ebd..6b61ac6cd4d2 100644
> --- a/drivers/pinctrl/pinctrl-ingenic.c
> +++ b/drivers/pinctrl/pinctrl-ingenic.c
> @@ -2158,7 +2158,7 @@ static int ingenic_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>  			break;
>  
>  		default:
> -			unreachable();
> +			BUG();
>  		}
>  	}
>  
> 

-- 
~Randy

