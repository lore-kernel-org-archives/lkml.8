Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F81C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1EE2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590679085;
	bh=feCslDXnfABS0LMJgJkW1Cuz0T3bqAdIXOmhQSI78Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FlB2HB0YuW5thCnBxWTsbM2/z5RZUXUIHZEYXaqYZPMi+r4rqr3IDfzup5PiskQ3C
	 qtFN+UQgv9JFvPZ7xznReFyropj21wGuccinufyR8cVdqB+WiU7OJJcDFxk3yAhIei
	 tGBxrrCjTf7WTSK8rdcI4okPPCJQnjGNRhVcHSz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404172AbgE1PSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:18:04 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39661 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403988AbgE1PSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:18:02 -0400
Received: by mail-il1-f195.google.com with SMTP id c20so490596ilk.6;
        Thu, 28 May 2020 08:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W7JmnXWUA2/w+QHNp/eqEXBvmT29Vv/u+hNrqukjKRk=;
        b=PdLYU4KF3vk/uK/91E0dqxZGbnl5+ijaUl1RIydfoW+VaieP47YZuhppMf3XOEU26w
         n/IcVZ67+5t0gl9e/o23vhij7qw3bNUTSkO13PRcm/38sHfSvW3W9zQyzZ5LucTrgjvR
         v5WrZDvIK1rJtqBok2Bm2vqMrBABpIrno++ILfXgO6Gk3SPu6ffCvFwJJTY0TLKnLs2a
         nQrFiSzSIm4RFQTHYwmpWV9gFkCmwJ1jq1LBMicYe052+ZPdDjVkWx61fsbpVacwuI0I
         b6XcmtdG00VjjLwZTOcLVWUPBrWb+oEpYJFEaMndx6JIngHzrRfXdxMCgDao7VBJWf8p
         k5cw==
X-Gm-Message-State: AOAM532sshpvdnZREpuRHm8ON/7ukkuXK0SY5X+D0cYrw+fMokBnNOf0
        9tOVlEHfIQzBRLI6iY4CHA==
X-Google-Smtp-Source: ABdhPJy17QiQkvGntGRPHg1QXf6YjP6QEce0EoeS5H/2FJ/lRag/QSP6MsKOWiaBQklm+VwqeLG28w==
X-Received: by 2002:a92:c88b:: with SMTP id w11mr3179656ilo.244.1590679081204;
        Thu, 28 May 2020 08:18:01 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id o12sm2612140iob.6.2020.05.28.08.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:18:00 -0700 (PDT)
Received: (nullmailer pid 91846 invoked by uid 1000);
        Thu, 28 May 2020 15:17:59 -0000
Date:   Thu, 28 May 2020 09:17:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        Linux-imx@nxp.com, u.kleine-koenig@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: Convert mxs pwm to json-schema
Message-ID: <20200528151759.GA91686@bogus>
References: <1589456470-2658-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589456470-2658-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 19:41:10 +0800, Anson Huang wrote:
> Convert the mxs pwm binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/pwm/mxs-pwm.txt  | 17 ---------
>  Documentation/devicetree/bindings/pwm/mxs-pwm.yaml | 43 ++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/mxs-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
> 

Applied, thanks!
