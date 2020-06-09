Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE9FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F14207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591723928;
	bh=LTcBoamWhld/ra+UitAF/59CJxE0THLNOV5UPkWwDm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M5mAAzemxRbhzEFWu71qvusGN9imekMmQsNGiBD2CvtEWG0suDNiWOFRnCmsrUbTY
	 k5dK3V7Cv1UPFt8yB7xMHrngPuD+lrO/NAUsrwBsAk2V8tGN8U9ZCqgzc5MY3Sj3/8
	 qLhlqIY3LzJSPaObt5cuMBi57KhWLtApx644zhMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgFIRcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:32:07 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:36833 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgFIRcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:32:06 -0400
Received: by mail-il1-f173.google.com with SMTP id a13so21170498ilh.3;
        Tue, 09 Jun 2020 10:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IGnSfBXB+3nfSv3N6F0fbjwPESQfDqrwP19nspwqC6U=;
        b=AZiZx/neoKQAPCV9u1imUvPrnpXeDNwR7wx41FcKM/DswJRQgU+3qnmh18pSIySo/1
         IeZDvKdcZ2S38p9/PmPQ/oYGGiuK1bJnvIyVOWYFPGI5JGQj/FFkUG7IivOq312WcJ0t
         sp+nS/VmxQ6PAUVWxV8AI6zBMt6LG9aNgWFMXj0g1HZE7s5FMQ2721ifS+q5TGxSif9a
         c3GZqYWI66CzKJ7+vMZnteJjOJ/n+woVQaxxthqDBIPSvHAy88/BCSFVvEFMBG3htm07
         vLv0VgestMRYsb01bvBx2Uj+JWywdyExmg9Qg8MwjGiRJc+9oc0pRZe8nyoSJNKIetSM
         cULg==
X-Gm-Message-State: AOAM531Fx3dZjuohSRbSYUqtC3H/yc4t+mqagZFH8QQBJOBDPmDkqTaK
        7/jsAt6rcTBGcGSdxT9B9A==
X-Google-Smtp-Source: ABdhPJyVUj4y5yOWIEZhHu2FOPrV9CJO6MI8LLU5aR4WVyN9icWLtu67T0oniravBER69+CId1YnxA==
X-Received: by 2002:a92:89cf:: with SMTP id w76mr20191903ilk.10.1591723925603;
        Tue, 09 Jun 2020 10:32:05 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l12sm640246ilj.8.2020.06.09.10.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 10:32:04 -0700 (PDT)
Received: (nullmailer pid 1119483 invoked by uid 1000);
        Tue, 09 Jun 2020 17:32:04 -0000
Date:   Tue, 9 Jun 2020 11:32:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: Add MediaTek MT6873 devapc driver
Message-ID: <20200609173204.GB1107294@bogus>
References: <1591698261-22639-1-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591698261-22639-1-git-send-email-neal.liu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 06:24:19PM +0800, Neal Liu wrote:
> These patch series introduce a MediaTek MT6873 devapc driver.
> 
> MT6873 bus frabric provides TrustZone security support and data
> protection to prevent slaves from being accessed by unexpected
> masters.
> The security violations are logged and sent to the processor for
> further analysis or countermeasures.
> 
> Any occurrence of security violation would raise an interrupt, and
> it will be handled by devapc-mt6873 driver. The violation
> information is printed in order to find the murderer.

There's also a proposed driver with similar functionality[1]. Come up 
with a common solution.

Rob

[1] https://lore.kernel.org/linux-arm-kernel/20200128153806.7780-1-benjamin.gaignard@st.com/
