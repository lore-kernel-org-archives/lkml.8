Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A95FC34051
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6F32176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgBSOW5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:22:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33002 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgBSOW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:22:56 -0500
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1j4QFa-000224-6N
        for linux-kernel@vger.kernel.org; Wed, 19 Feb 2020 14:22:54 +0000
Received: by mail-pf1-f198.google.com with SMTP id z19so322733pfn.18
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 06:22:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=MLzunwtdiwZE8X3dSBg1bcU+Imt/wqtftJaxuJ1ldhU=;
        b=gADyhQhlidrzae2IXGx3vMUbYd+eXLwEoOW9zT03nGu9MSPE9i0H8cCzvIqllOIJ8u
         xq9cqGuRKA7Np8hcOZ/+LgogkjfPnVxxZaufXwxdQG61YeU+OCY7ngWmSqfVlImn0HnG
         iMWuYn29hf4scCqDb67AsK6VxePK57Z+4hhKRDvGc6OITEPPBHP39ga5msOBUPRuqgRQ
         9ZLE7QIdNjrLSZiC0Bvweab3T2OoB/XDVQSTSJIZNxmBHGEQtZQ2Zg++Pb5DdwwQXgFK
         rXut7HPYPg9v2DLaTFJ1rryM51Z4gFptd/smTuCVhBHeXzrYcVrlJnCKtTji9/9JVPdE
         4iJg==
X-Gm-Message-State: APjAAAVWdSiyqGt9eMTM08AhdtngMNLRjdRhSwSzL9gy/dpBRbiHPZad
        GenL0QYFNKlsaxwXvdnpDGg9SHiQjBUzziPGqTl0G9cEHWQpjFSGd2Nu3o8KEw05V/unXZ6pz02
        x2xCZpio+4XVSE+19yCUWkFEPAevadCYt2ScK0sIGUw==
X-Received: by 2002:a63:f84b:: with SMTP id v11mr27755963pgj.133.1582122172833;
        Wed, 19 Feb 2020 06:22:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAf9zQyTPVPbMjR6FbxyzaCj2ekLS3doKIrUEPzVc140+FEtyEVjAoXaVkdyd8BTxOWOpurg==
X-Received: by 2002:a63:f84b:: with SMTP id v11mr27755913pgj.133.1582122172066;
        Wed, 19 Feb 2020 06:22:52 -0800 (PST)
Received: from 2001-b011-380f-3214-7181-50ee-02bc-c2ee.dynamic-ip6.hinet.net (2001-b011-380f-3214-7181-50ee-02bc-c2ee.dynamic-ip6.hinet.net. [2001:b011:380f:3214:7181:50ee:2bc:c2ee])
        by smtp.gmail.com with ESMTPSA id w26sm3190144pfj.119.2020.02.19.06.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 06:22:51 -0800 (PST)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Hard Disk consumes lots of power in s2idle
Message-Id: <0955D72C-D24D-402E-884F-C706578BF477@canonical.com>
Date:   Wed, 19 Feb 2020 22:22:48 +0800
Cc:     Linux PM <linux-pm@vger.kernel.org>, linux-ide@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Kent Lin <kent.lin@canonical.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

Your previous work to support DEVSLP works well on SATA SSDs, so I am asking you the issue I am facing:
Once a laptop has a HDD installed, the power consumption during S2Idle increases ~0.4W, which is quite a lot.
However, HDDs don't seem to support DEVSLP, so I wonder if you know to do proper power management for HDDs?

Kai-Heng
