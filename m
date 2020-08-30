Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A26C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 08:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E8B2078D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 08:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORMYXf8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgH3Ipn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 04:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgH3Ipn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 04:45:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85888C061573;
        Sun, 30 Aug 2020 01:45:42 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id g6so1485823pjl.0;
        Sun, 30 Aug 2020 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WiNxa0n81+ZmG4cSOgItga0yRmbWV7qQvdH+kZPT5Zw=;
        b=ORMYXf8J8DcCr6VrE8tPHN0P87U7mjxBxwuSSPS0uSxg5ZIBGj87x3uvD5mzCkY23K
         RuGaZvnTJSZR0K2gOEOvZ87gte8SEXVQmnrj077dvAVDe3evxO54+TetRHOwVHVgqCal
         Qt3bRmkj18czte1kxYkQhjnkMaQPdFaInMorDABRT1nPum4gm2v8d1cIowTi9+f4PHCN
         6PuIKQUa9PSmReHnB8OZ+tsxQvWw+Pdvq1pTJssvcnK3EndqoS1ygi2blKO0NHsHPkB+
         H8C9gMo1JrUTXFSluG+9WrgsrG6BTNiJDqrLGm0Y++EvRk8bx7utZ14sETASpxvLj4a1
         YKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WiNxa0n81+ZmG4cSOgItga0yRmbWV7qQvdH+kZPT5Zw=;
        b=VjsrigAJNhJ83Egcsf3FOuS0IIfttJVXpgWOXHfcBazAPhi7Sl9zqisQPEIrjDk20X
         WNELM879qmy5DYMTvsQsUfOHOM3X0FWoU18Wj6pVxZRCbkMdnRmKahhc3f9iTkPnEXc1
         fo7H9ue3+DNZz0mXDk1QrNJZrv/ObbwAupPlGZxiCdEhkHWVLc+MSW9UIzKfQna2Ku0V
         xaoPfxHINQGMtTikFmuZE2Gpc411EijGgG9gXiPOHZocFcxCg8tqF3DHehmDPdDY9Iop
         IesmU+qDXAEyWZKLVHZmbrI4FzYEiKcH4pTZv7prBElMOdCzRsgouArh8aKgImi3wMWH
         eQkQ==
X-Gm-Message-State: AOAM532wUg051nQj90dUSJwrLMVabBD6vZGv3COBCiJtfNwsmSuphHs/
        axMIKcRZoOGq83uka/4LVpo=
X-Google-Smtp-Source: ABdhPJzAgEHS4pusVSjIwBTzKwOuJcgaNfkZ71b4tA+812jXiQ7jGMMAa3JLcZErzB5uKqx1ChRjNA==
X-Received: by 2002:a17:902:7582:: with SMTP id j2mr5042928pll.322.1598777141185;
        Sun, 30 Aug 2020 01:45:41 -0700 (PDT)
Received: from gmail.com ([223.190.108.199])
        by smtp.gmail.com with ESMTPSA id g5sm3741903pjx.53.2020.08.30.01.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 01:45:40 -0700 (PDT)
Date:   Sun, 30 Aug 2020 14:13:52 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Sean Young <sean@mess.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v1] [media] netup_unidvb: use generic power management
Message-ID: <20200830084352.GA36870@gmail.com>
References: <20200728092717.937023-1-vaibhavgupta40@gmail.com>
 <20200830081004.GA17376@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200830081004.GA17376@gofer.mess.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 09:10:04AM +0100, Sean Young wrote:
> On Tue, Jul 28, 2020 at 02:57:17PM +0530, Vaibhav Gupta wrote:
> > The .suspend() and .resume() callbacks are not defined for this driver.
> > Still, their power management structure follows the legacy framework. To
> > bring it under the generic framework, simply remove the binding of
> > callbacks from "struct pci_driver".
> 
> Unlisted fields in a static struct initializer will get set to 0 (or NULL
> for pointers) already. Removing the NULL initializers will not change
> anything.
> 
> Possibly you want to remove the redundant initializers but your commit
> message should say so.
> 
> 
> Sean
> 
Hello Sean,

Yes, you are right. I mentioned a general commit message. I will send a v2 with
suggested changes.

Thank you
Vaibhav Gupta
