Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423F4C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2269C24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgBSOsd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:48:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33658 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgBSOsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:48:33 -0500
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1j4QeO-0003nv-6q
        for linux-kernel@vger.kernel.org; Wed, 19 Feb 2020 14:48:32 +0000
Received: by mail-pj1-f69.google.com with SMTP id hi12so318093pjb.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 06:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IsUQCWCQs19s26oNsXXvK15grsV4ubhhjAffZSQkp/A=;
        b=c/KKZteMYZKtEysFlOFmcvj5esJWqWbgLqfa0TZgzGV9UH1RbdcaTtZIeBKeBm5Mc6
         CzhyMh3ggeoKTFidxXPWvrx+4MEYexPxY7L/1KFaanQfpe2pL7IkMlE+fNvCrKAs9dd/
         CCo8z33kZA00sFw8mKEwmL2oXNzbV7nZA2Tgalob4b8Pa8HC+EitvXUxB2n6xLgHTf3N
         FCB9FV9M5BawGDgBKUA1LvkrHcrEoDO+ZoWsuUNQwelMvg9u6jPWaidvSijhj6VG0Oqq
         nrVwZWLv8csYpvmjg6uqxWysgfKJd9dQstX3qal8Hrzau71xGoswf1g1gpsHKab/1AbW
         hA3g==
X-Gm-Message-State: APjAAAWBB6nHQBhaWYEZ2cnDpDymv4psPEkVrqB69/+MMDQOxJ6UG9Vi
        jPxwtiaVGY6Lx12wtVI6KgHw/mxDS05iqHF1XvcNrGKrasYWDIHx9gleNCUyNx5cJsSOWVdZQyd
        pxo5YGcRrnrKCnxa3Nk1WSg3A/u5MAmNFl6o6DL90QA==
X-Received: by 2002:a17:902:5ace:: with SMTP id g14mr25624688plm.311.1582123710931;
        Wed, 19 Feb 2020 06:48:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6hdU7x05frl8JRLbXThpkSiZUSDbH2wA8GUbKPlscApgCMotUh+Ldere0qxKYqYKmGlt8XA==
X-Received: by 2002:a17:902:5ace:: with SMTP id g14mr25624656plm.311.1582123710555;
        Wed, 19 Feb 2020 06:48:30 -0800 (PST)
Received: from 2001-b011-380f-3214-7181-50ee-02bc-c2ee.dynamic-ip6.hinet.net (2001-b011-380f-3214-7181-50ee-02bc-c2ee.dynamic-ip6.hinet.net. [2001:b011:380f:3214:7181:50ee:2bc:c2ee])
        by smtp.gmail.com with ESMTPSA id c15sm3268649pfo.137.2020.02.19.06.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 06:48:30 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: SFP+ support for 8168fp/8117
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <cae39cfbb5174c8884328887cdfb5a89@realtek.com>
Date:   Wed, 19 Feb 2020 22:48:27 +0800
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>,
        Jason Yen <jason.yen@canonical.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <9AAC75D4-B04F-49CD-BBB9-11AE3382E4D8@canonical.com>
References: <2D8F5FFE-3EC3-480B-9D15-23CACE5556DF@canonical.com>
 <20200102152143.GB1397@lunn.ch>
 <DC28A43E-4F1A-40B6-84B0-3E79215527C9@canonical.com>
 <c148fefc-fd56-26a8-9f9b-fbefbaf25050@gmail.com>
 <02F7CBDE-B877-481C-A5AF-2F4CBF830A2C@canonical.com>
 <80E9C881-91C8-4F29-B9CE-652F9EE0B018@canonical.com>
 <995bddbc4f9d48cbb3a289a7e9799f15@realtek.com>
 <12EA7285-06D7-44D3-B033-4F52A06123CC@canonical.com>
 <cae39cfbb5174c8884328887cdfb5a89@realtek.com>
To:     Hau <hau@realtek.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hau,

> On Feb 19, 2020, at 22:22, Hau <hau@realtek.com> wrote:

[snipped]

> 
> Hi Kai-Heng,
> 
> Attached file is r8168 that I have add SFP+ support for rtl8168fp. If possible, please give it a try.

I've already tested r8168 and it does support SFP+.

What we are discussing here is to support this chip properly in mainline kernel.

This is what we've discussed so far:
https://lore.kernel.org/lkml/2D8F5FFE-3EC3-480B-9D15-23CACE5556DF@canonical.com/

Kai-Heng
