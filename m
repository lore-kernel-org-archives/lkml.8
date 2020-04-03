Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC81C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1862082F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585874421;
	bh=RJce0s6KlQxC6h2IiRV5aBM1cXm1VT+Q7PowoQ15MOs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hdfhbFYUmrNhqkUz6Wyg9qY+/GhL4pAav3O7DXJ1MOuRK6YtuMHIqvSO2+0cFX2WG
	 WwwL52e0+fVxgYYSuyj8Xkqe41HP29EUMnW5fGX3Uzf17W/3GRQRGR0aArHkrc8d4Q
	 P4iYqrBWzhgEJtt5OLcXk/BhTPXepRNMr6CbO650=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390451AbgDCAkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 20:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390424AbgDCAkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 20:40:17 -0400
Subject: Re: [GIT PULL] bulk pin control changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585874416;
        bh=RJce0s6KlQxC6h2IiRV5aBM1cXm1VT+Q7PowoQ15MOs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=E6J3qhLObgi1ja0yD12gYQZ285IiQ46jui+rgf44taoT37TNMf66pLQl6Z55V11DP
         yTZoqNFXfAtDQl2/W7hNDNTnu1pZoH5RMvO892yMFfv3Ld3y8CEYk5Fg9csPLgqcpa
         /cOJ4pyPVgGASrV182NNVPBCfGuB75LVYf/MQMDU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdbO2JBTtU-XTWzfzTkFD_x7EiPqQ-VraPcYJA7_6U-mvA@mail.gmail.com>
References: <CACRpkdbO2JBTtU-XTWzfzTkFD_x7EiPqQ-VraPcYJA7_6U-mvA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdbO2JBTtU-XTWzfzTkFD_x7EiPqQ-VraPcYJA7_6U-mvA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 tags/pinctrl-v5.7-1
X-PR-Tracked-Commit-Id: c42f69b4207e104229242c3d9da43b55d4b95d6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc3b3f4bfbded031a11c4284106adddbfacd05bb
Message-Id: <158587441692.31624.3105665865723969608.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 00:40:16 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Apr 2020 09:38:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc3b3f4bfbded031a11c4284106adddbfacd05bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
