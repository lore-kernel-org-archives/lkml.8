Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18F8C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 14:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E3B2084E
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 14:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHnfyxUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgCHOxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 10:53:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40342 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCHOxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 10:53:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id y1so2941232plp.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0YgvG98+C7Hv1PiMeKbN/HzqGCFiqwzwYpuxu1hQ9Ds=;
        b=lHnfyxUPw8qagDvATBpNEN6eytsonnCFStS1tOUBAvZE8bP6n4jKSRSnWmEQj8phF0
         BGkYZCWz9micqXeDaofS4Rf0bNCU3YY82TXv/tVRGsfOChDch2y9awmhyMnONb9xVLfY
         7f2qBiuQw1kHa0ma2cDvMnfdDB9k77G6+y8ZX0y8qtpqyKk7nGLN5RRHCEI6c9cDv97r
         LnHtmkvsk8obp0aKeIZapZXwWj6N0QPvVkWitFdyYwHZN09l7U3NZYYze0dJhZ5aIUr0
         0qLRp+ur7VHXU2wzg5nK58XAgR1otd619cpuqnAv8fojiLB+16+G4SAav+27XjXd7o5x
         Il4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0YgvG98+C7Hv1PiMeKbN/HzqGCFiqwzwYpuxu1hQ9Ds=;
        b=JQS6gjfUSDSjV7exn07NHSPyZZ5YsqqyTU5moY8UKcEbBJAmqLOzEk8BB0l+1bCE2K
         /OWFaVWOFC5waJVvszdVDyrrWfJ1597PDBZLp57ojvQSEakrJFjNomnNsQFNtDMzhS/q
         F5+zOMR5A7uFFD69oo484W+Hq/F6kKL7TpEtRDN2KaxCNfl2m/H/FgYfJSRUmdrAuiqg
         802er+Y2kUzdbk/BdBN0PSIYUw+AM2uapDBozPkSgRNArpGARaFSG6nnRh2sdiuAnWDI
         xOKJWvFljr5mnBhg08T2ofD+zJnqDW55tOVu3igTEihBDtdbOUNsk7YLYuv0tzJrx7Ru
         WecQ==
X-Gm-Message-State: ANhLgQ2trimazpGR8IuyibGWrRvXT/62InFhtRKIstdVWPiwY/3eUFfR
        TsEK98SwDIFpsa3J2lqIFdM=
X-Google-Smtp-Source: ADFU+vtxl9gsgmIy/4MrHIgj8LXRJKUTbnhFHS0hHScpJXyVD+hesD+V9yp2+R3y1g6YuovXPgjB3A==
X-Received: by 2002:a17:90a:a409:: with SMTP id y9mr11786777pjp.103.1583679230945;
        Sun, 08 Mar 2020 07:53:50 -0700 (PDT)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id k21sm5229014pfi.115.2020.03.08.07.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Mar 2020 07:53:50 -0700 (PDT)
Date:   Sun, 8 Mar 2020 20:23:48 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: mmp: replace setup_irq() by request_irq()
Message-ID: <20200308145348.GA7062@afzalpc>
References: <20200301122243.4129-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301122243.4129-1-afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubomir,

On Sun, Mar 01, 2020 at 05:52:41PM +0530, afzal mohammed wrote:

> Hi sub-arch maintainers,
> 
> If the patch is okay, please take it thr' your tree.

get_maintainers doesn't show any maintainers for mmp, but it specifies
you as the sole reviewer, please let me know the route upstream for this
patch.

Regards
afzal
