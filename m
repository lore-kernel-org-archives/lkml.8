Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100A3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C15208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596229265;
	bh=u8BA+2sm+9UwuUoedgkPd98weNXOegii/vv+KfkcEFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TXKiyp83LEkBZ7Ax0RC1zwdCBdkkrUvQIoTRn+PeJ0Gad1oxD/AeM4bISUT6/Cr/n
	 F1kklXZN5qjf/2Pb4rwGy5EjDZ5ZHDlxWMzZFFPW8KBgRI7+zXdGSQqw7jFCvTDmRP
	 7steSmJLGpnZz7dKLXrSbR3P5bBwQgT2avWCVBFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgGaVBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:01:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35304 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgGaVBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 17:01:03 -0400
Received: by mail-io1-f68.google.com with SMTP id s189so25750032iod.2;
        Fri, 31 Jul 2020 14:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=he4Igwk/67gpHkuDjdC4uwLoo0dcwQMpUF2WbhaQetQ=;
        b=TPPUsU2bArpDDTJMl8LDgoUYfrBzU5WoI77zUm9Mtd9a81EK89jYVRd7asKJuOMMbT
         y9b4iC+EQnytXItLQwp8e8ZakbazdCUcEZZdLZOZGfqEkOzQ3s1yL44oshjmNIy/uQHn
         TTOKspRWGYlD6xA8akyc+qjTwpczVrMqxO/xpokhKcIC3umxNGc6Cyn7v2WTl4R3QP+O
         /65XvJgky0Eqcod41W5YKuiyaMVPi9aEWB2Hb8uvbyfskihxfsrZM0mTzBgOmuNwHz+U
         IbH65yBi9fF01ET4n1CBlrJ8M/wwrrFKS5H39HQAKQmhJP2VF1Q0taLQKiD/6AFdJkWS
         Y3Hw==
X-Gm-Message-State: AOAM533zizFdhbLBxQWj5+3mw53peVrDJonjg1SOaiklruzSyKmWa4oP
        hDkHaXe29wLiCKWbYardkw==
X-Google-Smtp-Source: ABdhPJz5zr86vUbd/1/OTctwlFOTcHcbn6YLc+aqmoYZ/vLEcG0zrUaemo2J6QRDaidL9t05GtmCPA==
X-Received: by 2002:a6b:fe0f:: with SMTP id x15mr5445855ioh.173.1596229262610;
        Fri, 31 Jul 2020 14:01:02 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q14sm4883075ioi.48.2020.07.31.14.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 14:01:01 -0700 (PDT)
Received: (nullmailer pid 778932 invoked by uid 1000);
        Fri, 31 Jul 2020 21:00:59 -0000
Date:   Fri, 31 Jul 2020 15:00:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: usb: dwc2: add optional
 usb-role-switch property
Message-ID: <20200731210059.GA778876@bogus>
References: <20200728074602.14218-1-amelie.delaunay@st.com>
 <20200728074602.14218-2-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728074602.14218-2-amelie.delaunay@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 09:46:00 +0200, Amelie Delaunay wrote:
> This patch documents the usb-role-switch property in dwc2 bindings, now
> that usb-role-switch support is available in dwc2 driver.
> 
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
