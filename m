Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145D7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E027F207F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiO7osuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgGBAyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgGBAys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 20:54:48 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11F7C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 17:54:48 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l6so24138270qkc.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 17:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=hO91gN0h/Yr5xSJfWsTPMl5yb7ckd6xh7ekWQ6cvBIA=;
        b=QiO7osuZ0V9urEG1lVlw4WEcRNR0F3Sdnl9NjD89hK4dpbaR8xm137hAqFW/blgQNX
         pLY7xwYaz3WeauXhs62baAWCiVeILKiIwi6q1dLxDWtzYvEhCj3oezBGt1Pr9ETLdfUY
         QPTkp0SjYMIoCkgmc0bL2hy+MfPtlas1Ar/F5fSJaRkzeOIcVqWGQrqiuMFZAE7+E4SR
         IB8tO6wfQH+eotybHY5E/+Wm/Euywh5ZpIxyf9lOg4z72fP+DyWgqcbST2E9PRDS7fV7
         KMuVqDMQnTgY2pVF4+UPq6XxpL0yXn4kTThRYpLN/ntDmT+kIIyKtezb+zXlfb3Yz7QV
         9prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=hO91gN0h/Yr5xSJfWsTPMl5yb7ckd6xh7ekWQ6cvBIA=;
        b=Vfm5OgLPuoYm+MyqYZKrh70VcUcOE2fMXLqEv88DOwyx4oxBtwWW5Fb6//H+o58Ds9
         zK6R4oUTLcuzVvEqmhqPAy9dgt8rbcomcaSwUejAyz+JzuuT+jPP8Wza6zO1NnsAv1Hq
         1VDLfa60rwD3b4QvSxGRQOYHrw7ckG1Noqx8trBghOpFwEjM76zrJibGDztPX1Om6SfE
         4B1ePUeX3NGmP+TPRJYZ0qLyaS/sDtEesbmTUzQZOX7olclHr2aWQrP0U2m/lO2dICWQ
         j0WqWV/KQz/y2V/paY//+GUezt2eTUIGwhljDfv7mk+yRicdmrhm5eaPRG+GJS7ewpYv
         5wcA==
X-Gm-Message-State: AOAM531WmaTb7IjtX+Ht227dOKi8ZA+BRvU7Joij1e8WDHAYZ2MguN0l
        H5P5WRSLqY6SFD91m/SM/Lw=
X-Google-Smtp-Source: ABdhPJyXc53Sx1YOZSJEC1jfR/nuKaGgvtLyvG53K2V1rEfpc4caHt1WAHF+YCSvxu+w8B1RG0Gssg==
X-Received: by 2002:a37:9b01:: with SMTP id d1mr29385611qke.65.1593651288027;
        Wed, 01 Jul 2020 17:54:48 -0700 (PDT)
Received: from LeoBras (200-236-245-17.dynamic.desktop.com.br. [200.236.245.17])
        by smtp.gmail.com with ESMTPSA id q189sm7224509qkd.57.2020.07.01.17.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 17:54:47 -0700 (PDT)
Message-ID: <3049147914a4a04a095a3f3bd74a7c7ad4d961ad.camel@gmail.com>
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
Date:   Wed, 01 Jul 2020 21:54:41 -0300
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
> > In fact, there is a lot of places in this file where it's called direct
> > window. Should I replace everything?
> > Should it be in a separated patch?
> 
> If it looks simple and you write a nice commit log explaining all that
> and why you are not reusing the existing ibm,dma-window property 
> for that - sure, do it :)

Nice, I will do that :)

> (to provide a clue what "reset" will reset to? is there any other
> reason?)

That's the main reason here. 

The way I perceive this, ibm,dma-window should only point to the
default DMA window, which is guaranteed to always be the same, even if
it's destroyed and re-created. So there I see no point destroying /
overwriting it.

On the other hand, I also thought about using a new node name for this
window, but it would be very troublesome and I could see no real gain.

Thanks !

