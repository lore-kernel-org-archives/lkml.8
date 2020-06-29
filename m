Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D58C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47CAB206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593468233;
	bh=uhgx90ReH2lg8RDTwDIx75LdlJVQowsGqEzwBIC1kXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xmKj6WTQZOzmOED6NCjqvxAar1QZeV4Yf/7KYy+RV0vmQ86ErcKzRPEBvcwb8jS1g
	 vAylPC4ooZkGSaCKDDNZ8lgjO61Nac58SZPxO36oJOX/nwpmmW+Z56yxxaxw4cS9Mk
	 +4n99sA+SWJhRVk9iXlS7xMVHmyt3ZCGS7EvFoAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391779AbgF2WDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:03:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38804 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgF2WDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:03:30 -0400
Received: by mail-io1-f68.google.com with SMTP id f6so3269520ioj.5;
        Mon, 29 Jun 2020 15:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cCuA/1H5zPFkQibB/1FVyUKxdfeDC7D9Mc34Pi/i1Bk=;
        b=TahneyMEvXAwMXkAVcepLu2TEJe6a44UQUlMXNF588bh9E55ftMgEnRjslBkwEgFVw
         1lZzxACgKsSVl6pjB4KC9BNsrfZMYLlquQjcL5aJJyGyTIEUcE1EHhoui6UU/KczTLW9
         7O9CWwnKCNEpBlRU3aIUhBg/eM8KcxsQ7kWBPN7lFvnmyQhb/Ulkc9SqCyhR9y2o7ZrT
         h21xnilNaHQvr8jsIy/zecePgniZ2DAafmMsywrPAZVxP3bmOMgWjqKBBscBPYfzDT/1
         NI4b181pR4dyVKwxeYDW6+5wp3VAWeIbq7uzjcVlYSAtWjXL+rfvzDqOfEJ5hsPTpglL
         dWcw==
X-Gm-Message-State: AOAM532+uLIIMkfIpxfH4BUtPK0VxNet1PjRUEJjUGcVvR0QVeOuvsHW
        +vCEikfAogM1rVgd/Pa3xg==
X-Google-Smtp-Source: ABdhPJzQNlss41FGC2hfOql88X+H8ZgwM3IXBHQO6+dHsWdZNlR+AYQSnEQVWlioy6ByTnwwWVx/Bg==
X-Received: by 2002:a5e:9b0b:: with SMTP id j11mr19140572iok.17.1593468209250;
        Mon, 29 Jun 2020 15:03:29 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id q4sm606515ils.11.2020.06.29.15.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 15:03:28 -0700 (PDT)
Received: (nullmailer pid 3018066 invoked by uid 1000);
        Mon, 29 Jun 2020 22:03:26 -0000
Date:   Mon, 29 Jun 2020 16:03:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, ben.dooks@codethink.co.uk,
        jpawar@cadence.com, sparmar@cadence.com, weiyongjun1@huawei.com,
        rogerq@ti.com, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, robh+dt@kernel.org,
        colin.king@canonical.com, balbi@kernel.org, kurahul@cadene.com,
        peter.chen@nxp.com
Subject: Re: [PATCH RFC 1/5] dt-bindings: add binding for CDNSP-DRD controller
Message-ID: <20200629220326.GA3017609@bogus>
References: <20200626045450.10205-1-pawell@cadence.com>
 <20200626045450.10205-2-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626045450.10205-2-pawell@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 06:54:46 +0200, Pawel Laszczak wrote:
> This patch aim at documenting USB related dt-bindings for the
> Cadence CDNSP-DRD controller.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  .../devicetree/bindings/usb/cdns-cdnsp.yaml   | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/cdns-cdnsp.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/cdns-cdnsp.example.dt.yaml: example-0: usb@f3000000:reg:0: [0, 29437952, 0, 1024] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/cdns-cdnsp.example.dt.yaml: example-0: usb@f3000000:reg:1: [0, 4076929024, 0, 65536] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/cdns-cdnsp.example.dt.yaml: example-0: usb@f3000000:reg:2: [0, 4076994560, 0, 65536] is too long


See https://patchwork.ozlabs.org/patch/1317380

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

