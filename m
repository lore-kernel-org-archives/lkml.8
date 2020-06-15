Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C27C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E34206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFuFpUNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgFOJ3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgFOJ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:29:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E33DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:29:03 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r9so13898903wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9EDtJNfX1SAp0MBHTf1DDs5zKPsOXN9CX0Ktu243vuw=;
        b=sFuFpUNqWigBExkx20jCEZPeFLzamfwkmd3Fd/Id0kN+BJSI0pQipK/DaO2A3lrwMA
         r4pb6FvIjue2bc3TDHLA11I1TH6OUg74T89Y0OMml13+StHNUHubqjFhdkfMMo4TzVz1
         tdt0i9mG1xZF8Ifj1x4Oso7dVuQmfC9H3wWvi6OjXRdIQsoyny/UYUy1Uf+5NUObR07l
         LtfmZPtN7+aUIl7PAqgKUmryDf+QtcyhDMLs76/30/hVtxi1PdqJBWNffbqcRInb73Fb
         N+LRVLIPkuZvITgrdHkVq4XAFRoprFGy5aahYrY2Zl1TtuqUG7wibz0J7UvnUoU4drLQ
         KCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9EDtJNfX1SAp0MBHTf1DDs5zKPsOXN9CX0Ktu243vuw=;
        b=kSeH+9Wkf1I+HZ3c4AmDxF8MerNNi8PwhHctqkLijPLddnYS0KAHhh6uWyjDMGCc+k
         5ntqQCQEPSUK4yY1S+DMGZ4e2QU/FSLH1lV7aGmf9s7ZDNe1vqBO/olVg9WDqw31n/U6
         YbWwKgG5sbW+ScsCYqf/XvtZyXJrDb42yVvZFOSvG7og3PHdzC2LVThFHL123FKCVWCU
         4au4qMjXESVYk//6un3FL8zVUhzZSlAfK8IlWLEurt6UTUfYx2vKf0ckAEthEtkmmaIK
         +fCVrE9F9RCH3PZO0cAbsNpFp54EFjH/FiMXXFlEVwxEqLGmHfWINNhkUMsyUtql3YEL
         XVRg==
X-Gm-Message-State: AOAM533N1cjDuCSS1jxPDp/AVuO9uN1CwqxlrL21HN708ZjTk9bWPx2j
        8HvH3zQitl5aCnf6+yTqe+kqtzXcykD4H1nfwyA=
X-Google-Smtp-Source: ABdhPJyCePymwAb915SzpAfLx2XsbhZ2ocwEbcv4PcsBnWgEQHMoHAZiY8Vqju7OcjmQszvVxsVQQkKUSvdBuewdn3U=
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr11600752wmc.1.1592213342244;
 Mon, 15 Jun 2020 02:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200614135125.19502-1-rikajff@gmail.com> <20200614140531.GA2661398@kroah.com>
In-Reply-To: <20200614140531.GA2661398@kroah.com>
From:   Ricardo Ferreira <rikajff@gmail.com>
Date:   Mon, 15 Jun 2020 10:28:51 +0100
Message-ID: <CACtES-qmpRJ2mk+1vhsJm55G6j6U1+rLB1t2izHwJ1u4_eUKHw@mail.gmail.com>
Subject: Re: [PATCH] Staging: rtl8712: Addressed checkpatch.pl issues related
 to macro parameter wrapping in parentheses.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jun 2020 at 15:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jun 14, 2020 at 02:51:25PM +0100, Ricardo Ferreira wrote:
> >  #define init_h2fwcmd_w_parm_no_rsp(pcmd, pparm, code) \
> >  do {\
> > -     INIT_LIST_HEAD(&pcmd->list);\
> > -     pcmd->cmdcode = code;\
> > -     pcmd->parmbuf = (u8 *)(pparm);\
> > -     pcmd->cmdsz = sizeof(*pparm);\
> > -     pcmd->rsp = NULL;\
> > -     pcmd->rspsz = 0;\
> > +     INIT_LIST_HEAD(&(pcmd)->list);\
> > +     (pcmd)->cmdcode = code;\
> > +     (pcmd)->parmbuf = (u8 *)((pparm));\
> > +     (pcmd)->cmdsz = sizeof(*(pparm));\
> > +     (pcmd)->rsp = NULL;\
> > +     (pcmd)->rspsz = 0;\
> >  } while (0)
>
> Does that change really make any sense?  checkpatch is a nice hint,
> sometimes it is not correct...

(Replying again since I mistakenly sent my comments only to Greg...)

Yeah I was over-eager and applied some of checkpatche's patches
without thinking twice... I guess the parenthesis wrapping only makes
sense when you have an operator (either binary or unary). I've
rechecked each macro identified by checkpatch to see if there is a
need for parenthesis wrapping in their current usage.

Regards,
Ricardo Ferreira.
