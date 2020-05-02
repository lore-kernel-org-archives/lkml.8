Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60D9C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 20:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF922072E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 20:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTkqkhnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgEBUwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 16:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgEBUwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 16:52:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB78C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 13:52:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d184so3443594pfd.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 13:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=quexCiWi2oqFOD1er6RWFHC8nDUp8vrpbF2hyNz1YDk=;
        b=KTkqkhnBavlNqH+FdL/axkGz6CE/wj4XBoxlBCeB9bP5PCj1j0NegJBvltKtfb/cHr
         Zlkiz40bdmSA8y7Z4dkwj4etXMOU8iCeFtIsx4KP00stIJ7I1/sEUMMolDMHrNZKv57j
         OlWcDE6OuzW8Ju2bh6vKfBS0lG4KF9xmYHPCkvyrX6AmbM3cVCMeg/CEbL05a10gP/OJ
         pwzMxlr4f0CrvBjDSOgMIrAcvVdEntkOaas9XicT3s7hSfUbqV9JIPv/r96LMYvP4is+
         aiFcYXhmPwfR9QKiHkMtpRfvLXX6+8+IrOHDJx+UeoeeNE9uOCJzNIuP2E6m56EShOIP
         TH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=quexCiWi2oqFOD1er6RWFHC8nDUp8vrpbF2hyNz1YDk=;
        b=YKZBPFtUYHwQMUEGW/D+4+sqXGD8Xj/yHn1c+ysbMxGBMRTPxOpnKeDG9PrdRY0bH4
         v9c79fki4O9qtT5ZPwiezgFZFLAaZQyiAPwwsWpwjgq07tpIXgIbohN6v5+PCRJHUznk
         HcYK6pZhq6ohSXOz/Wdq/fJoqUOW9KSpx8koS99kCDe/YBbGtYxraNSsMq3LpkutGPUn
         ZOnkn7B03xm6/vwQb01Hhe21ggHppYY/w3wZ5hAmMx34cLXcirAaRjhid29FLEdeI/lv
         +4Bz7hiLLk829r5rvNb5zMRXjLd0Bl70+Chk3otpoFO4QE7OuvmgjCsy98YzTfLi6o55
         y0jw==
X-Gm-Message-State: AGi0PuYaXsMhQDJUlapNfUXpmjjOv0GB7CXbptRkYoSyjNqyYmI/TP1w
        nwrgGK4J7kQj0WwJ9o/0jrTbdUtN
X-Google-Smtp-Source: APiQypIGGvo4hPVTHloclEXPFvewsJZUgC/arK65mW0EELFwd5G01MaeRxV79MepK10FtePHDVldGA==
X-Received: by 2002:a63:4383:: with SMTP id q125mr9558514pga.27.1588452732707;
        Sat, 02 May 2020 13:52:12 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y2sm5180007pfq.16.2020.05.02.13.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2020 13:52:11 -0700 (PDT)
Subject: Re: [Patch] mtd:rawnand: brcmnand: Fix PM resume crash
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
References: <20200502204137.37134-1-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f0e781e6-a7ac-37be-13c3-885eb65a0921@gmail.com>
Date:   Sat, 2 May 2020 13:52:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200502204137.37134-1-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/2020 1:41 PM, Kamal Dasu wrote:
> This change fixes crash observed on PM resume. This bug
> was introduced in the change made for flash-edu support.
> 
> Fixes: a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers")
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
