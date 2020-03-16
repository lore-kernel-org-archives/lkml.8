Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0DDC10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4901B205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVHfixay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgCPBHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 21:07:21 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:39226 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbgCPBHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 21:07:21 -0400
Received: by mail-pl1-f175.google.com with SMTP id j20so7191167pll.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 18:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AdzzcWZzSLtBeY98jfj+Ttbq0//K3mBqiWsgbXV2zL8=;
        b=dVHfixayHEKTXc/XWfKhNdYavnYcYYJzdIht0p1JsXL5e6FUa11n+KMtNe08OQDx/p
         yV6zzaMBL8xNRXFtnDN4qqoVWmNy6aqW63aLTS5jL1gWsg1AWQloYur04fKnZXCtTfM7
         rvWzhUFJi+qBpOpHlCR5pnxCv6hMRPm+6zaGrGd2s7dy/PaMkIp3zmwBUzyYEBhNza/x
         5LoNSHxzk0inKteYu5aNAHFFVNywWxq7TbYOzzA7Uk7VpIiPrBjg4Zdmzn/h7f4xfNyf
         0Io/qvRVUE5av9RdXzD6DLaqzmmTYrg2/vjKslwzEHwti72hcTntyOj91CVeDithdsa3
         g4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AdzzcWZzSLtBeY98jfj+Ttbq0//K3mBqiWsgbXV2zL8=;
        b=caWk02Pp7pPWDryBuABEaSX7EIjgoORo6VtUIUMCuWZlK+JXUMSqENMIO9qGsX231R
         GC3UjznU9z3fJo/GgHbqa8kbzzA30BjiIypNj2TVkaAJfiM2UB0+UjdnRN9oRVYlhQYh
         27UoQ+KlwEVwC4QtUcQuuzWjUVBnr2Br1bP6Gf/2tBeFurapBPCI4Nb1egfkTzQBcUr3
         NPLsyYdWqte03WKJZMDyMxfSsE4usTrdb+mWztAJGHNByl0WH7aGwwlP3X6caG0WvI15
         FbQtD21k6QSuwDgTvZ5DKI+BjYA8vSSkW6BO5EfmjTg1H39+nO/oKrGx7k8AG9nlc+n3
         t7AA==
X-Gm-Message-State: ANhLgQ1Z7K7AfmEi/05QUU9NjuxByhX3Yd/h0el1IvcFmfqoa1IMdjfg
        rnLDYipCTjvipqIqgYYRFNd1MKn3T0Birmz4s8CzaLqk
X-Google-Smtp-Source: ADFU+vvGJZn87Sx9PqJeNj6PyWSoCxLimXp+WMA9MGsRcxFemmWW+3p+7FekRwBIGQJCswBJUNjZ0ZGuKobVMChGWp0=
X-Received: by 2002:a17:90a:858c:: with SMTP id m12mr22286040pjn.127.1584320839194;
 Sun, 15 Mar 2020 18:07:19 -0700 (PDT)
MIME-Version: 1.0
From:   Javier Romero <xavinux@gmail.com>
Date:   Sun, 15 Mar 2020 22:07:08 -0300
Message-ID: <CAEX+82KEmCXyWjQifTR5fEW8B27PN+BJpaGOF39ffsL1kawiWg@mail.gmail.com>
Subject: Contribution to the Linux Kernel.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My name is Javier, have been working as a Linux sysadmin for the last
10 years and would like to know if I can help on the Linux Kernel and
contribute as a tester.

Thanks for your kind attention and sorry for the inconvenience.

Best Regards,


Javier Romero
