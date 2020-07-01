Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3955BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 178C12072D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbaEO652"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgGADE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 23:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgGADE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 23:04:57 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD739C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 20:04:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so14161115wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLtS6Wl7safhhZxHe3vVwSQB+yrO3mf2F7wF6Yw4fG0=;
        b=KbaEO652xuoW+WWFjpVvbpU4iiOyR2q6HIhzph64pNfR28SnPEpOFpnm6Pk89a8e+W
         JAT3VG+sxB93nRQWpM+YDaZC3sSDFSCoU5dk3T3WCGVYQHSqG/ilxyomaVpY/q1N34lV
         B+gHoDj3TK7UiAVNnqeMeaz6KV1E7YtT91g384zDSd5THbqX7FIIiYz9AUvhFvXCyEcS
         koF1erQ2cVBTMQoBov9q6qC9wb0V16djKfjkQh7Ehd391Jz1koRhZU9LSpKSCDcHbW0T
         DH+x3H+qlggoe+5dm3Pu7I9g+Gsok4hhkE7WJI7M9k5HbiWhe0lP2G9BE3vMQNX5nIkx
         T9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLtS6Wl7safhhZxHe3vVwSQB+yrO3mf2F7wF6Yw4fG0=;
        b=AnWcVsGfr1gC4ZPHObayxe42fdUhSy4X7crvDf+PrsNHi/k+s8jUoTQoTwkZ+/IUkT
         QAziJXVT2adBWrPmyeHVEqsMDJ7dO2asJirxNmPCSq3R8TGVcQ9HNVB0YZnjLvL8xQ8w
         70S15N5avoNA34rC+KyVqSeKwBY/XpYh8pGL3PubZS9fhnbwL+8uHMAX8ykqdDDFFf8V
         i+jwIW2MhUrfbtsVGc1dvSLleEOKHR6OOvD6GKNFVCsf6MKaGBxFrh5xdkaJHhvjigjL
         X/S9jUnIdOw7hfWn4ARtktPtbMB6Q4JIDFoNs3eZQ+gF5wrlEwT4M4dRBZoXB2amZ06W
         ZnFA==
X-Gm-Message-State: AOAM530sv7UpZ6IcgkYdaF61mHmyNgG5tKbg0YGHBMyLWlYIm3bp6Mr/
        BlWSIxIuffq33glxbE67HGxAFtOqC24IcbylDVf5Bw==
X-Google-Smtp-Source: ABdhPJwTrmy+YsfHh6wkihsWhfoWsE3KVKSECWn1liJ/rlHC2aq2YGRFMe9yCLw77V28tEsajrievYBesO5qreNpbAk=
X-Received: by 2002:adf:dd81:: with SMTP id x1mr24362897wrl.7.1593572694204;
 Tue, 30 Jun 2020 20:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200630070552.1110864-1-davidgow@google.com> <20200630110654.00001d40@Huawei.com>
In-Reply-To: <20200630110654.00001d40@Huawei.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 1 Jul 2020 11:04:42 +0800
Message-ID: <CABVgOSnOo4iauOBGpJUZ4NRihCUU-1vue8hajZTCKAcH98_Lrw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Specify IOMEM dependency for adi-axi-adc driver
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 6:07 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 30 Jun 2020 00:05:52 -0700
> David Gow <davidgow@google.com> wrote:
>
> > The Analog Devices AXI ADC driver uses the devm_ioremap_resource
> > function, but does not specify a dependency on IOMEM in Kconfig. This
> > causes a build failure on architectures without IOMEM, for example, UML
> > (notably with make allyesconfig).
> >
> > Fix this by making CONFIG_ADI_AXI_ADC depend on CONFIG_IOMEM.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> Hi David,
>
> Could you confirm what the build error is?  I thought the stubs added in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1bcbfbfdeb
> were meant to allow us to avoid having lots of depends on IOMEM lines for the
> few architectures who don't support it.

No worries:
/usr/bin/ld: drivers/iio/adc/adi-axi-adc.o: in function `adi_axi_adc_probe':
torvalds-linux/drivers/iio/adc/adi-axi-adc.c:415: undefined reference
to `devm_platform_ioremap_resource'

Alas, the devm_platform_ioremap_resource function isn't handled by the
UML stubs: it all seems to be in drivers/base/platform.c and
lib/devres.c, behind #ifdef HAS_IOMEM.

In any case, improving IOMEM support for UML (at least for the KUnit
test case, which is my use case) is something I'd like to do. There
are only three drivers[1,2] upstream at the moment which fail to build
as-is, though, so it seemed worth trying to fix them in the meantime.
That being said, I tried just getting rid of the few #ifdef HAS_IOMEMs
around the various devm_*_ioremap functions, and everything seems to
be working... So maybe that's a false dependency given the various
stubs (at least on UML). I used this (hideously hacky) patch:

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index c0d0a5490ac6..b6f08c88e2b6 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -61,7 +61,7 @@ struct resource *platform_get_resource(struct
platform_device *dev,
}
EXPORT_SYMBOL_GPL(platform_get_resource);

-#ifdef CONFIG_HAS_IOMEM
+#if 1//def CONFIG_HAS_IOMEM
/**
 * devm_platform_get_and_ioremap_resource - call devm_ioremap_resource() for a
 *                                         platform device and get resource
diff --git a/lib/Makefile b/lib/Makefile
index b1c42c10073b..35c21af33b93 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -115,7 +115,7 @@ obj-y += math/ crypto/

obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
obj-$(CONFIG_GENERIC_PCI_IOMAP) += pci_iomap.o
-obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
+obj-y += iomap_copy.o devres.o
obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o

---

If this seems to work more broadly, I may try to clean it up and post
it for broader review.

Cheers,
-- David
