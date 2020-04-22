Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F337C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244D82087E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0a3ct1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDVMz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbgDVMzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:55:55 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32459C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 05:55:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j3so2134526ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 05:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=bBQf8SISgLuPMTcD8HTQlSGzFX9/De6Tiouw/4dnZPQ=;
        b=G0a3ct1L25MVhipFG16VTNDTUK1bTIA/S8CjR6Mi0L5f2i2Yq3ZZ42vofDhg/dtOEQ
         zuf5PXlZDL3XPoMR1FQ+AENCMOeBlxyWtxLSTXChzMovfLK2fYkDLcDyXTh6jvNQ0Ufn
         BTVEyyOe8uZv6uJo5pbFBGOGKm7fJnYvZ3d12QNtbhMWJXK8+mTKL/BeCNYstiY3hP6h
         y+5vsIyX2xvP4uzZSoQbDrjyFd8IsJzU/baOHdE1VO0ztsDS/ZZfp6ZzN0L5cX56LrpI
         Sb1ixS053mfBgfD0oM3+upIGloN4bbDDVaMm2tuL6fOcamRp2IJ8c6ShGCDhiMmaC12W
         N0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=bBQf8SISgLuPMTcD8HTQlSGzFX9/De6Tiouw/4dnZPQ=;
        b=Kpz5HE7sTZ+KoQYuIO6KMPEpBH/3tloOSJmSoaTsbbJ0RIJsMz4f07HZSMWKWqx13T
         b1OI/fLSpnaE5ozttCkzVgrchwaGBoQfVOX+ToKcJRvsuANDUEgBZic2j8ZtG+ZQps0c
         cYA+zGnnTxFQnBz7EpqbZ0vYc41igDtR+I1pKfHbmPma+tW1l7Q8FneeypWkpJCi0WyL
         1BwfyL0O22k80BspqQSIbilVFvDh8CfDBZZe5F7inEHtGb/cPaMn3xRz4nbmwgNlXBAE
         CbEN+a/tWr9e5raxpIR7Nc5YvEG8qxM/qBWo9tXSkFxiB5m4huSd4APa+LdAGNeCnQd4
         Qpqg==
X-Gm-Message-State: AGi0PuYyVLoEEOFL75Imbpp0faN+0uGZkYv7mBMDsqSXs+LX9SYv8HEX
        z6vasDnx/R8U6pynEnZl72Ue5QCsO3I=
X-Google-Smtp-Source: APiQypL/GYEwouGFmbbsubst5LxsQnAFum7WkVI2zc9hP31+izrTAalj/FVkXld3acHlkGoOn4Ij1Q==
X-Received: by 2002:a2e:9256:: with SMTP id v22mr15869197ljg.286.1587560153430;
        Wed, 22 Apr 2020 05:55:53 -0700 (PDT)
Received: from [10.11.11.4] ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id v7sm4565435lfq.55.2020.04.22.05.55.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 05:55:52 -0700 (PDT)
From:   Martin Zaharinov <micron10@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Bug Report High CPU Usage events_power_efficient
Message-Id: <E2C5FE67-C85E-469C-9B81-10F7555F836B@gmail.com>
Date:   Wed, 22 Apr 2020 15:55:51 +0300
To:     "linux-kernel@vger kernel. org" <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Qian and Greg=20
With latest 5.6.x kernel have problem with events_power_efficient 28488 =
root      28   0       0      0      0 R  95.5   0.0 101:38.19 =
kworker/2:1+events_power_efficient Process start to load machine after =
3-4 hour and load not stop only reboot machine remove process . Server =
runing on AMD EPIC CPU 2x 7301 32Gb Ram Have 2 x 10G card Intel when =
machine load over 1G traffic machine locked and only restart fix problem =
to next load . After move traffic and server stop load process still =
hear and load server ?
And after reboot process move to other core .

Best Regards,
Martin=
