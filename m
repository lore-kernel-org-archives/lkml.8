Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C573C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F1420720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGGKCl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:02:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34998 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGKCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:02:41 -0400
Received: from mail-pj1-f71.google.com ([209.85.216.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jskQw-0004z2-FF
        for linux-kernel@vger.kernel.org; Tue, 07 Jul 2020 10:02:38 +0000
Received: by mail-pj1-f71.google.com with SMTP id a6so20577948pjd.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WfyZ58MWMp2jhR675nU+YXT/hXi999kEOsSYDYXl5k8=;
        b=QUrcUnCbOJG0maVik5YXRmONG+6GYEtTRu7/k1o7COG3bDZN7HNqogtV3z8vdn0uUq
         VCMY1SDMtQPVu4/X0MsAz3BZmcyuzGcuG29YQprOvaRCA6RJ+BHJ25KJlkKoCR7ck/c2
         Kjt4FJKi4DcM3WCjfe0PlQp9J8WJ2HswwLrjcl6yIx9IWPizgM6JRGmp1/45BSY9Umsm
         79bUjF522w0r1Nb5sRvqUFY92sa6BRpidqch3Tp+shaouP9a3m9pdHjNr82Epj/fDbCm
         loSMyVIztI4Lx9P+erWUjKb4Ng9M4EZ1mlJo7kBQTjn+yhHbSWiUal56uoyYDab38b/f
         ml6Q==
X-Gm-Message-State: AOAM532Y7RS1iQOjaisOUhCKPDTa/40JG8KW5Irj0chm4fgEzJN1fiLp
        DYzwVXKqEBwLKFsnoLafvfLp+pdD6lOiKlEuk9LVHsInW+aRnG07DuoqPD/8BuyO0H9cbVAfgtE
        npKDdcy0JveeBoMFRIUefgmdhriiAQdkIobT88LCRZA==
X-Received: by 2002:a17:902:6b83:: with SMTP id p3mr45675371plk.193.1594116156918;
        Tue, 07 Jul 2020 03:02:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcu5zpqmFd1rkycrSeDdnTiXhHPkQ0kxix0rzpi93wz0vdVM+xh9YRAQbt7lH9zErJiiQ5Gg==
X-Received: by 2002:a17:902:6b83:: with SMTP id p3mr45675344plk.193.1594116156595;
        Tue, 07 Jul 2020 03:02:36 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id w9sm22656420pfq.178.2020.07.07.03.02.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 03:02:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] net: atlantic: Add support for firmware v4
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200707084657.205-1-alobakin@marvell.com>
Date:   Tue, 7 Jul 2020 18:02:31 +0800
Cc:     Anthony Wong <anthony.wong@canonical.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Nikita Danilov <ndanilov@marvell.com>,
        Mark Starovoytov <mstarovoitov@marvell.com>,
        Dmitry Bezrukov <dmitry.bezrukov@marvell.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <59235A03-8057-4B6E-93C9-394E965A2D55@canonical.com>
References: <20200707063830.15645-1-kai.heng.feng@canonical.com>
 <20200707084657.205-1-alobakin@marvell.com>
To:     Alexander Lobakin <alobakin@marvell.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 7, 2020, at 16:46, Alexander Lobakin <alobakin@marvell.com> wrote:
> 
> From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
> Date:   Tue,  7 Jul 2020 14:38:28 +0800
> 
>> We have a new ethernet card that is supported by the atlantic driver:
>> 01:00.0 Ethernet controller [0200]: Aquantia Corp. AQC107 NBase-T/IEEE 802.3bz Ethernet Controller [AQtion] [1d6a:07b1] (rev 02)
>> 
>> But the driver failed to probe the device:
>> kernel: atlantic: Bad FW version detected: 400001e
>> kernel: atlantic: probe of 0000:01:00.0 failed with error -95
>> 
>> As a pure guesswork, simply adding the firmware version to the driver
> 
> Please don't send "pure guessworks" to net-fixes tree.

Is matching a new firmware version really that different to matching a new PCI ID or USB ID?

> You should have
> reported this as a bug to LKML and/or atlantic team, so we could issue
> it.

Right, I'll wait for a new patch from atlantic team.

Kai-Heng

> 
>> can make it function. Doing iperf3 as a smoketest doesn't show any
>> abnormality either.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
>> index 73c0f41df8d8..0b4cd1c0e022 100644
>> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
>> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
>> @@ -46,6 +46,7 @@
>> #define HW_ATL_FW_VER_1X 0x01050006U
>> #define HW_ATL_FW_VER_2X 0x02000000U
>> #define HW_ATL_FW_VER_3X 0x03000000U
>> +#define HW_ATL_FW_VER_4X 0x0400001EU
>> 
>> #define FORCE_FLASHLESS 0
>> 
>> @@ -81,6 +82,9 @@ int hw_atl_utils_initfw(struct aq_hw_s *self, const struct aq_fw_ops **fw_ops)
>> 	} else if (hw_atl_utils_ver_match(HW_ATL_FW_VER_3X,
>> 					  self->fw_ver_actual) == 0) {
>> 		*fw_ops = &aq_fw_2x_ops;
>> +	} else if (hw_atl_utils_ver_match(HW_ATL_FW_VER_4X,
>> +					  self->fw_ver_actual) == 0) {
>> +		*fw_ops = &aq_fw_2x_ops;
>> 	} else {
>> 		aq_pr_err("Bad FW version detected: %x\n",
>> 			  self->fw_ver_actual);
>> -- 
>> 2.17.1

