Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3972C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA5620656
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWqfthpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgHESNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 14:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgHESIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:08:54 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3ADC061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 11:08:54 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id s15so16741022qvv.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=TKYRPGPLHCWrMIu7pyuuJy9bkPwY7mqum0/IqDLNX9Q=;
        b=hWqfthpN1kxgRdozFdigqWZhlrxM3Bq1/DKEB+wrmgW9FCiv+nTg28h85JfxbOgHfC
         v0ucln+sfvTxDLrxy1ePEG/JlHAlg1qJw55Ug67MVO3aRIoUii7J+1tSAQN6cpRwMvv1
         mEJ4tOMcLyuUYE73d7ak3ql37HdoU+Mum9Kt7dcX3CgEj7aa8qPDzxVVvkz0IxiTM0PU
         mRW58XLvYxRYNaw/w8nqo5r8IcG/uXrQHK9FdTkt8tzAIcI+etjkH2HpNR5u1yDxrQCb
         xk1OdDdHDJa6fVPvt1+f/tHKyZwxgAj0iYv17wCws+h54H8NqPoazwhYXap/HQVax9IN
         vBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=TKYRPGPLHCWrMIu7pyuuJy9bkPwY7mqum0/IqDLNX9Q=;
        b=CJ2xvdiYre4OAiiKo94+I6vl8aAwj0SzOvs7XDbEHEvJ7rBsqOxXBuiq8uD8hCFzjm
         w34+jVo/PTRj8CSGhvBBc8MkwgfSlkMbtg+kOfMIvnA9ln5DkKgUrJfviGiAZavLBQVZ
         T8cF3gqA7amsJS7FQOtiLlSSGWdtwQhMsgHCwC1MwcxjUm1xPzDIIPHnnHdscuS6lyU/
         kX6WcxpQ5zoGEbYswX0TAuDbRQSQ2MHzNsBEHW3EQeH5svjM5tdrStGG8SIjwADsnMZ5
         T+SsHn5TA20aGqYgzs+waYGd0T9Ru0EeaymRxFeyGFcyZotDRt52HkrVwyYCLafpV9iJ
         VmYw==
X-Gm-Message-State: AOAM532iAaw8/1JRjT3HZxsLm7rPdNDZpN3H9nrsM2zeQSlOegPhM8Pf
        RxAUw/0mp6gtHmqxembME5o=
X-Google-Smtp-Source: ABdhPJw0E/iVtQf8MQPZ3yxGZTwFzEI5nzK94oaCcxa5kXq+Gaoi4HeL8nChAJTI+0bZaA1JiLqI+Q==
X-Received: by 2002:ad4:446d:: with SMTP id s13mr4966591qvt.183.1596650929271;
        Wed, 05 Aug 2020 11:08:49 -0700 (PDT)
Received: from LeoBras (179-125-154-168.dynamic.desktop.com.br. [179.125.154.168])
        by smtp.gmail.com with ESMTPSA id c33sm2744722qtk.40.2020.08.05.11.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 11:08:48 -0700 (PDT)
Message-ID: <e60591c023173ac04057293962c498a09acc1fc1.camel@gmail.com>
Subject: Re: [PATCH v5 0/4] Allow bigger 64bit window by removing default
 DMA window
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Aug 2020 15:08:42 -0300
In-Reply-To: <20200805030455.123024-1-leobras.c@gmail.com>
References: <20200805030455.123024-1-leobras.c@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Travis reported successful compilation with mpe/merge:

https://travis-ci.org/github/LeoBras/linux-ppc/builds/715028857

