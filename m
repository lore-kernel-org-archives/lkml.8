Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193C8C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 14:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D889B2083E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 14:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVDLREjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgDKOKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 10:10:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37274 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgDKOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 10:10:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id r4so2259857pgg.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 07:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hVz3RKesqfENG8YZfzgFEZLw0CBMmoitjAxR2BG+SlY=;
        b=AVDLREjSC/5mANUr1ZKWvXh6/ODFfvDPQkUTa5hJmyHSX/NmaDexF0UKejZj+wj+qD
         Fu5NlRWKJrHg9yhptcPdcfmAIlu4sHoZ+GaPACRqEVluZQK4n7vzoH5DvTVeV87sgtI8
         rIxF/e7JaR1++rMmn9gZZ8YS7l8f41ky6tJqGmdmZM3I7T6nZPazAhpMqnwqMEhOXLaf
         30aGmnLrthvD7M0rXtE9gYh0jya8Pnq3Pso436Nd8ExySIj2O+e8w2YQgaMxNCzoFfMc
         AJpnvAfjzwgTurL9dC9iqGJKlk04HtmoaghVY+0SM5uMiu7THY+xrrNh9lO59hIozzix
         1kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hVz3RKesqfENG8YZfzgFEZLw0CBMmoitjAxR2BG+SlY=;
        b=Lnj98VRXv6m0h/fMRTOLGPirtqwaaaHNqq28clu4DKibbNVXdzwkrAT6Znhdd2RCA1
         mpe9uIWD0cF06R2LYQIvMqsd2nmL/3W3jNPsW2kqQtiSpA+2U5fDHBwUll7sifuvSjUI
         F55ReJU7Z+mJAEOCn1z42B12YFg4qlyUJmkSnUVwxZvwGhAx3nx9l/bMxBAisOfXFX3D
         eJ48g0MdCl71lsJUDXM9uosNuq3UO04bNW9IYzJifMCpIL7STMyBOFW3Hby7CZpRulZd
         5gCkGn6hUYJUR0a/HFibs/HIqcu1Y1cI1Yfn6W/cyp4G6q0EIq/N1mCH1ApxVh0/WFEW
         QaRw==
X-Gm-Message-State: AGi0Pua6d5XEi+q4Cpg/jl+5ms8zXxOASD4+j9QXZja88NFRojGbJNla
        nVvBHykfmqmR7STlWJoS7UU=
X-Google-Smtp-Source: APiQypK4ambPWyfulpYazHSP+waZRc7HSwbk7Z5HtLUhYJMbr94VnQuQTIeR0s1L/lCFBPS1GI1d+w==
X-Received: by 2002:a62:1909:: with SMTP id 9mr9706895pfz.196.1586614204279;
        Sat, 11 Apr 2020 07:10:04 -0700 (PDT)
Received: from localhost ([183.82.181.116])
        by smtp.gmail.com with ESMTPSA id 189sm3792943pgh.58.2020.04.11.07.10.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Apr 2020 07:10:03 -0700 (PDT)
Date:   Sat, 11 Apr 2020 19:40:01 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 6/6] genirq: Remove setup_irq() and remove_irq()
Message-ID: <20200411141001.GA7688@afzalpc>
References: <20200321174303.GA7930@afzalpc>
 <cover.1585320721.git.afzal.mohd.ma@gmail.com>
 <0aa8771ada1ac8e1312f6882980c9c08bd023148.1585320721.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aa8771ada1ac8e1312f6882980c9c08bd023148.1585320721.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Mar 27, 2020 at 09:41:16PM +0530, afzal mohammed wrote:

> Now that all the users of setup_irq() & remove_irq() has been replaced
> by request_irq() & free_irq() respectively, delete them.

All the setup_irq() & remove_irq() replacements have hit Linus's HEAD.
Any time this change can be sent to mainline.

Regards
afzal
