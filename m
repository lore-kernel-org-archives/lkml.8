Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60DFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D25207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mASX7545"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgFZRrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgFZRrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:47:00 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0456BC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 10:47:00 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l6so9540648qkc.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=fkFi+jmw2zi2Bpb13lGdSVxVK1RDggY+07lZfXdmWkw=;
        b=mASX7545832fQHYswKaLcmSKvWG5sESxf8V/lKsnex7qxLNKrW8ChdM8EzbqHrMlzJ
         CZVhYF5Xm5uH7Ltj6RnzV+tAdkYpjTZ0wjvgtQ9aiSeP5EtObCl4mP0+UojhavKQFHPD
         0qDzZXnQ7iFoeUQJV+aPX9aEnx+jRrHjJbeh8MxIf0XqkdQJgTKab9jA0cQ1p2uPc3Eo
         Z/XxvYy3pmPmreCjt0eucNJQJ+MwtnSPKSZQg53Ella+BGjUXW4TMXQPvL85q+OQbzDR
         s+jFiL5cmZzL41LWRGuDtVX0B1q7DdTqoUeBRtcinH3WPAcL4OTX4u66uZP14vcUc5nd
         5G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=fkFi+jmw2zi2Bpb13lGdSVxVK1RDggY+07lZfXdmWkw=;
        b=ZO1sKUKwXXMO8u4V0ONdB/X+ZrBoQKrNzPZLnrf0cOHEJbdLvB/oA8HZ7n5jRskdVU
         plzORjPKpTqReKGjoXvOueX5qmqEsd8HGkDnm1RM4HtcLDLQwvjtLBB4cIbJW6KPYJ2M
         ERccfU3qTbS43SpaFyZW8m1m74ikEp4OPnb5JPFWQLZomOZGieAYTGEIrE+FbUKaPO59
         r9v24WahzryUDMsUxLw4wlNtmQuHjuFQrjbpRe4WHxkDc6Ji9UJxeUe40XqqMl9/zwNY
         Tihj4NcmNSu96pozeURMGCy22W3/rcFHt4fviYDPen4V+i8yUug/Q8zBFoa2kP8UlB4z
         +AAg==
X-Gm-Message-State: AOAM530zYvlf4XfJHa9iqCqzIS9m9xNR8BsUlLJ075ie01iCA8jV2cAs
        s8aXRrF77VACu7UVJOOY1hk=
X-Google-Smtp-Source: ABdhPJzcWnNjR5+QzFD4mqwuojguwT3Xh2XT9wLDkREZn6Pv2pYj8gK8Nj52Eq9rql3WnO3X5yPBpw==
X-Received: by 2002:a37:3d4:: with SMTP id 203mr3705422qkd.420.1593193619293;
        Fri, 26 Jun 2020 10:46:59 -0700 (PDT)
Received: from LeoBras (200-236-242-115.dynamic.desktop.com.br. [200.236.242.115])
        by smtp.gmail.com with ESMTPSA id h185sm8257482qkf.85.2020.06.26.10.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 10:46:58 -0700 (PDT)
Message-ID: <1069466fa3a373e92d9db18957674b1d9c6e9cf2.camel@gmail.com>
Subject: Re: [PATCH v2 6/6] powerpc/pseries/iommu: Avoid errors when DDW
 starts at 0x00
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 26 Jun 2020 14:46:46 -0300
In-Reply-To: <20200624062411.367796-7-leobras.c@gmail.com>
References: <20200624062411.367796-1-leobras.c@gmail.com>
         <20200624062411.367796-7-leobras.c@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-24 at 03:24 -0300, Leonardo Bras wrote:
> As of today, enable_ddw() will return a non-null DMA address if the
> created DDW maps the whole partition. If the address is valid,
> iommu_bypass_supported_pSeriesLP() will consider iommu bypass enabled.
> 
> This can cause some trouble if the DDW happens to start at 0x00.
> 
> Instead if checking if the address is non-null, check directly if
> the DDW maps the whole partition, so it can bypass iommu.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>

This patch has a bug in it. I will rework it soon.
Please keep reviewing patches 1-5.

Best regards,
Leonardo

