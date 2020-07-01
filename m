Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABCBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C8B207E8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCk0GG/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgGAXsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 19:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgGAXsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 19:48:53 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8CFC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 16:48:52 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l6so24012624qkc.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 16:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=eWwA839IZ7dq+a29DyXkGmi7dM/v2sHdleLj59LsJvo=;
        b=cCk0GG/Q7j5pgcUJbgaej4solO6bRP1anrWSbOb2EYkbaZxCNkvsDaDv+4+ZfzrJgg
         9cRPJ7yZcVHRhpJwVBBhCE78Dsp3GtXcAfbi2u4jI9ICI+w/S2PSRBa0a8wqjsNmesHr
         7nZsYNfFsiCfc8U/j+55Mva2CqSs8RBxMIG21YNs5+84XsEvvCYKimHcVF2fm+/uJgdJ
         UeLbcYiM27bjGQJ4in7VrEE3JRyVCpaBPx38oTX3zzO7Vv6N/cveyCLl+eKkSxcR2zPU
         GF7Tj4oXuiboudPqmevExnWWH24HrJ8XtJndBXodVjlPyATj1F8NLcMnKnN//QUX3FgJ
         Dpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=eWwA839IZ7dq+a29DyXkGmi7dM/v2sHdleLj59LsJvo=;
        b=DOrtMxGydtZv34uPYJfVyIgLIsjakln45FbOrKzbvd7GrPvqWpVYLBujg6oJj4sgUA
         27NUbKcIWdun8TmIEeMB0QQT4SHwmDaw72+DR6J/juu/99sL+OuNz88kqJQpYL+0A/tU
         AeqGa3Sjso+jTyOLUNfd2uvKje9O161i/WlnAtMnYlV5V/sKSVN/6DG26i/RLC326ZR9
         ImmCKpBkunI/5GcuVYdtmbuvXpiw2/AvyKwgzpN4EJ7kvzr0TBVhyX8pvHq6QH9XF4y3
         GZ3TU/TI/WP958m/S52WK8rt9xV+impzsdcbfY7Ey8oRsTLSPXXHOsphYh8hGkLuSPz4
         Mqtg==
X-Gm-Message-State: AOAM5311iWx/lWN/GFSjdnDV2W35vXi2Qg2ZvWhxlYjnQytpUHOxZkgK
        +dNkvmZPqwuykctZmpEFWoE=
X-Google-Smtp-Source: ABdhPJw0PQ7LdCWGBl5gstq7lsFeqHSpDXcjrWbUSpr7dI7hbWVIEH2haZKhZCeGWOEo3FhVCBQSqg==
X-Received: by 2002:a37:f71e:: with SMTP id q30mr26753981qkj.68.1593647332002;
        Wed, 01 Jul 2020 16:48:52 -0700 (PDT)
Received: from LeoBras (200-236-245-17.dynamic.desktop.com.br. [200.236.245.17])
        by smtp.gmail.com with ESMTPSA id j16sm6708518qtp.92.2020.07.01.16.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 16:48:51 -0700 (PDT)
Message-ID: <0c3de45dfb612745aa2ee4126b3935303d8e8704.camel@gmail.com>
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
Date:   Wed, 01 Jul 2020 20:48:42 -0300
In-Reply-To: <0e8bcc38614ec80c7816c07dd4dc70854c2b901d.camel@gmail.com>
References: <20200624062411.367796-1-leobras.c@gmail.com>
         <20200624062411.367796-6-leobras.c@gmail.com>
         <18df09c0-ef83-a0d8-1143-1cb4d50bf6b7@ozlabs.ru>
         <0e8bcc38614ec80c7816c07dd4dc70854c2b901d.camel@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-01 at 16:57 -0300, Leonardo Bras wrote:
> > It is not necessarily "direct" anymore as the name suggests, you may
> > want to change that. DMA64_PROPNAME, may be. Thanks,
> > 
> 
> Yeah, you are right.
> I will change this for next version, also changing the string name to
> reflect this.
> 
> -#define DIRECT64_PROPNAME "linux,direct64-ddr-window-info"
> +#define DMA64_PROPNAME "linux,dma64-ddr-window-info"
> 
> Is that ok?
> 
> Thank you for helping!

In fact, there is a lot of places in this file where it's called direct
window. Should I replace everything?
Should it be in a separated patch?

Best regards,
Leonardo

