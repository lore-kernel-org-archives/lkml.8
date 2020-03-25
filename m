Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7E5C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122FC206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9UmJpjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgCYImQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:42:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57031 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726842AbgCYImP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585125734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=smUYnakPG6mkNAQMrLgQAa6PIyDVkKbu5dMb9RgLsj4=;
        b=E9UmJpjBOJxG55DcRCW2cvfwau8Dt07SjIb2tIHbbCAg3nSOFvyVPb+1I/LV1A5xpUEiny
        L29IVaX2VWP5Ef8VBJuL4Z8yEbaZhpI1eLPSdz9Ly6D4g8A+h1nZGJuiubA80mtEtCacXF
        OiEqnzEWHjKCI/kt+Pfi84KyIRWEl8k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-qYBfVJYmOQmqLPLDMzoy9A-1; Wed, 25 Mar 2020 04:42:11 -0400
X-MC-Unique: qYBfVJYmOQmqLPLDMzoy9A-1
Received: by mail-wr1-f72.google.com with SMTP id h17so795628wru.16
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=smUYnakPG6mkNAQMrLgQAa6PIyDVkKbu5dMb9RgLsj4=;
        b=ZFtkX28GWtGsKEiuBtyGMPseD8ArBMl4VFt7oSoFTfUEypEwkN1kjJPA8ittmp62tQ
         xaNAxzJ/cJb7iZyaxsx5C1fVDOKdkKJ5n0Xo2PQtv11Suh2Z2OkhoB1juECndwO8szp1
         pRLqxOmJ8M28XlYkBaTbuM3dAMwzp0pp6LURZEegeTNgMnWeHAjfzmE1t51YKZwU3VTs
         SeltpDLoBbFxk3xlPDvAFM98PnKjOnhUJ4UXOEXFgQUkgtj1rVBgcNv2xB31PU8ikxWd
         7+nW9YxfWPyaSBZFdIKac1RC8it8gVuE2Ou5lU2Cmm+bWWwBhriA3Q8Hqp53kTnriQu0
         1rOg==
X-Gm-Message-State: ANhLgQ3gw0ltMdGkTZHbeLY4YxKfas6PBJui3Yd+nHz26ZR/oVSpIre3
        BRGgzrcxJUcvALE789TkO8S/zvff23SoUijiji2mNi/QUFD4Mzr13U09pXFkGrQH3pt6+WRsRFz
        zhHuEtR1agOuZ9LlHvITIJU+g
X-Received: by 2002:a1c:2842:: with SMTP id o63mr2312101wmo.73.1585125729926;
        Wed, 25 Mar 2020 01:42:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv8Ylip5kjvYuDXlkgykCDWsTxj3N7Eo5Bht30Y8qdaqXNUvCVSrgP6KFQ3HIYEfEjxOPHWbg==
X-Received: by 2002:a1c:2842:: with SMTP id o63mr2312074wmo.73.1585125729642;
        Wed, 25 Mar 2020 01:42:09 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id f12sm8055323wmf.24.2020.03.25.01.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:42:08 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 00/10] Objtool updates for easier portability
Date:   Wed, 25 Mar 2020 08:41:53 +0000
Message-Id: <20200325084203.17005-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset includes some of the least controversial changes that
were needed as part of the arm64 port [1].

It consist mostly of small fixes or lifting some limitations to make it
easier to support a new architecture in objtool. Of course, these will
not be the only required changes, but these are the ones I hope make
enough sense to be merged separately from the rest of arm64 port series.

The patches should apply cleanly on linux-tip/master tree.

[1] https://lkml.org/lkml/2020/1/9/643

Thanks,

Julien

-->

Julien Thierry (9):
  objtool: Move header sync-check ealier in build
  objtool: check: Remove redundant checks on operand type
  objtool: check: Clean instruction state before each function
    validation
  objtool: check: Ignore empty alternative groups
  objtool: check: Remove check preventing branches within alternative
  objtool: check: Use arch specific values in restore_reg()
  objtool: check: Allow save/restore hint in non standard function
    symbols
  objtool: Split generic and arch specific CFI definitions
  objtool: Support multiple stack_op per instruction

Raphael Gault (1):
  objtool: Add abstraction for computation of symbols offsets

 tools/objtool/Makefile                    |   5 +-
 tools/objtool/arch.h                      |  10 +-
 tools/objtool/arch/x86/decode.c           |  24 +++-
 tools/objtool/arch/x86/include/cfi_regs.h |  25 ++++
 tools/objtool/cfi.h                       |  21 +--
 tools/objtool/check.c                     | 157 +++++++++++++---------
 tools/objtool/check.h                     |   3 +-
 7 files changed, 159 insertions(+), 86 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/cfi_regs.h

--
2.21.1

