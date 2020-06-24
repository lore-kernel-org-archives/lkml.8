Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1FFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A7672088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593000623;
	bh=bYUmJf+kGTAzcOnkfuvJz5znculJXbUvDa1xHZwHhL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ysqbrShk4x6MT1QRwYAf0yiL51qxvgPxTcEgabw2Dx4opAIQc+ioTT/mHX9ubSQL8
	 ugw5f64PyVEmRIODZBc1kddxpkvho8A0eYOnAxxYsjCnJTVekPcuZEWdf4T7zA5q5s
	 AcuHCkbEP9e8aP0fRFRD1gIr4ARabfPESHT0PZ0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403819AbgFXMKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388522AbgFXMKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:10:21 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A06812088E;
        Wed, 24 Jun 2020 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593000620;
        bh=bYUmJf+kGTAzcOnkfuvJz5znculJXbUvDa1xHZwHhL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxJqcoA2M2WvjdaqSFHtvB6fOIZ/93lOdOJB8/AQ6PrpPJ0LQL9VtEwhkAfDfvMJW
         7HaNtMMWcRBtPncOXC4WKAdvMzAC73HZN3oJ+oLEY4Lv1WnuKBAcpb0keoPiOPY8TN
         i9ZXBVdTS28kxzS1b3HdxZovHDGgI4p1Xl8+pfbk=
Date:   Wed, 24 Jun 2020 17:40:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kishon@ti.com, rdunlap@infradead.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v2 1/1] phy: intel: Fix compilation error on FIELD_PREP
 usage
Message-ID: <20200624121016.GZ2324254@vkoul-mobl>
References: <8a309dd3c238efbaa59d1649704255d6f8b6c9c5.1590575358.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a309dd3c238efbaa59d1649704255d6f8b6c9c5.1590575358.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-05-20, 18:56, Dilip Kota wrote:
> FIELD_PREP expects constant arguments. Istead of doing FIELD_PREP
> operation on the arguments of combo_phy_w32_off_mask(), pass the
> final FIELD_PREP value as an argument.
> 
> Error reported as:
> In file included from include/linux/build_bug.h:5,
> from include/linux/bitfield.h:10,
> from drivers/phy/intel/phy-intel-combo.c:8:
> drivers/phy/intel/phy-intel-combo.c: In function 'combo_phy_w32_off_mask':
> include/linux/bitfield.h:52:28: warning: comparison is always false due to limited range of data type [-Wtype-limits]
> 
> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_37' declared with attribute error: FIELD_PREP: mask is not constant
> 94 |   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");          |   ^~~~~~~~~~~~~~~~
> drivers/phy/intel/phy-intel-combo.c:137:13: note: in expansion of macro 'FIELD_PREP'
> 137 |  reg_val |= FIELD_PREP(mask, val);
> |             ^~~~~~~~~~
> 
> ../include/linux/compiler.h:392:38: error: call to__compiletime_assert_137
>  declared with attribute error:
> BUILD_BUG_ON failed: (((mask) + (1ULL << (__builtin_ffsll(mask) - 1))) & (((mask) + (1ULL << (__builtin_ffsll(mask) - 1))) - 1)) != 0
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> 
> ../include/linux/bitfield.h:94:3: note: in expansion of macro __BF_FIELD_CHECK
>    __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
>    ^~~~~~~~~~~~~~~~
> ../drivers/phy/intel/phy-intel-combo.c:137:13: note: in expansion of macro FIELD_PREP
>   reg_val |= FIELD_PREP(mask, val);

Applied, thanks

-- 
~Vinod
