Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74696C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F092206F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQzX+2Vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEFFqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 01:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725771AbgEFFqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:46:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D25C061A0F;
        Tue,  5 May 2020 22:46:08 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v4so4049696wme.1;
        Tue, 05 May 2020 22:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=e1TERoguEz9nk9SqrBe4h2hEZb+u/o5PdVhS/pRqBTs=;
        b=nQzX+2ViQzvd+cAHmw8E26W4zg2ynvV1O7XGCCWjkmPE8yr1TuOgSyROEqK2LXe7mC
         /ZdJOdPCn9zcO4Z2k5+ZoTOukmHTD++IsTXObJS9u5orKzGFu6pMKngSG5SiklT0z7JY
         MKwwOTDBpJblyhMC3P8AZXAiLhH1302coDd051UyMMeTmqBHPzjfxxDO/ADsasDl2bk2
         j8UciE49pTr6y/0PEczn0BSD8iVbg9FwHFjOk03oyeqjhJ77nnlwz85JV/yflJmi3UDu
         PmPI3IgJkzjUVM4TJS2nuefzG92pkpEbt1bwyfRJwHX7pPDcN6fb8IJEy2rqDgymB9CR
         KoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=e1TERoguEz9nk9SqrBe4h2hEZb+u/o5PdVhS/pRqBTs=;
        b=Wu3Bn7kYjStqkVdl+jZSSRAlyMSG3na+3g2ok8tbZvnDwWoaoBmdnjWIe2+Ud8uECf
         LsCulcDlhuGqS/buSfmwtf11VERYboFypSRohY4y9UFdnevYiivhg/g3uHZsFp/aeW48
         F5zzInKMCucjDyEeiUkIT2nPSfD8OkvausxgF9FEYrWEhUqvmHbpJ41XOcfBZFuEBqnM
         OkdybOhibgopW/ESGI1ujajRe8HhPsdtEwiz1+1tHpd4M0x65Y7VdkOSDrd+FAehCB4P
         ND3layjBJVsQkzPA3GaypL5Ane6BK+we/akGHxJA9ISyTMYIJcFijrobnQEkYYMz/oEm
         rD1g==
X-Gm-Message-State: AGi0PuZW1hsnpfveBhlfNkOAn0nrEO9ITDowDAuMl8X/Zq6C8gi5rOnn
        I4Yigk70eXVr+iKJ12gwppI=
X-Google-Smtp-Source: APiQypK+swIcBwcJSK76JFD7UfaycsexUHBN1orynIhwHQPeXRQMb327hZdVIdxBOeBBuwGl0BXg2g==
X-Received: by 2002:a1c:9d8c:: with SMTP id g134mr2392953wme.79.1588743967070;
        Tue, 05 May 2020 22:46:07 -0700 (PDT)
Received: from felia ([2001:16b8:2df1:2500:bc2e:80a7:2be5:2fcf])
        by smtp.gmail.com with ESMTPSA id l6sm910337wrb.75.2020.05.05.22.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 22:46:06 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 6 May 2020 07:45:57 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Pierre Morel <pmorel@linux.ibm.com>
cc:     Vasily Gorbik <gor@linux.ibm.com>, Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: MAINTAINERS: Wrong ordering in S390 PCI SUBSYSTEM
Message-ID: <alpine.DEB.2.21.2005060741520.7719@felia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

with your commit de267a7c71ba ("s390/pci: Documentation for zPCI"), 
visible on next-20200505, ./scripts/checkpatch.pl -f MAINTAINERS 
complains:

WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic order
#14723: FILE: MAINTAINERS:14723:
+F:	drivers/pci/hotplug/s390_pci_hpc.c
+F:	Documentation/s390/pci.rst


This is due to wrong ordering of the entries in your submission. If you
would like me to send you a patch fixing that, please just let me know.

It is a recent addition to checkpatch.pl to report ordering problems in 
MAINTAINERS, so you might have not seen that at submission time.


Best regards,

Lukas

