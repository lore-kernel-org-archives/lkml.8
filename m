Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496ECC33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA18207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8trnNxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgANHUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:20:48 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:34656 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgANHUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:20:47 -0500
Received: by mail-wm1-f45.google.com with SMTP id w5so1589947wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 23:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zNp+HRj7ISDym9fLxoaemCs7LgB3434L4W/O+M4YFjs=;
        b=r8trnNxblKgUoOmqb43NmLJp4+5aPxqwlE5iP/4u3pusZ3UvLqCmyPYP7/Wp9sbCY3
         WJFMVbMM/d1acwdZAkzE+2zKIMpMYyxzdvQtSsLGX5EoaiZ31xCsoWpkd4SL1u4sam2r
         +v8pxrlYymUDdBlKTo8deRRBRUgZ2zTsNeuTOmStFowb4WRvrx+1A76g8wGAWH0p5jc4
         35D49OhosexyRcmfn3ci/TAI962mDT+4UGnVKTKA8IQvUFpfMvpTo8MCyhNN5dsQI52G
         5KO4g9Lfjz0WVkJvFTol1REblocvCoHjYcfIbZ3x2WrYX+103n+iG+RYraBORt2gVaB1
         Ztpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zNp+HRj7ISDym9fLxoaemCs7LgB3434L4W/O+M4YFjs=;
        b=glQKH2x+fgOY6XlR4urPkllb8CoCo3IzwdlSl9eOuYIz/h1CKKWg8JYcNC5TyJsAgq
         fs2wart3JnIq2m3QY9E6G8EXhB7p22vYdHq1WXQQUBWT5CV1nYT0OzTxRKq3q86BH7bD
         ifftAEvu2jTZIS6qgMYkYtXeqAvvnKNUSiVj9WQei4lcKE4cNuh2cLFHsfEMOf+sFlEr
         mwseck5Apl7hU/g+zwHliBUdc5ksKR+AKRwz8uZKU7VdDisilxFfqitEpnHK3Jpokmtl
         BA5IPLoXtQfFKgoOMCgBRnzH+ekiElZcX6ouIYIF1CoSiJyzDLwW/MCamu3V7Ks9I2n0
         inWQ==
X-Gm-Message-State: APjAAAW9g8AmYzs9ns0zWKvmPqv2QBylwMh4lBJnGSCDG/wTPIV1DViK
        iM/tWUM5WhETHwoET/66MjSQUsI2zTAcLJkDqkRl84MK
X-Google-Smtp-Source: APXvYqyXMUx+o1dWPAx8gCuGBY5fP/32UigUDie5AUPIr6i8pvWrC3VrlseVsuIkoxDp2Lv8CztYY/a7FskuuI1bpw8=
X-Received: by 2002:a7b:c084:: with SMTP id r4mr23874578wmh.99.1578986446260;
 Mon, 13 Jan 2020 23:20:46 -0800 (PST)
MIME-Version: 1.0
From:   xuesong Chen <xuesong1977@gmail.com>
Date:   Tue, 14 Jan 2020 15:20:35 +0800
Message-ID: <CAJKSTDwPX3D956yMaNakgjbHSd7hyyU7YbGN-nM=LmR3qXMtxQ@mail.gmail.com>
Subject: Question about output of kmalloc()
To:     linux-kernel@vger.kernel.org
Cc:     xuesong Chen <xuesong1977@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Below code snippet in the .ko:

unsigned long *p = (unsigned long *)kmalloc(sizeof(*p), GFP_KERNEL);
printk("Addr of p = 0x%p\n", p);

The output is:
Addr of p = 0x0000000018606ce7

In my mind, during the early day, the p should be 0xfffff...., can
anybody give some tips why the output looks like it's a physical
address?
