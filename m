Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0624DC28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 07:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D01DE2054F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 07:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDHDVCfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgECHde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 03:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726950AbgECHdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 03:33:33 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2246DC061A0C
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 00:33:33 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id i16so8342400ils.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 00:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GQKJl+BbA3A9PxUBVN6rpDE+fiOpG/RQeVtlH/xyTOc=;
        b=FDHDVCfMTYZ0cJrBCuZuXWVBcoGDitXwZreZgWVgqjRVHw5/iSLxrSQY1IbxAHOscf
         pPKzROVMvJUKw/Tx4hn1E2TrZ2/HQzSeMfXGMzm57ZidNFffxdQHhNaGC9XfRK9hOQPd
         u4CizrsxdHz11G9uqVkV+0cQp2nh5x0vIQ7idsq5ZlMT4Q7w9LESHrXQU320/kzXSE7S
         YVVeOQ7B14kufDY7pu3dWPAkrkpcN8VImrE7hyNIjoRqtLFzWgAXaXJouMt4nM1nmeAi
         vrxOEUCEPS31jzs78gFvYClfCJhhomj/M0YdSyJBzL/R27WIyGPSuxzpoasgSfA3QaIW
         D1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GQKJl+BbA3A9PxUBVN6rpDE+fiOpG/RQeVtlH/xyTOc=;
        b=KFtsXevOVl6rM/LEfR9bfG7XHtl2fwpJWl6ck2qX5AQEieDWmfeMphjd3UZlWqXuSs
         5SevkeJle5+HNRQeC0rTNy3ra0TDJ6ubLhBeTjUGkrVE9B45PCRSEI5cX9cQeG+sopzi
         TShbjwzrnVufNwku2fulR2Z4JWFG9Dk2YJ+IzdaEebwYHzyt3m4BC/FlnkXzDpFggYfV
         1/tv4ckOkPciuZo1IpC3a1B82UoUDdHWWAW50+s0jlo+oQ4eblg/k6lBJGAJ60+4gbvs
         TGe36oZQ9/sHPBuuW0iGJbHXG0vAESYXT4wSufD5GFf3gSh4NpEGI9UORl83spd8WvK7
         NjZg==
X-Gm-Message-State: AGi0PuZAkfJ0ureQU6FK3/5NQHD6WolZpLjbCVF+7kjU73fMMaaZX+p6
        W3z1bO9EMsf9PsSZYKBF80s3heZVBIH9wC0rv37THkMWLbk=
X-Google-Smtp-Source: APiQypJAvXDbNleBibW+u/BZ6oACm/jVLw78n+z7D3YDuCXpyVlfRqLgWHAWjpULITOhtEWqZ0+ovQ2t1F2W5vsR24U=
X-Received: by 2002:a92:ba46:: with SMTP id o67mr10962681ili.66.1588491212147;
 Sun, 03 May 2020 00:33:32 -0700 (PDT)
MIME-Version: 1.0
From:   Dongyang Zhan <zdyzztq@gmail.com>
Date:   Sun, 3 May 2020 15:33:21 +0800
Message-ID: <CAFSR4ctCsEriCnsJ3wWi_gGNwER5Adohn7p+=zvWqVqz2R0kYw@mail.gmail.com>
Subject: Possible null pointer dereference in smp_init_package_map()
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am a security researcher, my name is Dongyang Zhan. I found a potential bug.

I hope you can help me to confirm it.

Thank you.

In Linux 4.10.17, smp_init_package_map() in /arch/x86/kernel/smpboot.c
does not handle the failure of memory allocation, which may cause a
null pointer dereference bug.

Source code link:
https://elixir.bootlin.com/linux/v4.10.17/source/arch/x86/kernel/smpboot.c#L326

Source code and comments:
physical_to_logical_pkg = kmalloc(size, GFP_KERNEL);
memset(physical_to_logical_pkg, 0xff, size); // does not check if kmalloc fails
