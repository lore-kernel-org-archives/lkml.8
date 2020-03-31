Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13444C2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6042080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585689793;
	bh=Tx7uVSypMIhTvg8uI/C0fKvl1CRn0JboHFjmCzQGI48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tKmGZ+JNITp1j1hwW6Z0wVPXpZSMBycDvgkszH3tff4tJ4uXjwaUtOdtIt/7BztHJ
	 uvFQUcjKDyodSK2SrV5x1300tFrFSB0QiF46WW/bmltWgDjOxcR6xMQHs2g0kKGR84
	 1RvPaT6okBW6wBwgL/TQQaCeZ5e6U+SmXouwe7II=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbgCaVXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:23:12 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46367 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731331AbgCaVXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:23:12 -0400
Received: by mail-il1-f196.google.com with SMTP id i75so13653653ild.13;
        Tue, 31 Mar 2020 14:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6E5wCBTaGL3aDN6kgYp9T1kImLV10yY1PuBITmZkm1o=;
        b=Gzb+emNWybbCLngp+HlFydhQiwhDGJWDwAkJAkdbMQORTe4fft78YJ1pVn9U6CGSBR
         sNvVUDlMn8xhcG63HM/wmABS9ZrnnaklYvtGhftzUOr64c491+tdkzT7JaH2+lTnEiSW
         bGnJeviebDzPUW5szWaF6Mfhs/ZFJWWQxuc2MauxGt7bNhVq/4fIMZgVrYDXacOz9c7m
         GT/zssLXKPhGoI+lVJDlV9ZTXW6ujUnRO3c7wxjphL2dwNgyvid45s5ek94wA54Iqxyy
         Y+n1pV2AqZzyYGXLS4W/Y2Rs2B9f0xBLR7RRXYOg5Y9/MdzGFu3kzF3WWWCM7uiuD8OM
         6auQ==
X-Gm-Message-State: ANhLgQ1lkRPw4lXErXNSxyKvUETraPzMwYIp7HV+maSi8CZD9Q+9vqcG
        wDMmFk78NZKTr41hSJa6eYOYbUg=
X-Google-Smtp-Source: ADFU+vuYzc6hlxulQJiPiVD3r+hYbr7LpIVBXeHvIqu+WtAg/miFUSHjeQpTQYRNg3CeTz/SUXm5pg==
X-Received: by 2002:a92:778e:: with SMTP id s136mr18938555ilc.256.1585689791376;
        Tue, 31 Mar 2020 14:23:11 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l14sm15851ioj.22.2020.03.31.14.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:23:10 -0700 (PDT)
Received: (nullmailer pid 19413 invoked by uid 1000);
        Tue, 31 Mar 2020 21:23:09 -0000
Date:   Tue, 31 Mar 2020 15:23:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: phy: Add PHY_TYPE_XPCS definition
Message-ID: <20200331212309.GA19353@bogus>
References: <cover.1585103753.git.eswara.kota@linux.intel.com>
 <a7177dcd027539e0fc39611b9dce6725611b6cca.1585103753.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7177dcd027539e0fc39611b9dce6725611b6cca.1585103753.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 16:59:38 +0800, Dilip Kota wrote:
> Add definition for Ethernet PCS phy type.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
>  include/dt-bindings/phy/phy.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
