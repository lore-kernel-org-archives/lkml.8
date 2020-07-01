Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C49C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38FBF20663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzE31B2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbgGAODH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbgGAODG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:03:06 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48582C08C5C1;
        Wed,  1 Jul 2020 07:03:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x3so5516537pfo.9;
        Wed, 01 Jul 2020 07:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=RMM9Z9iqlVaLrecC9159bXlUvQlK4CIqEqnJXgl0LBg=;
        b=ZzE31B2owR1axpP7mYfwuJ7ByeXlub2RI51vzy5ICs5QskYcnElPcGF/uzVE/6R5yA
         /33VzijNVDZObmPtmhswp7GQEdiau/6IbduGtM2oePRXbZvBMzI6mUn6fhTvk9haZA5c
         GNoJe41L7AxpG6lAVvFXDKbAoZkEeiLobAFmWVO6XHaUx+HacmlQODT2R0TtpTwdVKhd
         ziFrzaWYOMrpKr9IHYCkwjUsY+DBgdI4+8wcpgDIpbcRhMrVSkPmczzZQtS9SMqFKQCo
         RVa7twrdFgXX1WfmJA29BvMpRFUOc0gEYKF5GLV2cUEYUCB04jP6yuPq2YF/7scGfKn3
         LdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=RMM9Z9iqlVaLrecC9159bXlUvQlK4CIqEqnJXgl0LBg=;
        b=E449t9t0MkJS2ZmN4RSVrDGp66ULuxUlCNakY0bDfGFGaYMWQBKTUkJC3MTWfRNI2o
         bOJuMf3SzUYH5ozQ6R6uQLUFXvh76gxM0lg4UHIMla341FevMGOWOd/2vxYwdIt5tucv
         YLyeVh/lSYeAw8vJsO1qUPtqJI2udWYBK4h2eu+29ajdpAmUOR/nMsRn/Zi8CIem7OHE
         8KlBrgjN9X7HtwQeX6ILKiwRDDuDjwomdJiMgbft9kltcVj5fdHizTWQ+r2FnWSChIPM
         vEKdFN1jZdo6oUQxJaj8JpQkPP2QIGg6NJt+5q/D7ZqaDJhxnIyer0/Nm/v6ZhE1MWn+
         qwBA==
X-Gm-Message-State: AOAM532u6yrfzSI27qf92VZP0aW73lF6n6PaqttsjitiV41WxTmUtQIe
        KJRGl8Xe3YSMqe9swXLpDniW1yhQUPc=
X-Google-Smtp-Source: ABdhPJwK1gSyb6BqnZnNGzRFKYis0IPoxy9s7luGlbe6f2nIJBQgiEIvKx84HquKvQmcnNG7mMI2mg==
X-Received: by 2002:a05:6a00:2bb:: with SMTP id q27mr21826479pfs.176.1593612185922;
        Wed, 01 Jul 2020 07:03:05 -0700 (PDT)
Received: from [127.0.0.1] ([103.86.69.165])
        by smtp.gmail.com with ESMTPSA id w17sm430114pge.10.2020.07.01.07.03.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 07:03:05 -0700 (PDT)
From:   =?utf-8?B?6buE6YeR5rW3?= <2538082724huangjinhai@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC v2 00/27] Kernel Address Space Isolation
Message-Id: <53ECD40A-9BC1-4C1E-B089-21BC27264219@gmail.com>
Date:   Wed, 1 Jul 2020 22:02:58 +0800
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, graf@amazon.de,
        hpa@zytor.com, jan.setjeeilers@oracle.com, jwadams@google.com,
        konrad.wilk@oracle.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        liran.alon@oracle.com, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org, rkrcmar@redhat.com,
        rppt@linux.vnet.ibm.com, tglx@linutronix.de, x86@kernel.org
To:     alexandre.chartre@oracle.com
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How about performance when running with ASI?
