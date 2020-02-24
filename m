Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA1DC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F97220732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWpye4I3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgBXKvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:51:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46516 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgBXKvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:51:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id g4so3457399wro.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 02:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kRZXlrxsXiUp76pJUg1A1idTwmDFL/za+p20Iqq28LA=;
        b=aWpye4I3V+5CEJjrj2uJR2xdbJS/+LF+RYdn4SVnfHM9zW4soJtQ4DDCMlq2w8ovK0
         Ne7XZTqiG87ZTLAd16bMV86ij+XfEGZ9bdyoAhvgJQmUWZONyDwo+FuC6jAI0Ev9yd3w
         iLQJ+n9OeXvD6/P3xfk9GVRurzCDqhcs62ad6RhI2qMZJPfjl7S5ZRZwSgDk/E1Xp5GG
         P03a78iPpoFRBGzbWcA/a+oiLtSnw7+gJtTsRPT9MU8MxiMQR4i1kXwBgIz3piUYxLR8
         zpA90VETnE0sbGG7q1y46Xa6FF20y4h8NEvoWw5EruFK+LE9cXNWHD9EjMBkecD4FZFm
         MpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kRZXlrxsXiUp76pJUg1A1idTwmDFL/za+p20Iqq28LA=;
        b=R1y3oqH7ivtcy9mU8GN9/jbxDpcH3aM/42EeMFG/wjtptqS8mWfWq8yecmhSa9PpNU
         5Al8+dEC05KMt7/M4rRlkF2T31zQR6aLJBGVI1zHh65ahxCThsFsUplhwDwvCDASc+Zn
         DVQRxTY4o+m1PSoY/k76r7l95Ps3D5TRG42Z0cCOD+LCF7uSZGjfxzQ9PD+j/n0uMT0d
         oVhLpa2Q0/W4z+JIcwsBq2ZeJ16POBC/OvsBRZCX/juauWypzz+FLmnmKC+8WgUSq9Yd
         DHbd9kJq/6cdpZ2x3SjucAUcAlR7WnmO5+fLFcxrAPeUfgEXmEws6hvGQgee9sBKEVLR
         k+KQ==
X-Gm-Message-State: APjAAAUW+YclmnxtMpgL2HcKJK8eUnEjvG0QtQevemCUjep9fu9e8GWt
        JKxDq30XCfWtI/UGDZxGqFQ6avXPMQs=
X-Google-Smtp-Source: APXvYqxrdCUTNHecQ/lWt1/A5Ue3ifumWztPy7Ua4Idfks8Z+yOSveQHA4M4xhgaYqjMo1tm6Jnzig==
X-Received: by 2002:adf:a19c:: with SMTP id u28mr65545868wru.221.1582541464079;
        Mon, 24 Feb 2020 02:51:04 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id w19sm16854001wmc.22.2020.02.24.02.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 02:51:03 -0800 (PST)
Date:   Mon, 24 Feb 2020 10:51:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: Kconfig: Fix some typo
Message-ID: <20200224105134.GQ3494@dell>
References: <20200216113242.20268-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200216113242.20268-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2020, Christophe JAILLET wrote:

> Fix several variations of typo around functionality.ies
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/mfd/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
