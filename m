Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D815C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526582067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m5S65qmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgGMQmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbgGMQmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:42:01 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F21C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:42:01 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j20so6255465pfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=D2p8l4RwF49IaqlGNhFNX2PDV06ZlxWtnVEnPdUoVvI=;
        b=m5S65qmfAtZ+DE6jugUsn8dEUbqv/Od3SPF9f/W9FSZBQkdNPKjvKWE2boVCT6lXgO
         E8YlghSYcJ9cGJjOWRtHAekPaSoOQ7oqvC+Uqgfjck0RsnfIcSFMxhEXkmXrb9KxmtC/
         T5xnq1otpS6eXZAzJoLSoOXD6HfaAQDi5y5jpNz7AFkLkbNL12AKXTX8zPkVwUnauHrq
         MVlNIg0A6QrPRXvovutsReTUOY5VF7Cph4Z4NAlAiFRB3RjswipwYtUdKyum78dpGRmo
         2yKzdKG7dg3vrHVwTFnBMXedvw8QAiwXISKONtYvVUGkYyQh0OhjpVV9pElnPD2wfomr
         LbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=D2p8l4RwF49IaqlGNhFNX2PDV06ZlxWtnVEnPdUoVvI=;
        b=ky0gCuhmUnXBn06Oe2FQxuUNxoXOdNDBUovPXbEfChslI8tztT3ATei2qfZ6Jpy2IJ
         nXQlLDJgkg7/fJbdd6NvQXUnfssr9Ql67poQYDGHP6olSyUa5pDDeZNyov5hnRerVd2+
         CFbfPj9772qKApdygOM+3SQiTQwYTw1Xib5Hlg+rcINp9w+QpR3URv8nUct3br9CfmZP
         jQo6+gnF6x+opaiEDvkbbFZ8NlI+gB38XoP1Rm2bQEaIhCjAiBkf+iRJzYwrOz1E3XyG
         Ock0TY/npA+otP00mnUO/MnW/OERet9HWuhuGPLR01H6zMQ84MDg6k5VAD3wd3Ni3o57
         Q76g==
X-Gm-Message-State: AOAM5309cOsNspUahu5hXJ8i1QwbwHMSSsrVgzzRSUg+T5ilaHHbcy7I
        KupmApQsaW0iaAP2aX3OdssTrKqh0BdDxnY04XsXvQ==
X-Google-Smtp-Source: ABdhPJxNzaUg1VYYGrzhokFLtflG3YjdoqVeK+4vCAApZU91rqUmtpGucUbX0k0uo97Mx2Lr6oCeAPObb5srhfy+MOw=
X-Received: by 2002:aa7:9303:: with SMTP id 3mr682479pfj.108.1594658520341;
 Mon, 13 Jul 2020 09:42:00 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Jul 2020 09:41:49 -0700
Message-ID: <CAKwvOdn-2E=v_7Uie71pz2jjYCKnk98K1Ly8EkpxzvC6M5pXFA@mail.gmail.com>
Subject: linux plumbers + clang + s390 virtualized testing
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vasily and Heiko,
We were very excited to see your patches going by for enabling Clang
support for s390.  Since then, we've added s390 builds to our
continuous integration setup.

We've been running into a few issues with doing virtualized boot tests
of our kernels on s390.

I was curious if you'll both be attending Linux plumbers conf?  If we
carve out time for an s390+clang talk, would this be of interest to
you to attend?
-- 
Thanks,
~Nick Desaulniers
