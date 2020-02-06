Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A02C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1920721775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581021989;
	bh=Ocj0H6TQmpr7XwjGv77HKUZhpIL7ZWZKic9S5tcam94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hckRdsyKdmTMok+YLUvCzXa0KKXjEeXDje0njPMeC9VQbphYF6GG1bZeO/MzhQBr1
	 ecMW9ZxTjbSBqa6hb7ts2jkmWgMcSj6wxlIRmqyvejztde/fs8zIo//Ie0tM1x/dNI
	 NYvf5H1dGrhsVy3pJweupHCNUIuDmiqi77Yk8aD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBFUq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:46:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40745 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgBFUqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:46:25 -0500
Received: by mail-pg1-f194.google.com with SMTP id z7so3333485pgk.7;
        Thu, 06 Feb 2020 12:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jPtOQdw8vyUeztLpc680CHtZLK6W1JEQ2cHvbgrlY+8=;
        b=WqXY9MDGqAuSlJ3Htq+iCYlFvm9yzCL2kfMcTGeF6Fm4x7kEg1/X8EivvdBzr3oRew
         7gHInV7c4+S9g2kIDnKx+40EffR34sc4K8E4NnQ1oxGGaM2UgZ2PbtM3itWF0qk/0LTN
         ISTe4CXRiZfiQFqAOGy8CbBhOgTOPwyHoVjDXI5FbZTtB/aPUhxHXyzbeO7UP6qf8pIB
         HR5fC5KKnih6yhfjQsYIUeOmpfZ4nKBY5fr7Yv+jClW2ixtRL0ZkeeJzystO/c/pqJct
         kNxzqBha1V9aGfMoL2/B1jKkuwxz7XTcXCkQm0Omn45fPoZloF6d71dy1HbpSRekiTpC
         hAKA==
X-Gm-Message-State: APjAAAURznOXjApo7kd+BORqDLn+qnYPuIoHyISmXPBIPZcxqTaskEst
        wB6Qm5XBxp1SoAObeqVebQ==
X-Google-Smtp-Source: APXvYqxza9xpQ1nh+paMG8H01152jYTBvT3wn55ABgjvQ/4PX2elrh5aIP/rcP6j59uN6+87Rk8oUQ==
X-Received: by 2002:a63:4b52:: with SMTP id k18mr5635945pgl.371.1581021982840;
        Thu, 06 Feb 2020 12:46:22 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id z29sm292462pgc.21.2020.02.06.12.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:46:22 -0800 (PST)
Received: (nullmailer pid 28243 invoked by uid 1000);
        Thu, 06 Feb 2020 17:56:52 -0000
Date:   Thu, 6 Feb 2020 17:56:52 +0000
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com
Subject: Re: [PATCH v3 2/2] dt-bindings: clk: intel: Add bindings document &
 header file for a new clock driver
Message-ID: <20200206175652.GA25108@bogus>
References: <cover.1580373142.git.rahul.tanwar@linux.intel.com>
 <1c4b7a999f47df4214a60971e27fa9311c8c64b4.1580373142.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c4b7a999f47df4214a60971e27fa9311c8c64b4.1580373142.git.rahul.tanwar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 04:54:01PM +0800, Rahul Tanwar wrote:
> Clock generation unit(CGU) is a clock controller IP of Intel's Lightning
> Mountain(LGM) SoC. Add DT bindings include file and document for CGU clock
> controller driver of LGM.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/clock/intel,cgu-lgm.yaml   |  40 +++++
>  include/dt-bindings/clock/intel,lgm-clk.h          | 165 +++++++++++++++++++++
>  2 files changed, 205 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
>  create mode 100644 include/dt-bindings/clock/intel,lgm-clk.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml b/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
> new file mode 100644
> index 000000000000..e9649fe75435
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/clock/intel,cgu-lgm.yaml#

Drop 'bindings'

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
