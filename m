Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8E8C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA70A21734
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuhRVJ24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgAWXJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:09:20 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33042 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgAWXJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 18:09:19 -0500
Received: by mail-qk1-f193.google.com with SMTP id h23so300640qkh.0;
        Thu, 23 Jan 2020 15:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=7uiCjSSCZSVUod21B2H/Tkjx2WrBUx9BhkTEN2ChC/c=;
        b=kuhRVJ24fzDCQU8OMIx4yhwrEdkZwh5BU3SnGSKbJ7KxNgbH3ux2s60q8rmlq7TSbn
         rSg+nekjAfzXabrUPbndI/iVYIfMQtwwhBRLH1nJMPedTGbwNaBAYAHRqaS4mxgCtn/i
         qBUYWJozt2GYIx7JsiYYSnb56H505kaNxg1Ftd+KiAKs/QMKZhE77EM+17l6LTF9EvK8
         ubJHirmNyQzJaEpubQsuO7GF2h98RabdsF5HSKVFm83MEhpbHJvF0D5504bFRsZqWqcF
         SmIILEmSsCqAbc+zZzJvlHQQI0QQBjEKLz60gbd5vfy3fwcuUx2c5cjFpu7g1GJkJDnZ
         6i4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=7uiCjSSCZSVUod21B2H/Tkjx2WrBUx9BhkTEN2ChC/c=;
        b=EV/iXYdaJEk8/r4/qtXtaXb75U24Y2rLbCDNBegU95nGu7M7Eb4Xb/N+NppnMP+q3a
         kTM/jTyltvdIgk8dHDEyf/rVF0l2vH/3ZhBRslY8C/gyEGBxwfdHHq/Y+LnmwerxAP6X
         Pl6+AE2rto5pHwmEB6nF68ZnU/C7Pk3yzNwIp7wX0E+FuWRS9tAVDj++WbpGZjcfbH0p
         9O/tJBi6r+43iJv1L3PSQ2BwsuHEzW4uM2pxWBkjI53OcyS9tbRBN7uy/ALftNBlM/Te
         9cIUupVWNLh1NCKPzza1qAUFErZOIvCU8JhMXsgAgg4TVbh4A32DrSxQPU0AaP7eMJId
         8tGQ==
X-Gm-Message-State: APjAAAVDXL7SM9vacKAXKnWlazmp6BZihVnJOZ7ErTZ1BvezulleWC8q
        YlbIdDdXK3jRyfGXW9D9wa4auoV5
X-Google-Smtp-Source: APXvYqxZSfz8uO5tyQlMAmcfiy8fkZlxzITlIcOQZft/gJKR6LkI7UzQPTD1whTiZCJSkP1xZyCJRQ==
X-Received: by 2002:ae9:edc8:: with SMTP id c191mr638340qkg.227.1579820958674;
        Thu, 23 Jan 2020 15:09:18 -0800 (PST)
Received: from [10.0.0.29] (pool-98-118-94-114.bstnma.fios.verizon.net. [98.118.94.114])
        by smtp.gmail.com with ESMTPSA id m23sm2110648qtp.6.2020.01.23.15.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 15:09:18 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V3 1/3] dt: bindings: brcmnand: Add support for flash-edu
Date:   Thu, 23 Jan 2020 18:09:17 -0500
Message-Id: <1F43C9DF-7176-4173-972B-99584E99C7E0@gmail.com>
References: <20200123135402.GA4763@bogus>
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <20200123135402.GA4763@bogus>
To:     Rob Herring <robh@kernel.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,=20

Added tags to  latest v4 patch set.

Thank You
Kamal

> On Jan 23, 2020, at 8:54 AM, Rob Herring <robh@kernel.org> wrote:
>=20
> =EF=BB=BFOn Wed, 22 Jan 2020 15:41:09 -0500, Kamal Dasu wrote:
>> Adding support for EBI DMA unit (EDU).
>>=20
>> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
>> ---
>> .../devicetree/bindings/mtd/brcm,brcmnand.txt          | 10 +++++-----
>> 1 file changed, 5 insertions(+), 5 deletions(-)
>>=20
>=20
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>=20
> If a tag was not added on purpose, please state why and what changed.
