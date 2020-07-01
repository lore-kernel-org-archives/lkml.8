Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2499FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED55E2065D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZAuh+y9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbgGAOAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgGAOAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:00:32 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C09C08C5C1;
        Wed,  1 Jul 2020 07:00:31 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x3so5513319pfo.9;
        Wed, 01 Jul 2020 07:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=RMM9Z9iqlVaLrecC9159bXlUvQlK4CIqEqnJXgl0LBg=;
        b=pZAuh+y9YXGaVkwmyTNUK6rVb5i4bnUpiDREGSnus4X/ugdZRpeNJeddmgt2CeqIIr
         w2c4OVMhwQiO1GgccBybk1jq8f1E4IGV/4q8oo9psl8AbVn+QVcKb11QbcXYndTCPhAV
         Ai2vqisWmo/v2MuEECmKBh15t0ZmHBtgXYH9yiJ+8Ur6GtRlmb7mm4/iAfDVuZ7UdTDi
         6/HHKzQARUw61lMZFWv+UPAIqLVFwOd3BMRrkwHEu7upmT6kfRh550kd2PlvqDMM/ZhV
         1S53ywOnmWkoxbheuogOHFVhv2JBljyvbfISS0EX8vG7kk9OGzFuE2de1EKGjRd+pObu
         mbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=RMM9Z9iqlVaLrecC9159bXlUvQlK4CIqEqnJXgl0LBg=;
        b=kdEW4loQ4pZO5+Q03XTCRUe3Jmy9ZYNXuWkfX7ui4TTgwjvIuKLskN+KfDszY5jvW4
         4JNjGkJpqkEdqZL3Y0rHjjT2eazZb9k/0uQTvStdSzX/S2oTkxrFqca/zMVO87iZkkN/
         ExwF48m8uVtGyQnbN0p6YhxhR4LRt4nGmlo7y/Q+BxUI2KRWHjoRDblFN7iIW6khMBR9
         rB1x+r7DNGleCkgA3TqkM2zgeGyfvO+sCdyQJ32nKopxC2wgbmJHtDC+J1Ur4rDNXuPu
         owaggoY5CoPqUv/XnBsxO7gsawATDb78SOEbbsFPZMJcVtpIPJooS0oyWxOV/DV9A+Pd
         A58Q==
X-Gm-Message-State: AOAM532VAfobf1eLC8VJZHB0I/UdQWQk9vadLIN8+bPOepc2NLRdyrSv
        2fNzeaIgxO1QZEWGwCWhubA=
X-Google-Smtp-Source: ABdhPJwtk6aRJcuPXjkOKXQshN2ut6gJt10I2Kfi/lrupW+nTf1iy/lFADeQ1J3AKozf8HIhyxok+w==
X-Received: by 2002:a63:6ca:: with SMTP id 193mr14832979pgg.269.1593612031585;
        Wed, 01 Jul 2020 07:00:31 -0700 (PDT)
Received: from [127.0.0.1] ([47.244.202.117])
        by smtp.gmail.com with ESMTPSA id q24sm5905573pgg.3.2020.07.01.07.00.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 07:00:31 -0700 (PDT)
From:   =?utf-8?B?6buE6YeR5rW3?= <2538082724huangjinhai@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC v2 00/27] Kernel Address Space Isolation
Message-Id: <43B183F4-DDAC-4C68-AB1E-9CE5406CF43A@gmail.com>
Date:   Wed, 1 Jul 2020 22:00:22 +0800
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
