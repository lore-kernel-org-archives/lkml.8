Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7129C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5D4214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583180151;
	bh=XBIlLtTR+hqxUAsA5Yx5PP36QSo7TdI6f1P3rBmX5ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FedT66Z6vfn5MrhZVmv6RwaRnlPjYtE/Gqw5ZUJUlGC7Voua7CUHrZSM6MVWyGyoy
	 Dn+wbEqGHh0TLmxlzLr7fB3qQS1v5M5OXAS5NEfhodbRxlFdEZUG65BmQ8P3vuBmV8
	 Yj0I1XoGnTA9boxdihg9q+xAU2nil/0xAkd7JGHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgCBUPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:15:50 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33717 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgCBUPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:15:50 -0500
Received: by mail-oi1-f193.google.com with SMTP id q81so593577oig.0;
        Mon, 02 Mar 2020 12:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uloyMFrQMW3e3WA+o8H5r7/9NmI8i2m5BMZKHBf+VaA=;
        b=g3TDwaOTaRNG5nCKN5RCK6nw5f3h4Ws08TEgJbhp5EGEOBruiWg/FEDYoZV99+YQWa
         Fz3RdNZP0SOAjGUSbmduzlXFyiDfl4lSn53nTgXePUOVxE09BL4PxGyu1ghAo75Gy6/B
         Yx/5S5sRfjMKpXOvk74SGGF6ns9PlbCLitwChoN6A1RPVnuSswl5lHCoSf+LiniOibhi
         Pf/qwTP0rJZHN66YrFkCjDnfAKWGxVYIizBLTytjV/5yntA8SXxB2bv99D55/0EGyOCo
         4mlOuQz5ibTgURzmyAsxwIQvf924Ca/jadRQ6gbHuamk/ombq4h44sC2z48zxVbrdKrj
         tZDA==
X-Gm-Message-State: ANhLgQ3pgpmigb39ZWspXZIwb80NSo9X+bupA9JbS0thDis0YSKXlxsW
        lgmiTcPrdmwMNw7CJcKXlQ==
X-Google-Smtp-Source: ADFU+vs7D7qTQC+jUddUuufziRZ92WcFPe3N0lpV52sZ1nny4AXBcH1g+VSOzHxL/JLm0bXW03K0Ig==
X-Received: by 2002:aca:5205:: with SMTP id g5mr108991oib.43.1583180149145;
        Mon, 02 Mar 2020 12:15:49 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a10sm222365oti.44.2020.03.02.12.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 12:15:48 -0800 (PST)
Received: (nullmailer pid 21968 invoked by uid 1000);
        Mon, 02 Mar 2020 20:15:47 -0000
Date:   Mon, 2 Mar 2020 14:15:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: Re: [PATCH v3 01/13] dt-binding: gce: add gce header file for mt6779
Message-ID: <20200302201547.GA21778@bogus>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
 <1582897461-15105-3-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582897461-15105-3-git-send-email-dennis-yc.hsieh@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 21:44:09 +0800, Dennis YC Hsieh wrote:
> Add documentation for the mt6779 gce.
> 
> Add gce header file defined the gce hardware event,
> subsys number and constant for mt6779.
> 
> Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
> ---
>  .../devicetree/bindings/mailbox/mtk-gce.txt   |   8 +-
>  include/dt-bindings/gce/mt6779-gce.h          | 222 ++++++++++++++++++
>  2 files changed, 227 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/gce/mt6779-gce.h
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
