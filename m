Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291BAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BAC2068D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591742157;
	bh=dH050DLY/wT5hCpiEbkKD2zaK08/YpMeyzg3L//3Gf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E1p/pUxu11PIgQYdHCiibnIsV9HS6nyq73iiNQWzIPZTrCZxFeX3rKwT1LjAovVvn
	 v8QR5KkY0Elj8XGxvW3yt4wM0XhgFcVghMwbnS+vIJnX7YpNUuxfGIzUqa3NUO+TRX
	 +hSwza+T6ZJq1DZXL6FhQYqBltI27BJtl5cjYXG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgFIWfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:35:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44028 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgFIWfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:35:53 -0400
Received: by mail-io1-f68.google.com with SMTP id u13so18464463iol.10;
        Tue, 09 Jun 2020 15:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AF/xxGAAmmq8m781/9mNSTPPuWu4/Lu9Y/67FNW6glw=;
        b=VYzSY6UNfv5hEb/9lV4C1XY1MRBshUowgbkEiiZGdWQxC0SvuNPwZyicgIDOQosjho
         WRiX36/Bz8wZ7RQWV2mChgjyOAEYflweD2tDau9u3HQVPBH885IQhNnyQ5wbFJvhvjNO
         KjEwD8E9iggKc+zFEi8OAne/D8zooqx42nTmiHzWcWhtV2HKAlShGXttDIWDgfW9anQC
         v3WOke2TW+ESz9q8oRXorDeFi/p7kLpF5Q1VZAoD7y5mguDwkqMXVbHVbVWVHx/bzDlR
         TavELp5H2VmYASeouocZyrYVuSZcJtPb/8Xt2BtQ9VDf53/AO7MoA1ymr6my+iywiWmr
         L1Jw==
X-Gm-Message-State: AOAM532tnBBW9v8hvn+0c9weyB35yxcuXN37UoPPj17C2S0gpUmJXaUB
        ptOSvDLeQRInXbuLhqo9Yj4NIM4=
X-Google-Smtp-Source: ABdhPJzgTHx2wsS5oN+cDdflkB51UZl3ANDgnJ8eo4bswCiO2TTBM6n25loZTTE9uJUeI4Dr/iikYw==
X-Received: by 2002:a5d:8c8a:: with SMTP id g10mr346802ion.208.1591742152884;
        Tue, 09 Jun 2020 15:35:52 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id o2sm9804652ilq.71.2020.06.09.15.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:35:52 -0700 (PDT)
Received: (nullmailer pid 1625877 invoked by uid 1000);
        Tue, 09 Jun 2020 22:35:51 -0000
Date:   Tue, 9 Jun 2020 16:35:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH 1/3] dt-bindings: Add ARM PSA FF binding for
 non-secure VM partitions
Message-ID: <20200609223551.GA1620273@bogus>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
 <20200601094512.50509-2-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601094512.50509-2-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 10:45:10AM +0100, Sudeep Holla wrote:
> Add devicetree bindings for a Arm PSA FF-A compliant non-secure partition
> at virtual interface(VMs).
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  .../devicetree/bindings/arm/arm,psa-ffa.txt   | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,psa-ffa.txt

I'm hoping this goes away if the firmware is discoverable, but if not DT 
bindings are DT schema now.

Rob
