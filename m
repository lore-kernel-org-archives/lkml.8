Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24810C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2868204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1MRi+xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgGCG1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGCG1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:27:13 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F000BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 23:27:12 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e12so23154292qtr.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 23:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=bt5K9XtO4LmaNxjZqwWNBKUIx68FUKBArV0VTR0P1tY=;
        b=m1MRi+xr0n+zOnLQxXEmEVq+ZcH6RpRlw8z74GuOZAGBPWvWm9fm1xfXrGo/M/Iyjx
         5/3tlXePjZODGcMmpSG0qjYLz5YpBQEul5CWIRPjBVI+y63ZEIVkPHvFt4vUQ9sAw7se
         izukHid+jBmwTICNAksbWgdQ1C4qJMQ3YgFXveggrGwIyeaujoFb10R4i+YxzW7cW3R3
         GavY6hZgyllhtZBIT1tAV3AJA3lfh4yrDuX030m+EXIQemQV1Y+9kUmzpBAVrNO1+vrS
         PydCHu8K89X6mHVSfYkKIrPNKWPhO4VJbI2xLDYRnYRM1VL2hRTd5H7VrTWrOaeVLhiy
         GpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=bt5K9XtO4LmaNxjZqwWNBKUIx68FUKBArV0VTR0P1tY=;
        b=qNJkZtwybIc/HxIKObObwPNfpTN64X7Muk1Rcufz1RYOyeW0iLjufomtuWGUz+IaTv
         6og4rW+jjwY+Mej8Ax9PKmRd834pQR0YuV4C494Fl6KYoAVDSntvxkSL7jZBlNmSamUR
         Iv6+hU83Ir5Pnxrbqf8m4bQKnZXg9hfuHXr4HaGnX75fCW9aL62SE4V1E0YrDbvsunv1
         kBYvhet89RH3OeCwgojdaxIdw7NasPikBLAkFTrykr6wImwc2MmqqdxBZ7Zf8PskTG3M
         OIUXaSKEHLwUyoU1eTgWdQy7RUhvO7QZmH5gA9LW8a5H2EOygPbe5RFZF27qsyponKJ8
         PLFQ==
X-Gm-Message-State: AOAM533Gh4FkmxCGKU5FgYcqPPDJdoBXUYeC+10MwuH0Lh/4dzqWGmtZ
        900gs/3kmRUuFBT6vGK2Anw=
X-Google-Smtp-Source: ABdhPJxUxn9Zk+mz//5V0e1yuEBIBvzhAuaXiY+i3MFSy1R30ijJEoE7d1WlyIqDbtoEyw+xiRnU1w==
X-Received: by 2002:ac8:408c:: with SMTP id p12mr34184171qtl.332.1593757632167;
        Thu, 02 Jul 2020 23:27:12 -0700 (PDT)
Received: from LeoBras (200-236-245-17.dynamic.desktop.com.br. [200.236.245.17])
        by smtp.gmail.com with ESMTPSA id h197sm10113548qke.51.2020.07.02.23.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 23:27:11 -0700 (PDT)
Message-ID: <e9edda01a21f7144cf4781132df070feea04f767.camel@gmail.com>
Subject: Re: [PATCH v2 5/6] powerpc/pseries/iommu: Make use of DDW even if
 it does not map the partition
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 03 Jul 2020 03:27:05 -0300
In-Reply-To: <2c5dc8d2-f379-5a5f-844a-f4eea233f265@ozlabs.ru>
References: <20200624062411.367796-1-leobras.c@gmail.com>
         <20200624062411.367796-6-leobras.c@gmail.com>
         <18df09c0-ef83-a0d8-1143-1cb4d50bf6b7@ozlabs.ru>
         <0e8bcc38614ec80c7816c07dd4dc70854c2b901d.camel@gmail.com>
         <0c3de45dfb612745aa2ee4126b3935303d8e8704.camel@gmail.com>
         <2c5dc8d2-f379-5a5f-844a-f4eea233f265@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-02 at 10:31 +1000, Alexey Kardashevskiy wrote:
> 
> On 02/07/2020 09:48, Leonardo Bras wrote:
> > On Wed, 2020-07-01 at 16:57 -0300, Leonardo Bras wrote:
> > > > It is not necessarily "direct" anymore as the name suggests, you may
> > > > want to change that. DMA64_PROPNAME, may be. Thanks,
> > > > 
> > > 
> > > Yeah, you are right.
> > > I will change this for next version, also changing the string name to
> > > reflect this.
> > > 
> > > -#define DIRECT64_PROPNAME "linux,direct64-ddr-window-info"
> > > +#define DMA64_PROPNAME "linux,dma64-ddr-window-info"
> > > 
> > > Is that ok?
> > > 
> > > Thank you for helping!
> > 
> > In fact, there is a lot of places in this file where it's called direct
> > window. Should I replace everything?
> > Should it be in a separated patch?
> 
> If it looks simple and you write a nice commit log explaining all that
> and why you are not reusing the existing ibm,dma-window property (to
> provide a clue what "reset" will reset to? is there any other reason?)
> for that - sure, do it :)
> 

v3 available here:
http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=187348&state=%2A&archive=both

Best regards,
Leonardo

