Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC33C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177B620675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZEYifmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgGFWKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 18:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGFWKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 18:10:17 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF185C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 15:10:16 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id s24so6276130pfe.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 15:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TeMNibGOk1cRjLoij7HYXan5nG7TvCCfcPYSz+A8zvE=;
        b=cZEYifmyM+6ev7oAnrBGKaUTN0mINF31fNNc+bUqvmwPXf6p5iEU4fJgk0bizX+3dF
         St1e3DxczAOooShYVpHq+AkKH5xy6Oi46AEcdeVk8TYdGI5H50tH5fuWLbyDE3HPvXS2
         kTcHckVuGDaoorNgsEStRSEnt5bUl2/BSUu1VOqSw6jPBKGAFYk6hLZ88YOnrMbYYVSh
         UdyZNo6i3WcgQJ9qGiz3MlybhjziEnp471F949jLEit1RM0QxM6f5Nj/G6/qlOS4CgIF
         JP6IbL6CITsc3v8dmFEsEUlsm62V67RuNxr1LU3JQZQWV0EoJKQESgCr6JT0fasvID6u
         kAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TeMNibGOk1cRjLoij7HYXan5nG7TvCCfcPYSz+A8zvE=;
        b=mbFVm4iqcjjnO6pq0ARqKT4WQ56X15Gtb93k5W6cIbFF2vllsHFomI/Jf8uxi+Ywk7
         sARa/I3C/Qz2h4DiIFQDwBKYAqsl6vNG1qtJM8E0/EpDz1xnmODRhMKrr5yfCRaD/OLA
         uivnyM7PRlK3fnSiDHoAeozrjtYgSfNliK0eABEbZoFxCtJviOtEJWc8uBr8C1hGvUgi
         mu4H+nk3DMtyu5UPbk4H/B/+GdGZL3JwupDkb162bFPHeRdPBEZJMZbYki7rlhkyxzdV
         737lF2mwo4A8NLkbI+b6h8PxGA+Se5oEemxQVqh2CGn6rI2RPXNF0gmmJsIH9p6I3Ddi
         nkaQ==
X-Gm-Message-State: AOAM530ueR5ufpOriEyREWZNkaFtErFv0Qm5pMsqkWMQ5P3CgrBioLe/
        ftTL5+n3u0DAMQVKU64JKbO0zH7ay7AEhwdo
X-Google-Smtp-Source: ABdhPJwv2YHMmYmDlYgUO0fIXVCDCX93tVi8nTqSYEG+geHToZYhy2QPI02Z25vhXH9dMH42YgYaJA7j/PHMpNNC
X-Received: by 2002:a62:ab15:: with SMTP id p21mr46098016pff.146.1594073416397;
 Mon, 06 Jul 2020 15:10:16 -0700 (PDT)
Date:   Mon,  6 Jul 2020 22:10:00 +0000
Message-Id: <20200706221001.1996816-1-linchuyuan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v2 0/1] hwmon:max6697: Allow max6581 to create tempX_offset
From:   Chu Lin <linchuyuan@google.com>
To:     linux@roeck-us.net
Cc:     belgaied@google.com, jasonling@google.com, jdelvare@suse.com,
        linchuyuan@google.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongqil@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per max6581, reg 4d and reg 4e is used for temperature read offset.
This patch will let the user specify the temperature read offset for
max6581. This patch is tested on max6581 and only applies to max6581.

Testing:
echo 16250 > temp2_offset
cat temp2_offset
16250

echo 17500 > temp3_offset
cat temp3_offset
17500
cat temp4_offset
0
cat temp2_offset
17500

echo 0 > temp2_offset
cat temp2_offset
0
cat temp3_offset
17500

echo -0 > temp2_offset
cat temp2_offset
0

echo -100000 > temp2_offset
cat temp2_input
4875

echo 10000 > temp2_offset
cat temp2_input
47125

echo -2000 > temp2_offset
cat temp2_input
34875

echo -0 > temp2_offset
cat temp2_input
37000

Signed-off-by: Chu Lin <linchuyuan@google.com>
---
ChangeLog v1 -> v2:
  - Simplify the offset reg raw value to milli ceisus conversion
  - Substitute the temp1_offset with dummy attr
  - Avoid using double negative in the macro definition
  - Return the actual error when i2c read/write is failed
  - clamp the value to MAX or MIN respectively if an out of range input is given
  - Provide mux protection when multiple i2c accesses is required

Chu Lin (1):
  hwmon:max6697: Allow max6581 to create tempX_offset

 drivers/hwmon/max6697.c | 100 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 4 deletions(-)

-- 
2.27.0.383.g050319c2ae-goog

