Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23386C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 12:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0E6206B6
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 12:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liNxTb77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHIM5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 08:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgHIM5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 08:57:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BB5C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 05:57:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c19so11738743wmd.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 05:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQcFptD/1jRl7mtWn7+XF9FKOWnm02CLbG2ixWaKNCw=;
        b=liNxTb77yswgSB08pnXCpdwB9KXzCG/4hNutmbv+lj5VXkFDYwQtACsOCGoFvabcEI
         SrvZWzqS7fgLo9TignDJ0fY7E9DAg1Asld5CGW/frEheM+SexebgmK3rX//fGe2dwqOe
         PBNnWJAJsmQ+QaDLI+1y6WDyO4bHxEvyEMT/yOQSG/CSwMI+8Sc+SbQ9UlJyioLgyzCy
         c7tSe8Fh1ST8FcR4DeUyxnZBAkWaWI7HkqDRgmrI+rWhKiMXwKyuItg/RGCjSwrbVKpc
         6AAnozCc67gobQSY+pgqMItg0/7T5FhsCMMdVrjgtAcdY9FLibkBOQhGa/KeLWtvKxUV
         qnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQcFptD/1jRl7mtWn7+XF9FKOWnm02CLbG2ixWaKNCw=;
        b=BnVY7fKLI5m/iIxNpwK0Shik0jKH0nNSy7f+O+xgwU60ueq/AUstbDimr4ZScTfvqn
         W+Vd2eys/Kfz4tur+xkcb4uRNSs+VKahLHJtdcHQoCwe0Os3rddmoLa8UnmWBM3ZPks0
         Byn6597ptM1/TTPzG4Sc1oUp96iLWbf888jzgfU1mhlSR/Ok0tWyaR6a9kB1fLQ7Az3U
         I1dakw9mr28TRqnnIR2Ki556wgk0+sFSqaK6x+4HD4ArCz9oy9OqgAhI7zfSElf3NFlo
         UQVvzm0OTyl9P6UsPEwn4uUOmSIBkbiBHGGxOX8TVbbznP3XimtppTLedbXT6vR/l/Vr
         yGSA==
X-Gm-Message-State: AOAM530n8uf3NJT0zIrBQoc0LVHJav1L/P7f+OVPea8MoC2kpPIfQJPq
        EopYDbrwD8q2thh2hjXk57M=
X-Google-Smtp-Source: ABdhPJwoQDJIPt1TT1tW4mhtOM3YcR2P/SlUGyEL1ZpI/LVs9AYbh9e2P/VbRq+KeLj9KPzQhBVaLw==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr10635654wmc.117.1596977872403;
        Sun, 09 Aug 2020 05:57:52 -0700 (PDT)
Received: from pc-sobremesa.mundo-R.com (162.189.27.77.dynamic.reverse-mundo-r.com. [77.27.189.162])
        by smtp.gmail.com with ESMTPSA id y17sm18418818wrh.63.2020.08.09.05.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 05:57:51 -0700 (PDT)
From:   =?UTF-8?q?Alejandro=20Gonz=C3=A1lez?= 
        <alejandro.gonzalez.correo@gmail.com>
To:     f.fainelli@gmail.com, markus.mayer@broadcom.com,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        computersforpeace@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Alejandro=20Gonz=C3=A1lez?= 
        <alejandro.gonzalez.correo@gmail.com>
Subject: RE: [PATCH] tools/thermal: tmon: include pthread and time headers in tmon.h
Date:   Sun,  9 Aug 2020 14:57:20 +0200
Message-Id: <20200809125720.2111347-1-alejandro.gonzalez.correo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <3C3E65E75D9910479323816378A812E7417797A2@BGSMSX104.gar.corp.intel.com>
References: <20200617235809.6817-1-mmayer@broadcom.com> <f5e160e0-ac4f-8c14-d06e-38f859690ff9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -----Original Message-----
> > From: Florian Fainelli <f.fainelli@gmail.com>
> > Sent: Thursday, June 18, 2020 8:23 AM
> > To: Markus Mayer <markus.mayer@broadcom.com>; Daniel Lezcano
> > <daniel.lezcano@linaro.org>; Pawnikar, Sumeet R
> > <sumeet.r.pawnikar@intel.com>; Zhang, Rui <rui.zhang@intel.com>; Brian
> > Norris <computersforpeace@gmail.com>
> > Cc: Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>; Linux
> > Kernel Mailing List <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH] tools/thermal: tmon: include pthread and time headers
> > in tmon.h
> > 
> > 
> > 
> > On 6/17/2020 4:58 PM, Markus Mayer wrote:
> > > Include sys/time.h and pthread.h in tmon.h, so that types
> > > "pthread_mutex_t" and "struct timeval tv" are known when tmon.h
> > > references them.
> > >
> > > Without these headers, compiling tmon against musl-libc will fail with
> > > these errors:
> > >
> > > In file included from sysfs.c:31:0:
> > > tmon.h:47:8: error: unknown type name 'pthread_mutex_t'
> > >  extern pthread_mutex_t input_lock;
> > >         ^~~~~~~~~~~~~~~
> > > make[3]: *** [<builtin>: sysfs.o] Error 1
> > > make[3]: *** Waiting for unfinished jobs....
> > > In file included from tui.c:31:0:
> > > tmon.h:54:17: error: field 'tv' has incomplete type
> > >   struct timeval tv;
> > >                  ^~
> > > make[3]: *** [<builtin>: tui.o] Error 1
> > > make[2]: *** [Makefile:83: tmon] Error 2
> > >
> > > Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> > 
> > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> > --
> > Florian
> 
> Reviewed-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> 
> Thanks,
> Sumeet.

I've tested this patch with musl-libc for the same arch. It works like a charm.

Acked-by: Alejandro González <alejandro.gonzalez.correo@gmail.com>
Tested-by: Alejandro González <alejandro.gonzalez.correo@gmail.com>
