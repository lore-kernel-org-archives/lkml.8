Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D237C35247
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21602168B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ry6MxWHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgA0J2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:28:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38039 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgA0J2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:28:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so1269483wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 01:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0rrhtVNAh9PShHy/q9Ma9GVW1EfhEw69zS9XJ919ql0=;
        b=Ry6MxWHzMuizNcrIXmJ+ILo+Ug7WUFj2cdd4Eac/fjorUhjJ2vLe5BblmPQiY93Ojy
         ZalxLlJsMUzY5eE/JWqQaa48yat6sljaz/LQePrn8lUkDLo0e4xb0Yhfnsyi3I3dp1Xm
         VXoU8+gImAEfDIYfovlDVgbs9va2kmsp5dOpps8YcCCzJruwdjxY0jNi7Z//uCkt4mNs
         7QP/OTgqbl+7t2XJUf0KNj7wII9CH/3zuP7oS0U6piojruWjHIY2LdXiQ2ROqb1A8GCz
         TYOOrRYslFYNPP27XVVKnsYZ5MirgESSHJvSmm0OYpM0Icbc+1htpRyckYSlwJtShVtE
         AT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0rrhtVNAh9PShHy/q9Ma9GVW1EfhEw69zS9XJ919ql0=;
        b=ElJT0gEh5uzA76EK6ER2f5ZsWHv3Vj4PW54+mnSmmdP4YdMX3chpRy26yyhYezmOpv
         4ETJFX5R/b/9+2MBly+6lAQqIuAB1kVCIRucl/8N0isbp98cXi7+QqydoNDC1uIRg7kP
         tY6O0zvURAKNM2cCsFaLODNCbi9ddDNTlri9TKcoiyku1IE5pXgg3m9IXqvcS2ZhJvOX
         kBGvMr9Pimf9hXeOraAJF8mufcXKTHhkUZh3OK3FJHn1DfdWdRpHD5CWPH/lUYUfK4Cd
         yB5ikwObxVLxfEgL7JZJ3T3UgS1awq9bnkkTobnFe5WAxs1GIIJpnOrD6KVnFTt/ffC0
         HheA==
X-Gm-Message-State: APjAAAU9r61qoa+ajQQ9/e3wT+jPNSPtbGgdz5UtQ2Pv4mSbXm3kZMuL
        W9HrdNs/4oUl64FFOMxpW6nJnw==
X-Google-Smtp-Source: APXvYqzNHfraG8VHB52d4ZUiAtnUfeH8L+HhvLAOE6hLMkT3axNMdPiY+28wttfTyIVlaLSDOucCtQ==
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr12654838wmg.34.1580117283232;
        Mon, 27 Jan 2020 01:28:03 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id d14sm21424165wru.9.2020.01.27.01.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 01:28:02 -0800 (PST)
Date:   Mon, 27 Jan 2020 09:28:15 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, b.galvani@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org
Subject: Re: [PATCH 2/5] mfd: rn5t618: add ADC subdevice for RC5T619
Message-ID: <20200127092815.GA3548@dell>
References: <20200117215926.15194-1-andreas@kemnade.info>
 <20200117215926.15194-3-andreas@kemnade.info>
 <20200120084934.GZ15507@dell>
 <20200124162818.0697f551@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200124162818.0697f551@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020, Andreas Kemnade wrote:
> hmm, I cannot find this in any branch/repo I know of and not in linux-next,
> just wondering...
> I guess the iio part is something to go towards 5.7 unless 5.5
> is delayed mucch.

Oh, it looks like there was a conflict.  Could you collect any Acks
(including mine) rebase and resend please?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
