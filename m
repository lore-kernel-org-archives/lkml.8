Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF5BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44CB22075B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PVvSSiry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgHQNBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgHQNBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:01:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCE3C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 06:01:35 -0700 (PDT)
Received: from zn.tnic (p200300ec2f26be0031a8dd4880ed200b.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:31a8:dd48:80ed:200b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5BCA1EC0330;
        Mon, 17 Aug 2020 15:01:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597669292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tLOg+qGvJJcBv2b5B817+87cewFZk0KCe49pFMIgwkA=;
        b=PVvSSiryHsqgHTC0dZNZ5d2VyarVkqQmXbRdlQE/hugA5kVpjEeHHvrYoA1jEqngPIg5FJ
        lZOmEw1sjMuTO2GtqSX29B004uABNFJx6ZVy7ENOfCx1ke2RhRrmxUKgvJ/MbGbk6yHQbF
        jbjR7RZop6Cys6qYrlpkkD+F0frAGaI=
Date:   Mon, 17 Aug 2020 15:02:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Gustavo A. R. Silva" <kernel.org@embeddedor>
Subject: Re: [PATCH] x86: Use fallthrough pseudo-keyword
Message-ID: <20200817130227.GI549@zn.tnic>
References: <20200707200303.GA4680@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200707200303.GA4680@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 03:03:03PM -0500, Gustavo A. R. Silva wrote:
> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> fall-through markings when it is the case.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

...

> @@ -362,7 +361,6 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
>  		case INAT_SEG_REG_GS:
>  			return vm86regs->gs;
>  		case INAT_SEG_REG_IGNORE:
> -			/* fall through */
>  		default:
>  			return -EINVAL;
>  		}
> @@ -386,7 +384,6 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
>  		 */
>  		return get_user_gs(regs);
>  	case INAT_SEG_REG_IGNORE:
> -		/* fall through */
>  	default:
>  		return -EINVAL;
>  	}

What's the logic for those two to not get a fallthrough; marker?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
