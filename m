Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B6EC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDE22077D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMBHYcII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgGUBj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGUBjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:39:23 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F582C061794;
        Mon, 20 Jul 2020 18:39:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so1206285wmi.3;
        Mon, 20 Jul 2020 18:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Nrug+AWSzjZGrBINnJb7jz7fHx/HXVjSPsVyZ+aIDeo=;
        b=RMBHYcII3aAfMtjYSyy48tK+c1/Q/zQkwkMYYl6or0ZK12+W75rcPJDNBupa/yyNyU
         2A6PieyzOXLHlZF54nE+H+5XjALkG3sFaOXW3kagnM8kxto3jv3AFJ7mkmk67pfVqHj6
         mRyLT/wGHzIH26vwiZNlzp2gMgiJEnnjtd+MONCTj8Pi/+dw2yIsIjwd6om1i2v8E74I
         dTFPO/QsXpURRPqKvF87bxcZzUclFKimx0SqaO27BKW8Cm8D9gwUjn5FSt62gsUSYp4Z
         UscD5srtkjOsI7BU2TmSI2d4HP5s6/H5QAxL56S9eaQ8tMjTUje8TqBf0e0DW5SD5gYR
         VnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Nrug+AWSzjZGrBINnJb7jz7fHx/HXVjSPsVyZ+aIDeo=;
        b=oYt9iDy8xr3Jvavyk1bhrYYL/ILPWCUlyAka4Nkac1cSqTH82qfwiPCO3jL6L2inye
         UahYZnGq7UnhLfW+Au3tbbEflhGZZkhX6AjRFFvT4CSwxebOoAKSgxpm3wFgCyLf/5fa
         JEMHPqEMtnLBx6IGnUXFtq1p4lyi4hFGGYIBvGEm5mTX+x6QoN2bcUyZa43z9IwqwyDB
         C0ftc1QTQI39yWhC4h7rDUJ0PeuDUIOjtge2o7yhJZF/wfNXEElmgqyDm1y+AjhnVbqO
         rMMulMtQqQvILl5nx4NaqF1wVtP1n1ZIUgydRCrUAQEMTrutpMIkHLeiWCO7capciMnQ
         +rmw==
X-Gm-Message-State: AOAM53323mZQr0wXk8Bv2mGG5XRw9nhxBXdy9eGYvhvTDC/XRC3+qby6
        CdNv+fVt0IXVB8zHp2HKpgo=
X-Google-Smtp-Source: ABdhPJxEWy8mHaI1ZwdniVdsbDPS6hEK7Mlb0/0gXb3tSP5J/MILa3B1gJ74K7YR5WVFNdJeUDADJA==
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr1677645wmf.140.1595295562280;
        Mon, 20 Jul 2020 18:39:22 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id z10sm35619627wrm.21.2020.07.20.18.39.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 18:39:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH] arm64: dts: meson: misc fixups for w400 dtsi
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <7hd04pakqm.fsf@baylibre.com>
Date:   Tue, 21 Jul 2020 05:39:18 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2A03FA86-D190-4DD1-95EE-AA0E5618DACE@gmail.com>
References: <20200718052950.3707-1-christianshewitt@gmail.com>
 <7hd04pakqm.fsf@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 21 Jul 2020, at 2:24 am, Kevin Hilman <khilman@baylibre.com> wrote:
> 
> Christian Hewitt <christianshewitt@gmail.com> writes:
> 
>> Current devices using the W400 dtsi show mmc tuning errors:
>> 
>> [12483.917391] mmc0: tuning execution failed: -5
>> [30535.551221] mmc0: tuning execution failed: -5
>> [35359.953671] mmc0: tuning execution failed: -5
>> [35561.875332] mmc0: tuning execution failed: -5
>> [61733.348709] mmc0: tuning execution failed: -5
>> 
>> Removing "sd-uhs-sdr50" from the SDIO node prevents this. We also add
>> keep-power-in-suspend to the SDIO node and fix an indentation.
>> 
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> 
> This could use a Fixes tag so it can be backported to stable
> 
> Kevin

Okay, I will send v2 with a fixes tag.
