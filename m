Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D473CC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A039C20767
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587584569;
	bh=VcBeU1021myRjcRg5O2qICZa7SkpUdjklF/ABgfD7nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gwv6bOaujxPYU5Gkj361TNiUC8uV8o6zZd0+sfq7BTsFCW/DHtbS9GP904qahCcA3
	 MfPa5t59yew8ZAxdDgnLXhvhhV39LdNXfmI8ymZLJpzPrBJrmiK/PSlXoo87YQkswO
	 rJJpOVSkP/i+YmneSdqccUBx7UjPDfNcgCqBSI2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgDVTmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:42:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44342 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgDVTms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 15:42:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id j4so3250789otr.11;
        Wed, 22 Apr 2020 12:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H+xYHNUN8NpwWICu1ZzL9vzjHv/h/QGUDSeS/fpG3ug=;
        b=CqSlvyKm8EsAor7l+Zv5/zsuuuNdp03WjTUTJ1xhVcwJKucJM9NHdtNedCKFmxDozt
         qmy2xHRY1K8pYPGubDC3ObBudHOMkqhiI7UqHi72kNGwH1VVyRTB+dOR1SCmrjHDlqxg
         qkLWJjqm4SFRaoKR8Xn8kWP2Pj2DGFPwWCsGMNCLazsYntOFAw4sB08rHLqmzANw/i0d
         q4NbTeGsq4AN6TKW1fXulgSVphU5Bmm1SjMVk2pJE3/y081Us6SfMVJEtJBdht5YrySG
         GPPlzFfEqN9cbTGlfQKkb3Z7b87HL0C2l1JMgLE2adwQLZ3X3kTuVQ8qK5UNTUw3v6G3
         s2Ig==
X-Gm-Message-State: AGi0PuZQwVe0gY2r/zj9+k6jh3bwTBNyZ4xgR2i/x5YIUrktCPvBPlgf
        4Ug1sljfa/JD1D73jySmWA==
X-Google-Smtp-Source: APiQypIAC27fXYzhwwR1murVCsIEyDWyoJ33c1WBjH8aheZV10QcVH827SMvx4BBrBuyijKmXH6PSg==
X-Received: by 2002:a9d:23a3:: with SMTP id t32mr555321otb.333.1587584567424;
        Wed, 22 Apr 2020 12:42:47 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q142sm42070oic.44.2020.04.22.12.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 12:42:46 -0700 (PDT)
Received: (nullmailer pid 8669 invoked by uid 1000);
        Wed, 22 Apr 2020 19:42:45 -0000
Date:   Wed, 22 Apr 2020 14:42:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, mripard@kernel.org, wens@csie.org,
        anarsoul@gmail.com, devicetree@vger.kernel.org,
        alistair23@gmail.com, linux-arm-kernel@lists.infradead.org,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v4 1/3] dt-bindings: net: bluetooth: Add
 rtl8723bs-bluetooth
Message-ID: <20200422194245.GA8411@bogus>
References: <20200422035333.1118351-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422035333.1118351-1-alistair@alistair23.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 20:53:31 -0700, Alistair Francis wrote:
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  .../bindings/net/realtek-bluetooth.yaml       | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/net/realtek-bluetooth.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/net/realtek-bluetooth.yaml#

See https://patchwork.ozlabs.org/patch/1274671

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
