Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBA8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA462074B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590706369;
	bh=Ci5Q9Rz1oBZG4KK23knviog2z7Dbw0z2Q0/7CIJpeMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e+BhReVh2V4wGUMmB8DPsmfrfi6moW8n0VofCz07dOk3z+GOXSmFejk6rnrtOXAlp
	 +Ev/mY2wrPCshRFQd3MJ16FE/p5rwEYHA7ETPcPgWL/vS/qBojU1mHS8KHca/TQg7e
	 F21st6g6i1r3tytHGwx17P1ERmsB7YQEk9YBz+OM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437313AbgE1Wws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:52:48 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37991 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437268AbgE1Wwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:52:47 -0400
Received: by mail-il1-f196.google.com with SMTP id q18so640223ilm.5;
        Thu, 28 May 2020 15:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0vhQp9XNZNfZUF651FAD7AKZcJtfFmbMwFLrNqs62EI=;
        b=U1S3miAEvCIJT0Du4xWtkhwP8n1lXdu/mOvFp+q+74TYHFdt+HmwopgaEor68hVlF1
         LOmQQPkikBxgb5AkNb/qlXhBvrgH1okhl7lwcudA0Cxz5/0/DXsgQKxtl8RnI8QUyUay
         uo29qG1b4SNfzfhNLFebfoZafaS2DP+Z05d4ChCCntYBznE3Ipxs68c5dRpQ+Y9X8tKI
         uLsdnhJeF1Vh8uIMAp7J9bcRClhii6gmmi3NR2ahxUtmGtdT8Gel1OU2Bq8THEONmdiL
         p9q0A5K+BfW+eRSrWuBwMMGl3ZOLNawYnT4/+dQOjLXMkmaA5n5tBeVQvZLSlL7sXePZ
         tDRQ==
X-Gm-Message-State: AOAM530JOBeDHJgeTs6YKIoNSQhjBs3GA71h2BUyyYU4nZeUsDSfWnFG
        +R3A7T2QxWUTnX46sAJguQ==
X-Google-Smtp-Source: ABdhPJxfyyr0KlQzRC18dEL6/3PLPwBdp8yogKP7UhKR3e9n5p0nKXKeN/j2owSpSRZWGV9PJz9CoQ==
X-Received: by 2002:a05:6e02:11a5:: with SMTP id 5mr5080394ilj.108.1590706366514;
        Thu, 28 May 2020 15:52:46 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w29sm2074753ila.26.2020.05.28.15.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:52:45 -0700 (PDT)
Received: (nullmailer pid 827788 invoked by uid 1000);
        Thu, 28 May 2020 22:52:44 -0000
Date:   Thu, 28 May 2020 16:52:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] DT: Improve validation for Marvell SoCs
Message-ID: <20200528225244.GA815881@bogus>
References: <20200521091356.2211020-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521091356.2211020-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 11:13:47AM +0200, Lubomir Rintel wrote:
> Hi,
> 
> chained to this message is a second version of remaining patches from the
> first spin of the "DT: Improve validation for Marvell SoCs" [1] patch set.
> 
> [1] https://lore.kernel.org/lkml/20200317093922.20785-1-lkundrak@v3.sk/
> 
> I've attempted to address the review of the v1, each patch includes a
> detailed change log.
> 
> Compared to v1, wherever the license or maintainer information was
> missing, I've filled in GPL-2.0-only and people listed in MAINTAINERS
> file. As I've indicated in v1 cover letter, am not sure whether this is
> the optimal course of action. However I've included the relevant people
> in v1 Cc list and asked for clarifications, but didn't really get any
> feedback to that.

Find someone that would care if the bindings are deleted. I'm fine 
if you put yourself. Maybe subsystem maintainers are willing to take 
orphans. I really only want my name on common things.

Rob
