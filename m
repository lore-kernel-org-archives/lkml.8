Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D40C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 14:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 423C92075F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 14:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWqY7sN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgEXOIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 10:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgEXOIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 10:08:42 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C325C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 07:08:42 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d24so12983021eds.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 07:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oOPa+ZvfDR3HcvpFO6vT0WShjxXnzg9SNOFTcwUbROg=;
        b=hWqY7sN6lFkh6DfzmV1owOmZkQPJS/Vmb5dpb8VaxSnYiRK8E+r5nv0ALwqzt4nh0V
         Bts8MYfihYbzSchAhdShqE5sJH2T72xpqgSgoruGdSP8QFsUutg7aDjv//lFz39tXRoi
         5VzW13t1tllwjQqhi4SI4U6ugwn8RcL1hKH33nyvi129MvkSMz7ojb+kSQ4MH6o3G4Gl
         qmltsyNL8HjVqK9u/EbMUz87KvJo8Gs2mQQ0d2GUqkVXjL8YxohHArneQ13oqfqPRTaW
         NofPg7j2IO+wulosLimD9dA1BM6s+QvUB1j5etzGFfrhi1ut5mUgaXY0mx5tlYSUV9Zz
         xN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oOPa+ZvfDR3HcvpFO6vT0WShjxXnzg9SNOFTcwUbROg=;
        b=PVCuvHIzN/OLkTM9D5NNs6hpTmh2O6M7RabkgWVe+9B44lzSNZIyY6ykAMXUOlJexI
         kKwS/llXlTP8gNEgeJeGesuM07WHgvc4w3/3LbqiEScMLphw5s6ewfRaM/i0dHFIUuQF
         0V9mCiiOeVCQjrrCKlN0Yhs3H8tHbOYqPS5+JiSecj0eYu5ZckQX6qPJ1Yj09fPnbivF
         3pQB46rWLK0bF3UH61nfA0cWv4x5lWkxTxZ0Sh+P76o7JCJtwmh1tbSrUgGjvQGujBBK
         CStwET+0vZBHFjMCq8a9xPRiirxkbwYUoHp0KFVKyYZCeJhE6nCL2Vhrj6ud5cPRvcL6
         Z9RA==
X-Gm-Message-State: AOAM532Nhj0Kd6QbLYkh7axqf0oOogK7DHj117ZeG2Ow4cJUfLWxcFx2
        7TH+yjaUVwY7CSCR3VrxP3M=
X-Google-Smtp-Source: ABdhPJzh1UeIujqeorr1WiLLnh8/PGj+rE0hSQm2S6Uo6GAYrdacJxOfQWztG7PCwRs6VurIxf3mfQ==
X-Received: by 2002:a50:abe3:: with SMTP id u90mr11208483edc.278.1590329321092;
        Sun, 24 May 2020 07:08:41 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:ed3c:ef0e:6f3d:f78f])
        by smtp.gmail.com with ESMTPSA id q25sm4990305edw.77.2020.05.24.07.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 07:08:40 -0700 (PDT)
Date:   Sun, 24 May 2020 16:08:38 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     GAURAV PATHAK <gauravpathak129@gmail.com>
Cc:     abbotti@mev.co.uk, gregkh@linuxfoundation.org,
        hsweeten@visionengravers.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] Removing ununsed variable int lo, hi, int data and int i
 from comedi/drivers/dt2814.c.
Message-ID: <20200524140838.urnzunavhoic6c72@ltop.local>
References: <20200524113613.GA19734@xebrium.com>
 <20200524121044.fzpm6hkqrrpa2yhc@ltop.local>
 <20200524133218.GA1391@xebrium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524133218.GA1391@xebrium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 07:02:20PM +0530, GAURAV PATHAK wrote:
> 
> For few drivers, I am getting:
> 
> CC [M]  drivers/staging/vt6656/key.o
>   CHECK   drivers/staging/vt6656/rf.c
> /usr/lib/gcc/x86_64-linux-gnu/7/include/stddef.h:417:9: warning: preprocessor token offsetof redefined
> ./include/linux/stddef.h:17:9: this was the original definition
> 
> but I guess these are false positive, as #undef offsetof is already present in ./include/linux/stddef.h.

But there is no #undef in /usr/lib/gcc/x86_64-linux-gnu/7/include/stddef.h
which seems to be sometimes included after Linux's include/linux/stddef.h

-- Luc 
