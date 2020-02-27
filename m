Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC88FC4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA6C2468D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgB0Itg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:49:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51115 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgB0Itg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:49:36 -0500
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1j7ErO-0006X2-2A
        for linux-kernel@vger.kernel.org; Thu, 27 Feb 2020 08:49:34 +0000
Received: by mail-pf1-f197.google.com with SMTP id d127so1597075pfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 00:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yuo2Bfz0FnDnLaB5WH/eEhmv3YLgZdUk0gQwtfu9d3g=;
        b=VpwZob0uGfvw+AtFaLmW9OszyFDvAwPlSpxlzkAM0nFfrLdZtkNVCm2Sx+prR8wCa5
         c2odTxYPlFloZcDxzNVHAlviL6Xh2ZpVhjzZnewNTNX0UX4eYql06Xav09nlXs7Z5Alj
         7ux+5vczVNeaSx8tjj3PVjdd5rXsu5T9h0c0Ks4wwMmAiUKo0mdhbWf5HPGdmba2t0ln
         Hi9ezsqZEHs2BU9h8oVfBdnVUIxi+Vm9WXLdxEVLHdbHpFyDFn7+532ka5KbThnrrw/X
         gU5doz2QHGUtg9Hqr4jWwZjKqzJAi2r98L4vI/9vyZ0IB8HhBdyk5gRRixZTAbqYOof8
         Y4Gg==
X-Gm-Message-State: APjAAAWkzDjv4YgqwpjcigbrFWD3MZmhawyLtaeCuqJqYP6lOpaEjBTo
        nfHV3IhKyPbprQArD3yITYVsWC9ifY+G6v33AOPPIyDrL+aycKoHGnZ5DcAUxKOZ/e3LqgVL4yq
        6MbSzCCS7GLY1WqBsPDnGT5JBwLzIwggoRSTbZO64jA==
X-Received: by 2002:a17:90b:14a:: with SMTP id em10mr3765902pjb.4.1582793372751;
        Thu, 27 Feb 2020 00:49:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwPxvvV8ywaszpVzifTAV8XbWtdxoYItNFUu7k/B5/ayjIFnd4TKFAsokDu1IEjAQLGJ/q09A==
X-Received: by 2002:a17:90b:14a:: with SMTP id em10mr3765879pjb.4.1582793372445;
        Thu, 27 Feb 2020 00:49:32 -0800 (PST)
Received: from 2001-b011-380f-3214-6497-1af0-2c80-300f.dynamic-ip6.hinet.net (2001-b011-380f-3214-6497-1af0-2c80-300f.dynamic-ip6.hinet.net. [2001:b011:380f:3214:6497:1af0:2c80:300f])
        by smtp.gmail.com with ESMTPSA id t63sm6176198pfb.70.2020.02.27.00.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 00:49:31 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: SFP+ support for 8168fp/8117
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <9AAC75D4-B04F-49CD-BBB9-11AE3382E4D8@canonical.com>
Date:   Thu, 27 Feb 2020 16:49:29 +0800
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>,
        Jason Yen <jason.yen@canonical.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <5A21808E-C9DA-44BF-952B-4A5077B52E9B@canonical.com>
References: <2D8F5FFE-3EC3-480B-9D15-23CACE5556DF@canonical.com>
 <20200102152143.GB1397@lunn.ch>
 <DC28A43E-4F1A-40B6-84B0-3E79215527C9@canonical.com>
 <c148fefc-fd56-26a8-9f9b-fbefbaf25050@gmail.com>
 <02F7CBDE-B877-481C-A5AF-2F4CBF830A2C@canonical.com>
 <80E9C881-91C8-4F29-B9CE-652F9EE0B018@canonical.com>
 <995bddbc4f9d48cbb3a289a7e9799f15@realtek.com>
 <12EA7285-06D7-44D3-B033-4F52A06123CC@canonical.com>
 <cae39cfbb5174c8884328887cdfb5a89@realtek.com>
 <9AAC75D4-B04F-49CD-BBB9-11AE3382E4D8@canonical.com>
To:     Hau <hau@realtek.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hau,

> On Feb 19, 2020, at 22:48, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Hi Hau,
> 
>> On Feb 19, 2020, at 22:22, Hau <hau@realtek.com> wrote:
> 
> [snipped]
> 
>> 
>> Hi Kai-Heng,
>> 
>> Attached file is r8168 that I have add SFP+ support for rtl8168fp. If possible, please give it a try.
> 
> I've already tested r8168 and it does support SFP+.
> 
> What we are discussing here is to support this chip properly in mainline kernel.
> 
> This is what we've discussed so far:
> https://lore.kernel.org/lkml/2D8F5FFE-3EC3-480B-9D15-23CACE5556DF@canonical.com/

Is there anything you can share so we can support this chip properly in upstream?

Kai-Heng

> 
> Kai-Heng

