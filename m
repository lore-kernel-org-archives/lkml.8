Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28512C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0068F206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="wNd/BPey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgGHGo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgGHGo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:44:28 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDA5C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 23:44:28 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w6so49189487ejq.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 23:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H3S5tywqz97erjS7LDzXGuHTrdnZD9VUuldP8+itAa4=;
        b=wNd/BPeyXfjIe9yIh34g3N8qUwFz9ejUIZFpntOXvJnwbBzo/+oz8abHw3rWSPuac9
         nqBaSoZK3Gy3yDqwdX2f/vp0IOteYuV7fzbQLe3PRgLLKe4tjlA7S17w1H2qEsImmbqQ
         lS/4zO1NKhijvhCJOaJVWNT9pkkEcByZXljDcxLjfb1YfdDt5VEgx7xrG3rJnb3ztz1Y
         Wax2NeMhGGhftDM3IILIDFrh81bWe0QWll2I98iAlA1u7WQSpiQ9Ye163WAyu8mijWiU
         oiOH838fBNvZlkyVB5A/7OY3CN4Wvcvj+knJQlpRhDPsOTmqBla+/PjydbM3II5CnTJ0
         Xawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3S5tywqz97erjS7LDzXGuHTrdnZD9VUuldP8+itAa4=;
        b=uCvlPmIFpk847L/aZJHyYm/6u6ZQV4HAYzB21BCv8xHTQEojc5EbFrM14fmbfMkxPj
         iNgNfWsU2rtoIdC7DUTlq5odKeZYZU2wlTgqYzeG7ECx/Gb5Fxsumz/OO9AHCYaJBIXI
         kMp1iC/frbGblPSeRZXUdqO0oiBfVB3E2EtLhafccAuZHvfzFyuWq/8FgTwzp+ZSdy/G
         ApkfD+gqY3/k10kmww94WpT6MrqqUsy3cBAymahDKzAG9ftDh8Fhyp8xUPXCk/K5xmkg
         11wR+/FwsrR9hYAGg5ugyzylTlmp/yw3kvKlOuhgx33u1LeDRlHz5UNLx6z/bxqnTw7A
         CU2Q==
X-Gm-Message-State: AOAM531YzNgRh6BXSLhSQ5ajSfzy/FgAt/n5Dhf6/Gng3CsChIUzjogu
        kA2SFV69z6KmVYdYV5A2OeBOwEuWK3hgLidPLcYkaw==
X-Google-Smtp-Source: ABdhPJx4SQlGZTtKojNW/mWzWPOIk3H66jdIvXjAOSf3+ZTHKHnHHoak+j4hKVLWKfpDLoxfuBGf+OkOtlqLn0keYoQ=
X-Received: by 2002:a17:906:b888:: with SMTP id hb8mr49967426ejb.124.1594190666893;
 Tue, 07 Jul 2020 23:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200707055917.143653-1-justin.he@arm.com> <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz> <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com>
 <20200708053239.GC386073@linux.ibm.com> <CAPcyv4i2gnrugO5n715WsDoj+gxV9Mjt-49zNnv+ROMLYy79LQ@mail.gmail.com>
 <20200708061934.GD386073@linux.ibm.com>
In-Reply-To: <20200708061934.GD386073@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Jul 2020 23:44:15 -0700
Message-ID: <CAPcyv4j-vs5pJhr=e3PbuydSfxiEdj_Z5TAvui+pvu28SmgiEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Justin He <Justin.He@arm.com>, Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Kaly Xin <Kaly.Xin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 11:20 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
[..]
> > Darn, I saw ARCH_KEEP_MEMBLOCK and had delusions of grandeur that it
> > could solve my numa api woes. At least for x86 the problem is already
> > solved with reserved numa_meminfo, but now I'm trying to write generic
> > drivers that use those apis and finding these gaps on other archs.
>
> I'm not sure if x86's numa_meminfo is a part of the solution or a part
> of the problem ;-)

More the latter, but hopefully it can remain an exception and not the rule.
