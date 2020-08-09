Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17831C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC4A2206CD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597002766;
	bh=7KmUMjSQsMRnOeXErSmPaijU4VM2a63DTzKAX/5gUCc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ss0j64QN/a0J+TZUNojT3dEKoribCUisS/XC1VkQu7hNIt6PoHHcWHiP3A78/z0WZ
	 5sJNrnRTo59MkFil7s3Lg+aBsOqWJz1DvPY3H0iyt3g2fTaiOHvUzpgekCOchS1SCq
	 yRO5juJ2WGWOuCkdVIB2EGZ5uWSMggnPocxWrE1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgHITrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 15:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgHITrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 15:47:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C890C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 12:47:22 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 185so7366738ljj.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 12:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vy2/Tr7nL0xv4oVageuubwhBrv+oQnLE6xMeTiKzlWg=;
        b=LTKE7gQHSMbXFk9BVmgefSL/wzopLbPob90qw8+5pHE5gKF0rhLL+EohGdbeXMjNcS
         q9+Yl4CrJIBM4pVPQ58/QvBFG4KfA/1bQIvG4TBGrX8oLdm1W5xqR6zgWfQVzINniybL
         6c1mtrtqdtE5kji/ppywZ7rFT9FwrRXNif3a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vy2/Tr7nL0xv4oVageuubwhBrv+oQnLE6xMeTiKzlWg=;
        b=g9XUuXLZ4Dx7x6wILbTcI96C/et8e5KSZkXvwi+U5OXHfUEOF+wqjJkMmLCyaNKGZn
         aOWkPtNcVD5ElqLYXWESd80r/Hsc5Nwa/I1DZzLCsmd1R9Uv094ow0C3s/A9n+6Djik5
         v1+0VWXkTGC4+PX8I1rujQMETe2QjWxkHL9hDI8dIerEFL4cYVyFefKUYo/j0XB2Z9nl
         77pIB22mdzA+kP5XfnVPl3yGeLLgrJUneOJT5p4Qf3FNuL7aYjsIzizjfJVQGOGjX8Jc
         czQjAaB/MR62S9Vh1oiTJdQjGN7GESbtCTZ5lJZUzGuXWfVFz04o+t3Pf8hzipEWxml8
         Hmvg==
X-Gm-Message-State: AOAM532G/jDDOZMd04UoJBpuRdBdZIhUZ1nZaEUA5wok0f3LDIxkNMAt
        ho5fX5JO0NNMyc52s6WMqeHxnFSXxrU=
X-Google-Smtp-Source: ABdhPJzMX905ufDwnoKP7o3umfTlDPEJMLL/w41hCxGHGUD73g0RnlzcSKzYx1JNfgBnIH6pyNRHcA==
X-Received: by 2002:a2e:9904:: with SMTP id v4mr10405068lji.321.1597002439719;
        Sun, 09 Aug 2020 12:47:19 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id q8sm9356179lfm.92.2020.08.09.12.47.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 12:47:18 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id v4so7390870ljd.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 12:47:18 -0700 (PDT)
X-Received: by 2002:a2e:7615:: with SMTP id r21mr10223230ljc.371.1597002437691;
 Sun, 09 Aug 2020 12:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200809003453.79673eb3@xps13>
In-Reply-To: <20200809003453.79673eb3@xps13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Aug 2020 12:47:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJ0SQjLeMiVvMXayxvxCmAMdROxyb-Pzs=kr4-Ba5BCA@mail.gmail.com>
Message-ID: <CAHk-=whJ0SQjLeMiVvMXayxvxCmAMdROxyb-Pzs=kr4-Ba5BCA@mail.gmail.com>
Subject: Re: [GIT PULL] mtd: Changes for 5.9
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 8, 2020 at 3:35 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> MTD core changes:
..

You didn't even mention the stm32 controller change, which seems to be
the biggest individual thing in here..

Hmm?

              Linus
