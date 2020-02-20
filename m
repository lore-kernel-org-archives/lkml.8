Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF87EC3404C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 04:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8537B24656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 04:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VVilIpci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgBTEGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 23:06:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38734 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbgBTEGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 23:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=2B30VI6eJGEA5pA1T5UNyL7lZvVIOgHsyyDSv4rmXU0=; b=VVilIpciuq94enZEfa/9dsDphY
        lk7HnsxuaMlIwdSVerUx14tUIHo3z66sDKJTSjwJY7EMECtXBbwqmY+t5yjk0wV6DDX9lmezSubLW
        QUHUQ9KxMvoNmTar2oez2DEK9d1TpThHSu4LDX3ZwbLR2nW5N7P7dE8L05M/x15Z4G7bzTAcDQnCK
        HegQlXdatn6UAH6a+/kk89b/8ItCaTJXb4R/F5rZLV7D8kMfAAV0JVc/tjgYVvTLygrKx+tptRf4n
        GPetcOklnTjBnPtmIrFbEuaQ/IkxvWijuKFihr9jiD6Cl/mXZ83FpXZ5h7dhuGbXmmmvfiXd/m9YI
        pt7sKgdQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4d6O-0001SU-Ld; Thu, 20 Feb 2020 04:06:16 +0000
Subject: Re: [PATCH V3 3/5] vDPA: introduce vDPA bus
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     tiwei.bie@intel.com, jgg@mellanox.com, maxime.coquelin@redhat.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        rob.miller@broadcom.com, xiao.w.wang@intel.com,
        haotian.wang@sifive.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com,
        kevin.tian@intel.com, stefanha@redhat.com, hch@infradead.org,
        aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com
References: <20200220035650.7986-1-jasowang@redhat.com>
 <20200220035650.7986-4-jasowang@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0a74e918-3b89-2aaf-7855-02db629ce886@infradead.org>
Date:   Wed, 19 Feb 2020 20:06:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220035650.7986-4-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/20 7:56 PM, Jason Wang wrote:
> diff --git a/drivers/virtio/vdpa/Kconfig b/drivers/virtio/vdpa/Kconfig
> new file mode 100644
> index 000000000000..7a99170e6c30
> --- /dev/null
> +++ b/drivers/virtio/vdpa/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config VDPA
> +	tristate
> +        default m

Don't add drivers that are enabled by default, unless they are required
for a system to boot.

And anything that wants VDPA should just select it, so this is not needed.

> +        help
> +          Enable this module to support vDPA device that uses a
> +          datapath which complies with virtio specifications with
> +          vendor specific control path.
> +

thanks.
-- 
~Randy

