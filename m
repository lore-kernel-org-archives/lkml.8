Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7CEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617172065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595538644;
	bh=tD1TLT2HA8rRWNEmtWVWz/vwIcojwLoXBh6qRL5Oxqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PuUcjC1gfmw8SKkmDZ3DPyo0FnLF5ZZNer3LaqQcslIxQct0cTqUgq1CRxqegHtzc
	 ku6qfj9U5L4AVOY5JMceU0Vh6F0qkanjQ4yKi9d1qOqyyU8DwLFK0rXozHR7Zn5X8w
	 PnLjwzAGjSubiZ3FCjnCuu2+tKr/eV68iUYZNc5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGWVKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:10:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33455 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgGWVKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:10:43 -0400
Received: by mail-io1-f68.google.com with SMTP id d18so7788321ion.0;
        Thu, 23 Jul 2020 14:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rFnG6OjqqnnpckoLrF3IZeXaDva71gf7e2ghfJANXJg=;
        b=WnjFgiT3oZtrQsSP6M056gk2UDj8nnuD6qbS27XY820YGwaHFEwdufHGZeyM6/vUMs
         jn0bysi21w1wPSqKVe4+QqPbshxVIHl+xvoHXRpkMQrecIWNq0qFndPWtLJnJfvIqk51
         o6obecMnJfdfwxIz8KWhoWSmpLbHjJ7H3/uO8CuZ9usUB+BSnPMlVY0WHzvRS182rt5e
         FWXKBopBUWPw/Ccs3nGGtNM4qp1tCLKA/OWaPbs/mjjqAVoeDUdGOX+eJO3yQsCXsAC8
         jN20w6MKH/3L8QYbEPbI6MCmMEmxDWFOx3ob5s3M3W+Rp8hL5oD0cYjz+sAGMUfX77AC
         2TVw==
X-Gm-Message-State: AOAM531I/DRXqRoKHnALtnwC904u+9Vj9pyenx2j/0HSbBBvxLMj6yv9
        tB11Gw2C+dS1/2kQOm5TaA==
X-Google-Smtp-Source: ABdhPJzPkVpagcW3ivBb3LUe2ly7ZSWK85Q3R+Kf30ArUVlbxiQmo8M85lxbkm/bp9JvXSVnb1L/Jw==
X-Received: by 2002:a6b:4f19:: with SMTP id d25mr233891iob.190.1595538642326;
        Thu, 23 Jul 2020 14:10:42 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d6sm2086764ioo.9.2020.07.23.14.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 14:10:41 -0700 (PDT)
Received: (nullmailer pid 864810 invoked by uid 1000);
        Thu, 23 Jul 2020 21:10:40 -0000
Date:   Thu, 23 Jul 2020 15:10:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Dongjin Kim <tobetter@hardkernel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-amlogic@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: amlogic: add support for the
 ODROID-N2+
Message-ID: <20200723211040.GA864520@bogus>
References: <20200719141034.8403-1-christianshewitt@gmail.com>
 <20200719141034.8403-3-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719141034.8403-3-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 14:10:33 +0000, Christian Hewitt wrote:
> HardKernel ODROID-N2+ uses a revised Amlogic S922X v2 chip that supports
> higher cpu clock speeds than the original ODROID-N2.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
