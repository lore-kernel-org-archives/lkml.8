Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060DAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6CE0204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Kp1pu1SD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgHKObx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgHKObw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:31:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B040C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 07:31:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f9so1959832pju.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 07:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r51ccutYVlFvv3X6Pg3FxNNeKuDnlu3S7azBa2+2k5w=;
        b=Kp1pu1SDNm0BNylNt4JINTScI+kwLHJxmm8B6OUWR2PDnK6V8MYEx/YDkzhIsBmxqC
         S9wuvYuXhffdKqsVEckE427oLfGgBS25OuN4+s0OGqZbJ7vZnCI7pMljVCiuf3y5Z/PN
         LPDV6KUxbFYVyJbNdZkFOCo1tEFCDpzdutjwclVvaD4I1Mmsy3QAa9FmkNlwQ0F+SIkn
         mirhXi/FiGEWDPo/ykYzDRgdID1FiTJRwWGtRLaWEHEgavUaPN9W5FhfDZPnw73D4Y6Y
         p7DyirZDdX7shpnzRaAWRdq3IzjAtiKOKCfPRE8wIATlVOD+wHpmOMe1Z/364sJXCXCZ
         Ry+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r51ccutYVlFvv3X6Pg3FxNNeKuDnlu3S7azBa2+2k5w=;
        b=gj0Af4eA0c/hBVSyMDsCJexQ5HLUo2ozQNEaj1ezSk4y+82pTW/yjlJcsJmgI9zKzS
         /7fvMrYcap+n2F1qTNxl30fcNRPZzzHFoRti75JgasSu/7KgjiQrroWMCdlBi6+MSn2b
         iWszqM2Eyrr1XSpSw1NWcUbIld/+6PKLaLMMCktm4IFj1yk8UaLG2Y2zIWeaTxFPMwI1
         poOSSwJx64R4wFXMB1nZTT5C2r8FpARWb6F3QsMIrnlRExXeHrjfIiAdp/QmZWEPfKk2
         bYpT4EiEQK94j7+SQtK4TygcoFwAFJ+jBSY91L7PGdYIaBIoUI1W+VEfK0f9GVtiBz+s
         pwmg==
X-Gm-Message-State: AOAM532Rc47ILLDIQWl9he/KYkg42guRArxmeLWRKiUmU3Fno5vqEYIM
        SbmMDrsmBlU1oYD6MmoGpjRcI4PYbZw=
X-Google-Smtp-Source: ABdhPJxSKd/YCS1pOSqvXcMNR74J/k27E2Jd0I5nhrwX6W/3qRgr1pFsXx6t+AxiXggh5mmsDAxSNw==
X-Received: by 2002:a17:90a:fd81:: with SMTP id cx1mr1397254pjb.90.1597156311351;
        Tue, 11 Aug 2020 07:31:51 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id m29sm21189235pgc.55.2020.08.11.07.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 07:31:50 -0700 (PDT)
Subject: Re: [PATCH] ext4: flag as supporting buffered async reads
From:   Jens Axboe <axboe@kernel.dk>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
Message-ID: <3ca300d1-040b-fa1e-5cba-944bc9a8d158@kernel.dk>
Date:   Tue, 11 Aug 2020 08:31:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/20 5:02 PM, Jens Axboe wrote:
> ext4 uses generic_file_read_iter(), which already supports this.

Ping...


-- 
Jens Axboe

