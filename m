Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22255C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E856021744
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tc04HH+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgDFMMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:12:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44417 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727614AbgDFMMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586175167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ouQfW90npHD033GMDM+a2FinSD7SQ9pCB41aFB2pv8M=;
        b=Tc04HH+d2yKVSfiLc+NH/ZpZ5X409ckCSe1ziYPaLI2uAcB9biMKzVGIIEPVwg4SzoFLjD
        Lx3glhiXXM9NEgyj5UbifHDZrb2LlaMnMiSmyqLqKN0GEWSWyhobmto7VGhbFs++vWdMJm
        k8jXS2qoyDefUYxYeAA2v6+Tenq5l6s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-WQOFlN1EMyi9P6HZ0HGYNg-1; Mon, 06 Apr 2020 08:12:45 -0400
X-MC-Unique: WQOFlN1EMyi9P6HZ0HGYNg-1
Received: by mail-wr1-f72.google.com with SMTP id u16so8299845wrp.14
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 05:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ouQfW90npHD033GMDM+a2FinSD7SQ9pCB41aFB2pv8M=;
        b=ipmmjosCXSsyN0wPkmxNGDu38I7bhQ3N6Hd1S40R6VNaHXfI4Q1NPISInZB0rAbf9J
         OcB75iucSbE7FqVc9S5uKxe9XHzFR5AizqLX1/PstVCzSPf5SrxReHxT7YADWJSHgSl2
         IoGGx8NCLvKnwdPDWu9Swr7DntpUpEB/GC6WRA8fmspHN1XMn1oy8On37pmc7c0qtVlH
         32kR0ju/ku9MANCrUTj8ymHL4AVczcITTFP5XuuBeGtBhtzsFIldpeSxrNauCYMOLg++
         H8FIDRpKuoXTnyT1xmU0eTI4PrHjNMYHgrqGmcK1BJp2+dHMcAYFWSmrpZk+Wq4qPFdt
         Jf0A==
X-Gm-Message-State: AGi0Pub1pIz/sOcazbiaBSBQRJocRkIcAUWBlzemtbdlgiIlFhiWb5Sf
        swIYrknkWsN7ejDhfWegEElTvC1ouu1wKHI1blgHYgz8BdeA5JDBR8be93PpdM9MM/xYvZk4EiW
        vH8JFVRiaPJylVEgJAmFjdhjQ
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr20975143wmj.12.1586175164696;
        Mon, 06 Apr 2020 05:12:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypK4UDlctUcc5AyT0Y1eM00Stu92bOV1riiMCGdPiZpDMtuNKkpU/qBM4BYhbqFnYLAuIIxflQ==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr20975119wmj.12.1586175164472;
        Mon, 06 Apr 2020 05:12:44 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id h13sm870991wru.64.2020.04.06.05.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 05:12:43 -0700 (PDT)
Date:   Mon, 6 Apr 2020 08:12:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
        "christophe.lyon@st.com" <christophe.lyon@st.com>,
        kbuild test robot <lkp@intel.com>,
        "daniel.santos@pobox.com" <daniel.santos@pobox.com>,
        Jason Wang <jasowang@redhat.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/2] vdpa-sim: depend on HAS_DMA
Message-ID: <20200406121233.109889-2-mst@redhat.com>
References: <20200406121233.109889-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406121233.109889-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_dma_ops isn't available on all architectures:

        make ARCH=um
...

   drivers/vdpa/vdpa_sim/vdpa_sim.c: In function 'vdpasim_create':
>> drivers/vdpa/vdpa_sim/vdpa_sim.c:324:2: error: implicit declaration of function 'set_dma_ops'; did you mean 'set_groups'?
+[-Werror=implicit-function-declaration]
     set_dma_ops(dev, &vdpasim_dma_ops);
     ^~~~~~~~~~~
     set_groups

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 08b615f2da39..d0cb0e583a5d 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -14,7 +14,7 @@ if VDPA_MENU
 
 config VDPA_SIM
 	tristate "vDPA device simulator"
-	depends on RUNTIME_TESTING_MENU
+	depends on RUNTIME_TESTING_MENU && HAS_DMA
 	select VDPA
 	select VHOST_RING
 	select VHOST_IOTLB
-- 
MST

