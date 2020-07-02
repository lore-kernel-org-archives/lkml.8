Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295C2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F39CE207F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtyRtQb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgGBAgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgGBAgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 20:36:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD832C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 17:36:19 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c139so24060040qkg.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 17:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=lQHf+0bVn/Xs5pc4jD6G53UgqJbz7a3lP2qgiE8LNco=;
        b=GtyRtQb25zFFlLbHaH+CWPKcfFazJsquvMrP/fkPdgNoT5FtUTuaj9gX5hY/I+zBck
         PBui18eYLlIT3gfLOTwn5wTY/HqUSIC9UoGmPMIqSBR5A/GB2489NBFh4JMhY3FQmNWC
         NGLhuLau9Ughq6VgWhpZgvY2m4w84nGEkQfQyhP8tXscmR8neZrJlfqJ2Rk8BxIHl+8e
         RhEtfBBLx8pTik/01jknPv7U8V6UueK0+K/YCnjbh5F+5NSI2R2tP3LTjbJV4tBjc5W2
         VPiQbuUBDwmj1reEylN2+dXEdjkgPNoZo3VjDXVcOoEx087wuZuGQSQhzqklFhAzdoZ2
         OCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=lQHf+0bVn/Xs5pc4jD6G53UgqJbz7a3lP2qgiE8LNco=;
        b=laEJTwRgD58Lek9J2a7tJhEK2AUBlITXQ16oxuwNXutsLKDVdeH1oegJ5Mq29Tx/4/
         Pz76B4up2SJuYBy7E7TKk1b6h5y4isZbcc2Y+vRd6pw44SixNot28dBIi6qSUXbDx71T
         x9YWWyfR3pKd7Ter/hSfAvVkqDbulf5pilDuATiUD6AtGRZX1Hdd7cEl06eBOMy8Fx4H
         R45WdPKkRAu5wivwzx5KJ2q3vySHgzIXTTwXdhkTjzgAhbgWgVuW+JugKtsIiiQjD0RV
         4Qy4vx96byqOmM3qV5Hkx/muZxUD5WFSUAibcMm+JZYI4tyd5AzLEfrVWSN0K6anpjvb
         p2Bg==
X-Gm-Message-State: AOAM5325aXuPxyAcG3BwpTcPZFUZ13dPN+hWneXfPPFZY0dgVk27Ob3f
        OmUwW2OCqYC/RB4sEu47CbI=
X-Google-Smtp-Source: ABdhPJyJBesnBNF6KAvF4epCg0RD8u1qFrRivuh4zSkLTEYTAbqn7EaQ1o97VDTuVhl4VjzW8csWmA==
X-Received: by 2002:a05:620a:22cc:: with SMTP id o12mr14870213qki.230.1593650179010;
        Wed, 01 Jul 2020 17:36:19 -0700 (PDT)
Received: from LeoBras (200-236-245-17.dynamic.desktop.com.br. [200.236.245.17])
        by smtp.gmail.com with ESMTPSA id x13sm6545920qts.57.2020.07.01.17.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 17:36:18 -0700 (PDT)
Message-ID: <f1f0563dae4c81620b53bcc258f2960a7948a583.camel@gmail.com>
Subject: Re: [PATCH v2 1/6] powerpc/pseries/iommu: Create defines for
 operations in ibm,ddw-applicable
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Jul 2020 21:36:12 -0300
In-Reply-To: <a884da45-7778-95cf-d65b-a6c82d2024a7@ozlabs.ru>
References: <20200624062411.367796-1-leobras.c@gmail.com>
         <20200624062411.367796-2-leobras.c@gmail.com>
         <b0caaaa0-14c9-51de-bb92-5be8ccaa418d@ozlabs.ru>
         <01443a2f1d58a595ddff03fd14fd56f4c26171bf.camel@gmail.com>
         <a884da45-7778-95cf-d65b-a6c82d2024a7@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-02 at 10:21 +1000, Alexey Kardashevskiy wrote:
> > enum {
> >        DDW_QUERY_PE_DMA_WIN,
> >        DDW_CREATE_PE_DMA_WIN,
> >        DDW_REMOVE_PE_DMA_WIN,
> > 
> >        DDW_APPLICABLE_SIZE
> > }
> > IMO, it looks better than all the defines before.
> > 
> > What do you think?
> 
> No, not really, these come from a binary interface so the reader of this
> cares about absolute numbers and rather wants to see them explicitly.

Makes sense to me.
I am still getting experience on where to use enum vs define. Thanks
for the tip!

Using something like 
enum {
	DDW_QUERY_PE_DMA_WIN = 0,
	DDW_CREATE_PE_DMA_WIN = 1,
	DDW_REMOVE_PE_DMA_WIN = 2,

	DDW_APPLICABLE_SIZE
};

would be fine too?
Or should one stick to #define in this case?

Thank you,

